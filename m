Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D239D3EB;
	Tue, 18 Aug 2026 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045976; cv=none; b=UDKqeUuBx9dF8wfWQb5byW5nW6Xi7glub8Myhna6u9r+njo8H6ScAV7meFapNy4UiCYLSIgrSHWC30tpNYVHXvoT1zXeUK2MJMTY7llcpXbPlQAxu0u5RR8w354P9bVP4xzFc7jBVTf2BTMMo0zsca9cQl1oCpaeLfSMk4CWsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045976; c=relaxed/simple;
	bh=+EFe0PfFIAlIFxAaTH6NmDRVqhin9Q4iwJ6PVYc4UQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pn/BO8KTwrUaJVTs7+8UYttrKmhtuXbnnbv1Oc7EcBmoCHaBByXQnChTs9y07LGDTrTZLvmvUbIBmfb6UEbSPwGJONOgpFFWtG0e7GQVAPPjmosyGFD/H7iywHxFsSDXWnDlKqF5WrLHUEVymXV/FoTbT1X0NSks5ceh+58xZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b3ce71a49ae811f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:09ef6b78-c2dc-46bc-871b-87190dfd182e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:02c3d268a92bb0d2ddc7d265a9d315e0,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3ce71a49ae811f19a56ed5b684f684d-20260818
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1530558210; Tue, 18 Aug 2026 17:39:26 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH 1/3] serial: 8250_mxpcie: set the driver data before registering ports
Date: Tue, 18 Aug 2026 17:39:16 +0800
Message-Id: <20260818093918.3190686-2-lilinmao@kylinos.cn>
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

mxpcie8250_rs485_config() looks the board up with dev_get_drvdata() on
the PCI device, but pci_set_drvdata() only runs after the registration
loop.  Where mxpcie8250_setup_port() presets rs485.flags to
SER_RS485_ENABLED, uart_configure_port() calls ->rs485_config() from
inside serial8250_register_8250_port(), and the callback dereferences a
NULL board pointer.

Publish the driver data before the first port is registered.

Fixes: d21a1509c623 ("serial: 8250_mxpcie: support serial interface mode switching")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ce873fbd62e93..c0e3517d4e4ec 100644
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

