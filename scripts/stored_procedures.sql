-- Language
DELIMITER //
CREATE PROCEDURE sp_listLanguages()
BEGIN
	SELECT LAN.id, LAN.name 
    FROM language LAN 
    ORDER BY LAN.name ASC;
END //
DELIMITER ;

-- User
DELIMITER //
CREATE PROCEDURE sp_addUser(IN pUsername VARCHAR(20), IN pPassword VARCHAR(20), IN pFullname VARCHAR(50))
BEGIN
    INSERT INTO user (username, password, fullname)
    VALUES (pUsername, AES_ENCRYPT(pPassword, SHA2('B!1w8*NAt1T^%kvhUI*S^_', 512)), pFullname);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_verifyIdentity(IN pUsername VARCHAR(20), IN pPassword VARCHAR(20))
BEGIN
	SELECT USER.id, USER.username, USER.fullname 
	FROM user USER 
    WHERE 1 = 1 
    AND USER.username = pUsername 
	AND CAST(AES_DECRYPT(USER.password, SHA2('B!1w8*NAt1T^%kvhUI*S^_', 512)) AS CHAR(30)) = pPassword;
END //
DELIMITER ;