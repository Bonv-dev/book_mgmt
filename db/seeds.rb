# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# name と email は ChatGPT で生成
users = [
  { name: 'admin',       email: 'admin.admin@sample.com',      is_admin: true,  is_librarian: false },  # user[ 0], admin
  { name: '司書 一郎',   email: 'librarian.ichiro@sample.com', is_admin: false, is_librarian: true  },  # user[ 1], librarian
  { name: '佐藤 太郎',   email: 'sato.taro@sample.com',        is_admin: false, is_librarian: true  },  # user[ 2], librarian
  { name: '鈴木 花子',   email: 'suzuki.hanako@sample.com',    is_admin: false, is_librarian: true  },  # user[ 3], librarian
  { name: '高橋 健二',   email: 'takahashi.kenji@sample.com',  is_admin: false, is_librarian: true  },  # user[ 4], librarian
  { name: '伊藤 裕子',   email: 'ito.yuko@sample.com',         is_admin: false, is_librarian: true  },  # user[ 5], librarian
  { name: '渡辺 真一',   email: 'watanabe.shinichi@sample.com', is_admin: false, is_librarian: true  },  # user[ 6], librarian
  { name: '中村 明美',   email: 'nakamura.akemi@sample.com',   is_admin: false, is_librarian: true  },  # user[ 7], librarian
  { name: '一般 大輔',   email: 'ippan.daisuke@sample.com',    is_admin: false, is_librarian: false },  # user[ 8]
  { name: '加藤 恵',     email: 'kato.megumi@sample.com',      is_admin: false, is_librarian: false },  # user[ 9]
  { name: '山本 剛',     email: 'yamamoto.tsuyoshi@sample.com', is_admin: false, is_librarian: false },  # user[10]
  { name: '吉田 彩',     email: 'yoshida.aya@sample.com',      is_admin: false, is_librarian: false },  # user[11]
  { name: '山田 浩一',   email: 'yamada.koichi@sample.com',    is_admin: false, is_librarian: false },  # user[12]
  { name: '佐々木 遼',   email: 'sasaki.ryo@sample.com',       is_admin: false, is_librarian: false },  # user[13]
  { name: '清水 美咲',   email: 'shimizu.misaki@sample.com',   is_admin: false, is_librarian: false },  # user[14]
  { name: '松本 慎吾',   email: 'matsumoto.shingo@sample.com', is_admin: false, is_librarian: false },  # user[15]
  { name: '林 佳奈',     email: 'hayashi.kana@sample.com',     is_admin: false, is_librarian: false },  # user[16]
  { name: '斎藤 直樹',   email: 'saito.naoki@sample.com',      is_admin: false, is_librarian: false },  # user[17]
  { name: '岡田 真理',   email: 'okada.mari@sample.com',       is_admin: false, is_librarian: false },  # user[18]
  { name: '村上 優',     email: 'murakami.yu@sample.com',      is_admin: false, is_librarian: false },  # user[19]
  { name: '長谷川 和也', email: 'hasegawa.kazuya@sample.com',  is_admin: false, is_librarian: false },  # user[20]
  { name: '近藤 美穂',   email: 'kondo.miho@sample.com',       is_admin: false, is_librarian: false },  # user[21]
  { name: '石井 龍',     email: 'ishii.ryu@sample.com',        is_admin: false, is_librarian: false },  # user[22]
  { name: '坂本 直子',   email: 'sakamoto.naoko@sample.com',   is_admin: false, is_librarian: false },  # user[23]
  { name: '森 俊介',     email: 'mori.shunsuke@sample.com',    is_admin: false, is_librarian: false },  # user[24]
  { name: '橋本 真央',   email: 'hashimoto.mao@sample.com',    is_admin: false, is_librarian: false },  # user[25]
  { name: '青木 春香',   email: 'aoki.haruka@sample.com',      is_admin: false, is_librarian: false },  # user[26]
  { name: '福田 大地',   email: 'fukuda.daichi@sample.com',    is_admin: false, is_librarian: false }  # user[27]
]

# User は device が絡むため、
# RDB カラムは encrypted_password だが、パラメータとしては平文の password と password_confirmation を渡す。
# なので、find_or_create_by を使うには工夫が必要。
# 他と同じように実行すると
#   SQLite3::SQLException: no such column: users.password
# エラーになる。
user = []
password = '12345qaz' # 簡単のため、全員決め打ち。
users.each_with_index do |params, index|
  user[index] = User.find_or_create_by!(
                 email: params[:email]
               ) do |u|
                 u.enabled = true
                 u.name = params[:name]
                 u.is_admin = params[:is_admin]
                 u.is_librarian = params[:is_librarian]
                 u.password = password
                 u.password_confirmation = password
               end
end

floors = [
  { enabled: true, name: '1F' },
  { enabled: true, name: '2F' },
  { enabled: true, name: '3F' }
]
floor = []
floors.each_with_index do |params, index|
  floor[index] = Floor.find_or_create_by!(params)
