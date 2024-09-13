Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF629CE7;
	Fri, 13 Sep 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239413; cv=none; b=YTg5eSxvF3M7hZksrnfywoKcsz0/JxMQ5sorOesQ9jvlllTLxGsDVhHWY3/K6s+/aYnjFluHaZKj4teRZHLUWwLL5kxzaEeq9bO5/iyLCewzjCkQ6mcqT6rTr5CtZ7186NbbxXLJJ41Wm2MJc2CYVlQO0/IZ3duTR7Gu5Y12zF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239413; c=relaxed/simple;
	bh=3WCsga3GqIwYhBmstLx/z0AhqxN2IfYpeKnamXXGdzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIJwh9koFn9D9wkMBmKseWvgCC8f4Fsz1dVhMUJqFUCE84ddawlusfE8W1IxKQuAtE2rNSwmgNK/BSf9lq1pUEb5dEP1kmkViQ+SwSRRJP7hKFq/r4aD+iwku5a7Gs1/AKOUwKYVwrVsn8U3DF2/L7nM0CFHj15L3dE7/Zv/+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=mXexuzNS; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="mXexuzNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1726239390; x=1726844190; i=parker@finest.io;
	bh=b4O9e5pH2C9mry5jrjkn2GHODSWJkyFz+pjodKXA+xA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mXexuzNSPzyaYwC1W/mFBzPal99tjPZ2A5u56BVsPEGbkcrhusrmM0TN+qCmyAQP
	 mcO3tiYBj/y6TMIxCmtdLBrgxDljw2BUD7j5vOOR0rmGDlzBBgwizat/Y1L+gdPQ+
	 BqZgVndn7h5CEvW2nDpIL1ziAxjJrfN7mc54oM/ZgfIPow5uOW9duCwRqOtL/2Qc7
	 6mrzQvGeeX0aCFaNvenFu8ZULCsjg8V/Kk4N0ta2+72CZK80gkalwsnzpdgtIqTpL
	 cXKIXrh0A6jz2Q2F9LRIid1Ae5w5IrxNI+vrYWMJH4GIrfqRSAbBei1qw8K0mhHe8
	 4uZ7bIiqyqq7kw391Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mad3m-1sIoq416d8-00g4RU; Fri, 13 Sep
 2024 16:56:30 +0200
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH v1 4/6] serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
Date: Fri, 13 Sep 2024 10:55:41 -0400
Message-ID: <78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman@connecttech.com>
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
X-Provags-ID: V03:K1:BQbriEhczTMvDyonXQ0dqYK7p6lCYymmcHtH1Fm/YlxLyNmjLOj
 ybBgu3uyOLqxpqYMHY3ZaNYZYKm6l5nLJr1crSoy5xkVsjFj+67Ii1h59d955/CwbGj1WJ0
 uINVYCSNM1FtfRvYj4dFqpFwOOBV99z3UeXT0tGT4tHNNdAxJIJdPFX4X9/ZOaYlkkJNE9a
 8vMpd+IeIY7ZbJO0li9Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9rsu8cD/61M=;Rfb+0YV+CyFLtFK67TtW7j0j3m1
 uI7UrW++m3EkrifFh3slJWgDjrEMghiRbeSwBoNYQ/dUSL1X+ZIBfslkdlad+L0PyldgvygHf
 1sEM2v0wRZQcK9/amdGfc2mIOvAN7K0IAbU3V4VFyLL5NBUJxqfJLqy99XE9O1l0jTAckedOs
 6Wu+GELprg0KpsJz14SnFmcBaFTt31YXOIkVsWCuaMT27Jb9O+lEPISIOk2u+/ZdDAjbHF4PD
 jEnHiy3mnXKLzCH7EmElFkck8q/YY2akkmnMKFHAsrFh6xNbxKsQrk+mzKQQV+PkoTweEzetX
 JizkrTTCnF5EtmoPjdUoevQ+TcquQjfnGpGfAPWu1SbIEcPRTcOa9erboFCCEsFfMJ3fYUTpm
 wsADqAC1BRb/xoMdOkzfrdWKQZPdTbhUi1+f12RoMyEMOtUXtll+xS+Qn25Ory/VFeSx2ess6
 Zr9TSuMFSDl3NfcG/IW8i3O4tiNHAjqVe8xsEV6Ens97YbZvnNA1Z3rDDB+iCFRjFbafx1dg0
 TzD0sBIn+ZAl/1v4K6Y7TXotTF5bTE5rrHj721uJ7AsrQ0yw6hBVtFrbXslPg16UqokMKEqql
 quDAzgnNtxOT2oLB+0MXhw90ru4FklotC7/pqT0IHRR4XUmNarbHICUBEG5eUHVuBlGdr6Zmn
 b74dFjaSPuPcL+Xiu45gipupfOZ/SGm7SgfJWwhReruuBVDkJ773Xln7czZFXmXJlmf2E/Q4k
 PXVbHYGvvL97zxP3LUXJTZDwBz833dbPg==

From: Parker Newman <pnewman@connecttech.com>

Replace the custom 93cx6 EEPROM read functions with the eeprom_93cx6
driver. This removes duplicate code and improves code readability.

exar_ee_read() calls are replaced with eeprom_93cx6_read() or
eeprom_93cx6_multiread().

Link to discussion with Andy Shevchenko:
Link: https://lore.kernel.org/linux-serial/Ztr5u2wEt8VF1IdI@black.fi.intel=
.com/

Note: Old exar_ee_read() and associated functions are removed in next
patch in this series.

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 54 +++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index b7a75db15249..0edb5aeba199 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -21,6 +21,7 @@
 #include <linux/property.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/eeprom_93cx6.h>

 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
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
+	struct exar8250 *priv =3D (struct exar8250 *)eeprom->data;
+	u8 regb =3D exar_read_reg(priv, UART_EXAR_REGB);
+
+	// EECK and EECS always read 0 from REGB so only set EEDO
+	eeprom->reg_data_out =3D regb & UART_EXAR_REGB_EEDO;
+}
+
+static void exar_eeprom_93cx6_reg_write(struct eeprom_93cx6 *eeprom)
+{
+	struct exar8250 *priv =3D (struct exar8250 *)eeprom->data;
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
+	priv->eeprom.data =3D (void *)priv;
+	priv->eeprom.register_read =3D exar_eeprom_93cx6_reg_read;
+	priv->eeprom.register_write =3D exar_eeprom_93cx6_reg_write;
+	priv->eeprom.width =3D PCI_EEPROM_WIDTH_93C46;
+	priv->eeprom.quirks |=3D PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
+
 /**
  * exar_mpio_config_output() - Configure an Exar MPIO as an output
  * @priv: Device's private structure
@@ -696,20 +731,15 @@ static int cti_plx_int_enable(struct exar8250 *priv)
  */
 static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
 {
-	u16 lower_word;
-	u16 upper_word;
+	__le32 osc_freq_le;

-	lower_word =3D exar_ee_read(priv, eeprom_offset);
-	// Check if EEPROM word was blank
-	if (lower_word =3D=3D 0xFFFF)
-		return -EIO;
+	eeprom_93cx6_multiread(&priv->eeprom, eeprom_offset,
+				(__le16 *)&osc_freq_le, 2);

-	upper_word =3D exar_ee_read(priv, (eeprom_offset + 1));
-	if (upper_word =3D=3D 0xFFFF)
+	if (osc_freq_le =3D=3D 0xFFFFFFFF)
 		return -EIO;

-	return FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
-	       FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
+	return le32_to_cpu(osc_freq_le);
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
=2D-
2.46.0

