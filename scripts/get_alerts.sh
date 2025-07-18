curl -k -u admin:SecretPassword -X GET "https://localhost:9200/wazuh-alerts-*/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "range": {
    	"timestamp" {
	  "gte": "2025-06-14T6:00:00.000Z",
	  "lt": "2025-06-14T6:10:00.000Z"
	}
    }
  },
  "sort": [
    {
      "timestamp": {
        "order": "desc"
      }
    }
  ],
  "size": 3
}'
