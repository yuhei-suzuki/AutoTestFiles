# スクラッチ組織作成(通常の作成の場合)
# sfdx force:org:create -f project-scratch-def.json -a testsample17 --setdefaultusername  --durationdays 30 &&
# シェイプ機能を用いたスクラッチ組織の作成(翻訳有効化できる)
sfdx force:org:create -v DevHub -t scratch -f shape-scratch-def.json -a testsample17 --setdefaultusername  --durationdays 30 &&
wait
# 標準データ投入
# 取引先
sfdx force:data:tree:import --sobjecttreefiles ./data/Account.json &&
# リード
sfdx force:data:tree:import --sobjecttreefiles ./data/Lead.json &&
# 取引先責任者
sfdx force:data:tree:import --sobjecttreefiles ./data/Contact.json &&
# 行動
sfdx force:data:tree:import --sobjecttreefiles ./data/Event.json &&
# 商談
sfdx force:data:tree:import --sobjecttreefiles ./data/Opportunity.json &&
# ToDo
sfdx force:data:tree:import --sobjecttreefiles ./data/Task.json &&
wait
# 標準ユーザの投入
sfdx force:user:create -a StandardUser3 -f user-def.json profileName='標準ユーザ' &&
wait
# リモートサイトの設定の投入(対象のスクラッチ組織のエイリアス名を作成した組織のものに書き換えること)
sfdx force:mdapi:deploy -d ./unpackaged -u testsample17 -w -1
wait
# 作成したSalesforceの組織を開く
sfdx force:org:open