analytics=> SELECT * FROM deals LIMIT 3;
  dealid   | state  | provider  |                             piececid                             |  piecesize  | startepoch | price | verified | clientid  
-----------+--------+-----------+------------------------------------------------------------------+-------------+------------+-------+----------+-----------
 127969756 | active | f02011071 | baga6ea4seaqp3gjn7zu5xkm37cyly3wu676cu7j7vfgt4jflvlz27rsuf2bnwna | 34359738368 |    5313270 |     0 | t        | f03510418
 127970542 | active | f02011071 | baga6ea4seaqlgosxxczh6uxw52t4btdj6dsdooa4nhkye3i77qe4m775522wuly | 34359738368 |    5313330 |     0 | t        | f03510418
 127972638 | active | f02011071 | baga6ea4seaqmbepwydqx5so7rmwek67o4lxdhumqsd5zwdfoyjnghovh4bhrioq | 34359738368 |    5313450 |     0 | t        | f03510418
(3 rows)

    
analytics=> SELECT * FROM clients LIMIT 3;
 clientid  |               clientaddress               | active | clientowner 
-----------+-------------------------------------------+--------+-------------
 f02208630 | f1i2reokfclrqls5mkgtbqk5esvj6it7nykv7c57y | t      | PA
 f03091977 | f1hnvljphtrpwb6pxszxoh7k57br7goo33s6b22ry | t      | PA
 f01131298 | f1wp6zoxj7sydnrywvzp276x3gayghi7r6le4tcwy | f      | IA
(3 rows)

   
analytics=> SELECT * FROM pieces LIMIT 3;
                             piececid                             |  piecesize  |                           rootcid                           |  filesize   | storageid | prepid | isdag 
------------------------------------------------------------------+-------------+-------------------------------------------------------------+-------------+-----------+--------+-------
 baga6ea4seaqjddhbjguualtiog5apjboeu4f4qudqe7dkxhhijljiigjamxzuey | 34359738368 | bafkreih3mvkpx7lscy6bxduci2c47beubzx2v4k2zsclqeiaosjh77gpzm | 33288862478 |         1 |      1 | f
 baga6ea4seaql7csiwamyq2ub7qehepksq666t32hlxzro5osxaco6vps3bieigi | 34359738368 | bafkreieaz6ktv6uom2cnxj2qiyrfaidrkdcwd2asotclgon7azdl7vza6u | 33196287967 |         1 |      1 | f
 baga6ea4seaqcwb27vkaf6mwo6mwfjg7xp4gwp74onc52l3hty73zhq6tmugiyja | 34359738368 | bafkreiexih3jlpavsvafpwpnxpznlrsrqg2vi2svjzlvau6oflmlldaxya | 33288823369 |         1 |      1 | f
(3 rows)

                               
analytics=> SELECT * FROM storages LIMIT 3;
 storageid |          storagename           |      type       |              path              
-----------+--------------------------------+-----------------+--------------------------------
         1 | 201569_News_Footage_1954_Can_7 | internetarchive | 201569_News_Footage_1954_Can_7
         2 | 200566_Mode_Art_Can_8017       | internetarchive | 200566_Mode_Art_Can_8017
         3 | 200349_Mode_Art_Can_2832       | internetarchive | 200349_Mode_Art_Can_2832
(3 rows)

   
analytics=> SELECT * FROM preparations LIMIT 3;
 prepid |                                       name                                       | storageid 
--------+----------------------------------------------------------------------------------+-----------
      1 | 201569_News_Footage_1954_Can_7 false 33822867456 34359738368 1048576 false false |         1
      4 | The_Story_of_Television false 33822867456 34359738368 1048576 false false        |         4
    122 | 202086_The_Sound_Of_A_Million false 33822867456 34359738368 1048576 false false  |       122
(3 rows)


analytics=> SELECT * FROM items LIMIT 3;
           identifier           | itemsizegib | preparationid | piecescount | packedsizegib 
--------------------------------+-------------+---------------+-------------+---------------
 201569_News_Footage_1954_Can_7 |     602.910 |             1 |          21 |       602.961
 200566_Mode_Art_Can_8017       |     585.124 |             2 |          20 |       585.173
 200349_Mode_Art_Can_2832       |     584.391 |             3 |          20 |       584.440
(3 rows)
