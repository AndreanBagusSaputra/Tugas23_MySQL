CREATE TRIGGER update_status_pembayaran
AFTER INSERT ON pembayaran
FOR EACH ROW
BEGIN
  DECLARE total_harga INT;
  DECLARE status_pembayaran VARCHAR(20);
  
  SELECT SUM(total) INTO total_harga FROM pesanan WHERE id = NEW.pesanan_id;
  
  IF total_harga = NEW.total THEN
    SET status_pembayaran = 'Lunas';
  ELSE
    SET status_pembayaran = 'Belum Lunas';
  END IF;
  
  UPDATE pembayaran SET status_pembayaran = status_pembayaran WHERE id = NEW.id;
  
END;