end

cabinets = [
  { enabled: true, name: 'C1-100', floor: floor[0] }, # cabinet[0], 1F
  { enabled: true, name: 'C1-101', floor: floor[0] }, # cabinet[1], 1F
  { enabled: true, name: 'C2-100', floor: floor[1] }, # cabinet[2], 2F
  { enabled: true, name: 'C3-100', floor: floor[2] }, # cabinet[3], 3F
  { enabled: true, name: 'C3-110', floor: floor[2] }, # cabinet[4], 3F
  { enabled: true, name: 'C3-120', floor: floor[2] }, # cabinet[5], 3F
  { enabled: true, name: 'C3-130', floor: floor[2] } # cabinet[6], 3F
]
cabinet = []
cabinets.each_with_index do |params, index|
  cabinet[index] = Cabinet.find_or_create_by!(params)
end

steps = [
  { enabled: true, name: 'S00', cabinet: cabinet[0] },  # step[0]
  { enabled: true, name: 'S01', cabinet: cabinet[0] },  # step[1]
  { enabled: true, name: 'S00', cabinet: cabinet[1] },  # step[2]
  { enabled: true, name: 'S00', cabinet: cabinet[2] },  # step[3]
  { enabled: true, name: 'S01', cabinet: cabinet[2] },  # step[4]
  { enabled: true, name: 'S02', cabinet: cabinet[2] },  # step[5]
  { enabled: true, name: 'S00', cabinet: cabinet[3] },  # step[6]
  { enabled: true, name: 'S10', cabinet: cabinet[3] },  # step[7]
  { enabled: true, name: 'S20', cabinet: cabinet[4] },  # step[8]
  { enabled: true, name: 'S30', cabinet: cabinet[5] }  # step[9]
  # cabinet[6] は段なし。→ 格納不可
]
step = []
steps.each_with_index do |params, index|
  step[index] = Step.find_or_create_by!(params)
end

categories = [
  { enabled: true, name: '文芸' },                    # category[0]
  { enabled: true, name: 'ミステリー' },              # category[1]
  { enabled: true, name: 'SF・ファンタジー' },        # category[2]
  { enabled: true, name: '歴史・時代小説' },          # category[3]
  { enabled: true, name: '恋愛小説' },                # category[4]
  { enabled: true, name: 'エッセイ・随筆' },          # category[5]
  { enabled: true, name: 'ノンフィクション' },        # category[6]
  { enabled: true, name: 'ビジネス・自己啓発' },      # category[7]
  { enabled: true, name: '趣味・実用' },              # category[8]
  { enabled: true, name: '児童書・ヤングアダルト' }  # category[9]
]
category = []
categories.each_with_index do |params, index|
  category[index] = Category.find_or_create_by!(params)
end

