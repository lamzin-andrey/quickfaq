<?php

function findByAttributes() 
    $model = new ActiveRecord();
    $model->findByAttributes();
}
/**
 * В случае, если данные для ячеек сетки нельзя получить с помощью fillRelation
 * (например есть в таблице поле object_id но оно не уникально, есть еще object_type, определяющее таблицу)
 * В конфигурации виджета добавляем 'postInit' => array($this, 'getClientsInfo'), если оно 
*/
function gridViewPreloadCellData(){
    
}
