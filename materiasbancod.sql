-- Cria o banco de dados com o novo nome
CREATE DATABASE IF NOT EXISTS materiasbancod;
USE materiasbancod;

-- Cria as tabelas básicas
CREATE TABLE turmas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE materias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('aluno', 'representante') DEFAULT 'aluno',
    turma_id INT NOT NULL,
    FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

CREATE TABLE tarefas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_entrega DATE NOT NULL,
    prioridade ENUM('alta', 'média', 'baixa') NOT NULL,
    concluida BOOLEAN DEFAULT FALSE,
    materia_id INT NOT NULL,
    aluno_id INT NOT NULL,
    FOREIGN KEY (materia_id) REFERENCES materias(id),
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
);

-- Insere dados de teste para a tela não ficar vazia
INSERT INTO turmas (nome) VALUES ('Informática 3º Ano');
INSERT INTO materias (nome) VALUES ('Matemática'), ('Biologia'), ('Programação Web');
INSERT INTO alunos (nome, email, senha, perfil, turma_id) VALUES ('Pedro Mendes', 'pedro@teste.com', '123', 'aluno', 1);

-- Insere tarefas para o aluno Pedro (id 1)
INSERT INTO tarefas (titulo, data_entrega, prioridade, concluida, materia_id, aluno_id) VALUES 
('Lista de Equações', '2026-05-30', 'alta', FALSE, 1, 1),
('Revisão Geral', '2026-06-05', 'média', TRUE, 1, 1),
('Trabalho sobre Células', '2026-06-10', 'alta', FALSE, 2, 1);