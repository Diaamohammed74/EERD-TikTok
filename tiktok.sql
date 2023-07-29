create database tikotk

-- Create User table
create table users(
  users_id INT PRIMARY KEY ,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
	created_at datetime default GETDATE() NOT NULL,
  user_type bit NOT NULL,
);

alter table users
add constraint unique_email unique (email);


select * from users 
-- Create business_user table
create table business_user
(
  busi_address VARCHAR(50) NOT NULL,
  users_id INT NOT NULL,
  PRIMARY KEY (users_id),
  FOREIGN KEY (users_id) REFERENCES users(users_id)
);
select * from business_user 
-- Create public_user table
create table public_user
(
  bitrhdate date NOT NULL,
  bio VARCHAR(50) NOT NULL,
  profile_img VARCHAR(50) NOT NULL,
  identifier_name VARCHAR(50) unique,
  users_id INT NOT NULL,
  PRIMARY KEY (users_id),
  FOREIGN KEY (users_id) REFERENCES users(users_id),
);
select * from public_user 



-- Create country table
create table country
(
  country_id INT primary key NOT NULL,
  country_name VARCHAR(255) NOT NULL,
);
select * from country 

-- Create catgeory table
create table category
(
  cat_id INT primary key NOT NULL,
  cat_name VARCHAR(255) NOT NULL,
);
select * from category 

-- Create company table
create table company
(
  com_id INT primary key NOT NULL,
  comp_name VARCHAR(255) NOT NULL,
  logo varchar(50) NOT NULL,
  website VARCHAR(255) not null,
  owner_id int foreign key references business_user (users_id),
   category_id int foreign key references category (cat_id),
     country int foreign key references country(country_id)

);
select * from company

-- Create company_phone table
create table company_phone
(
  phone INT NOT NULL,
  com_id int foreign key references company (com_id),
  PRIMARY KEY (phone,com_id),
);
select * from company_phone

-- Create compaign table
create table compaign
(
  compaign_id INT primary key NOT NULL,
  compaign_name VARCHAR(50) NOT NULL,
  budget money NOT NULL,
  status bit NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  users_id int foreign key references business_user (users_id),

);
select * from compaign
-- Create ads table
create table ads
(
  ad_id INT primary key NOT NULL,
  ad_name VARCHAR(50) NOT NULL,
  end_time date NOT NULL,
  start_time date NOT NULL,
  ad_status bit NOT NULL,
  ad_bid money NOT NULL,
  --ad_type INT NOT NULL,--
  compaign_id int foreign key references compaign (compaign_id),
);
select * from ads

-- Create social_media_acc table
create table social_media_acc
(
  acc_id int primary key NOT NULL,
  social_account varchar(255) NOT NULL,
  users_id int foreign key references public_user (users_id),
);
select * from social_media_acc

-- Create account_settings table
create table account_settings
(
  setting_id int primary key NOT NULL,
  show_following_list bit NOT NULL,
  profile_view bit NOT NULL,
  comment_available bit NOT NULL,
  mentions bit NOT NULL,
  duet bit NOT NULL,
  stich bit NOT NULL,
  showing_liked_vids bit NOT NULL,
  private_account bit NOT NULL,
  showing_liked_auds bit NOT NULL,
  users_id int foreign key references users (users_id),
);
select * from account_settings


-- Create audio table
create table audio
(
  audio_id  INT primary key,
  audio_name VARCHAR(255) NOT NULL,
  audio_content VARCHAR(255) NOT NULL,
  created_at datetime NOT NULL,
  users_id int foreign key references users (users_id),
);
select * from audio

-- Create hashtags table
create table hashtags
(
  hash_id int primary key NOT NULL,
  hash_name varchar(255) NOT NULL,
);
select * from hashtags

