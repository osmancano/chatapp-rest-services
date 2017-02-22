INSERT INTO public.chat_user (id, display_name, password, username) VALUES (-1, 'Osman', 'admin', 'admin');

INSERT INTO public.chat_permissions (ID,permission_name,key) VALUES (1,'Create User','CREATE_USER');
INSERT INTO public.chat_permissions (ID,permission_name,key) VALUES (2,'Create Board','CREATE_BOARD');
INSERT INTO public.chat_permissions (ID,permission_name,key) VALUES (3,'Post Messages','POST_MESSAGE');

INSERT INTO public.chat_user_user_permissions (chat_user_id, user_permissions_id) VALUES (-1, 1);
INSERT INTO public.chat_user_user_permissions (chat_user_id, user_permissions_id) VALUES (-1, 2);
INSERT INTO public.chat_user_user_permissions (chat_user_id, user_permissions_id) VALUES (-1, 3);

INSERT INTO public.chat_board (id, description, board_name) VALUES (-1, 'Sample board', 'Java Coding');
INSERT INTO public.chat_board (id, description, board_name) VALUES (-2, 'Another Board', 'C# Coding');

INSERT INTO public.chat_message (id, image_file_name, message_text, posted_date, msg_board_id, msg_user_id) VALUES (-1, null, 'Welcome message 1', '2017-02-21 15:39:27.323000', -1, -1);
INSERT INTO public.chat_message (id, image_file_name, message_text, posted_date, msg_board_id, msg_user_id) VALUES (-2, null, 'Welcome message 1', '2017-02-21 15:39:30.396000', -1, -1);
INSERT INTO public.chat_message (id, image_file_name, message_text, posted_date, msg_board_id, msg_user_id) VALUES (-3, null, 'Welcome message 3', '2017-02-21 15:39:45.497000', -2, -1);
INSERT INTO public.chat_message (id, image_file_name, message_text, posted_date, msg_board_id, msg_user_id) VALUES (-4, null, 'Welcome message 4', '2017-02-21 15:39:52.106000', -2, -1);
