Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848230EF6D;
	Wed, 25 Feb 2026 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007478; cv=none; b=PCybzHJihngbLq30NFbMbOlL9SaZHodN3WGHS03tOe8hoLlN6HcWFgiqvV1+VCOoFTZFPPx2O1rK91cO2TjciQL5byz9X9wet5r1pZ9WDrU+H4O+ZB+Wg5LuebgVjk9Kwu1giOCyvTTbTlZC9C7U2i5/nKkJdkpQq1G083FAW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007478; c=relaxed/simple;
	bh=tFhHUbzn94l3Kip/ySM2guPOSnA3UdtZRgWCcQ3qJJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWVIsABDw25iCJY20OU6ynPhWKFSzZzLklToO/lEiRIpsFZO/UdJpLk2E/iDDAhMR9A9Jf74FIe97F9p79V5nv9l07Ly4EYjwrCWNlUdqUsZwQp9mFxuzlhjgrg2zXSvO8DlH6/Q+K4q8ue8Hvp3ijW262YJ+QsLmLZkFrsGFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrPSSj9h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrPSSj9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD35C116D0;
	Wed, 25 Feb 2026 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772007477;
	bh=tFhHUbzn94l3Kip/ySM2guPOSnA3UdtZRgWCcQ3qJJg=;
	h=From:To:Cc:Subject:Date:From;
	b=qrPSSj9h3NQNR92UUFfQ3Ccn5hsiyYDJ2reotEkhSn1z9WPARbCpmqdBzt+cCFE5O
	 kteVgT6Q5j2YsQxOgXlY6cRsN34uCHgbnq+kqNP6V03k3PJ5T5YqCRnYvcM5ti9Umu
	 3Gad06xRqI4XI3R+a0LcKnJXnNQgAm5QzfVBx/81YRBaGAtp6g9sKcrKHmopn3iKYn
	 Jb0cK0wWURLk0fji40fh8Vrcc9djBL5Au91Z6YErZ1TuEMFgacmQuLquY/G1QZbxXT
	 OxVfnFKyZLm6wSfgZuZhNTsulk0gDViVF8LwFryjluKpbeB0lvlevrR/r5xpiVXnTt
	 8ZaT2Iu+ihnvA==
From: Michael Walle <mwalle@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	jochen@baltes.es,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] tty: serial: 8250: Add SystemBase Multi I/O cards
Date: Wed, 25 Feb 2026 09:17:23 +0100
Message-ID: <20260225081739.946723-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SystemBase Multi I/O serial cards, which are
"compatible" with a standard 16550A controllers, except that they need
to have their interrupts enabled in a proprietary way.

Tested with a Delock "Serial PCI Express x1 Card 8x Serial RS-232".

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6589bb531cc6..7957a552b6ab 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -100,6 +100,8 @@
 #define PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG     0x7025
 #define PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG     0x7026
 
+#define PCI_VENDOR_ID_SYSTEMBASE	0x14a1
+
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
@@ -2128,6 +2130,35 @@ pci_moxa_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+#define SB_OPTR_IMR0	0x0c /* Interrupt mask register, p0 to p7 */
+static int pci_systembase_init(struct pci_dev *dev)
+{
+	resource_size_t iobase;
+
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(dev);
+
+	iobase = pci_resource_start(dev, 1);
+
+	/* This will support up to 8 ports */
+	outb(0xff, iobase + SB_OPTR_IMR0);
+
+	return 0;
+}
+
+static void pci_systembase_exit(struct pci_dev *dev)
+{
+	resource_size_t iobase;
+
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		serial_8250_warn_need_ioport(dev);
+		return;
+	}
+
+	iobase = pci_resource_start(dev, 0);
+	outb(0x00, iobase + SB_OPTR_IMR0);
+}
+
 /*
  * Master list of serial port init/setup/exit quirks.
  * This does not describe the general nature of the port.
@@ -2476,6 +2507,16 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_siig_init,
 		.setup		= pci_siig_setup,
 	},
+	/* Systembase */
+	{
+		.vendor		= PCI_VENDOR_ID_SYSTEMBASE,
+		.device		= 0x0008,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_systembase_init,
+		.setup		= pci_default_setup,
+		.exit		= pci_systembase_exit,
+	},
 	/*
 	 * Titan cards
 	 */
@@ -3041,6 +3082,7 @@ enum pci_board_num_t {
 	pbn_b0_1_921600,
 	pbn_b0_2_921600,
 	pbn_b0_4_921600,
+	pbn_b0_8_921600,
 
 	pbn_b0_2_1130000,
 
@@ -3241,6 +3283,12 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
+	[pbn_b0_8_921600] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
 
 	[pbn_b0_2_1130000] = {
 		.flags          = FL_BASE0,
@@ -6152,6 +6200,9 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_b0_1_115200 },
 
+	/* Systembase Multi I/O cards */
+	{ PCI_VDEVICE(SYSTEMBASE, 0x0008), pbn_b0_8_921600 },
+
 	/* Fintek PCI serial cards */
 	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
 	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
-- 
2.47.3

