-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `idusuario` INT NOT NULL,
  `rua` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NULL,
  `distrito` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `complemento` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `idcategoria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `url_foto` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vendedor` (
  `idvendedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `produto` VARCHAR(45) NULL,
  `endereco_idusuario` INT NOT NULL,
  `pedido_idpedido` INT UNSIGNED NOT NULL,
  `pedido_produto_idproduto` INT UNSIGNED NOT NULL,
  `pedido_produto_categoria_idcategoria` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idvendedor`, `endereco_idusuario`, `pedido_idpedido`, `pedido_produto_idproduto`, `pedido_produto_categoria_idcategoria`),
  INDEX `fk_vendedor_endereco1_idx` (`endereco_idusuario` ASC) VISIBLE,
  INDEX `fk_vendedor_pedido1_idx` (`pedido_idpedido` ASC, `pedido_produto_idproduto` ASC, `pedido_produto_categoria_idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_vendedor_endereco1`
    FOREIGN KEY (`endereco_idusuario`)
    REFERENCES `mydb`.`endereco` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendedor_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_produto_idproduto` , `pedido_produto_categoria_idcategoria`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `produto_idproduto` , `produto_categoria_idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produto` (
  `idproduto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `quantidade` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `quant_estoque` INT NOT NULL,
  `comentario` TEXT NULL,
  `classificacao` INT NULL,
  `categoria_idcategoria` INT UNSIGNED NOT NULL,
  `vendedor_idvendedor` INT UNSIGNED NOT NULL,
  `vendedor_endereco_idusuario` INT NOT NULL,
  PRIMARY KEY (`idproduto`, `categoria_idcategoria`, `vendedor_idvendedor`, `vendedor_endereco_idusuario`),
  INDEX `fk_produto_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_produto_vendedor1_idx` (`vendedor_idvendedor` ASC, `vendedor_endereco_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_produto_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `mydb`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_vendedor1`
    FOREIGN KEY (`vendedor_idvendedor` , `vendedor_endereco_idusuario`)
    REFERENCES `mydb`.`vendedor` (`idvendedor` , `endereco_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`detalhes_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalhes_pedido` (
  `cod_produto` INT NOT NULL,
  `preco` DOUBLE(9,2) NOT NULL,
  `quantidade` VARCHAR(45) NOT NULL,
  `desconto` DOUBLE(9,2) NOT NULL,
  PRIMARY KEY (`cod_produto`)
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `idpedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `quantidade` VARCHAR(45) NULL,
  `dt_pedido` VARCHAR(45) NULL,
  `produto_idproduto` INT UNSIGNED NOT NULL,
  `produto_categoria_idcategoria` INT UNSIGNED NOT NULL,
  `detalhes_pedido_cod_produto` INT NOT NULL,
  `usuario_idusuario` INT UNSIGNED NOT NULL,
  `usuario_endereco_idusuario` INT NOT NULL,
  PRIMARY KEY (`idpedido`, `produto_idproduto`, `produto_categoria_idcategoria`, `detalhes_pedido_cod_produto`, `usuario_idusuario`, `usuario_endereco_idusuario`),
  INDEX `fk_pedido_produto1_idx` (`produto_idproduto` ASC, `produto_categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_pedido_detalhes_pedido1_idx` (`detalhes_pedido_cod_produto` ASC) VISIBLE,
  INDEX `fk_pedido_usuario1_idx` (`usuario_idusuario` ASC, `usuario_endereco_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_produto1`
    FOREIGN KEY (`produto_idproduto` , `produto_categoria_idcategoria`)
    REFERENCES `mydb`.`produto` (`idproduto` , `categoria_idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_detalhes_pedido1`
    FOREIGN KEY (`detalhes_pedido_cod_produto`)
    REFERENCES `mydb`.`detalhes_pedido` (`cod_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_usuario1`
    FOREIGN KEY (`usuario_idusuario` , `usuario_endereco_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario` , `endereco_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT UNSIGNED NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `cpf` CHAR(14) NOT NULL,
  `dt_nasc` DATE NOT NULL,
  `telefone` VARCHAR(45) CHARACTER SET 'cp1256' NOT NULL,
  `endereco_idusuario` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `endereco_idusuario`),
  INDEX `fk_usuario_endereco_idx` (`endereco_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_endereco`
    FOREIGN KEY (`endereco_idusuario`)
    REFERENCES `mydb`.`endereco` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pedido_idpedido`
    FOREIGN KEY (`idusuario`)
    REFERENCES `mydb`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