# name と isbn は ChatGPT で生成
books = [
  { enabled: true,  name: "こころ",                          isbn: "978-4101010014", category: category[0], step: step[0], memo: "" }, # book[ 0]
  { enabled: true,  name: "人間失格",                        isbn: "978-4101006017", category: category[0], step: step[0], memo: "" }, # book[ 1]
  { enabled: true,  name: "雪国",                            isbn: "978-4101001029", category: category[0], step: step[0], memo: "" }, # book[ 2]
  { enabled: true,  name: "容疑者Xの献身",                   isbn: "978-4167110123", category: category[1], step: step[1], memo: "" }, # book[ 3]
  { enabled: true,  name: "白夜行",                          isbn: "978-4167110116", category: category[1], step: step[1], memo: "" }, # book[ 4]
  { enabled: true,  name: "十角館の殺人",                    isbn: "978-4062738211", category: category[1], step: step[1], memo: "" }, # book[ 5]
  { enabled: true,  name: "銀河鉄道の夜",                    isbn: "978-4101092058", category: category[2], step: step[2], memo: "" }, # book[ 6]
  { enabled: true,  name: "星を継ぐもの",                    isbn: "978-4150114589", category: category[2], step: step[2], memo: "" }, # book[ 7]
  { enabled: true,  name: "指輪物語 旅の仲間",               isbn: "978-4566024162", category: category[2], step: step[2], memo: "" }, # book[ 8]
  { enabled: true,  name: "竜馬がゆく",                      isbn: "978-4167105761", category: category[3], step: step[3], memo: "" }, # book[ 9]
  { enabled: true,  name: "国盗り物語",                      isbn: "978-4101152103", category: category[3], step: step[3], memo: "" }, # book[10]
  { enabled: true,  name: "燃えよ剣",                        isbn: "978-4101092072", category: category[3], step: step[3], memo: "" }, # book[11]
  { enabled: true,  name: "世界の中心で、愛をさけぶ",        isbn: "978-4094087614", category: category[4], step: step[4], memo: "" }, # book[12]
  { enabled: true,  name: "恋空",                            isbn: "978-4048738393", category: category[4], step: step[4], memo: "" }, # book[13]
  { enabled: true,  name: "阪急電車",                        isbn: "978-4344414840", category: category[4], step: step[4], memo: "" }, # book[14]
  { enabled: true,  name: "徒然草",                          isbn: "978-4101092065", category: category[5], step: step[5], memo: "" }, # book[15]
  { enabled: true,  name: "夜は短し歩けよ乙女",              isbn: "978-4043872016", category: category[5], step: step[5], memo: "" }, # book[16]
  { enabled: true,  name: "ぼくのメジャースプーン",          isbn: "978-4062768577", category: category[5], step: step[5], memo: "" }, # book[17]
  { enabled: true,  name: "バカの壁",                        isbn: "978-4106100031", category: category[6], step: step[6], memo: "" }, # book[18]
  { enabled: true,  name: "永遠の0 ノンフィクション版",      isbn: "978-4062767594", category: category[6], step: step[6], memo: "" }, # book[19]
  { enabled: true,  name: "貧困大国アメリカ",                isbn: "978-4004310414", category: category[6], step: step[6], memo: "" }, # book[20]
  { enabled: true,  name: "7つの習慣",                       isbn: "978-4863940243", category: category[7], step: step[7], memo: "" }, # book[21]
  { enabled: true,  name: "嫌われる勇気",                    isbn: "978-4478025819", category: category[7], step: step[7], memo: "" }, # book[22]
  { enabled: true,  name: "イシューからはじめよ",            isbn: "978-4862760859", category: category[7], step: step[7], memo: "" }, # book[23]
  { enabled: true,  name: "きょうの料理 基本編",             isbn: "978-4141872282", category: category[8], step: step[8], memo: "" }, # book[24]
  { enabled: true,  name: "山と高原地図の使い方",            isbn: "978-4635530658", category: category[8], step: step[8], memo: "" }, # book[25]
  { enabled: true,  name: "はじめての家庭菜園",              isbn: "978-4058001234", category: category[8], step: step[8], memo: "" }, # book[26]
  { enabled: true,  name: "ハリー・ポッターと賢者の石",      isbn: "978-4915512379", category: category[9], step: step[9], memo: "" }, # book[27]
  { enabled: false, name: "モモ",                            isbn: "978-4001140014", category: category[9], step: step[9], memo: "" }, # book[28]
  { enabled: false, name: "かいけつゾロリのドラゴンたいじ",  isbn: "978-4591032216", category: category[9], step: step[9], memo: "" } # book[29]
]
book = []
books.each_with_index do |params, index|
  book[index] = Book.find_or_create_by!(params)
end

logs = [
  # 最初のデータは、admin が格納した事にしておく
  { status: 1, book: book[0], user: user[0] },
  { status: 1, book: book[1], user: user[0] },
  { status: 1, book: book[2], user: user[0] },
  { status: 1, book: book[3], user: user[0] },
  { status: 1, book: book[4], user: user[0] },
  { status: 1, book: book[5], user: user[0] },
  { status: 1, book: book[6], user: user[0] },
  { status: 1, book: book[7], user: user[0] },
  { status: 1, book: book[8], user: user[0] },
  { status: 1, book: book[9], user: user[0] },
  { status: 1, book: book[10], user: user[0] },
  { status: 1, book: book[11], user: user[0] },
  { status: 1, book: book[12], user: user[0] },
  { status: 1, book: book[13], user: user[0] },
  { status: 1, book: book[14], user: user[0] },
  { status: 1, book: book[15], user: user[0] },
  { status: 1, book: book[16], user: user[0] },
  { status: 1, book: book[17], user: user[0] },
  { status: 1, book: book[18], user: user[0] },
  { status: 1, book: book[19], user: user[0] },
  { status: 1, book: book[20], user: user[0] },
  { status: 1, book: book[21], user: user[0] },
  { status: 1, book: book[22], user: user[0] },
  { status: 1, book: book[23], user: user[0] },
  { status: 1, book: book[24], user: user[0] },
  { status: 1, book: book[25], user: user[0] },
  { status: 1, book: book[26], user: user[0] },
  { status: 1, book: book[27], user: user[0] },
  { status: 1, book: book[28], user: user[0] },
  { status: 1, book: book[29], user: user[0] },

  # 借用・返却・廃棄したログも足しておく
  # id:1 → 保管
  # id:2 → 貸出中
  # id:3 → 廃棄済
  { status: 2, book: book[0], user: user[8] },  # book[ 0] 借用中
  { status: 2, book: book[1], user: user[8] },
  { status: 1, book: book[1], user: user[8] },  # book[ 1] 返却済
  { status: 3, book: book[28], user: user[1] },  # book[28] 廃棄済
  { status: 3, book: book[29], user: user[1] }  # book[29] 廃棄済
]
logs.each_with_index do |params, index|
  Log.find_or_create_by!(params)
end
