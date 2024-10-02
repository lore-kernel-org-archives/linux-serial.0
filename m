Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD91D0977;
	Wed,  2 Oct 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881988; cv=none; b=mP67b13r+NvJVxwrAZGghdP6uBlKId5DzjyNa7ujUHpB4tXeeNms4WxIGlweCtlHhwmERevZ6ZDLmHiMJn436b9i/uRGBqTt3sHF4/mtL+Z1xg58nLxWxfIWFdwvDTg0xSELHWygxicvxrDZ8x0HJnRTejVHydMAaqr/qDhIFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881988; c=relaxed/simple;
	bh=/qPIkJ6n8RnNU1FkT1OzWc5ZvQyz7g5ZgNu+tm14gy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Ups6zHKhOp2D2L9Vm6t43qEcXy9zh4FDAQHjDdlnRkDDDuFT6UOkA3+y/1wUA0NhZ+4GZDWuFrAym5EJoGbCM9r0NaI24ZWIYSrIjXUyQUHBpF+WffcXgbnSEPbRAANDaoJj5b7TlKZVrbzAf8Fb+RxP1QGEPkhbUxWjo3Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=2ZOykGVu; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="2ZOykGVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727881976; x=1728486776; i=parker@finest.io;
	bh=JOzP2lvNRCJkoFukbKvYKYvYZ4eg3b4MdMP26Bf590Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2ZOykGVuXWNF34tDrAkWpUT6AXCpoH952zYIgoituq+ayykKo66o4y3evg1yuLbA
	 QnCU0Qgb5hwn6tFMFgvHkLG+di2WwLBJjvZp0it9TXlybb36f+2Qq3iIDvQJyHWkM
	 gYuMtGr1CMvbfiWXyaSAds8uP0ck8PMGcBR+jZPwGGKNPKIKrEiY9qqK+fbD9om6z
	 jcxnv6OSIpdXIf6n73f3TUo68NxZsfdm95ifYb/Uum1zQI7+pgUmILZERBFvS/2FV
	 pIlrSIXDQxJfAR8/TzRYA6aIMwz3fcUkf/m0ugKIYlT0gLYGRPyMH2AntKcRZXDdp
	 83JZIwgpddYGgz9V5g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M2bMR-1s3uwf1zzJ-018ApD; Wed, 02 Oct
 2024 17:12:56 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 4/5] serial: 8250_exar: Remove old exar_ee_read() and other unneeded code
Date: Wed,  2 Oct 2024 11:12:36 -0400
Message-ID: <ed756c48965a95ce3384ebb7fe2441b4928b4510.1727880931.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727880931.git.pnewman@connecttech.com>
References: <cover.1727880931.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZKkEuX/vMv7rEaPVRwC0sf+1njpjqxPAsqiC7f8hdLwjoRUgm7z
 v2b1OECESfTwR0Bsmhg3Pxm3WhxlsH3w0pxh56fDZNpLmpFdRzJdRGkpSSv/W6d2bgz1Lvz
 5xWzGFMJA4V6CZSEY4NZE4s0UxuC6cKOv0Y9jXHTk8MPjPi9J3/39werSCEsYw2tVzaSrNP
 ZMp/wZup94Jyoi0MTJNyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lkc8gQo12cs=;lQy7r91v9ageP7IeRhij/V60axi
 P/WYJhZk1ycLWtSsMSm7jECy8SpAWJlMwV6Coc9rOGPetZOO2ilEESHlrCyMeXPcJEPbym/PU
 9Tbq5emy76/IpP7WCgKXkVFXFHZxlzncxx6Pcv2QjHlalWp/7EUkD6rR2mM+v2vF+k8F48ffF
 MEh5lBH3LuIim24aooKOqkI0dprdr6LEFiP65wFIlV8DYs4VpLkRtzkCO0FmxJhhXfTySoVwi
 BkliZtMTHYqsrL/FNnZhWkwqsvaSXANT2+GCn8Q9Yv+3N9Dx7/bTNKEwu1Kc7xE3taJTZJYu0
 enVCJYpaWDZA2RfO7i8ebsYjYDku9gWKbRvb6+QIomHXWRddkX4iLTzwYD3T4XuQiLX10Xmyu
 WfMMg5vUBY9C0weBJZUJj9A1ONivdJ2cUN3R/qdHkpJcaFJZA9FFzdxmvXBMkTBpGwz6nEfFQ
 D3+mupH43sjJA0kijLwAWRHhLHtWboV5yxlI4mecQeftOms9Ld8vmUDQYX6fQqq0PCRW1eqB6
 Cn8nXBYQU8dxywMH4s8Q992c6GZ8D4Ca0fnO6Ofx0/80IQobDyOm1YLv5o5g5nyY50bFEQuoK
 JJTGFY8bxeNqSq7fxF+Owfnm//VTq7aZ6Ai52pA20kjoZiVVCGCUz+axXkzlufwdvvidwjIdo
 BJHkxLjV8W6fR1Z//W9JHpavfldovY9Vlyse5EaWcyfpgokMEWvIowLbZ72LQJwPuRITRs7eo
 oWrLPTonv6ghRrph2alEKK3+nnyOFhxgw==

From: Parker Newman <pnewman@connecttech.com>

Remove the old exar_ee_read() and associated helper functions.
Remove defines that are no longer needed after the switch to using the
eeprom_93cx6 driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
- Commit message wording.
- Rebased to v6.12-rc1.
- Remove CTI_EE_MASK_OSC_FREQ_LOWER and CTI_EE_MASK_OSC_FREQ_UPPER.
- Add CTI_EE_MASK_OSC_FREQ define.

Changes in v4:
- Move CTI_EE_MASK_OSC_FREQ change from this patch to patch 3.

 drivers/tty/serial/8250/8250_exar.c | 90 -----------------------------
 1 file changed, 90 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index e9f57516fbee..470e8128c79a 100644
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
@@ -268,94 +266,6 @@ static inline u8 exar_read_reg(struct exar8250 *priv,=
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

