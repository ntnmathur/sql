-- 52)
-- In facebook, there is a follow table with two columns: followee, follower.
-- Please write a sql query to get the amount of each follower’s follower if he/she has one.
-- For example:
-- +-------------+------------+
-- | followee    | follower   |
-- +-------------+------------+
-- |     A       |     B      |
-- |     B       |     C      |
-- |     B       |     D      |
-- |     D       |     E      |
-- +-------------+------------+
-- should output:
-- +-------------+------------+
-- | follower    | num        |
-- +-------------+------------+
-- |     B       |  2         |
-- |     D       |  1         |
-- +-------------+------------+
-- Explanation:
-- Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.
-- Note:
-- Followee would not follow himself/herself in all cases.
-- Please display the result in followers alphabet order.

create table follow (
followee VARCHAR(50),
  follower VARCHAR(50)
);

INSERT INTO follow VALUES ('A','B');
INSERT INTO follow VALUES ('B','C');
INSERT INTO follow VALUES ('B','D');
INSERT INTO follow VALUES ('D','E');

select
  a.followee as followee_follower,
  count(*)
  from follow a
  inner join follow b
    on a.followee = b.follower
 group by a.followee;