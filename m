Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485694;
	b=GUzFlwXZ8UTRxGJzdbM3yvPyvtgOP0E4kPV5tQZ1aIb3ff0KfELoGH3PKX7mwwsys8Ap
	 kmdFxgJ7VpaeDbd4NslThaBFsH94OTm9JsjWwG9arFpQJoxv46/xyFUpDxERbpmocUWPb
	 7kBxxA/9D9Gzn13gx+q6affM5WJPQRPq8JXbyRSGp7R7Sg1+6FEmzC9JYJ0OICWcq58HK
	 pSJZ3ExVpAOhmFwLZ/hDHKrfsXGIC/vE3j3WpJdZOR+nxZDugaGKKI6jO8d3FeXdT1VRj
	 MC3TgQzDl7FhLcPWeEG+F1vJid8JSjnUM8E650EMRIQGUtwqwePfcvSXB+5ywjaKfYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485694;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l2Mj1yHq7UQOwdtNCSDgWI1tkPpgnieguVw9hneq0Lk=;
	b=iGYn+GEKeHP+ddEn6r+hZ4uB75Ey+jyFL4RWFHoQSMeA+8KJgmXpIPmmAl/L5/9qj7TG
	 IFwUNA/IbF0p75QyebHC94FnEufxWYwv/Ypv3NjTb241yos8CRyRLVf5QImSfFC15JYJj
	 Ez4BNoLwvGcEYvMaIIH/ufyRDx3/n2lG0Pj07OeI3oYMLkhgRseT2aDUY6q+hrlg0xJnN
	 bg2cOq+16/ZxM1HeDZgX5zrL0bs2y0gitn3fE/aZ3Dzi81KX6ULTORpYZ+MEAOvobJvNg
	 L34QNA5Y/pkSREpt1YApYEQc7dBsynR9vlUF+xqmlW2NHKW589yaGdWAhHthFw/dJHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B24606A32E
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B24606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0a2fa6bccc6211f19a56ed5b684f684d-20261020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f119b193-1cff-4245-a857-a4af38f2d6d1,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:7db8b62,CLOUDID:47ad41c54335af75f5a802b6634ee235,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:2,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a2fa6bccc6211f19a56ed5b684f684d-20261020
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 883738334; Tue, 20 Oct 2026 16:41:27 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue, 20 Oct 2026 16:41:13 +0800
Message-Id: <20261020084113.853878-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
This also drops the __maybe_unused annotations on the suspend/resume
callbacks, since pm_sleep_ptr() inside the new macro already handles
the case where CONFIG_PM_SLEEP is disabled.
When CONFIG_PM=y but CONFIG_PM_SLEEP=n (a valid configuration that
enables runtime PM but disables system suspend/hibernation), this
keeps a completely empty dev_pm_ops structure -- all callbacks are
NULL -- as dead code in the object file.Modify pm_ptr to pm_sleep_ptr.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/tty/serial/atmel_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5d8c1cfc1c60..c3880259e3bc 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2723,7 +2723,7 @@ static bool atmel_serial_clk_will_stop(void)
 #endif
 }
 
-static int __maybe_unused atmel_serial_suspend(struct device *dev)
+static int atmel_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -2765,7 +2765,7 @@ static int __maybe_unused atmel_serial_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused atmel_serial_resume(struct device *dev)
+static int atmel_serial_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
@@ -2996,7 +2996,7 @@ static void atmel_serial_remove(struct platform_device *pdev)
 	pdev->dev.of_node = NULL;
 }
 
-static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
 			 atmel_serial_resume);
 
 static struct platform_driver atmel_serial_driver = {
@@ -3005,7 +3005,7 @@ static struct platform_driver atmel_serial_driver = {
 	.driver		= {
 		.name			= "atmel_usart_serial",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
-		.pm			= pm_ptr(&atmel_serial_pm_ops),
+		.pm			= pm_sleep_ptr(&atmel_serial_pm_ops),
 	},
 };
 
-- 
2.25.1

