#!/bin/sh
while true; do

  for repo in Kotakjualan-Email  pemilo-admin  pemilo-candidate  pemilo-room  pemilo-vote  sqola-option  sqola-student pemilo-fadmin pemilo-fclient; do
    (
      cd "${repo}"

      changed=0
      git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1

      if [ $changed = 1 ]; then

              git pull
              npm i

              if [ $repo = pemilo-fclient ] | [ $repo = pemilo-fadmin ]; then
                npm run-script build
              fi

              pm2 restart "${repo}"
              echo "${repo} service have been updated";

      else
            echo "${repo} Up-to-date at "$(date);
      fi
    )
  done

  sleep 60
done
