USE enterprise_workspace;

-- Insert test workspaces
INSERT INTO workspace (id, name, description) VALUES
('w1', 'Engineering Team', 'Software engineering department workspace'),
('w2', 'Marketing Team', 'Marketing department workspace'),
('w3', 'HR Department', 'Human Resources department workspace');

-- Insert test users
INSERT INTO users (id, name, password, email, status, birthday, phone_number, address) VALUES
('u1', 'John Doe', 'a2234567890123456789012', 'john@example.com', 'ACTIVE', '1990-01-15', '+1234567890', '123 Main St'),
('u2', 'Jane Smith', 'a2345678901234567890123', 'jane@example.com', 'ACTIVE', '1992-03-20', '+2345678901', '456 Oak Ave'),
('u3', 'Bob Wilson', 'a2456789012345678901234', 'bob@example.com', 'ACTIVE', '1988-07-10', '+3456789012', '789 Pine Rd'),
('u4', 'Alice Brown', 'a2567890123456789012345', 'alice@example.com', 'ACTIVE', '1995-11-30', '+4567890123', '321 Elm St');

-- Insert user-workspace relationships
INSERT INTO user_workspace (id, user_id, workspace_id, role, apartment, position) VALUES
('uw1', 'u1', 'w1', 'ADMIN', 'Engineering', 'Lead Developer'),
('uw2', 'u2', 'w1', 'MEMBER', 'Engineering', 'Frontend Developer'),
('uw3', 'u3', 'w2', 'ADMIN', 'Marketing', 'Marketing Manager'),
('uw4', 'u4', 'w3', 'ADMIN', 'HR', 'HR Manager'),
('uw5', 'u2', 'w2', 'MEMBER', 'Marketing', 'Content Writer');

-- Insert task lists
INSERT INTO task_list (id, name) VALUES
('tl1', 'Development Tasks'),
('tl2', 'Marketing Campaign'),
('tl3', 'HR Recruitment');

-- Insert tasks
INSERT INTO task (id, list_id, title, description, deadline, priority) VALUES
('t1', 'tl1', 'Implement Login Feature', 'Create user authentication system', '2025-05-01', 'High'),
('t2', 'tl1', 'Database Optimization', 'Optimize database queries for better performance', '2025-05-15', 'Medium'),
('t3', 'tl2', 'Social Media Campaign', 'Plan and execute Q2 social media campaign', '2025-06-01', 'High'),
('t4', 'tl3', 'Senior Developer Hiring', 'Recruit senior developer for engineering team', '2025-05-30', 'Medium');

-- Insert task members
INSERT INTO task_member (id, task_id, user_id) VALUES
('tm1', 't1', 'u1'),
('tm2', 't1', 'u2'),
('tm3', 't2', 'u1'),
('tm4', 't3', 'u3'),
('tm5', 't4', 'u4');

-- Insert labels
INSERT INTO label (id, name, color) VALUES
('l1', 'Bug', '#FF0000'),
('l2', 'Feature', '#00FF00'),
('l3', 'Enhancement', '#0000FF'),
('l4', 'Urgent', '#FF8800');

-- Insert task labels
INSERT INTO task_label (id, task_id, label_id) VALUES
('tl1', 't1', 'l2'),
('tl2', 't2', 'l3'),
('tl3', 't3', 'l4');

-- Insert conversations
INSERT INTO conversation (id, workspace_id, name, description, created_by) VALUES
('c1', 'w1', 'Engineering Daily Standup', 'Daily standup meeting chat', 'u1'),
('c2', 'w2', 'Marketing Team Chat', 'Marketing team discussion', 'u3'),
('c3', 'w3', 'HR Announcements', 'HR team announcements', 'u4');

-- Insert conversation members
INSERT INTO conversation_member (id, conversation_id, user_id, role) VALUES
('cm1', 'c1', 'u1', 'ADMIN'),
('cm2', 'c1', 'u2', 'MEMBER'),
('cm3', 'c2', 'u3', 'ADMIN'),
('cm4', 'c2', 'u2', 'MEMBER'),
('cm5', 'c3', 'u4', 'ADMIN');

-- Insert chat messages
INSERT INTO chat_message (id, conversation_id, sender_id, content, status) VALUES
('m1', 'c1', 'u1', 'Good morning team! What are your tasks for today?', 'SENT'),
('m2', 'c1', 'u2', 'Working on the login feature implementation', 'SENT'),
('m3', 'c2', 'u3', 'Team, lets discuss the new marketing campaign', 'SENT'),
('m4', 'c3', 'u4', 'Welcome to the HR announcements channel!', 'SENT');

-- Insert attendance logs
INSERT INTO attendance_log (id, workspace_id, user_id, work_date, check_in, check_out) VALUES
('a1', 'w1', 'u1', '2025-04-17', '2025-04-17 09:00:00', '2025-04-17 18:00:00'),
('a2', 'w1', 'u2', '2025-04-17', '2025-04-17 09:15:00', '2025-04-17 17:45:00'),
('a3', 'w2', 'u3', '2025-04-17', '2025-04-17 08:45:00', '2025-04-17 17:30:00'),
('a4', 'w3', 'u4', '2025-04-17', '2025-04-17 09:30:00', '2025-04-17 18:15:00');

-- Insert events
INSERT INTO event (id, workspace_id, user_id, date, work_content, report) VALUES
('e1', 'w1', 'u1', '2025-04-20', 'Team Building Activity', 'Planning team building event for engineering team'),
('e2', 'w2', 'u3', '2025-04-25', 'Marketing Strategy Meeting', 'Quarterly marketing strategy review'),
('e3', 'w3', 'u4', '2025-04-22', 'Employee Training', 'New employee orientation and training session');
