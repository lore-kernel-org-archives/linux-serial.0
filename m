Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CB3CD8C9;
	Mon,  9 Mar 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064451; cv=none; b=BBka06dkzdNS80bAZU9CY5r9Tm4J3vcwMjzly0ipe5izgXuhFYA6vUvnmeVLpHHMu9Siv1XEQIY4xlopcQOAjOPLW6XGGaspyXawu0lYPmHCEgz1RXzmXm/0QJacr09fkoWARSLstuM7Olqjan5cG2GlqPeQmNCWKkdySjeMdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064451; c=relaxed/simple;
	bh=XpuZzODpcmd8gO/nePcQz4+PvaxgI7x54z4naCWYAyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjMT/lhahj8ep2qPKNiY+P+p4hTLPDnU4g7OhGx1Y8kHOqxEjuqLsVi55j+mGqD8uEBGL58BLVNTeIMap9vHONFpGzPyT8g994gfrwLClytuxe6MFZGV+2leiSUiQ2aJdu+L1PwnmZrTGmXMvk+NW0mTdjqjEmeZC0WuiYZwMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mupuf.org; spf=pass smtp.mailfrom=mupuf.org; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mupuf.org
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <martin.roukala@mupuf.org>)
	id 1vzb3X-007peQ-Gc; Mon, 09 Mar 2026 14:53:59 +0100
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <martin.roukala@mupuf.org>)
	id 1vzb3X-0003fw-2y; Mon, 09 Mar 2026 14:53:59 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1057822)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vzb3S-00A2vO-Ew; Mon, 09 Mar 2026 14:53:54 +0100
From: =?utf-8?q?Martin_Roukala_=28n=C3=A9_Peres=29?= <martin.roukala@mupuf.org>
Date: Mon, 09 Mar 2026 15:53:10 +0200
Subject: [PATCH] serial: 8250_pci: add support for the AX99100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260309-8250_pci_ax99100-v1-1-3328bdfd8e94@mupuf.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBMmy8quEiH+TDWbCoUIpLsnL
 b/FexkSRaYEU5Uh0s2Jz6OgqSvwuz02EhyKQaLssUUtRqnQXJ6NfbRuEEXoiAblXLCuhZJdkVZ
 +/uW8vO8HPm51IGIAAAA=
X-Change-ID: 20260309-8250_pci_ax99100-d4ee75bbdab3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Martin_Roukala_=28n=C3=A9_Peres=29?= <martin.roukala@mupuf.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773064434; l=2650;
 i=martin.roukala@mupuf.org; s=20260309; h=from:subject:message-id;
 bh=XpuZzODpcmd8gO/nePcQz4+PvaxgI7x54z4naCWYAyo=;
 b=tbGpMcpSnMVu2Hj7+wXRiNB6kKZQuTdJmC/BkTYuP89da4d1PVFQnSnbqopCu4z6PzEI0Wt2p
 aMi4+WiMVuaBF3dfH6iZFXsryhqBXcP/BWpfrGRnGvHYS2pwc8sshaK
X-Developer-Key: i=martin.roukala@mupuf.org; a=ed25519;
 pk=TyNPQJvzE39EljzGB5lyKu0Ljo0X5RXGjKlVR4LEL9Q=

This is found in popular brands such as StarTech.com or Delock, and has
been a source of frustration to quite a few people, if I can trust
Amazon comments complaining about Linux support via the official
out-of-the-tree driver.

Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>
---
I have been carrying this patch for 5+ years, without experiencing any
problem related to it... so I thought it would be a good time to start
upstreaming it and solving the lack of support for the AX99100 for more
than just me and users of my packages.
---
 drivers/tty/serial/8250/8250_pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index aa1ab4da9ff1..6cfd1b2af5b7 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -137,6 +137,8 @@ struct serial_private {
 };
 
 #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
+#define PCIE_VENDOR_ID_ASIX		0x125B
+#define PCIE_DEVICE_ID_AX99100		0x9100
 
 static const struct pci_device_id pci_use_msi[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
@@ -149,6 +151,8 @@ static const struct pci_device_id pci_use_msi[] = {
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+			 0xA000, 0x1000) },
 	{ }
 };
 
@@ -920,6 +924,7 @@ static int pci_netmos_init(struct pci_dev *dev)
 	case PCI_DEVICE_ID_NETMOS_9912:
 	case PCI_DEVICE_ID_NETMOS_9922:
 	case PCI_DEVICE_ID_NETMOS_9900:
+	case PCIE_DEVICE_ID_AX99100:
 		num_serial = pci_netmos_9900_numports(dev);
 		break;
 
@@ -2544,6 +2549,14 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_netmos_init,
 		.setup		= pci_netmos_9900_setup,
 	},
+	{
+		.vendor		= PCIE_VENDOR_ID_ASIX,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_netmos_init,
+		.setup		= pci_netmos_9900_setup,
+	},
 	/*
 	 * EndRun Technologies
 	*/
@@ -6065,6 +6078,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0xA000, 0x3002,
 		0, 0, pbn_NETMOS9900_2s_115200 },
 
+	{	PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/*
 	 * Best Connectivity and Rosewill PCI Multi I/O cards
 	 */

---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260309-8250_pci_ax99100-d4ee75bbdab3

Best regards,
-- 
Martin Roukala (né Peres) <martin.roukala@mupuf.org>

