
DROP DATABASE IF EXISTS enterprise_workspace;
CREATE DATABASE enterprise_workspace;
USE enterprise_workspace;

-- Bảng workspace
CREATE TABLE workspace (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
     description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Bảng users (Đổi tên từ user do user là từ khóa SQL)
CREATE TABLE users (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
     password VARCHAR(255) NOT NULL, 
    email VARCHAR(255) UNIQUE NOT NULL,
    avatar VARCHAR(255),
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
     birthday DATE,
     phone_number VARCHAR(255),
     address VARCHAR(255)
);

-- Bảng user_workspace (Quan hệ nhiều - nhiều)
CREATE TABLE user_workspace (
    id CHAR(36) PRIMARY KEY,
    user_id CHAR(36),
    workspace_id CHAR(36),
    role ENUM('ADMIN', 'MEMBER') NOT NULL,
    apartment VARCHAR(255),
    position VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (workspace_id) REFERENCES workspace(id) ON DELETE CASCADE
);

-- Bảng conversation
CREATE TABLE conversation (
    id CHAR(36) PRIMARY KEY,
    workspace_id CHAR(36),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_by CHAR(36),
    FOREIGN KEY (workspace_id) REFERENCES workspace(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Bảng conversation_member
CREATE TABLE conversation_member (
    id CHAR(36) PRIMARY KEY,
    conversation_id CHAR(36),
    user_id CHAR(36),
    role ENUM('ADMIN', 'MEMBER') NOT NULL,
    FOREIGN KEY (conversation_id) REFERENCES conversation(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng chat_message
CREATE TABLE chat_message (
    id CHAR(36) PRIMARY KEY,
    conversation_id CHAR(36),
    sender_id CHAR(36),
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    reply_to CHAR(36) NULL,
    edited TINYINT(1) DEFAULT 0,
    status ENUM('SENT', 'READ', 'DELETED') DEFAULT 'SENT',
    FOREIGN KEY (conversation_id) REFERENCES conversation(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (reply_to) REFERENCES chat_message(id) ON DELETE SET NULL
);

-- Bảng chat_reaction
CREATE TABLE chat_reaction (
    id CHAR(36) PRIMARY KEY,
    message_id CHAR(36),
    user_id CHAR(36),
    reaction VARCHAR(10) NOT NULL,
    FOREIGN KEY (message_id) REFERENCES chat_message(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng chat_attachment
CREATE TABLE chat_attachment (
    id CHAR(36) PRIMARY KEY,
    message_id CHAR(36),
    file_path VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (message_id) REFERENCES chat_message(id) ON DELETE CASCADE
);

-- Bảng chat_call
CREATE TABLE chat_call (
    id CHAR(36) PRIMARY KEY,
    conversation_id CHAR(36),
    caller_id CHAR(36),
    type ENUM('AUDIO', 'VIDEO') NOT NULL,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (conversation_id) REFERENCES conversation(id) ON DELETE CASCADE,
    FOREIGN KEY (caller_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Bảng task_list
CREATE TABLE task_list (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Bảng task
CREATE TABLE task (
    id CHAR(36) PRIMARY KEY,
    list_id CHAR(36),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    deadline DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    FOREIGN KEY (list_id) REFERENCES task_list(id) ON DELETE CASCADE
);

-- Bảng task_member
CREATE TABLE task_member (
    id CHAR(36) PRIMARY KEY,
    task_id CHAR(36),
    user_id CHAR(36),
    FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Bảng task_attachment
CREATE TABLE task_attachment (
    id CHAR(36) PRIMARY KEY,
    task_id CHAR(36),
    file_path VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE
);

-- Bảng task_comment
CREATE TABLE task_comment (
    id CHAR(36) PRIMARY KEY,
    task_id CHAR(36),
    user_id CHAR(36),
    content TEXT NOT NULL,
    reply_to CHAR(36) NULL,
    FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reply_to) REFERENCES task_comment(id) ON DELETE SET NULL
);

CREATE TABLE label (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL
);

CREATE TABLE task_label (
    id CHAR(36) PRIMARY KEY,
    task_id CHAR(36),
    label_id CHAR(36),
    FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE,
    FOREIGN KEY (label_id) REFERENCES label(id) ON DELETE CASCADE
);

-- Bảng schedule
CREATE TABLE schedule (
    id CHAR(36) PRIMARY KEY,
    workspace_id CHAR(36),
    user_id CHAR(36),
    date DATE,
    work_content TEXT,
    report TEXT,
    FOREIGN KEY (workspace_id) REFERENCES workspace(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE schedule_task (
    id CHAR(36) PRIMARY KEY,
    schedule_id CHAR(36),
    title TEXT,
    description TEXT,
    FOREIGN KEY (schedule_id) REFERENCES schedule(id) ON DELETE CASCADE
);

-- Bảng chấm công (attendance_log)
CREATE TABLE attendance_log (
    id CHAR(36) PRIMARY KEY,
    workspace_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    work_date DATE NOT NULL,
    check_in TIMESTAMP NOT NULL,
    check_out TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (workspace_id) REFERENCES workspace(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE event (
    id CHAR(36) PRIMARY KEY,
    workspace_id CHAR(36),
    user_id CHAR(36),
    date DATE,
    work_content TEXT,
    report TEXT,
    FOREIGN KEY (workspace_id) REFERENCES workspace(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE event_comment (
    id CHAR(36) PRIMARY KEY,
    event_id CHAR(36),
    user_id CHAR(36),
    content TEXT NOT NULL,
    reply_to CHAR(36) NULL,
    FOREIGN KEY (event_id) REFERENCES event(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reply_to) REFERENCES event_comment(id) ON DELETE SET NULL
);

CREATE INDEX idx_attendance_log_workdate ON attendance_log(work_date);

-- Bảng lưu trữ dữ liệu khuôn mặt để điểm danh (user_face_log)
CREATE TABLE user_face_log (
    id CHAR(36) PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
