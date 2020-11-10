module Index
 #https://ruhighload.com/%D0%98%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5+%D0%B8%D0%BD%D0%B4%D0%B5%D0%BA%D1%81%D0%BE%D0%B2+%D0%B2+clickhouse
 #~ CREATE TABLE products_views (
    #~ date Date,
    #~ product_id UInt32,
    #~ product_name String,
    #~ product_category UInt8
#~ ) ENGINE = MergeTree(date, (product_id), 8192)


#~ Конструкция MergeTree объявляет индекс:

    #~ date — название колонки, в которой находится дата. В clickhouse это обязательно, т.к. все данные всегда распределены по значениям этой колонки.
    #~ product_id — название колонки, по которой строится индекс.
    #~ 8192 — гранулированность индекса (используйте значение из примера). 

#~ С такой структурой индекса, запросы будут эффективными:

#~ SELECT count(*) FROM products_views WHERE product_id = 751

#~ # в таком запросе будет использован индекс

#~ Индекс может состоять из нескольких колонок (составной индекс):

#~ CREATE TABLE products_views (
    #~ date Date,
    #~ product_id UInt32,
    #~ product_name String,
    #~ product_category UInt8
#~ ) ENGINE = MergeTree(date, (product_id, url), 8192)

#~ # Составной индекс

#~ Однако в этом случае, в выборке могут использоваться колонки слева-направо
 #~ (фильтр по одной только колонке url не использует индекс).
 #~ Как и в других базах данных индекс будет использован в случае не только равенства, а и неравенства и операции IN. 
 
end
