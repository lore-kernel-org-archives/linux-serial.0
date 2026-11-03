Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666756;
	b=IpIq2tk0ZVsEVJUyfpn0PgvWlAVqgQY2LUDBDuwcadQ7UwGI6Q6kxP+BlsTZF+Q8EB3f
	 6UpHQ0eIgXMM5Sznuq1DETo2YkEfXBDP2x7rX52jBuG7MWc0PNZQvqNJyhxt9flKjO/JS
	 uwADpX32UcsPIGMEAgC/JzH6fhvILW/Ave4tXZp4kbqOFds6LA9ytYhJvELgfaafEQL1g
	 Z1dR8V/82nwg4dHCVEJ8L4DgB6TAPrcTfVRkHGjZFZfCbNWacQMxzDGc5Dr+ArEA83JQ4
	 CLITGIQhhzYXkmvcy1j3pioIYSIkIewZvB2ehAC3rNpcdlMPeBoKl7y6zRKZwDaJGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666756;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=kFcT8W+2UTHSKifaLK0InKSMUNNzp4iqDnKoB68nIR0=;
	b=iTti6mwZWmjlqkezNPi3QMMIrwN4nTywlXBKs8bgd0KPcfVgkXXxvqKaIFTF/uIm2cl8
	 0ZPHU6LDQKA337qeIGJ+4Uxw6Hbmugb8IgfWkdLWZbnjnexLPeVJDI2YkV3a0loDrwuQ/
	 qMeGHf4oE3rl1sAtic9x7Tj26NVkOLSUV9gOKXWLAW16a5OuRye2ALtbsMAM3BSfgf5/A
	 JXZ/fluqqKylnkXDnp4x2WO2lWLzzF2Iiq2kxsyKAtZIkADOEM6CVuaNoK9UbTofLw7wh
	 Ot0EzW3xuegBaQqRzhsMf7uD/KmXa6o95BpTq3NujnLs/RUkJuENCaDBqsuei/cwoQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="UWuKA/lD";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98490606A327;
	Tue,  3 Nov 2026 00:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98490606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=UWuKA/lD
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 533e14b12;
	Tue, 3 Nov 2026 08:45:51 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Tushar Behera <tushar.behera@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: samsung: Fix potential NULL dereference on removal
Date: Tue,  3 Nov 2026 08:45:47 +0800
Message-ID: <20261103-cmc-tty-2-683dcb126b@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-cmc-tty-0-f5f5ec0841@mail.sdu.edu.cn>
References: <20261103-cmc-tty-0-f5f5ec0841@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa19ede9a5903a1kunm33c27c80118226
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0NDVh0ZSU1JHxlJQh9ITFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=UWuKA/lDrlecki3KggJEW/DWLReYqRDsN4s6bcrPtfGTOAOgtzyZa0lINfL2C2JM5ST6rqgO8AV9w47NTmnmF2Dl7s5WNwJ3s1QWYgtCppTF8WU+7Byc9N4W1gV95MAm6HFImK5DRtO2jV0j/RX3pl+IsyYpWXdBMKyig9f7xTM=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=kFcT8W+2UTHSKifaLK0InKSMUNNzp4iqDnKoB68nIR0=;
	h=date:mime-version:subject:message-id:from;

Removing one port unregisters the shared UART driver and clears its
state even when other ports remain registered. Removing another port
then dereferences the cleared state.

Keep the UART driver registered until all platform devices are removed
at module exit. Retain registration on first probe.

This issue was found by our static analysis tool under development.

Fixes: 6f134c3c7703 ("serial: samsung: Move uart_register_driver call to device probe")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the affected object with arm64 defconfig and LLVM
(W=1). No hardware or fault-injection testing was performed.

 drivers/tty/serial/samsung_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d636..9768effbd39f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2058,7 +2058,6 @@ static void s3c24xx_serial_remove(struct platform_device *dev)
 	if (port)
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
 
-	uart_unregister_driver(&s3c24xx_uart_drv);
 }
 
 /* UART power management code */
@@ -2684,6 +2683,8 @@ static int __init samsung_serial_init(void)
 static void __exit samsung_serial_exit(void)
 {
 	platform_driver_unregister(&samsung_serial_driver);
+	if (s3c24xx_uart_drv.state)
+		uart_unregister_driver(&s3c24xx_uart_drv);
 	s3c24xx_serial_unregister_console();
 }
 
-- 
2.43.0

