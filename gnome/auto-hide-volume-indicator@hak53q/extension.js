import GLib from 'gi://GLib';
import NM from 'gi://NM';
import { panel } from 'resource:///org/gnome/shell/ui/main.js';
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';

export default class HideVolume extends Extension {
    enable() {
        this._nmClient = NM.Client.new(null);
        this._nmSignals = [];
        this._devices = this._nmClient.get_devices();

        this.sourceId = GLib.idle_add(GLib.PRIORITY_DEFAULT, () => {
            this.volumeOutput = panel.statusArea.quickSettings._volumeOutput;
            if (!this.volumeOutput)
                return GLib.SOURCE_CONTINUE;

            const updateVolumeVisibility = () => {
                if (this._isWifiConnected())
                    this.volumeOutput.hide();
                else
                    this.volumeOutput.show();
            };

            updateVolumeVisibility();

            for (let device of this._devices) {
                if (device.device_type === NM.DeviceType.WIFI) {
                    let signalId = device.connect('state-changed', () => {
                        updateVolumeVisibility();
                    });
                    this._nmSignals.push([device, signalId]);
                }
            }

            this.showSignal = this.volumeOutput.connect("show", () => {
                if (this._isWifiConnected())
                    this.volumeOutput.hide();
            });

            this.sourceId = null;
            return GLib.SOURCE_REMOVE;
        });
    }

    _isWifiConnected() {
        for (let device of this._devices) {
            if (device.device_type === NM.DeviceType.WIFI) {
                if (device.state === NM.DeviceState.ACTIVATED)
                    return true;
            }
        }
        return false;
    }

    disable() {
        if (this.sourceId) {
            GLib.Source.remove(this.sourceId);
        }
        if (this.volumeOutput) {
            this.volumeOutput.disconnect(this.showSignal);
            this.volumeOutput.show();
        }

        if (this._nmSignals) {
            for (let [device, signalId] of this._nmSignals) {
                device.disconnect(signalId);
            }
            this._nmSignals = [];
        }

        this._nmClient = null;
        this._devices = null;
    }
}