-- Create gifts table
create table gifts
(
  gift_id INT primary key NOT NULL,
  gift_name VARCHAR(255) NOT NULL,
  price_by_coins money NOT NULL,
  gift_img VARCHAR(255) NOT NULL,
  gift_desc VARCHAR(255) NOT NULL,
);
select * from gifts

-- Create purchase table
create table user_purchase_gift
(
  users_id int foreign key references users (users_id),
  gift_id int foreign key references gifts (gift_id),
  quantity INT NOT NULL,
  amount_by_coins money NOT NULL,
);
select * from user_purchase_gift

-- Create has table
create table user_has_gifts
(
  users_id int foreign key references users (users_id),
  gift_id int foreign key references gifts (gift_id),
  quantity INT NOT NULL,
);




-- Create video table
create table video
(
  video_id INT primary key NOT NULL,
  created_at datetime DEFAULT GETDATE() NOT NULL,
  updated_at datetime DEFAULT GETDATE() NOT NULL,
  video_type bit NOT NULL,
  users_id int foreign key references users (users_id),
  audio_id int foreign key references audio (audio_id),

);
select * from video

-- Create post table
create table post
(
  post_id INT primary key NOT NULL,
  post_desc varchar(255) NOT NULL,
  post_content varchar(255) NOT NULL,
  video_id int foreign key references video (video_id),
);
select * from post

--normalization post_ads--
create table post_ads
(
  post_id int foreign key references post (post_id),
   ad_id int foreign key references ads (ad_id),
   primary key(post_id,ad_id)
)
select * from post_ads

-- Create send gifts table
create table user_send_gifts
(
  user_sender_id int foreign key references users (users_id),
  post_id int foreign key references post (post_id),
  gift_id int foreign key references gifts (gift_id),
  quantity INT NOT NULL
);
select * from user_send_gifts

-- Create story table
create table story
(
  video_id INT NOT NULL,
  PRIMARY KEY (video_id),
  FOREIGN KEY (video_id) REFERENCES video(video_id)
);

-- Create hashtag table
create table hashtag
(
  post_id int foreign key references post (post_id),
  hash_id int foreign key references hashtags (hash_id),
  PRIMARY KEY (post_id,hash_id),
);

-- Create view table
create table view_
(
  user_viewer_id int foreign key references users (users_id),
  video_id int foreign key references video (video_id),
  primary key(user_viewer_id,video_id)
);

-- Create react table
create table react
(
  users_id int foreign key references users (users_id),
  post_id int foreign key references post (post_id),
   primary key(users_id,post_id)
);

-- Create comment table
create table comment
(
  users_id int foreign key references users (users_id),
  post_id int foreign key references post (post_id),
  content varchar(255) not null,
  primary key(users_id,post_id)
);


create table follow(
    follower_id INT,
    following_id INT,
    FOREIGN KEY ("follower_id") REFERENCES users(users_id),
    FOREIGN KEY ("following_id") REFERENCES users(users_id),
);


select count(users_id) from users where user_type=0

--	public user 0
--	business user 1 

--users data
INSERT INTO users (users_id, email, password, created_at, user_type)
VALUES /*(1, 'user1@example.com', 'password1', GETDATE(), 0),
       (2, 'user2@example.com', 'password2', GETDATE(), 0),
       (3, 'user3@example.com', 'password3', GETDATE(), 1),
       (4, 'user4@example.com', 'password4', GETDATE(), 1),*/
	   (5, 'user5@example.com', 'password5', GETDATE(), 1),
	   (6, 'user6@example.com', 'password6', GETDATE(), 1),
	   (7, 'user7@example.com', 'password7', GETDATE(), 1),
	   (8, 'user8@example.com', 'password8', GETDATE(), 1),
	   (9, 'user9@example.com', 'password9', GETDATE(), 1),
	   (10, 'user10@example.com', 'password10', GETDATE(), 1),
	   (11, 'user11@example.com', 'password11', GETDATE(), 1),
	   (12, 'user12@example.com', 'password12', GETDATE(), 1),
	   (13, 'user13@example.com', 'password13', GETDATE(), 0),
	   (14, 'user14@example.com', 'password14', GETDATE(), 0),
	   (15, 'user15@example.com', 'password15', GETDATE(), 0),
	   (16, 'user16@example.com', 'password16', GETDATE(), 0),
	   (17, 'user17@example.com', 'password17', GETDATE(), 0),
	   (18, 'user18@example.com', 'password18', GETDATE(), 0),
	   (19, 'user19@example.com', 'password19', GETDATE(), 0),
	   (21, 'user20@example.com', 'password20', GETDATE(), 0);


