Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD32629F;
	Fri, 13 Sep 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239412; cv=none; b=n+8ce4U0u3uLCpujOXZ84jKt7d/AImDg52x5Q2PKLHFdu4lnsctYN+GHBMYYCikxxMYkH+edQQh7TPcIIkI/+XOudn92oQNE0ierhus6LYPm7Xon9U0DrAr7B8+Hx8DSMsX6HPfmtUlwVy2xt4XKdUefAjoLqIA83hT68fJD0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239412; c=relaxed/simple;
	bh=6HGa3xH4q/wVIDbcp21UHl2EmGSf3xbW64DuCdXyolc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGHkEfU01nRrSb4MHW5x6/idec4Frfs2Vy6spfWk5WaOQ2OIfwXPjisxayq67GW2EUgMWA61PGsnpszvc2daAGeQrxQN5niVw+h5nM8AIkAMlqOf+V6ZrDupvgWHA1FQt9sv6Hpppcpud3xuE89jLTYdfrTxMrIHAQWK6WGSnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=g7jUPpoU; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="g7jUPpoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239390; x=1726844190; i=parker@finest.io;
	bh=XwoyajezAxnq4yQoPqaucc/mmTrf6GLB40+rbTgUjoU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g7jUPpoUyzfdcVEYnf19SOKXmwk9J7z/f0ayL6veGP/3m/cr+x6seWDqu0plPw0V
	 AenIhRW5v2l8hWydcvprg2j4rApoWl/skDeCSbLH9SzyhzI2vfa0oxk0s30chIXeL
	 /DsRIjKuayfoWT/beUMC2TRvwqYD5LRxZABYdPsYpK3P+GLSW9xnDbFeW+lw92UMZ
	 Ttv2f2+jyHmNXp1vQaBGyb8Op4518Qz2nssOyZ9KyFQrhBbSFBBqcJTX1QCiD3xuZ
	 XapduiHvvb+pyOhtYboc0HsU1zE31p4czvQE9Bha1M0Id66B/T5IMrcz+mT8vOyaL
	 aFGgDTPznowPVTs+yA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MKtBx-1sYqSB34cX-00QBQ7; Fri, 13 Sep
 2024 16:56:30 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 5/6] serial: 8250_exar: Remove old exar_ee_read() and other unneeded code
Date: Fri, 13 Sep 2024 10:55:42 -0400
Message-ID: <3d7342999229210b18d1e163362999cac78a52d6.1726237379.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726237379.git.pnewman@connecttech.com>
References: <cover.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PiWaDdgHCq6lF/1o+DvXnHdtCsbtl67UQZZbI/RYrhJYKdJ43V2
 784SedABsWcUXJQSleEbl5aQ5N04VUeGe3RnUV29GS0Rdbvf+z1/vjcpBhW3omWZ6FudoDl
 X97x3EmGk2qqWHIzj10cZKIV/UKg0JIcERt4rN+7ltHXiHtIZBxEMgEBQ6n4yWLuKgrKbzY
 PMpUwlQnBX4uPev+AHVWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bFYaTlExvS4=;Yy/Bb8iWmB21KDO5uNEI9QwRnKl
 E5DfwtRn5vIJ0w8FrkD3n5KqREBeyOEKL1UWyH0ShkCiortq6e91v4N+8sIAOzw0XoicQncYp
 VxCu2G+iJOUCQ4oQs7OYGQirkb8pu1Jy1+FIiDoM5lg0ynTVBvCesIgrfKIyKqM6jpOkFyqnJ
 s0wnxspO5/jNJ/rN7ZyDpJ3ENDYlQLD3Bq0lN9sFYdIG4jgKItkpv56TknwT2QSNUqKA1lmZP
 A9q+gPAD0ZJXX4PoAXm/kpM235qzhLnxz4DpxPvULFyLPfVutzPgs6eA6HshhAcJHHWdccqdI
 pK/jkl1Lr4/riRPI45uMKy+i6Bljug/8okIiJSO8ETvUuYDKD3thmMEYP7uZCqDVC1BynUL2r
 qvr9h3DpFAhzvAnJqD3TrY8PTSFUc9dv7Eq1vIVdPcYvndLBhe9jrRzXBSSPRziEYkgaSqCIZ
 0Gud/MSpSCk58eDsqZiDILjCyY7J/INdQY7LU6PywpusCH51UKKhSF5wTZXRZfFtiTBd3yxkM
 3ou8HWOiDEiuyCOjof+/lOSBkWQ+5nPWK9uw3JgFPoR4uTRtx7aEPtlHTUhuLYi/CASch6jZw
 /7Xa5sU5O+gPzfFxuwyiRKSdnu0/y/m2yOi1kL2rr97LUbU+Vo0OuScsEsr+P5BOGygUqeA4K
 J4hfwBQIOSfaLI8GfyH5Y7+BRAzFNg2JtdoR4Rr4RXg5C/cCspM1yNFe4omOVcqy0pjcWqsLT
 U5cFtgoC4V70yCyta5B52pREEOUx73GYQ==

From: Parker Newman <pnewman@connecttech.com>

Remove the old exar_ee_read() and associated helper functions as well as
some defines that are no longer needed after the switch to using the
eeprom_93cx6 driver.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 92 -----------------------------
 1 file changed, 92 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index 0edb5aeba199..3ef28429f1d1 100644
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
@@ -190,8 +188,6 @@
 #define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */

 #define CTI_EE_MASK_PORT_FLAGS_TYPE	GENMASK(7, 0)
-#define CTI_EE_MASK_OSC_FREQ_LOWER	GENMASK(15, 0)
-#define CTI_EE_MASK_OSC_FREQ_UPPER	GENMASK(31, 16)

 #define CTI_FPGA_RS485_IO_REG		0x2008
 #define CTI_FPGA_CFG_INT_EN_REG		0x48
@@ -269,94 +265,6 @@ static inline u8 exar_read_reg(struct exar8250 *priv,=
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
 	struct exar8250 *priv =3D (struct exar8250 *)eeprom->data;
=2D-
2.46.0

