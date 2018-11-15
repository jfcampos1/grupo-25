$("#resultados-foro").html("<%= j render @foros %>")
$("#resultados-foro").append("<%= j render @posts %>")
