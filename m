Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFA61FCF;
	Fri, 20 Sep 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841060; cv=none; b=nQmMMSgBUIBxyeeJlzfrPt9UrqbEMRV/0C/clH4T8TLdkpF9bc8RalSbEWOs5NNuLHwlSIirA9BlY0Ya24SLI/w+Hg9/K+9xkgKtvv0mkw53TOTaKfEx+NTLjc6r3kyW+IqrfsZwQjzFTYtBE0XNqTclPkPG8g6Lbx57qDPdT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841060; c=relaxed/simple;
	bh=ZNqCSDM1HQEjbF6HFOmsZ/LVqnwVg1FikcCEkoZppec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gawy5SHwH/U/qu9I4LEQxMdYxcq76aonzPszAHeJijs0AGXEBTUncI36Rxddd7oCERkPgIYrWpYiYdy+hlLnq50pYSJEiwlE5VPkBxwW9tNlk2jXu4tjj2MWwirQFcg96yj+BThFPcIlyDbuosg/S3IQ5doRMBBd1/rZ3ofxFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=OrxjBtJa; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="OrxjBtJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726841038; x=1727445838; i=parker@finest.io;
	bh=HXD1LgVa7vJ6hdhMC83sJKrCbgCM2HfctXEdwMy4OaU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OrxjBtJaODg3Kdi9Hm8FQegGMBhCx8gJUyRctNjaI70mU8grgR0c4ssDFdXOGFdy
	 RsXl0HwewDwGYmbabGQYpsFD+Mr0JW1ooVERfhGLW1xx1amYLg+OSXYb5PeVMY/6s
	 ofYXKJS20TGsflbaMwiUPeySJqPUoCg0Np2oWovzQh+Njyt3ZVEIInAbPYfFlzHao
	 pZIz7NViv2CAemjFcSRoeGZEi4MEPJKPzG+4xI3DpPGMZByDmE8OJi4vYtztrmwO8
	 blDGX1kJOkEgxtMsa/+kkDCw9l9DGezLxd1/aU+PfWmxDCG1P87uyeZ32cMvZ17BC
	 23Ekr6OVH2HCMPG9cw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lj04u-1sFZrM1Ufm-00oAwf; Fri, 20 Sep
 2024 16:03:58 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 4/4] serial: 8250_exar: Remove old exar_ee_read() and other unneeded code
Date: Fri, 20 Sep 2024 10:03:24 -0400
Message-ID: <3edee1e670cc214f73a13c0bf127f4ad8e6bce7f.1726838531.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726838531.git.pnewman@connecttech.com>
References: <cover.1726838531.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SkJqHJQLDsZ+n0F8cDzXKeIyax70ZUOKiZGtZRj3gT9hojm3Iey
 sXfOSIpXzWEUFOuFZ43cNfOnJrhhFg0yMpaagRo9xSXfgHdM/uU3Pq3O99RX0+4AO03xqmb
 QSXs1hA7QqQ0S5oXPa+DCbCfR/irXwbRxI5VYg/CBBJxBS4S5Mi8CIwN9edzMTZ9EFJ6UOW
 wQfRww2/OIUYSZPrbEz2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NqPGd6OTug4=;RJQyuzIqFs4R4DRRLxaAOv4gsxj
 Gu4Il7/XKwfG4DuFikjFicsKgBmi7bYYKZNVAG9HbSqr5jfKtdEm6180bAxUCyr8C/xbWm1gj
 22k/XGUBayCSabDKrnmth1IdcbFkQbA/Wrt2C2BEO5XpJ7tmdUWuz30TSwrVXPQv5hMcNZ5N+
 ug7ywkahGh7Oo1tvG66qQgQI2S755x1H9IsJkhRqwD6wgSg9DUZX0PNjcjSqSOTy2Tp4dV5Sv
 JApCjQ7N7XBmyw0a3XBmOQR3eZPTojA1pO9yJAtB4oZFhovc9iXuqq11ANyElSt7GmLitAcCq
 Y95eL3PAPYttWMYunurfKX8YlcC0l/B2K7spe7nYWi3pB2WZ70D6UhlWl3qj3XsN9a/smp0uH
 5FOKmd0RUo/O3T86MBTmUHTLuzTHPrj07p5xlTe+QtenfuDiUMN62mec15eXusdp1siYzNYYx
 d9E9ZgsHjrwYz8av0I0eIFGSkUmfHUWCO37rNp54fp37bKm8xBz4v0s06G+7XaT5ybeU9lX7z
 SnABGQk8OisXtnC2XV3ZteoDFpi7ZUNMRHOn0c3+C85QG3Azpj5Ht1cj4foPFtTFKUHDRX/UA
 lSERa2l0B2BzwgduUcJ64THBTOtsKaJVebNUDMsLAA8JgP/y37/oid2qjUpqwBcEoY8uO+3po
 0AFMjWrUGRVhmj5EuTUzuNNiw/WOLxQ8It2sUBZU6NYKR2uabSm4KydsNSm3OyeABNtypbgUf
 +63VqvXZG2USOwy1c1BIlYP1Llnok9eJw==

