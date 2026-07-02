use std::env;
use std::path::Path;

fn main() {
    // 檢查是否有帶入 --bypass-cache 參數
    let args: Vec<String> = env::args().collect();
    let bypass_cache = args.contains(&String::from("--bypass-cache"));

    // 如果不是 Fish 在觸發更新（無 bypass 旗標），且快取存在，則直接印出並退出
    if !bypass_cache {
        if let Ok(cached_cwd) = env::var("STARSHIP_CUSTOM_CWD") {
            if !cached_cwd.is_empty() {
                print!("{}", cached_cwd);
                return;
            }
        }
    }

    // 1. 獲取環境變數 PWD 與 HOME
    let pwd_str = match env::var("PWD") {
        Ok(v) => v,
        Err(_) => return,
    };
    
    let home_str = env::var("HOME").unwrap_or_default();

    // 2. 設定參數（未來若要調整規則，只需改這裡）
    let max_abbrev_len = 2;
    let truncation_length = 3;

    // 將路徑切分成各個目錄部件
    let pwd_path = Path::new(&pwd_str);
    let comps: Vec<&str> = pwd_path
        .iter()
        .map(|s| s.to_str().unwrap_or(""))
        .filter(|s| !s.is_empty() && *s != "/")
        .collect();

    let total = comps.len();
    let mut processed: Vec<String> = Vec::new();

    // 3. 核心邏輯判斷（選項 A：在 $HOME 根目錄時不縮寫）
    if !home_str.is_empty() && pwd_str.starts_with(&home_str) && pwd_str != home_str {
        // --- 在家目錄（$HOME）底下的子目錄邏輯 ---
        if total > 0 {
            processed.push(abbreviate(comps[0], max_abbrev_len));
        }
        if total > 1 {
            processed.push(abbreviate(comps[1], max_abbrev_len));
        }

        if total > 2 {
            let rem_list = &comps[2..];
            let rem_count = rem_list.len();
            let threshold = if rem_count > truncation_length {
                rem_count - truncation_length
            } else {
                0
            };

            for (idx, &comp) in rem_list.iter().enumerate() {
                if rem_count > truncation_length && (idx + 1) <= threshold {
                    processed.push(abbreviate(comp, max_abbrev_len));
                } else {
                    processed.push(comp.to_string());
                }
            }
        }
    } else {
        // --- 非家目錄下，或是剛好在家目錄根目錄的邏輯 ---
        let threshold = if total > truncation_length {
            total - truncation_length
        } else {
            0
        };

        for (i, &comp) in comps.iter().enumerate() {
            if (i + 1) <= threshold {
                processed.push(abbreviate(comp, max_abbrev_len));
            } else {
                processed.push(comp.to_string());
            }
        }
    }

    // 4. 輸出結果
    if processed.is_empty() {
        print!("/");
    } else {
        print!("/{}", processed.join("/"));
    }
}

fn abbreviate(s: &str, max_len: usize) -> String {
    s.chars().take(max_len).collect()
}
