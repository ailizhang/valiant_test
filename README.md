### Usage
#### Api endpoint
    http://localhost:4000/api/v1/

#### Request header
    Content-Type: application/json

#### Create a task
    http://localhost:4000/api/v1//tasks

##### Request Body
description - *text*, required   
completed - *boolean, default to "false"*, not required  
completed_at - *datetime*, required if the task is completed

Request with description only

    {
      "task": {
        "description": "Hello World"
      }
    }

Response

    {
      "success": true,
      "task": {
          "id": 1,
          "description": "hello world",
          "completed": false,
          "completed_at": null,
          "created_at": "03/06/2019 05:24PM",
          "updated_at": "03/06/2019 05:24PM"
      }
    }

Request with all attributes

    {
      "task": {
        "description": "Hello World",
        "completed": true,
        "completed_at": "01/06/2019 2:10pm"
      }
    }  

Note: The date field of attribute __completed_at__ has to be 'DD/MM/YYYY'  
