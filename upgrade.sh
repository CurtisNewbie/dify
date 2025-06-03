set -e

cd docker

bak_file="docker-compose.yaml.$(date +%s).bak"
cp docker-compose.yaml "$bak_file"
echo "backup docker-compose.yaml to '${bak_file}'"

echo "syncing latest source code"
git fetch && git merge main
echo "synced latest source code"

echo "stopping dify docker-compose service"
docker compose down
echo "stopped dify docker-compose service"

bak_data="volumes-$(date +%s).tgz"
echo "backing-up volumns data to ${bak_data}"
tar -cvf "${bak_data}" volumes
echo "backed-up volumns data to ${bak_data}"

echo "starting dify docker-compose service"
docker compose up -d
echo "started dify docker-compose service"

