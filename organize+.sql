DROP DATABASE IF EXISTS organize;
CREATE DATABASE organize;
USE organize;
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    ra INT,
    turma VARCHAR(10)
);
CREATE TABLE materias (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    progresso DECIMAL(5,2) DEFAULT 0.00, -- Ex: 100.00%
    avisos VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
CREATE TABLE provas (
    id_prova INT AUTO_INCREMENT PRIMARY KEY,
    id_materia INT NOT NULL,
    data_prova DATE NOT NULL,
    valor DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);
CREATE TABLE trabalhos (
    id_trabalho INT AUTO_INCREMENT PRIMARY KEY,
    id_materia INT NOT NULL,
    data_entrega DATE NOT NULL,
    valor_trabalho DECIMAL(5,2),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);
CREATE TABLE desempenho (
    id_desempenho INT AUTO_INCREMENT PRIMARY KEY,
    id_materia INT NOT NULL,
    faltas INT DEFAULT 0,
    notas DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);
CREATE TABLE avisos (
    id_aviso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    aviso TEXT,
    data_aviso DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
CREATE TABLE tarefas (
    id_tarefa INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    status ENUM('pendente', 'em andamento', 'concluida') DEFAULT 'pendente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);