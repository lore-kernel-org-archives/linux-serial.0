Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666757;
	b=OgUifAafWnC06twh0GfkmA06y1nDRetRRCoF43RzLWqVOY65JrzHb+G+5gVcVTune+f2
	 1ilKcS2F/KLNh4Tuih4RJxZ5AXrJ9oYw0zFkAOg9MRKC8euaeJ9VZ3GaZpNmUOJCz4fDa
	 9gc4vVuaLBVh3eY115n1vyqPVYnLiWKKc0rECU/f8RjS4QZJiGXgdghth1YAgxJ6u6qDd
	 p6Bxf19Xggx5IS4gqh/X73xEentLm3GvJDS+TyFaahI6ejBixRF3mzytjwghfKJvz80ZH
	 C7bl8hb9mNgMLlOFI/4cAvfQAOfvZey4wwIcroFak+G1B1iyVnVdAYdBvCbTUk5Psbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666757;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=GkD971tPxSKqETEMyAEUs3UeeROKJ4fTlH/yD0pAmps=;
	b=R3MHaduhzpzsY1VwOzhQb6zbn6PlGg/F4/Vkjk3NeqplfXvdkjGZ1FXIvl1WVekHmxu2
	 jjBAUCWnozoknwW1jYIvY+ah4jPlF9JAcfV4zFgYoBADGGiLnvyYjSNN/QrhullmyEqxa
	 SgX2HHV3grhSTRYSpAIBg0YVSHXrKh1i7weymSBz4fiHp0/5qE8L9Eu+hHveotoB0CN6N
	 6Bm8i6J6w+MX4pJIdPd/15J9yyhFAEhS8fpB750g/q0nQsnVzG9pRMUFSmGT9cW+v68uc
	 D9IMVkCu0g4bZzLalh1fmRfgkLce2Cr+2IC14uh1A+skLnvELWn8uuiWWadZffTOaNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=T8B6lD2X;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954A606A326;
	Tue,  3 Nov 2026 00:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5954A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=T8B6lD2X
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 533e14b0f;
	Tue, 3 Nov 2026 08:45:50 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: ip22zilog: Fix potential NULL dereference on exit
Date: Tue,  3 Nov 2026 08:45:46 +0800
Message-ID: <20261103-cmc-tty-1-617955e787@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa19ede96bc03a1kunm33c27c80118222
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx9DVk0YSkxOGExCTRpOQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=T8B6lD2XBJImXgQk415xHUTW6a04lFUthAXzcLauioBH1+pE9gvP2fF+9ezJBnMVa7K1AvIZ0+HOS9dlgqpVsbmAfSEg/XYCw/Bs1wonXEUyvUVjIRZgyEFHyciIn39zKFQXnIXuMm1flCHSSwq5E4qHiO7+HitbxQe9zNUj2xQ=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=GkD971tPxSKqETEMyAEUs3UeeROKJ4fTlH/yD0pAmps=;
	h=date:mime-version:subject:message-id:from;

uart_unregister_driver() frees and clears the shared UART state before
platform driver removal calls uart_remove_one_port(), which still needs
that state.

Remove the ports before unregistering the UART driver.

This issue was found by our static analysis tool under development.

Fixes: 3fc36ae6abd2 ("tty: serial: ip22zilog: Use platform device for probing")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the affected object with MIPS ip22_defconfig and LLVM
(W=1). No hardware or fault-injection testing was performed.

 drivers/tty/serial/ip22zilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 3fb8fdf8a853..b2a9c9652924 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -1140,8 +1140,8 @@ static int __init ip22zilog_init(void)
 
 static void __exit ip22zilog_exit(void)
 {
-	uart_unregister_driver(&ip22zilog_reg);
 	platform_driver_unregister(&ip22zilog_driver);
+	uart_unregister_driver(&ip22zilog_reg);
 }
 
 module_init(ip22zilog_init);
-- 
2.43.0

