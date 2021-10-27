# table explanation

>## Task
  >>* **title** :string  
  >>* **content** :text  
  >>* **status** :string  
  >>* **deadline** :date  
  >>* **priority** :string
  >>
  >>* *user_id :reference user(予定)*

>## User(予定)
  >>* *name :string*  
  >>* *email :text*  
  >>* *password_digest :string*  

>## Work(予定)
  >>* *user_id :reference user*  
  >>* *task_id :reference task*  


# version explanation

>* **ruby** 2.6.5p114  
>* **ruby on rails** 5.2.6  
>* **psql** 12.8  
>* **gem** 3.0.3  
