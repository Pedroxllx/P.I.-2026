<?php
// 1. CONEXÃO COM O BANCO DE DADOS
$host = 'localhost';
$dbname = 'materiasbancod'; // Nome do banco atualizado conforme o seu pedido
$username = 'root'; 
$password = ''; 

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro no banco: " . $e->getMessage());
}

// 2. BUSCA OS DADOS NO BANCO
$aluno_id = 1; // Simulando o login do aluno Pedro

$sql = "SELECT 
            m.id, 
            m.nome,
            COUNT(t.id) AS total_tarefas,
            SUM(CASE WHEN t.concluida = 1 THEN 1 ELSE 0 END) AS tarefas_concluidas
        FROM materias m
        LEFT JOIN tarefas t ON m.id = t.materia_id AND t.aluno_id = :aluno_id
        GROUP BY m.id";

$stmt = $pdo->prepare($sql);
$stmt->bindParam(':aluno_id', $aluno_id, PDO::PARAM_INT); 
$stmt->execute();
$lista_materias = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minhas Matérias - ORGANIZE+</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .navbar-custom { background-color: #0d47a1; color: white; }
    </style>
</head>
<body>

    <nav class="navbar navbar-custom py-3 mb-5">
        <div class="container">
            <a class="navbar-brand fw-bold text-white" href="#">🎓 Organize+</a>
        </div>
    </nav>

    <div class="container bg-white p-5 rounded-4 shadow-sm">
        <h2 class="mb-4">Minhas Matérias</h2>
        <div class="row">
            
            <?php foreach ($lista_materias as $materia): ?>
                
                <?php 
                    // Cálculo de Progresso (Regra RGN004)
                    $total = $materia['total_tarefas'];
                    $concluidas = $materia['tarefas_concluidas'] ? $materia['tarefas_concluidas'] : 0;
                    
                    if ($total > 0) {
                        $progresso = round(($concluidas / $total) * 100);
                    } else {
                        $progresso = 0;
                    }
                ?>

                <div class="col-md-6 mb-4">
                    <div class="card p-3 shadow-sm border-0 bg-light">
                        <div class="card-body">
                            <h5 class="fw-bold text-primary"><?= htmlspecialchars($materia['nome']) ?></h5>
                            <p class="mb-1 text-dark">Progresso: <?= $progresso ?>%</p>
                            
                            <div class="progress mb-3" style="height: 10px;">
                                <div class="progress-bar bg-primary" style="width: <?= $progresso ?>%;"></div>
                            </div>
                            
                            <p class="text-muted small">Total: <?= $total ?> tarefas | Concluídas: <?= $concluidas ?></p>
                        </div>
                    </div>
                </div>

            <?php endforeach; ?>
            
        </div>
    </div>

</body>
</html>