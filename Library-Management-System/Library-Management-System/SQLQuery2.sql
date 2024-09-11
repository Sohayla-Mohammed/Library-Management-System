 Create database Project 
use Project;

/* Table: Admin       */



create table Admin (
   Email                VARCHAR(50)  unique        not null,
   admin_ID             INT    identity(1,1)             not null,
   FirstName            VARCHAR(25)          not null,
   LastName             VARCHAR(25)          not null,
   Pass                 VARCHAR(10)          not null,
   constraint PK_ADMIN primary key (admin_ID)
);

/* Index: Admin_PK                                              */

create unique index Admin_PK on Admin (admin_ID);


/* Table: Author                                                */

create table Author (
   Name                 VARCHAR(50)          not null,
   Auth_ID              INT      identity(1,1)           not null,

   constraint PK_AUTHOR primary key (Auth_ID)
);


/* Index: Author_PK                                             */

create unique index Author_PK on Author (Auth_ID);

/* Table: "BOOK COPY"                                           */

create table BOOK_COPY (
   ISBN                 VARCHAR(17)          not null,
   Title                VARCHAR(25)          null,
   Pub_Year             INT               null,
   Category             VARCHAR(20)          null,
   constraint PK_BOOK_COPY primary key (ISBN)
);

/* Index: "BOOK COPY_PK"                                        */

create unique index BOOK_COPY_PK on BOOK_COPY (ISBN);

/* Table: Book                                                  */

create table Book (
   ISBN                 VARCHAR(17)          not null,
   Pub_Year             INT                 null,
   Title                VARCHAR(25)          null,
   Category             VARCHAR(20)          null,
   constraint PK_BOOK primary key (ISBN)
);

/* Index: Book_PK                                               */

create unique index Book_PK on Book (
ISBN
);

/* Table: Borrow                                                */

create table Borrow (
   ISBN                 VARCHAR(17)          not null,
   R_ID               INT                 not null,
   Start_Date           DATE                 not null,
   Due_Date             DATE                 not null,
   constraint PK_BORROW primary key (ISBN, R_ID)
);

/* Index: Borrow_PK                                             */

create unique index Borrow_PK on Borrow (
ISBN,
R_ID
);

/* Index: Relationship_8_FK                                     */

create  index Relationship_8_FK on Borrow (
ISBN
);

/* Index: Relationship_9_FK                                     */

create  index Relationship_9_FK on Borrow (
R_ID
);

/* Table: Manages                                               */

create table Manages (
   ISBN                 VARCHAR(17)          not null,
   admin_ID           INT                 not null,
   constraint PK_MANAGES primary key (ISBN, admin_ID)
);

/* Index: Manages_PK                                            */

create unique index Manages_PK on Manages (
ISBN,
admin_ID
);

/* Index: Manages_FK                                            */

create  index Manages_FK on Manages (
ISBN
);

/* Index: Manages2_FK                                           */

create  index Manages2_FK on Manages (
admin_ID
);

/* Table: Reader                                                */

create table Reader (
   LastName             VARCHAR(25)          not null,
   FirstName            VARCHAR(25)          not null,
   R_ID               INT       identity(1,1)          not null,
   Email                VARCHAR(50) unique         not null,
   Phone_NO             VARCHAR(15)          not null,
   Pass                 VARCHAR(10)          not null,
   constraint PK_READER primary key (R_ID)
);


/* Index: Reader_PK                                             */

create unique index Reader_PK on Reader (
R_ID
);

/* Table: Write                                                 */

create table Write (
   Auth_ID            INT                 not null,
   ISBN                 VARCHAR(17)          not null,
   constraint PK_WRITE primary key (Auth_ID, ISBN)
);


/* Index: Write_PK                                              */

create unique index Write_PK on Write (
Auth_ID,
ISBN
);

/* Index: Write_FK                                              */

create  index Write_FK on Write (
Auth_ID
);

/* Index: Write2_FK                                             */

create  index Write2_FK on Write (
ISBN
);

alter table BOOK_COPY
   add constraint FK_BOOK_COP_HAS_BOOK foreign key (ISBN)
      references Book (ISBN)
     on delete cascade on update cascade;

alter table Borrow
   add constraint FK_BORROW_RELATIONS_BOOK foreign key (ISBN)
      references Book (ISBN)
     on delete cascade on update cascade;

alter table Borrow
   add constraint FK_BORROW_RELATIONS_READER foreign key (R_ID)
      references Reader (R_ID)
     on delete cascade on update cascade;

alter table Manages
   add constraint FK_MANAGES_MANAGES_BOOK foreign key (ISBN)
      references Book (ISBN)
      on delete cascade on update cascade;

alter table Manages
   add constraint FK_MANAGES_MANAGES2_ADMIN foreign key (admin_ID)
      references Admin (admin_ID)
      on delete cascade on update cascade;

alter table Write
   add constraint FK_WRITE_WRITE_AUTHOR foreign key (Auth_ID)
      references Author (Auth_ID)
     on delete cascade on update cascade;

alter table Write
   add constraint FK_WRITE_WRITE2_BOOK foreign key (ISBN)
      references Book (ISBN)
     on delete cascade on update cascade;