--business_user data
INSERT INTO business_user (busi_address, users_id)
VALUES /*('Business Address 1', 3),
       ('Business Address 2', 4),*/
       ('Business Address 3', 5),
       ('Business Address 4', 6),
       ('Business Address 5', 7),
       ('Business Address 6', 8),
       ('Business Address 7', 9),
       ('Business Address 8', 10),
       ('Business Address 8', 11),
       ('Business Address 10', 12);
	   select * from public_user

--public_user data
INSERT INTO public_user (bitrhdate, bio, profile_img, identifier_name, users_id)
VALUES /*('1990-01-01', 'Bio 1', 'profile1.jpg', 'user1', 1),
       ('1995-02-02', 'Bio 2', 'profile2.jpg', 'user2', 2),*/
       ('1995-02-02', 'Bio 13', 'profile13.jpg', 'user3', 13),
       ('1995-02-02', 'Bio 14', 'profile14.jpg', 'user4', 14),
       ('1995-02-02', 'Bio 15', 'profile15.jpg', 'user5', 15),
       ('1995-02-02', 'Bio 16', 'profile16.jpg', 'user6', 16),
       ('1995-02-02', 'Bio 17', 'profile17.jpg', 'user7', 17),
       ('1995-02-02', 'Bio 18', 'profile18.jpg', 'user8', 18),
       ('1995-02-02', 'Bio 19', 'profile19.jpg', 'user9', 19),
       ('1995-02-02', 'Bio 20', 'profile20.jpg', 'user10', 20);


--country data
INSERT INTO country (country_id, country_name)
VALUES (1, 'Country 1'),
       (2, 'Country 2');

--category data
INSERT INTO category (cat_id, cat_name)
VALUES (1, 'Category 1'),
       (2, 'Category 2');

--company data
INSERT INTO company (com_id, comp_name, logo, website, owner_id, category_id, country)
VALUES /*(1, 'Company 1', 'logo1.jpg', 'www.company1.com', 3, 1, 1),
       (2, 'Company 2', 'logo2.jpg', 'www.company2.com', 4, 2, 2),*/
       (3, 'Company 3', 'logo3.jpg', 'www.company3.com', 5, 1, 1),
       (4, 'Company 4', 'logo4.jpg', 'www.company4.com', 6, 2, 1),
       (5, 'Company 5', 'logo5.jpg', 'www.company5.com', 7, 1, 2),
       (6, 'Company 6', 'logo6.jpg', 'www.company6.com', 8, 2, 2),
       (7, 'Company 7', 'logo7.jpg', 'www.company7.com', 9, 1, 1),
       (8, 'Company 8', 'logo8.jpg', 'www.company8.com', 10, 2, 2),
       (9, 'Company 9', 'logo9.jpg', 'www.company9.com', 11, 1, 1),
       (10, 'Company 10', 'logo10.jpg', 'www.company10.com', 12, 2, 1);
--company_phone data
INSERT INTO company_phone (phone, com_id)
VALUES (01111, 1),
       (01212, 1),
       (01313, 2),
       (01414, 2);

