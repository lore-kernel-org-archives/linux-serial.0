Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B53232;
	Wed,  2 Oct 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878821; cv=none; b=dT4Xa9nZkxIyaSkrwRGvr2mY6rCKP2+Ft3fVptBVycHoUQOZf3ejfjYxmqlOeZA8KSpwl6YSrmUeuXWgLrESgDkHKeI1aZYGBwq6neC90An1RReCFw9SdX1rDZihxiQBiwcR/VSgMKreVlglm4XYhtkxbVOVKEPuGd96nUYkpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878821; c=relaxed/simple;
	bh=imU29qAuSy3Z+SUoC+pJbQansrGR7DUZ0xBi2UB97s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM1S6yz2bn33Hn5eRFtiCtXxvjgqhs6wV2qagefoEwFscLeFxDp3pxLJcAsPBmwuLiQ51AVDIgpjsSgna6pW6zwpSfh0ldzgxj/VbdAbzSW3P/mlCVo1vBy2hDYz+07oK7970mrM2ALXTGQSOldtj4Kos/QgEK38phOkHbgR/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=OKuXGySH; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="OKuXGySH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1727878814; x=1728483614; i=parker@finest.io;
	bh=AEv6gvIwChRLASgAgra9CjXPhS04gbbBR4xg7EhSiSM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OKuXGySHBX8cS/LYa1eL91ISDZwcBJLxtxSj0CjIoo7qVQQvW13XrUmuQZUKW8L9
	 ZGvYojYSbClzR6VkPyRwKyy2uaA24mUmVVdYgqjvW3FqqApp66RlDYYodWMUY9xxS
	 3fU+T/jPxckYaFA3GcLvs4DyvInhgTBiPRii4eJVU8v848iOTG3xjPDjjWJ4S/bwc
	 OqU5nMNW15pa8dVOjKsnnXGngu/ayydzL58F6m3RoeKdTOg1syF9HpOy8n/uHbnKH
	 bye7ICauHFUb3SW1KHzH1Hejnln2QSB1hLyTGNRVd85sK3iJ/0iIlp1FHaNigqB0q
	 9D3iadGGActwtEhT6g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M2fop-1ssyum008V-00Asp7; Wed, 02 Oct
 2024 16:14:39 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v3 3/5] serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
Date: Wed,  2 Oct 2024 10:14:09 -0400
Message-ID: <e2040e9cfa95cb63d4a63faee99438cbd76f6b32.1727873292.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:r7YqCWMkxDJ4jLZCQamOfBQb0fZF1PWkmGt/q+L4oaIXH8xIYq9
 dq1arXKKyzFAYzclTbQDYQht2bkYLdhbC2j2rynZhLs3TiB1/ccsm6W5LG6/Kwj02xG9zeN
 1sT56jktbtPTuokSNleikBIOH0v2uw2w9cx0nC6S+WIL3GXquAPOwMdWCQoSQ4vZb4d04X2
 eeevq68prAbvRLGIqqdSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q2grJUbo9zw=;l/9tiADrCSecCRnBaJZa1QbhiHc
 PqKY+CWsmjgGFb+1Ts6rUC0llY1L5PkrTBQcJ70+0qrcSbRg8cwmpxsvRtIyeO8+ZmLbt8H8o
 N+8pU7UuRwLLaAkdBf9nm81qI5UKycBZZGJTE2wPR9vJ2Vz+PdTR/KYfPgVJC+OE8zjnEsqnx
 tU5nQR2EI+k9qfqrmZWXBsJwpn9e3kzA5H5ftDIsOuJBrL7HuvaLSTNcobV7WOpkyVVB2OzSf
 kYsjtzrEpSLz+oTvdYecB29zAolvF+qTZx9WoMCbjwnk3Sagldgv6+eyncfBJICEbXSWWZuWa
 R34eyEqf5ai5e+9+Do4ocSexTJG+0b786fR81KVe+kSsqjrdsy+hueUjnyayBAPDU8Zm9LruK
 m9Zg4WYfz1CmEjg9ADiQ9flL0oXBqUMKF3FGBZ8h+sijwpX+xHYHPmFmcKRmgwiFYBav4Awnb
 mXxGmRsuVBg+iLLO4GsJqXbawXKsllSbzLt9sXiAspNzyNhXvQl6ftPlYMz+WawuyoAI3LVsk
 RKC1/GrSbozQmqkYUtREab5vJ8AD58AClzClKC4AIPc20+4S3XOgOd6pGu40vr1pLLOszsapV
 e5Q81MRlWuQ1K9afcBUgeN+n3gM772aYzJqo5HGcs/AL64XYfxM0QOjGcP1Lt4w2CI4wXlnDn
 jF0AbQnOUvJTan/Ps8dEzoWgukS/FX6Td3jTd8iPMuzSlXTJGh/ptpaS1Er16l1W27cZK+U7i
 tD1+KoQjyLN4q3eVcOYinMCfCbg/G+k0g==

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

