
CREATE TABLE Person(
    Person_Id INT PRIMARY KEY,         -- מזהה ייחודי לכל אדם
    Personal_Name VARCHAR(20) NOT NULL, -- שם פרטי
    Family_Name VARCHAR(20) NOT NULL,   -- שם משפחה
    Gender enum("זכר","נקבה") NOT NULL,         -- מגדר (למשל: זכר, נקבה)
    Father_Id INT ,                   -- מזהה האב (יכול להיות NULL אם לא קיים)
    Mother_Id INT ,                   -- מזהה האם (יכול להיות NULL אם לא קיים)
    Spouse_Id INT 
);

create table Family_Tree(Person_Id int,
						Relative_Id int, 
                        Conection_Type enum("אבא","אמא","אח","אחות","בן","בת","בן זוג","בת זוג"));
                        
             
                        
-- תרגיל 1
DELIMITER //

CREATE PROCEDURE InsertFamilyTree()
BEGIN
    -- מגדירים טיפול בשגיאה: במקרה של חריגה, מבצעים ROLLBACK ואז מעבירים את השגיאה הלאה
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
-- אבא
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT Person_Id, Father_Id, 'אבא'
    FROM Person
    WHERE Father_Id IS NOT NULL;
-- אמא
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT Person_Id, Mother_Id, 'אמא'
    FROM Person
    WHERE Mother_Id IS NOT NULL;
    
-- אח, אפ יש ל2 האנשים אותו אבא/ אמא זה אומר שהם אחים.
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT A.Person_Id, B.Person_Id, 'אח'
    FROM Person A
    JOIN Person B ON ((A.Father_Id IS NOT NULL AND A.Father_Id = B.Father_Id)
                      OR (A.Mother_Id IS NOT NULL AND A.Mother_Id = B.Mother_Id))
    WHERE B.Gender = 'זכר';
-- אחות
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT A.Person_Id, B.Person_Id, 'אחות'
    FROM Person A
    JOIN Person B ON ((A.Father_Id IS NOT NULL AND A.Father_Id = B.Father_Id)
                      OR (A.Mother_Id IS NOT NULL AND A.Mother_Id = B.Mother_Id))
    WHERE B.Gender = 'נקבה';
-- בן
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT A.Person_Id, B.Person_Id, 'בן'
    FROM Person A
    JOIN Person B ON (A.Person_Id = B.Father_Id OR A.Person_Id = B.Mother_Id)
    WHERE B.Gender = 'זכר';
-- בת
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT A.Person_Id, B.Person_Id, 'בת'
    FROM Person A
    JOIN Person B ON (A.Person_Id = B.Father_Id OR A.Person_Id = B.Mother_Id)
    WHERE B.Gender = 'נקבה';
-- בן זוג
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT Person_Id, Spouse_Id, 'בן זוג'
    FROM Person
    WHERE Spouse_Id IS NOT NULL AND Gender = 'נקבה';
-- בת זוג
    INSERT INTO family_tree(Person_Id, Relative_Id, Conection_Type)
    SELECT Person_Id, Spouse_Id, 'בת זוג'
    FROM Person
    WHERE Spouse_Id IS NOT NULL AND Gender = 'זכר';

    COMMIT;
END//

DELIMITER ;

CALL InsertFamilyTree();



-- תרגיל 2
DELIMITER //

CREATE PROCEDURE InsertSpouseRelations1()
BEGIN
    START TRANSACTION;


insert into family_tree(Person_Id,Relative_Id,Conection_type)
select f.Relative_Id, f.Person_Id,"בן זוג"
from Family_Tree f join Person p ON f.Relative_Id=p.Spouse_Id
where  f.Conection_type="בת זוג" and p.Spouse_Id is not null and
             not exists(select 1 
				from Family_Tree f2
                where f2.Person_Id=f.Relative_Id and f2.Relative_Id=f.Person_Id
												and f2.Conection_Type="בן זוג");

 insert into family_tree(Person_Id,Relative_Id,Conection_type)
select f.Relative_Id, f.Person_Id,"בת זוג"
from Family_Tree f join Person p ON f.Relative_Id=p.Spouse_Id
where  f.Conection_type="בן זוג" and p.Spouse_Id is not null and
             not exists(select 1 
				from Family_Tree f2
                where f2.Person_Id=f.Relative_Id and f2.Relative_Id=f.Person_Id
												and f2.Conection_Type="בת זוג");

    COMMIT;
END//

DELIMITER ;
call InsertSpouseRelations1();
