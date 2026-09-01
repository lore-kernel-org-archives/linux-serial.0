Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399930649C;
	Tue,  1 Sep 2026 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236141; cv=none; b=SjppM52ACEpex/0wdZ1zq1OPBxslc0Oyob/UtwJ/prEWm+OmTdYGgqr8b8ZoOeDwPEKWF21PTRlKZmlOp92jbEgUoqG6lsYvneVtDpMYsuJEMAi2GZutQCS+CKnZimyFLvDApa22qzGmv1KC2m23Z9qGRc2xchroU5VNJVFYNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236141; c=relaxed/simple;
	bh=oQob6Yua2wROl+aqVcJrBF8oiC26wrxMvo45rROqe+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bC+QxQLj7KkCYVi610eHc9of9w9rfJFaZsFU2tJw7xtTEQMLqRRUiyq7te8xQd+xRl3rU1U7/j26oW66sy0kyQdcnRPzW1ef4VThThc0xBLJx/bYqrsfqSqw+3+VYnCUoTRz87rqsbl5K4HPTCVJxo9YEvLifQjDjCq8KfbqTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c6e3aecaa5bb11f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e3d5eaaf-f856-4bf0-8416-f174331daa98,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ce476518b0df80b745da7dc020f62de7,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c6e3aecaa5bb11f19a56ed5b684f684d-20260901
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2098884480; Tue, 01 Sep 2026 12:15:33 +0800
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
Subject: [PATCH v2 1/3] serial: 8250_mxpcie: set the driver data before registering ports
Date: Tue,  1 Sep 2026 12:15:17 +0800
Message-Id: <20260901041519.114737-2-lilinmao@kylinos.cn>
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

mxpcie8250_rs485_config() looks the board up with dev_get_drvdata() on
the PCI device, but pci_set_drvdata() only runs after the registration
loop.  Where mxpcie8250_setup_port() presets rs485.flags to
SER_RS485_ENABLED and the flag survives uart_get_rs485_mode() - the
device has no firmware node, or its node sets
linux,rs485-enabled-at-boot-time - uart_configure_port() calls
->rs485_config() from inside serial8250_register_8250_port(), and the
callback dereferences a NULL board pointer.

Publish the driver data before the first port is registered.

Fixes: d21a1509c623 ("serial: 8250_mxpcie: support serial interface mode switching")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
v2: no code change; the commit message now says the crash needs
    SER_RS485_ENABLED to survive uart_get_rs485_mode() (Crescent
    Hsieh).

 drivers/tty/serial/8250/8250_mxpcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ce873fbd62e9..c0e3517d4e4e 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -542,6 +542,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	mxpcie8250_init_board(pdev, priv);
 
+	pci_set_drvdata(pdev, priv);
+
 	up.port.dev = dev;
 	up.port.irq = pdev->irq;
 	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
@@ -578,7 +580,6 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		}
 		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
 	}
-	pci_set_drvdata(pdev, priv);
 
 	return 0;
 }
-- 
2.25.1

