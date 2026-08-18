Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF81448CE8;
	Tue, 18 Aug 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045981; cv=none; b=sMHGpOVyB7T7rDNxS2d/CLSEXm9214TbGzh+dwiowaExG3ROIqoZE/xlG8CjD2E+7vMms9BY1PvOPMHBiitxR/mK7oJlC3xbPmGVb71FV61sOs/pdbSXeDrBJT/Xq2ntPupWbLgYm1ELzl1KKAqgzwOKfzIXyfnxEG1TLiXqTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045981; c=relaxed/simple;
	bh=YGGvLyjuVFKbu53Y/AZ7U+kAxE9qdfPgxuWYZTi0KCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHg9DV07+NcWlr0G2uSosp0yItvPR1AcdiUPHsrH6G1FMoKfPtYFN0k/wpO/Yx7UPxnIF9Q9l/hPRldbpGfKDFbXCKwAtod6pGhcFn5c9/00rFAMVbPOsH3JnVSLtya++p2NPes3WS5F679mbsgWi3XleroHjVqpx6f4RZyCFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b58856d69ae811f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:656a1af8-8724-4de2-89ca-c1063ce96e8f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:d4173447bc66701c8e009505c14829aa,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b58856d69ae811f19a56ed5b684f684d-20260818
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 529868187; Tue, 18 Aug 2026 17:39:29 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH 2/3] serial: 8250_mxpcie: fail the probe when a port cannot be registered
Date: Tue, 18 Aug 2026 17:39:17 +0800
Message-Id: <20260818093918.3190686-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818093918.3190686-1-lilinmao@kylinos.cn>
References: <20260818093918.3190686-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When serial8250_register_8250_port() fails the loop only breaks out and
the probe still returns success.  The entries it did not reach keep the
zero devm_kzalloc() left there, and the entry that failed keeps a
negative error code.

mxpcie8250_remove() then feeds all of them to
serial8250_unregister_port(), which checks neither: line 0 unregisters a
port this driver does not own, and the negative line indexes
serial8250_ports[] out of bounds.

Fail the probe instead, unregistering the ports registered so far.

Fixes: 0481a041e956 ("serial: 8250: split Moxa PCIe serial board support out of 8250_pci")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index c0e3517d4e4ec..ddd02d5622ec4 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -570,14 +570,18 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		dev_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			up.port.iobase, up.port.irq, up.port.iotype);
 
-		priv->port[i].line = serial8250_register_8250_port(&up);
-		if (priv->port[i].line < 0) {
+		ret = serial8250_register_8250_port(&up);
+		if (ret < 0) {
 			dev_err(dev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				up.port.iobase, up.port.irq,
-				up.port.iotype, priv->port[i].line);
-			break;
+				up.port.iotype, ret);
+			while (i--)
+				serial8250_unregister_port(priv->port[i].line);
+
+			return ret;
 		}
+		priv->port[i].line = ret;
 		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
 	}
 
-- 
2.25.1

