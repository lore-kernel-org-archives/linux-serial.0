Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AF17BED4;
	Fri, 20 Sep 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841061; cv=none; b=A65guLQuy0shLPG/Po2n+jOkCmez52wabaQPNnEilYDpiz0vdZrWji4aE1gUTdNrJKOCpF+lIEdvtJ2R75Ja7M/gbTyK4BQdzDskti4yJyImQRFBdbyPBDfM7OWlAMRwzW3N2gwsQ5SIE/n+2pXrkFe6cNSmw8p/qbeJvJfFWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841061; c=relaxed/simple;
	bh=QQ1yP34mU3jOu426r3UpaGZPUduk+xkR7IRq7celwUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpD/Ppo6IafZ185UDz1l27ed4H/yi5NOh8Z4rle2gsKlIqLT5e5MN3kdJQlAP7EIVvoAN3mKJq+iIhYW81sBbBnF8btOoQsw7gbNnuQbQbDYcEaayaT+nu1zBRhlLHKCqWqacDYaqLFrqq+Xj49oJrpez34kC0suTsXNyazcuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=TtH4RoCV; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="TtH4RoCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726841038; x=1727445838; i=parker@finest.io;
	bh=00qz7bDIYoKPye2tJW00roRkQAakW3RHPiLKFE5Bw1E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TtH4RoCVyEPWoxREEmGNrOpDL0hi4gV0I4jVYVO0oCq9LtZdKIABFO//U5cZHccu
	 tolLvD+aWkbKe9SohujMzM97XmgVwrVEx2uZWQ2lC8AhrvAZYL8cP+OHb5Jwt68Jh
	 BSqmWIuRljPUX7pBpKnmgW2Y2maUYHgBgdUAxg+LsAfWt8AuOtfu+HKPoN/IGI32U
	 weiL9oBc4BQW63fC8U9YYqmC6hILdP9yoTuOHq1Vt5e06xP8yOuknRhimyJqapgmq
	 iKFizWSeMhTM6qGWdlV1tVeojQIVdFRvt16Q62q4FS/nKPPw89dd820zOWS2HdaDB
	 SqPp8dFinsZUVa8cRA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lm2cB-1sI2RA3paL-00p01S; Fri, 20 Sep
 2024 16:03:58 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v2 3/4] serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
Date: Fri, 20 Sep 2024 10:03:23 -0400
Message-ID: <87719d2113970b6ff4979329fb96346a0aca9775.1726838531.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:AiAODdBHDMYoChooQk6Aj/0l4ha0/f2Zix056vZ4fDV201FgFaq
 8F96vzBEv3/roAjLo46YSbE3RMhiNhTEq7AsOwSnmBjew3nMQPevijNSwUW2A6jQfVXoun0
 rBnX0gpRvgU90Lgnq7bQJKrU+pVakTsEDYd7CqAPOnNdmFX/Jy4N99fGzMgsTc/Grfe50Bb
 YoCVUDmzh4mAkmn60LuWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pG9E6vvS4BQ=;zbAl1AgWUlC17tbYrmbVHkgXpgO
 +7Ql10VdwRgttXqi3SaDeDqgJOKF4V4C+6Ua7GPigIjDMbCW5LItlIG4ue2lZke3ordUWHqkl
 MfjA6pyxH+mSPj1UWqryteBdGLg5We7VRCeTefgKLjIv4f8zhcdbLJVE/zqpqH7IJKlBeTq5u
 tTMQruX4RBs5pwNWdKDPSOHgefLYmSgPL2RgYOWcZd2+5bMQjehqA2XhJJphvpG6MpFNKBioL
 9s/eCDe9MNQQ0JHq+LyjiLqbEVcHH/iTQc2I8uqYXVaUHzSjj1QSyLY+RbF6+8PcRh4oz+T+9
 l4mDtQaNG2/RbCHUQGhj6mk51RBelm7PsqV+hRiltQHq2oTaCI1JACwv2OLAi45hpfqpmHi8D
 vJFi+XDs/eXb9pJ78boc6l/bML8mgQANsGJXR+hmW3Tuzmdyn+YhJVxBCnic2abLv6PNl6nSd
 zovNwn2+qOaiUeucOG7iDlLSnc31gTy6hfgOc24udFFbK42cmNwsyL+ug+5xquM6Z2P7+JUJT
 KUOQOdM0bveucTXpy0OaUsvPKnGD4XI7OLVfFOA5+da+Yx7v2wTjCMbhJ9pwq+lE8w+P8P+xd
 7VaEeT394ZmmXMfbZoLdbQwx6bbwK3xtpcAvbeAaqOyZgrX3mtd+oHTZ8rODqS0MnaIdFCERR
 put8PqXnt+2Wb8eFfTFlFSU68WZA3pZx8elIV+47V/J+CNP53vDkmyVE+qVatbDLlaNIpdbzA
 paQAoH2qk5FMGzzp/bjs9RNvqHuYwSSaQ==

From: Parker Newman <pnewman@connecttech.com>

Replace the custom 93cx6 EEPROM read functions with the eeprom_93cx6
driver. This removes duplicate code and improves code readability.

exar_ee_read() calls are replaced with eeprom_93cx6_read() or
eeprom_93cx6_multiread().

Add "select EEPROM_93CX6" to config SERIAL_8250_EXAR to ensure
eeprom_93cx6 driver is also compiled when 8250_exar driver is selected.

Note: Old exar_ee_read() and associated functions are removed in next
patch in this series.

Link to mailing list discussion with Andy Shevchenko for reference.

Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.intel=
.com/
Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
Changes in v2:
- Refactored cti_read_osc_freq() based on feedback.
- Moved Kconfig change into this patch.
- Sorted headers.
- Fixed comment.

 drivers/tty/serial/8250/8250_exar.c | 55 +++++++++++++++++++++++------
 drivers/tty/serial/8250/Kconfig     |  1 +
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index b7a75db15249..c40e86920110 100644
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
@@ -252,6 +253,7 @@ struct exar8250 {
 	unsigned int		nr;
 	unsigned int		osc_freq;
 	struct exar8250_board	*board;
+	struct eeprom_93cx6	eeprom;
 	void __iomem		*virt;
 	int			line[];
 };
@@ -355,6 +357,39 @@ static u16 exar_ee_read(struct exar8250 *priv, u8 ee_=
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
@@ -696,20 +731,16 @@ static int cti_plx_int_enable(struct exar8250 *priv)
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
+	if (osc_freq =3D=3D GENMASK(31, 0))
 		return -EIO;

-	return FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
-	       FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
+	return osc_freq;
 }

 /**
@@ -833,7 +864,7 @@ static enum cti_port_type cti_get_port_type_xr17v35x(s=
truct exar8250 *priv,
 	u8 offset;

 	offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
-	port_flags =3D exar_ee_read(priv, offset);
+	eeprom_93cx6_read(&priv->eeprom, offset, &port_flags);

 	port_type =3D FIELD_GET(CTI_EE_MASK_PORT_FLAGS_TYPE, port_flags);
 	if (CTI_PORT_TYPE_VALID(port_type))
@@ -1551,6 +1582,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
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

