Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7723A99E;
	Wed, 24 Sep 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721314; cv=none; b=L9ylqH2u2aL0GO5j9/V0sTHPSt6d/2A9smgUrnJUFkk0O9T/nE9oQABNdokRNBCvEKDG/+nBMbNqya834eSACpZnxTB3TJbkTNdwlgE+pihm6pV71uJkqZ03/dxW6BWn+P+woboUzUl506zgR46v3JRt8p3Sh5Eu4/AA+qrzbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721314; c=relaxed/simple;
	bh=bMfjgt0zuFACnPatM0wC6i0UpEJUWx4nsS7UCSaXjtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaf6AxsU+NWxJiKlw6ue9Y6IRr2V3t/aeVnhsIYBNiW7LJwyrA8s6EDz7dm7/DRL8l4zrQmAq9Zvf+LhQhd95YOt7dh92G7Zro4OJR6IjJtXA77mlNrnMxecpmOCCUg8vlo2WvCpZcW2jDPmS/sd944EAzL/NwMdAHrRq2ApMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=fH+6Zg7+; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="fH+6Zg7+"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=8376ac7522=fe@dev.tdt.de>)
	id 1v1Pkc-00BdZR-1e; Wed, 24 Sep 2025 15:41:42 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v1Pka-00B8RZ-UQ; Wed, 24 Sep 2025 15:41:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1758721300;
	bh=mlsi0Pk8mNlr2tL7GUgmd79KviwHbO4DTqqn7TGQM18=;
	h=From:To:Cc:Subject:Date:From;
	b=fH+6Zg7+4vEEAH5IeOIZA7nsOPAHY14un66csKhzL9yz17VkiCWBkaMyxtFQa+Eey
	 bloGmRbiQ52HdLoJ1LbLE7fzoUfHA0PIzXJMNYEm1jr+d5oJfZtMl0OB6m6jvs57Ax
	 sudR9AE+sOkNnL3Hk23olrO19vbjwMDXEt06b1VX6FfKJL2UlVePWrxLlOqJnYwGb9
	 U2P3mOStil/s9BSRsgJyqu9csxnSfZaFZqu0srThbApTalhlL7rNa9JBGJrIZMLexx
	 YjAoHj5C4SQovA0bYCSeq7nC7HStJZsbhggx0FDvOQQAj9V3FcEQFM2al5F746+Gkd
	 jFTliIM+N1NHA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 54378240040;
	Wed, 24 Sep 2025 15:41:40 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4586D240036;
	Wed, 24 Sep 2025 15:41:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id D8FE522FAE;
	Wed, 24 Sep 2025 15:41:39 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, Eckert.Florian@googlemail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH] serial: 8250_exar: add support for Advantech 2 port card with Device ID 0x0018
Date: Wed, 24 Sep 2025 15:41:15 +0200
Message-ID: <20250924134115.2667650-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1758721301-B3D80A68-F8C15D0B/0/0
X-purgate-type: clean
X-purgate: clean

The Advantech 2-port serial card with PCI vendor=3D0x13fe and device=3D0x=
0018
has a 'XR17V35X' chip installed on the circuit board. Therefore, this
driver can be used instead of theu outdated out-of-tree driver from the
manufacturer.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/tty/serial/8250/8250_exar.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
index 3c16a849b474..c682c0d0dffa 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -40,6 +40,8 @@
 #define PCI_DEVICE_ID_ACCESSIO_COM_4SM		0x10db
 #define PCI_DEVICE_ID_ACCESSIO_COM_8SM		0x10ea
=20
+#define PCI_DEVICE_ID_ADVANTECH_XR17V352	0x0018
+
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
@@ -1622,6 +1624,12 @@ static const struct exar8250_board pbn_fastcom35x_=
8 =3D {
 	.exit		=3D pci_xr17v35x_exit,
 };
=20
+static const struct exar8250_board pbn_adv_XR17V352 =3D {
+	.num_ports	=3D 2,
+	.setup		=3D pci_xr17v35x_setup,
+	.exit		=3D pci_xr17v35x_exit,
+};
+
 static const struct exar8250_board pbn_exar_XR17V4358 =3D {
 	.num_ports	=3D 12,
 	.setup		=3D pci_xr17v35x_setup,
@@ -1696,6 +1704,9 @@ static const struct pci_device_id exar_pci_tbl[] =3D=
 {
 	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
 	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
=20
+	/* ADVANTECH devices */
+	EXAR_DEVICE(ADVANTECH, XR17V352, pbn_adv_XR17V352),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),

base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
prerequisite-patch-id: d226b2363004eee0962a350752df5facc0637d96
--=20
2.39.5

