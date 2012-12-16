
CREATE TABLE forum_forums
(id 		int(10)		NOT NULL	auto_increment,  
 title 		text 		NOT NULL,  
 forum_info 	text 		NOT NULL, 
 PRIMARY KEY (id)
);


CREATE TABLE forum_threads 
(id 		int(10) 	NOT NULL	auto_increment,  
 forum_id 	int(10) 	NOT NULL,    
 title 		text 		NOT NULL,  
 date_time 	datetime 	NOT NULL,
 views 		int(10) 	default 0,
 PRIMARY KEY (id) ,
CONSTRAINT FK FOREIGN KEY(forum_id) REFERENCES forum_forums(id)
);

CREATE TABLE forum_users
(id		int(10)		NOT NULL	auto_increment,
 user_name	text		NOT NULL,	
 password	text		NOT NULL,
 email		text		 ,
 registerdate	datetime	 ,
 type		text ,
 avatar		text		 ,
 member_title 	text		 ,
 signature	text		 ,
 PRIMARY KEY (id)
);

CREATE TABLE forum_message 
(id 		int(10)		NOT NULL	auto_increment, 
forum_id 	int(10)		NOT NULL, 
 thread_id 	int(10)		NOT NULL, 
 message 	text		NOT NULL,  
 user_id 		int(10)		NOT NULL,  
 date_time 	datetime 	NOT NULL,
 PRIMARY KEY (id) ,
 CONSTRAINT FK1 FOREIGN KEY(forum_id) REFERENCES forum_forums(id),
 CONSTRAINT FK2 FOREIGN KEY(thread_id) REFERENCES forum_threads(id),
 CONSTRAINT FK3 FOREIGN KEY(user_id) REFERENCES forum_users(id)
);

INSERT INTO forum_users(USER_NAME,PASSWORD,EMAIL,REGISTERDATE,TYPE) VALUES('admin',PASSWORD('admin'),'qq@163.com',SYSDATE(),'Admin');