-- compaign data
INSERT INTO compaign (compaign_id, compaign_name, budget, status, start_date, end_date, users_id)
VALUES
  /*(1, 'Campaign 1', 10000, 1, '2023-01-01', '2023-01-31', 3),
  (2, 'Campaign 2', 20000, 0, '2023-02-01', '2023-02-28', 4),*/
  (3, 'Campaign 3', 15000, 1, '2023-03-01', '2023-03-31', 5),
  (4, 'Campaign 4', 12000, 1, '2023-04-01', '2023-04-30', 6),
  (5, 'Campaign 5', 18000, 0, '2023-05-01', '2023-05-31', 7),
  (6, 'Campaign 6', 9000, 1, '2023-06-01', '2023-06-30', 8),
  (7, 'Campaign 7', 25000, 1, '2023-07-01', '2023-07-31', 9);
  select * from compaign
    select * from ads

--ads data
insert into ads (ad_id, ad_name, end_time, start_time, ad_status, ad_bid, compaign_id)
values /*(1, 'Ad 1', '2023-01-31', '2023-01-01', 1, 100, 1),
       (2, 'Ad 2', '2023-02-28', '2023-02-01', 0, 200, 2),*/
       (3, 'Ad 3', '2023-03-31', '2023-03-01', 1, 150, 3),
       (4, 'Ad 4', '2023-04-30', '2023-04-01', 1, 120, 4),
       (5, 'Ad 5', '2023-05-31', '2023-05-01', 0, 180, 5),
       (6, 'Ad 6', '2023-06-30', '2023-06-01', 1, 90, 6),
       (7, 'Ad 7', '2023-07-31', '2023-07-01', 1, 250, 7),
       (8, 'Ad 8', '2023-08-31', '2023-08-01', 1, 300, 5),
       (9, 'Ad 9', '2023-09-30', '2023-09-01', 0, 180, 4),
       (10, 'Ad 10', '2023-10-31', '2023-10-01', 1, 200,3),
       (11, 'Ad 11', '2023-11-30', '2023-11-01', 1, 150,1),
       (12, 'Ad 12', '2023-12-31', '2023-12-01', 0, 120, 2);


--social_media_acc data
INSERT INTO social_media_acc (acc_id, social_account, users_id)
VALUES (1, 'Social Account 1', 1),
       (2, 'Social Account 2', 2);

--account_settings data
INSERT INTO account_settings (setting_id, show_following_list, profile_view, comment_available, mentions, duet, stich, showing_liked_vids, private_account, showing_liked_auds, users_id)
VALUES
  /*(1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1),
  (2, 0, 1, 0, 0, 1, 1, 0, 1, 0, 2),*/
  (3, 1, 0, 1, 1, 0, 1, 1, 0, 1, 3),
  (4, 1, 1, 0, 0, 1, 0, 0, 1, 0, 4),
  (5, 0, 1, 1, 1, 0, 0, 1, 0, 1, 5),
  (6, 0, 0, 1, 0, 1, 1, 0, 1, 0, 6),
  (7, 1, 1, 0, 1, 0, 1, 1, 0, 1, 7),
  (8, 1, 0, 1, 0, 1, 0, 0, 1, 0, 8),
  (9, 0, 1, 1, 1, 0, 1, 1, 0, 1, 9),
  (10, 1, 0, 0, 0, 1, 1, 0, 1, 0, 10),
  (11, 1, 1, 1, 1, 0, 0, 1, 0, 1, 11),
  (12, 0, 1, 0, 0, 1, 1, 0, 1, 0, 12),
  (13, 1, 0, 1, 1, 0, 1, 1, 0, 1, 13),
  (14, 1, 1, 0, 0, 1, 0, 0, 1, 0, 14),
  (15, 0, 1, 1, 1, 0, 0, 1, 0, 1, 15),
  (16, 0, 0, 1, 0, 1, 1, 0, 1, 0, 16),
  (17, 1, 1, 0, 1, 0, 1, 1, 0, 1, 17),
  (18, 1, 0, 1, 0, 1, 0, 0, 1, 0, 18),
  (19, 0, 1, 1, 1, 0, 1, 1, 0, 1, 19),
  (20, 1, 0, 0, 0, 1, 1, 0, 1, 0, 20);


