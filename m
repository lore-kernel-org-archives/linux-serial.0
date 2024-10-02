Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C771D1E81;
	Wed,  2 Oct 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878492; cv=none; b=BGNgdoqNnf1pPHVxpI0NoHWesLhFWEj/txZ0wRtniPIZfmNv8MBkjRtih/eGYAikehgacPvdqp+z7FdKJYCIO0t7zMt9Lo9a9kcxZNKiS6EzvMneCa2FVnfV7aAK5Ym0wjTjB4I7Pnhipp12qEyFv7lGGAh25+SDdpEFhl7+Hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878492; c=relaxed/simple;
	bh=UU7yluTaOlljkJZ4DRQSHi6pc3cchlz5TUalSQExE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA0fkXYGxXplUiAY+ZbUtStN8madl+W935FRt/kroL7UaAAP4EWv6NtY6v7gw+86JVOTl7Setw8OfMbB1rLSPnsg23R4CcRirXCt9zUDAJlE/OwxH7XQdhgjSChN4JpILqz7BmudyE91ynHJAHzLq+d2EQE52SgjGkJ1HHUsKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=AkednfYO; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="AkednfYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727878479; x=1728483279; i=parker@finest.io;
	bh=3n7fgjvLVeXDdg2K3Wk9P0E65/TYuhLwHMyaE6PUfiQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AkednfYO5uVgL1RLFdkK0Mx+FU6XnK7We1+yHkEGU/vZuqfdqmZZK6/8u28YapZ8
	 8vwk2mT7fZa6sBqrvgN5uxdArBm+Wdyp8OvMaMJbM458aJB7+CPfdJStru3k1+OCZ
	 7hYImlRqG1LE2p8gDuumJZJs51dmLmIDUb4bn6MeUk8mBdbpjaUriZdkPDxW7kOjr
	 N9nX61cT9MFuW8mDfLFmxewJGbaikoWuKIqZizky17jtj7+l7O+Kd6tPzV4qU50I4
	 d2pFg4f3tmaiXIlp1fv0uk3BEwnIeNWOiaXPHu8uibAqXPAW+5MUJMrQNlhAWvZ12
	 vSiVfxcl6o8XbqrRQw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MXpU8-1sNr7b2Ekm-00NLX0; Wed, 02 Oct
 2024 16:14:39 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 4/5] serial: 8250_exar: Remove old exar_ee_read() and other unneeded code
Date: Wed,  2 Oct 2024 10:14:10 -0400
Message-ID: <9d3b61f6bf003206aebe4db9f32366cc8e214201.1727873292.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727873292.git.pnewman@connecttech.com>
References: <cover.1727873292.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WRA6HwT7j+NPmxhTrtyCTO/7VQnn29zgH72FHEPcms4KVm7otv+
 TYvT3vFosKCJBG9swwuhgYkxRZvtmopmY2Qh1DE31LYtLTE46hCMb4ZiEvzqoGNhJmWnZQh
 cWZb61u5wikbZ3UsOL95Ke4iimg6KmllHPV0ZCGaJJ4fGi7ftVSZJbGYo1NtUIIRwKUgocU
 wQBmbXl+7armIR++m0TWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vWw+SiNbtHQ=;gboFqfcyrgnVG+IIjeFEJnh5Yc/
 T9nN1m5PRzw7t1zHmStnYfDRtROgp0qoixdhYatfoL7gViG25uJRmNHr73SwODR8+heAALDnx
 lW1+Ygrlx+Tfn3EKxq4j/uaYIzQV+C5tpdc+gmbwGT7bylaZWiHfMHF4+34yz9RIUmXIlJKZF
 FwjmcbMT2QEgWnha3bOB+VbMrZ3XZzuOJ60kpeNEe77Y7WfwRNLDPnHJpiauI92GAe3ZLSPYR
 cbwEDZmmQUWS0npDySTqENh9jm2sf9c/Twq6MjfuHQc4YJlsf3jIA24pvbvM83NmFmjDIy432
 iyK0D1EZRUiEQXcIcnZ/tVkmgQJzZNjvPN6aAFSr1gHyd+fNsnBO/va4yNtb5VCWeC3BdxZ8A
 zt+FiO1jOzIKj9rNFi38wjavKtD0Od/TXvbuGRef+SsfnpIm7V3+qopvetEnDYhdd41l15W2N
 OPLESexNt1sXfvsP5FqLM/jXUtZBsj/Xo2jVMRL/9xeh93r3NOz4F9TuKUpeZReLkrFmFGlhq
 kf3oX4XdfPLJFbXqkyKdIbxGgALjfnRJPW+4DMSE6S1e2zHJ5jXW+qu4HTO3bt9vSpTYoypFh
 42IycJJ3GPH7r9B9+xIrbRmtqYRHT4cssed3v06mDf4IM1DM1UD5TDH3saLUH9tz0hl/D2oJj
 DbEMQE7dNc1X06YUvHXom91a1OK8Szmn4jGsxcU9eFE2FD4wKjjLEvgW43FYoRLNdnTaXbyXH
 e0fEnsa/uVzDw9zRbhANqGx5VXT1SSYvw==

From: Parker Newman <pnewman@connecttech.com>

Remove the old exar_ee_read() and associated helper functions.
Remove defines that are no longer needed after the switch to using the
eeprom_93cx6 driver.
Add CTI_EE_MASK_OSC_FREQ define.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v3:
- Commit message wording.
- Rebased to v6.12-rc1.
- Remove CTI_EE_MASK_OSC_FREQ_LOWER and CTI_EE_MASK_OSC_FREQ_UPPER.
- Add CTI_EE_MASK_OSC_FREQ define.

 drivers/tty/serial/8250/8250_exar.c | 95 +----------------------------
 1 file changed, 2 insertions(+), 93 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index c40e86920110..470e8128c79a 100644
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
@@ -190,8 +188,7 @@
 #define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */

 #define CTI_EE_MASK_PORT_FLAGS_TYPE	GENMASK(7, 0)
-#define CTI_EE_MASK_OSC_FREQ_LOWER	GENMASK(15, 0)
-#define CTI_EE_MASK_OSC_FREQ_UPPER	GENMASK(31, 16)
+#define CTI_EE_MASK_OSC_FREQ		GENMASK(31, 0)

 #define CTI_FPGA_RS485_IO_REG		0x2008
 #define CTI_FPGA_CFG_INT_EN_REG		0x48
@@ -269,94 +266,6 @@ static inline u8 exar_read_reg(struct exar8250 *priv,=
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
@@ -737,7 +646,7 @@ static int cti_read_osc_freq(struct exar8250 *priv, u8=
 eeprom_offset)
 	eeprom_93cx6_multiread(&priv->eeprom, eeprom_offset, ee_words, ARRAY_SIZ=
E(ee_words));

 	osc_freq =3D le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) << 16)=
;
-	if (osc_freq =3D=3D GENMASK(31, 0))
+	if (osc_freq =3D=3D CTI_EE_MASK_OSC_FREQ)
 		return -EIO;

 	return osc_freq;
=2D-
2.46.0

