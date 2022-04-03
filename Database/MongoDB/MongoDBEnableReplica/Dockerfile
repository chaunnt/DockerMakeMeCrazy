FROM mongo:4

EXPOSE 27017
EXPOSE 27018
EXPOSE 27019

# Run SQL Server process
CMD mongod --shardsvr --replSet bdsreplica --port 27018 --bind_ip_all