From: Parker Newman <pnewman@connecttech.com>

Remove the old exar_ee_read() and associated helper functions as well as
some defines that are no longer needed after the switch to using the
eeprom_93cx6 driver.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 90 -----------------------------
 1 file changed, 90 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index c40e86920110..659a44b52f8d 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -136,8 +136,6 @@
 #define UART_EXAR_REGB_EECS		BIT(5)
 #define UART_EXAR_REGB_EEDI		BIT(6)
 #define UART_EXAR_REGB_EEDO		BIT(7)
-#define UART_EXAR_REGB_EE_ADDR_SIZE	6
-#define UART_EXAR_REGB_EE_DATA_SIZE	16

 #define UART_EXAR_XR17C15X_PORT_OFFSET	0x200
 #define UART_EXAR_XR17V25X_PORT_OFFSET	0x200
@@ -269,94 +267,6 @@ static inline u8 exar_read_reg(struct exar8250 *priv,=
 unsigned int reg)
 	return readb(priv->virt + reg);
 }

-static inline void exar_ee_select(struct exar8250 *priv)
-{
-	// Set chip select pin high to enable EEPROM reads/writes
-	exar_write_reg(priv, UART_EXAR_REGB, UART_EXAR_REGB_EECS);
-	// Min ~500ns delay needed between CS assert and EEPROM access
-	udelay(1);
-}
-
-static inline void exar_ee_deselect(struct exar8250 *priv)
-{
-	exar_write_reg(priv, UART_EXAR_REGB, 0x00);
-}
-
-static inline void exar_ee_write_bit(struct exar8250 *priv, u8 bit)
-{
-	u8 value =3D UART_EXAR_REGB_EECS;
-
-	if (bit)
-		value |=3D UART_EXAR_REGB_EEDI;
-
-	// Clock out the bit on the EEPROM interface
-	exar_write_reg(priv, UART_EXAR_REGB, value);
-	// 2us delay =3D ~500khz clock speed
-	udelay(2);
-
-	value |=3D UART_EXAR_REGB_EECK;
-
-	exar_write_reg(priv, UART_EXAR_REGB, value);
-	udelay(2);
-}
-
-static inline u8 exar_ee_read_bit(struct exar8250 *priv)
-{
-	u8 regb;
-	u8 value =3D UART_EXAR_REGB_EECS;
-
-	// Clock in the bit on the EEPROM interface
-	exar_write_reg(priv, UART_EXAR_REGB, value);
-	// 2us delay =3D ~500khz clock speed
-	udelay(2);
-
-	value |=3D UART_EXAR_REGB_EECK;
-
-	exar_write_reg(priv, UART_EXAR_REGB, value);
-	udelay(2);
-
-	regb =3D exar_read_reg(priv, UART_EXAR_REGB);
-
-	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
-}
-
-/**
- * exar_ee_read() - Read a word from the EEPROM
- * @priv: Device's private structure
- * @ee_addr: Offset of EEPROM to read word from
- *
- * Read a single 16bit word from an Exar UART's EEPROM.
- * The type of the EEPROM is AT93C46D.
- *
- * Return: EEPROM word
- */
-static u16 exar_ee_read(struct exar8250 *priv, u8 ee_addr)
-{
-	int i;
-	u16 data =3D 0;
-
-	exar_ee_select(priv);
-
-	// Send read command (opcode 110)
-	exar_ee_write_bit(priv, 1);
-	exar_ee_write_bit(priv, 1);
-	exar_ee_write_bit(priv, 0);
-
-	// Send address to read from
-	for (i =3D UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >=3D 0; i--)
-		exar_ee_write_bit(priv, ee_addr & BIT(i));
-
-	// Read data 1 bit at a time starting with a dummy bit
-	for (i =3D UART_EXAR_REGB_EE_DATA_SIZE; i >=3D 0; i--) {
-		if (exar_ee_read_bit(priv))
-			data |=3D BIT(i);
-	}
-
-	exar_ee_deselect(priv);
-
-	return data;
-}
-
 static void exar_eeprom_93cx6_reg_read(struct eeprom_93cx6 *eeprom)
 {
 	struct exar8250 *priv =3D eeprom->data;
=2D-
2.46.0

