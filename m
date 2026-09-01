Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C03A7595;
	Tue,  1 Sep 2026 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236149; cv=none; b=C3cvKBZA3/rJVqg7e39R2/3MrYBWjvJNysM1GjD68iPEZOBgxLAZpgH6obA9F9pJ/1T4qcVVmB/UiNU809S0VlIgL5PrWvIlG4ydPm7j0aeGz0msFAoDAIQth4NeAcK9p0L/TH9bMMMHyQwcbI9RqtQMtDiIVSeD+lHziga82SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236149; c=relaxed/simple;
	bh=njtMQmHCspMsDzwadVgqC8c282Qj9vEQ004uuwyo0e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOFpphd/SlU2dRbwAAs/ZeN/g7RxBosWAWaCrDlQNHMPyDkY4WNnKDwW5al/qfYom738+f3sGgUIHs/Ppjtk30Ssgp5ReCmGbiHaNyizDtpSpkN51yOnu4OitJM6dcUFMeC9CvJi4+GnVDcpqH1AAXRKzqt0X5AhXEJccs/wBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c7e1c7bca5bb11f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:78bc5021-8424-433b-b52c-81d90c743dab,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:407f907bc0f3a8e651c0f0c95a6b964d,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7e1c7bca5bb11f19a56ed5b684f684d-20260901
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1880373277; Tue, 01 Sep 2026 12:15:35 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2 2/3] serial: 8250_mxpcie: only unregister the ports that were registered
Date: Tue,  1 Sep 2026 12:15:18 +0800
Message-Id: <20260901041519.114737-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901041519.114737-1-lilinmao@kylinos.cn>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When serial8250_register_8250_port() fails the loop stops and the probe
keeps the ports registered so far, like pciserial_init_ports() in
8250_pci.c this driver was split from.  What the split lost is that
function's priv->nr: mxpcie8250_remove() walks all num_ports entries,
but the ones the loop never reached keep the zero devm_kzalloc() left
there, and the one that failed keeps a negative error code.

serial8250_unregister_port() checks neither, so removal unregisters
line 0 - a port this driver does not own - and indexes
serial8250_ports[] with a negative line number.

Record how many ports were registered and unregister only those.

Fixes: 0481a041e956 ("serial: 8250: split Moxa PCIe serial board support out of 8250_pci")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
v2: keep the ports that registered successfully and restore only the
    missing count; v1 failed the probe instead (Andy Shevchenko).

 drivers/tty/serial/8250/8250_mxpcie.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index c0e3517d4e4e..ef2516ec16da 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -109,6 +109,7 @@ struct mxpcie8250_port {
 struct mxpcie8250 {
 	unsigned int supp_rs;
 	unsigned int num_ports;
+	unsigned int nr;	/* ports actually registered */
 	void __iomem *bar1_base; /* UART registers (MMIO) */
 	void __iomem *bar2_base; /* UIR / GPIO / CPLD (IO) */
 	struct mxpcie8250_port port[] __counted_by(num_ports);
@@ -517,6 +518,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct mxpcie8250 *priv;
 	unsigned short device = pdev->device;
 	unsigned int num_ports;
+	unsigned int i;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -564,7 +566,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.handle_irq = mxpcie8250_handle_irq;
 	up.port.break_ctl = mxpcie8250_break_ctl;
 
-	for (unsigned int i = 0; i < num_ports; i++) {
+	for (i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
 
 		dev_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
@@ -580,6 +582,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		}
 		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
 	}
+	priv->nr = i;
 
 	return 0;
 }
@@ -588,7 +591,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 {
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 
-	for (unsigned int i = 0; i < priv->num_ports; i++)
+	for (unsigned int i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->port[i].line);
 }
 
-- 
2.25.1

