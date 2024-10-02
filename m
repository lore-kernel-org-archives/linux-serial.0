Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB701D0B86;
	Wed,  2 Oct 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881988; cv=none; b=cbwf7xacMhTTwk/y2ofHN5qRVALYVJ3OVf9ZMQLIZn8TPJ00ipKq4uFUtx3V56CsglFa6FbowW6jCkBT5WfivGjDtp/40vs3d6ZTUdWkNdEqQdecrhUqMPMflh9hq3esfBe8o8vyF/40zxqrKNY2n/I+qqRU7GLRx7spf3Bt2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881988; c=relaxed/simple;
	bh=KKQE5AbCF99JrIxLR3AhllI65S7JCKAGlU2Y4li0CYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJTXmewPDZ5VsSODyekW2tj8fjyKqnjcMU2yRDwlScoiWFBBJIrMGAWV4GrEVoPQlfwTN7ENcY5tyBmwUKTxcU6WULnoC8+lOOFUrphNJRYRDukI1tS3hNxr2JJSh/376XFuIbfqunYg6gvaJmdUYptZOnpSUlN4xcQM7PDfbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=lrIHh5Wr; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="lrIHh5Wr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727881976; x=1728486776; i=parker@finest.io;
	bh=KMA9Hb6A8XWb5WDgrKMYUMOQPVyVvWozBovJzordAVY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lrIHh5WrYD06R8zWl+J+7NlyqjSq0+wCzMyVWAxM29YcuAMutCekOUwpmv4EUL+z
	 laM+vT0Jtf+Quaef4/ojySZBytnfiJw402R9ZjWposX7R7Ut1cUgiH+3y5RlcNGut
	 7ICGrDSyzg/ia/rD0iNJLeWic4pFHKbmhM+TjdXdxudpgRkO5W+IL0dQz4px02smy
	 07wQ/rAM98QvWFnKtuWcK6dGr0Drou4BjBeceE+h+z89x3u7OHqB/ijiLXLbgXlfj
	 2Dxws8zlL1kV/lDGs4TEKLvC5Quu1sGz3QWDn59o9loL3T6NVncfJ/hmj334/A9UJ
	 eWIyn8Fm0BPpL576Hg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lu7BQ-1rvuBi0AFS-00yVvI; Wed, 02 Oct
 2024 17:12:56 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v4 3/5] serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
Date: Wed,  2 Oct 2024 11:12:35 -0400
Message-ID: <1bf2214ae27130ca58b9e779c4d65a0e5db06fc1.1727880931.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:dPLw+BuVb9CMuO25grPqcD8IxpQjtLvEVIvXoRICljJFIGXG6T0
 viyO7o7hsU/uj3eL2z32ieXKVawsNKsck+hMYLjeW8x7rTZQlmpvxGQMYRhK083Eq2uaoK3
 3dglVn5a5bQFDSPSZnuXUxwAdf0Q+UDTn2vWTX5aYfj07neMcZIqoiClizGfHkmHekrQGzT
 yrJPFdqdD7cjG1Idz0Ecw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CY/kJ1zzMeY=;NTHqWwMK5pmTga44nqty2ZDxR8R
 mjWUIXUKzwB8gUIPtlyheLYFaWj7fAhOHzUlRkKGYquT2O9lB1I3zQnseAi2QQP5kaHEGNZ8s
 GyDjQNu5+VwnlLG5lCLOkQ5c2ig34+eeoEfMLlnKiTK0Xt1vLqxYzhYpSUbC8XJeL9CgF7L13
 Vpie43MFyq8S/GwaYdjAZ/j/QxnS32ooBqxaganqIpK2NfT9ZJgdNU0LLzVoEbqPuU4ypEal0
 hq9Gfxmn9oHE4cMPsL4bi8fXt2LucSY+9zS4sP9qWcRPjgaBtpRj2KrTG97TMxL/hD1X9Oeb5
 Y+PiGSswix7dLbDsBMYiGXNRAZPrGJwlOaYAC0SBXwnA4N0d35YCUStGhYBr8XYNfrh0d+gxs
 QcfGdjv0OJD/5GIRx6uO0+tXbkRE4OxgFfAOP3E0Nlp9mEeZRkXbN9RaykpFKuiVFnAAzGgZi
 1mMlsgyxoHLdAEFs8orxy0qI4h0S0rVepXhf06DcNnmJ69OaLg5KGHFtkgNDg5fAPYfuJ6PnM
 liBN2SZgiPuPlVsPOcl8+cCUXpHHMQeHdUO+OpofFIlnZkNId0rnFgWq3F8sxHO0cQ3Q+593m
 ZGlPvGGhj7vDsL6t0pXNweLbU0JnMkJEqLDKTI/Fj+GUmINr7pxkdhKhk06MqAIGF5R1TsQMB
 5mmW6GQbTf4zfrzcg/iBeIpjlB0vbbyum86HXztEpqSOD5G3by9Anb1xzG0qtCexiTPU5V78x
 d6lpKaWks33dTiTcdEFJiWYEWUSOuWYog==

From: Parker Newman <pnewman@connecttech.com>

Replace the custom 93cx6 EEPROM read functions with the eeprom_93cx6
driver. This removes duplicate code and improves code readability.

Replace exar_ee_read() calls with eeprom_93cx6_read() or
eeprom_93cx6_multiread().

Add "select EEPROM_93CX6" to config SERIAL_8250_EXAR to ensure
eeprom_93cx6 driver is also compiled when 8250_exar driver is selected.

Note: Old exar_ee_read() and associated functions are removed in next
patch in this series.