--audio data
INSERT INTO audio (audio_id, audio_name, audio_content, created_at, users_id)
VALUES
  /*(1, 'Audio 1', 'audio1.mp3', GETDATE(), 1),
  (2, 'Audio 2', 'audio2.mp3', GETDATE(), 2),
  */
  (3, 'Audio 3', 'audio3.mp3', GETDATE(), 3),
  (4, 'Audio 4', 'audio4.mp3', GETDATE(), 4),
  (5, 'Audio 5', 'audio5.mp3', GETDATE(), 5),
  (6, 'Audio 6', 'audio6.mp3', GETDATE(), 6),
  (7, 'Audio 7', 'audio7.mp3', GETDATE(), 7);


--hashtags data
INSERT INTO hashtags (hash_id, hash_name)
VALUES
  /*(1, 'Hashtag 1'),
  (2, 'Hashtag 2'),*/
  (3, 'Hashtag 3'),
  (4, 'Hashtag 4'),
  (5, 'Hashtag 5'),
  (6, 'Hashtag 6'),
  (7, 'Hashtag 7'),
  (8, 'Hashtag 8'),
  (9, 'Hashtag 9'),
  (10, 'Hashtag 10'),
  (11, 'Hashtag 11'),
  (12, 'Hashtag 12'),
  (13, 'Hashtag 13'),
  (14, 'Hashtag 14'),
  (15, 'Hashtag 15'),
  (16, 'Hashtag 16'),
  (17, 'Hashtag 17'),
  (18, 'Hashtag 18'),
  (19, 'Hashtag 19'),
  (20, 'Hashtag 20');


--gifts data
INSERT INTO gifts (gift_id, gift_name, price_by_coins, gift_img, gift_desc)
VALUES
  /*(1, 'Gift 1', 10, 'gift1.jpg', 'Gift 1 description'),
  (2, 'Gift 2', 20, 'gift2.jpg', 'Gift 2 description'),
  (3, 'Gift 3', 15, 'gift3.jpg', 'Gift 3 description'),
  (4, 'Gift 4', 25, 'gift4.jpg', 'Gift 4 description'),
  (5, 'Gift 5', 30, 'gift5.jpg', 'Gift 5 description'),
  (6, 'Gift 6', 12, 'gift6.jpg', 'Gift 6 description'),
  (7, 'Gift 7', 18, 'gift7.jpg', 'Gift 7 description'),
  (8, 'Gift 8', 22, 'gift8.jpg', 'Gift 8 description'),
  (9, 'Gift 9', 28, 'gift9.jpg', 'Gift 9 description'),
  (10, 'Gift 10', 35, 'gift10.jpg', 'Gift 10 description'),*/
  (11, 'Gift 11', 14, 'gift11.jpg', 'Gift 11 description'),
  (12, 'Gift 12', 21, 'gift12.jpg', 'Gift 12 description'),
  (13, 'Gift 13', 27, 'gift13.jpg', 'Gift 13 description'),
  (14, 'Gift 14', 33, 'gift14.jpg', 'Gift 14 description'),
  (15, 'Gift 15', 16, 'gift15.jpg', 'Gift 15 description'),
  (16, 'Gift 16', 24, 'gift16.jpg', 'Gift 16 description'),
  (17, 'Gift 17', 31, 'gift17.jpg', 'Gift 17 description'),
  (18, 'Gift 18', 38, 'gift18.jpg', 'Gift 18 description'),
  (19, 'Gift 19', 19, 'gift19.jpg', 'Gift 19 description'),
  (20, 'Gift 20', 26, 'gift20.jpg', 'Gift 20 description');


