Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8D5237A3
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867467; cv=none; b=OMSiGc5TQ/PXizUN//gyR19VXHyeU7TOVKX5AadkUxNgs3L5cEXynMEdTco1QcpqFTcJE6SyQNU76s78sowJkZEdbHljZpSwd9/cIip3jSXDF8oIcBG1Z6RUFrBqUj+ixJzIDMAQNSIvLs/QpqmeCUe94HTThKwoOu2bDWJKQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867467; c=relaxed/simple;
	bh=8moAyst6CxBNPqoS7HrKundcTgR3nnAKSpMdJVL2XDQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=m98KpCL5ke/VZA1F9Gc4RxZFNcakO6aQMsgpKFVbqnc98mEP56d24zKtD0Jqj8bJEu3wnTnd2jMGffFSSnwKUQFxHEoAfOyGz7PCuomjmhS8hRMnKJKKVo+0hKA0Bc88GizJQZZrXIFFEm9u+ibDrd0BJq2RwVl5x54V5ktDAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af27ed46ab7911f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2fbc9747-8a62-46a5-b576-8db78faed7ce,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:7db8b62,CLOUDID:5695e330b0072cfc5bbe5dc2aaf6ba5b,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:2,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af27ed46ab7911f19a56ed5b684f684d-20260908
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1851151199; Tue, 08 Sep 2026 19:37:34 +0800
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
Date: Tue,  8 Sep 2026 19:37:19 +0800
Message-Id: <20260908113719.4078979-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
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