Link to mailing list discussion with Andy Shevchenko for reference.

Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.intel=
.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v2:
- Refactored cti_read_osc_freq() based on feedback.
- Moved Kconfig change into this patch.
- Sorted headers.
- Fixed comment.

Changes in v3:
- Commit message wording.
- Rebased to v6.12-rc1.

Changes in v4:
- Move CTI_EE_MASK_OSC_FREQ change from patch 4 to this patch.

 drivers/tty/serial/8250/8250_exar.c | 58 ++++++++++++++++++++++-------
 drivers/tty/serial/8250/Kconfig     |  1 +
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index b7a75db15249..e9f57516fbee 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/eeprom_93cx6.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/math.h>
@@ -189,8 +190,7 @@
 #define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */

 #define CTI_EE_MASK_PORT_FLAGS_TYPE	GENMASK(7, 0)
-#define CTI_EE_MASK_OSC_FREQ_LOWER	GENMASK(15, 0)
-#define CTI_EE_MASK_OSC_FREQ_UPPER	GENMASK(31, 16)
+#define CTI_EE_MASK_OSC_FREQ		GENMASK(31, 0)

 #define CTI_FPGA_RS485_IO_REG		0x2008
 #define CTI_FPGA_CFG_INT_EN_REG		0x48
@@ -252,6 +252,7 @@ struct exar8250 {
 	unsigned int		nr;
 	unsigned int		osc_freq;
 	struct exar8250_board	*board;
+	struct eeprom_93cx6	eeprom;
 	void __iomem		*virt;
 	int			line[];
 };
@@ -355,6 +356,39 @@ static u16 exar_ee_read(struct exar8250 *priv, u8 ee_=
addr)
 	return data;
 }

+static void exar_eeprom_93cx6_reg_read(struct eeprom_93cx6 *eeprom)
+{
+	struct exar8250 *priv =3D eeprom->data;
+	u8 regb =3D exar_read_reg(priv, UART_EXAR_REGB);
+
+	/* EECK and EECS always read 0 from REGB so only set EEDO */
+	eeprom->reg_data_out =3D regb & UART_EXAR_REGB_EEDO;
+}
+
+static void exar_eeprom_93cx6_reg_write(struct eeprom_93cx6 *eeprom)
+{
+	struct exar8250 *priv =3D eeprom->data;
+	u8 regb =3D 0;
+
+	if (eeprom->reg_data_in)
+		regb |=3D UART_EXAR_REGB_EEDI;
+	if (eeprom->reg_data_clock)
+		regb |=3D UART_EXAR_REGB_EECK;
+	if (eeprom->reg_chip_select)
+		regb |=3D UART_EXAR_REGB_EECS;
+
+	exar_write_reg(priv, UART_EXAR_REGB, regb);
+}
+
+static void exar_eeprom_init(struct exar8250 *priv)
+{
+	priv->eeprom.data =3D priv;
+	priv->eeprom.register_read =3D exar_eeprom_93cx6_reg_read;
+	priv->eeprom.register_write =3D exar_eeprom_93cx6_reg_write;
+	priv->eeprom.width =3D PCI_EEPROM_WIDTH_93C46;
+	priv->eeprom.quirks |=3D PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
+
 /**
  * exar_mpio_config_output() - Configure an Exar MPIO as an output
  * @priv: Device's private structure
@@ -696,20 +730,16 @@ static int cti_plx_int_enable(struct exar8250 *priv)
  */
 static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
 {
-	u16 lower_word;
-	u16 upper_word;
+	__le16 ee_words[2];
+	u32 osc_freq;

-	lower_word =3D exar_ee_read(priv, eeprom_offset);
-	// Check if EEPROM word was blank
-	if (lower_word =3D=3D 0xFFFF)
-		return -EIO;
+	eeprom_93cx6_multiread(&priv->eeprom, eeprom_offset, ee_words, ARRAY_SIZ=
E(ee_words));

-	upper_word =3D exar_ee_read(priv, (eeprom_offset + 1));
-	if (upper_word =3D=3D 0xFFFF)
+	osc_freq =3D le16_to_cpu(ee_words[0]) | (le16_to_cpu(ee_words[1]) << 16)=
;
+	if (osc_freq =3D=3D CTI_EE_MASK_OSC_FREQ)
 		return -EIO;

-	return FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
-	       FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
+	return osc_freq;
 }

 /**
@@ -833,7 +863,7 @@ static enum cti_port_type cti_get_port_type_xr17v35x(s=
truct exar8250 *priv,
 	u8 offset;

 	offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
-	port_flags =3D exar_ee_read(priv, offset);
+	eeprom_93cx6_read(&priv->eeprom, offset, &port_flags);

 	port_type =3D FIELD_GET(CTI_EE_MASK_PORT_FLAGS_TYPE, port_flags);
 	if (CTI_PORT_TYPE_VALID(port_type))
@@ -1551,6 +1581,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)
 	if (rc)
 		return rc;

+	exar_eeprom_init(priv);
+
 	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
 		rc =3D board->setup(priv, pcidev, &uart, i);
 		if (rc) {
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kco=
nfig
index 47ff50763c04..94910ced8238 100644
=2D-- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -150,6 +150,7 @@ config SERIAL_8250_EXAR
 	tristate "8250/16550 Exar/Commtech PCI/PCIe device support"
 	depends on SERIAL_8250 && PCI
 	select SERIAL_8250_PCILIB
+	select EEPROM_93CX6
 	default SERIAL_8250
 	help
 	  This builds support for XR17C1xx, XR17V3xx and some Commtech
=2D-
2.46.0