--user_purchase_gift data
INSERT INTO user_purchase_gift (users_id, gift_id, quantity, amount_by_coins)
VALUES
  (1, 5, 5, 50),
  (2, 5, 10, 200),
  (3, 15, 3, 30),
  (4, 12, 7, 70),
  (5, 16, 2, 20),
  (6, 15, 8, 80),
  (13, 15, 4, 40),
  (18, 16, 6, 60),
  (19, 16, 9, 90),
  (20, 16, 1, 10);

  select gift_id,sum(quantity) from user_purchase_gift
  group by gift_id


--user_has_gifts data
INSERT INTO user_has_gifts (users_id, gift_id, quantity)
VALUES (1, 1, 5),
       (2, 2, 10),
       (3, 2, 10),
       (4, 2, 10),
       (2, 2, 10);


--video data
select * from audio
INSERT INTO video (video_id, created_at, updated_at, video_type, users_id, audio_id)
VALUES
  /*(1, GETDATE(), GETDATE(), 1, 1, 1),
  (2, GETDATE(), GETDATE(), 0, 2, 2),*/
  (3, GETDATE(), GETDATE(), 1, 3, 3),
  (4, GETDATE(), GETDATE(), 0, 4, 4),
  (5, GETDATE(), GETDATE(), 1, 5, 5),
  (6, GETDATE(), GETDATE(), 0, 6, 6),
  (7, GETDATE(), GETDATE(), 1, 7, 7),
  (8, GETDATE(), GETDATE(), 0, 8, 3),
  (9, GETDATE(), GETDATE(), 1, 9, 3),
  (10, GETDATE(), GETDATE(), 0, 10, 2),
  (11, GETDATE(), GETDATE(), 1, 1, 2),
  (12, GETDATE(), GETDATE(), 0, 2, 2),
  (13, GETDATE(), GETDATE(), 1, 3, 1),
  (14, GETDATE(), GETDATE(), 0, 4, 1),
  (15, GETDATE(), GETDATE(), 1, 5, 1),
  (16, GETDATE(), GETDATE(), 0, 6, 1),
  (17, GETDATE(), GETDATE(), 1, 7, 6),
  (18, GETDATE(), GETDATE(), 0, 8, 5),
  (19, GETDATE(), GETDATE(), 1, 9, 1),
  (20, GETDATE(), GETDATE(), 0, 10, 2);

  select video_id from video where video_type=0
--post data
INSERT INTO post (post_id, post_desc, post_content, video_id)
VALUES
  /*(1, 'Post 1', 'Post content 1', 1),
  (2, 'Post 2', 'Post content 2', 2),*/
  (3, 'Post 3', 'Post content 3', 2),
  (4, 'Post 4', 'Post content 4', 4),
  (5, 'Post 5', 'Post content 5', 6),
  (6, 'Post 6', 'Post content 6', 10),
  (7, 'Post 7', 'Post content 7', 12),
  (8, 'Post 8', 'Post content 8', 14),
  (9, 'Post 9', 'Post content 9', 18),
  (10, 'Post 10', 'Post content 10',20);


--post_ads data
INSERT INTO post_ads (post_id, ad_id)
VALUES (1, 1),
       (2, 2);
	   select *from post_ads

-- Insert dummy data into user_send_gifts table
INSERT INTO user_send_gifts (user_sender_id, post_id, gift_id, quantity)
VALUES (1, 1, 1, 2),
       (2, 2, 2, 3);

-- Insert dummy data into story table
INSERT INTO story (video_id)
VALUES (1),
       (2);

-- hashtag data
INSERT INTO hashtag (post_id, hash_id)
VALUES /*(1, 1),
       (2, 2),*/
       (2, 5),
       (2, 6),
       (3, 6),
       (3, 5),
       (1, 2),
       (2, 3);

-- Insert dummy data into view_ table
INSERT INTO view_ (user_viewer_id, video_id)
VALUES (1, 1),
       (2, 2),
       (3, 2),
       (4, 2),
       (5, 2),
       (2, 2),
       (2, 2),
       (2, 2),
       (2, 2),
       (2, 2),(1, 3),
       (2, 3),
       (3, 3),
       (4, 3),
       (5, 3),
       (2, 3),
       (2, 3);


