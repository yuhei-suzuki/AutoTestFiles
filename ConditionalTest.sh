# スクラッチ組織作成(通常の作成の場合)
# sfdx force:org:create -f project-scratch-def.json -a testsample17 --setdefaultusername  --durationdays 30 &&
# シェイプ機能を用いたスクラッチ組織の作成(翻訳有効化できる)
# CREATE=$(sfdx force:org:create -v DevHub -t scratch -f shape-scratch-def.json -a testsample17 --setdefaultusername  --durationdays 30 --json)

# wait

# #「サインアップ要求」という文言があるかをチェックする
# if [ "`echo $CREATE | grep 'サインアップ要求に失敗'`" ]; then


# スクラッチ組織が作成できない場合にSFDXコマンドで組織情報を取得する
sctrath_list=$(sfdx force:org:list --verbose --json)
# スクラッチ組織の数をカウントする処理
sctrath_count=$(echo $sctrath_list | jq '.result | .scratchOrgs[] | .attributes.type' | wc -l)
echo 結果は
echo $sctrath_count
# スクラッチ組織の数を判別する
if [ ${sctrath_count} -eq 3 ];then
#　スクラッチ組織の数が3個の場合
sctrath_username=$(echo $sctrath_list | jq -r '.result | .scratchOrgs[] | .username' | head -1)
echo 結果は
echo $sctrath_username
echo Y| sfdx force:org:delete -u $sctrath_username
sfdx force:org:create -v DevHub -t scratch -f shape-scratch-def.json -a testsample27 --setdefaultusername  --durationdays 30
else
# 3個でなければ実行したいコマンドを記載する
sfdx force:org:create -v DevHub -t scratch -f shape-scratch-def.json -a testsample27 --setdefaultusername  --durationdays 30
fi
# ↓↓↓↓↓↓↓↓↓↓ここから下はスクラッチ組織が作成できた場合のコマンドを記述する↓↓↓↓↓↓↓↓↓↓
#　標準データのインポート
sfdx force:data:tree:import --sobjecttreefiles ./data/Account.json