-- Insert dummy data into react table
INSERT INTO react (users_id, post_id)
VALUES (1, 1),
       (2, 2);

-- Insert dummy data into comment table
INSERT INTO comment (users_id, post_id,content)
VALUES (1, 1,'comment comment'),
       (2, 2,'commen');

	   select * from comment

drop table comment
-- Insert dummy data into follow table
INSERT INTO follow (follower_id, following_id)
VALUES (1, 2),
       (2, 1);

	   


/*
	1 -> trigger to minus the quantity the user send of specifc gift to post 
*/
create trigger tr_update_user_has_gifts 
	on user_send_gifts after
	insert 
	as begin
	set NOCOUNT on;
	update user_has_gifts
	set quantity = user_has_gifts.quantity - inserted.quantity
	from user_has_gifts
	join inserted on user_has_gifts.users_id = inserted.user_sender_id
	and user_has_gifts.gift_id = inserted.gift_id; 
end;



INSERT INTO user_send_gifts (user_sender_id, post_id, gift_id, quantity)
VALUES (1, 1, 1, 2);

select * from user_has_gifts


/*
	2-> top 10 viewd videos
*/

select top 10 video.video_id,users.users_id,count(view_.video_id) 
as' number of views' 
from view_ join video
on view_.video_id=video.video_id
join users 
on users.users_id=video.users_id
group by users.users_id,video.video_id
order by ' number of views' desc


/* 
	3-> The Trendy Hashtag 
*/

select post_hashtag.hash_id,hashtags.hash_name, count(post_hashtag.hash_id) AS count
from post_hashtag join hashtags 
on post_hashtag.hash_id=hashtags.hash_id
group by post_hashtag.hash_id,hashtags.hash_name
having count(post_hashtag.hash_id) = (
    select max(count) from (
        select count(post_hashtag.hash_id) as count
        from post_hashtag
        group by post_hashtag.hash_id
    ) as count
);

/* 
	4-> The Maximum active cmopaign budget and its user email
*/

select * from compaign

select compaign.compaign_name,users.email
from compaign join users
on users.users_id=compaign.users_id
where compaign.budget=(
	select max(compaign.budget) from compaign
where compaign.status=1
)
/*
	5-> The most user has recieved gifts from his posts
*/

select top 1 users.users_id,count(gifts.gift_id) as'num of gifts'
from users
join video 
on users.users_id = video.users_id
join post 
on video.video_id = post.video_id
join user_send_gifts 
on user_send_gifts.user_sender_id = users.users_id
join gifts 
on user_send_gifts.gift_id = gifts.gift_id
group by users.users_id,users.users_id
order by 'num of gifts' desc

select *from user_send_gifts
--showing posts that take the max used hashtag

SELECT hashtags.hash_name, post.post_id
FROM hashtags
JOIN post_hashtag 
ON post_hashtag.hash_id = hashtags.hash_id
JOIN post 
ON post.post_id = post_hashtag.post_id
WHERE post_hashtag.hash_id = (
    SELECT TOP 1 hashtags.hash_id
    FROM hashtags
    JOIN post_hashtag 
	ON post_hashtag.hash_id = hashtags.hash_id
    GROUP BY hashtags.hash_id
    ORDER BY COUNT(*) DESC
);




--huge entries 

INSERT INTO view_ (user_viewer_id, video_id)
SELECT u.users_id, v.video_id
FROM (
  SELECT TOP 20 users_id
  FROM users
  order by users_id desc
) AS u
CROSS JOIN (
  SELECT  video_id
  FROM video where video_id=4
) AS v;


/*
Retrieve the usernames of users who have posted videos
with the same audio content
as a specific user, excluding the specific user:
*/

