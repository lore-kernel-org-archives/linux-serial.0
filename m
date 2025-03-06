Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EC18DB38;
	Thu,  6 Mar 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230350; cv=none; b=sxPIqXb53ePYzprXbbkYKDQMBzomtdm64M9yCeJIYkeJi46oqCr7ixTt/RCeAh16+BUEWr6cFXNATJm96T3RK3IqkEd/pTwyQyf0srffBayn1iDdj2jhfoKvxThiD/N5CQoSdBdLRbjCjgKze4k5Pkizm4EKNQweI757bwUzmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230350; c=relaxed/simple;
	bh=zdz7CkwVMBgcI2xIj/cd2ivjhVBpl28n6YxsxS4KtvY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HfjdbZ7DOJIJQUObxQRCSwh8t8v4WUPyq18T7/fTTZ89fz/KdQBULS+nFchaRt2HzsyGGMVlrOicoTngRZH3SpZr/tZXuGNI9WQ3felIqrymetY8xb4a5xLgsppVWDGye+QcDP9nXsyQFbge2HFYOgK07dnHoFTlNOwMpJgOc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BdVl2gnK; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BdVl2gnK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741230035;
	bh=HQ3ghFNl67yGrzRUhW9MQoloHh9uEC1vinm/88yQjuo=;
	h=From:To:Cc:Subject:Date;
	b=BdVl2gnKMIOsYPOSUa0txCwK2wRvytX2jGLkEB5VXj/XMfBW0hHsDV9M8FBeqIiH5
	 RMei5lkVdrksWlIBX+JE/DbH+a2Q5z4Bt6upTH25+wUZwCC3URX8GccHN013Z41avR
	 APtesodlOV3WfSm8VrknQmybhN+KD0RnLIZEho/E=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 21A765B; Thu, 06 Mar 2025 11:00:33 +0800
X-QQ-mid: xmsmtpt1741230033ti8xc8w0a
Message-ID: <tencent_50535E8627177335AEA311C5DC0A54609008@qq.com>
X-QQ-XMAILINFO: M8dwXi9nz8r0IVG23OGWrpfeR0qVYDKA3l9fCa2JPvSwR9cUlM905h6e0fL82B
	 oWILoKdPTx+ALisOhm4RjEJ7vwmFyDZ3uQGXnNvj2r/hIXvf3pPrB0Z5gyCEz6bSxiYDMoVRt9yH
	 xXBjO2wklX0avFIOoW28PBb8trLXdYlFheJ01GJeqh8TSmZRuqSVX0wwRSWaQe6SwcCd2Gux1MMh
	 8dwlMJfLLtOdYSXJJ7yJFHqaeNfbLDB46oddpdN0xPwWxfTEKiAWJ5zLKxrDizArsWlB7opx05Nj
	 xvqTCXHmrzigmFpNVW8zCZaWvexZgAPaqvZV/URMjsvsQFXLGGj5A48CBMIE+pZYXOs7kmzjSkwD
	 00WgnUZouY7N0X79bQvkYkWiB78N7gSmLUiVu8k724bO80TPUMgogyfYvGpHL3KSYBGntvkaEt/C
	 LM2EGLmFFNaiXj/tu7RvZrZI/RObovqw/JeVV48TjeSBlwutLjkoQaxgJmGzKvNdv/lMkBo586cV
	 3tCuthExUYDE97EdeiDwyFQ63Iv9XWPwQSpVSWGqo21BbI/PXlYfHqXu2IPY+xg+6mB9HPTv9u4+
	 JxlgFB11Nvfe3vJDgGw6T3knhXR2+ggSs6YlIC99bhIQnhDl4ZVQtgGRpb6OXTKY6fvC8/rXbSzI
	 Ee+sPa7G2vZTeaWqVxaJ1zKG1v9dtIWIA26M4+Umv2vzhhKDiIr/D4B5tAAFHkV8tG/5HnLMAJQK
	 jVOw4m1EDiEiAtAQ/JiAJXOsnEszwCJv9UsinCFxuZ5htSLa8MYaMSCJADc0YK1qRgGbIXK97cns
	 dNG7EBu5Nv48IAtegD049TGP1V6uU75VRp+nwp9Dfw8Jl21KfxWoY6tTP2Go84Jud3L6qxHetUZZ
	 DCDu4e0JK5IlnLmmnAHYP/ZIzPgQN2lsdl579CdGBWzbSpUNGitNxcPs1+/7EZuiq8DihBLUHQeL
	 n0iYJ83gv8h3slJ2ocssfKJd9iW9rf
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: xiaopeitux@foxmail.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: xiaopei01 <xiaopei01@kylinos.cn>
Subject: [PATCH] serial: 8250: Optimize port function assignment with generic macro
Date: Thu,  6 Mar 2025 11:00:32 +0800
X-OQ-MSGID: <20250306030032.85359-1-xiaopeitux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xiaopei01 <xiaopei01@kylinos.cn>

Refactor repetitive conditional function pointer assignments using a
generic macro ASSIGN_IF_EXIST. This consolidates 15+ conditional
checks into a consistent pattern while maintaining type safety.

Signed-off-by: xiaopei01 <xiaopei01@kylinos.cn>
---
 drivers/tty/serial/8250/8250_core.c | 52 ++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 6f676bb..6f305e9 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -777,38 +777,30 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 
 		serial8250_set_defaults(uart);
 
+		#define ASSIGN_IF_EXIST(dest, src, member) \
+			do { \
+				if ((src)->member) \
+					(dest)->member = (src)->member; \
+			} while (0)
+
 		/* Possibly override default I/O functions.  */
-		if (up->port.serial_in)
-			uart->port.serial_in = up->port.serial_in;
-		if (up->port.serial_out)
-			uart->port.serial_out = up->port.serial_out;
-		if (up->port.handle_irq)
-			uart->port.handle_irq = up->port.handle_irq;
+		ASSIGN_IF_EXIST(&uart->port, &up->port, serial_in);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, serial_out);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, handle_irq);
 		/*  Possibly override set_termios call */
-		if (up->port.set_termios)
-			uart->port.set_termios = up->port.set_termios;
-		if (up->port.set_ldisc)
-			uart->port.set_ldisc = up->port.set_ldisc;
-		if (up->port.get_mctrl)
-			uart->port.get_mctrl = up->port.get_mctrl;
-		if (up->port.set_mctrl)
-			uart->port.set_mctrl = up->port.set_mctrl;
-		if (up->port.get_divisor)
-			uart->port.get_divisor = up->port.get_divisor;
-		if (up->port.set_divisor)
-			uart->port.set_divisor = up->port.set_divisor;
-		if (up->port.startup)
-			uart->port.startup = up->port.startup;
-		if (up->port.shutdown)
-			uart->port.shutdown = up->port.shutdown;
-		if (up->port.pm)
-			uart->port.pm = up->port.pm;
-		if (up->port.handle_break)
-			uart->port.handle_break = up->port.handle_break;
-		if (up->dl_read)
-			uart->dl_read = up->dl_read;
-		if (up->dl_write)
-			uart->dl_write = up->dl_write;
+		ASSIGN_IF_EXIST(&uart->port, &up->port, set_termios);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, set_ldisc);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, get_mctrl);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, set_mctrl);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, get_divisor);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, set_divisor);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, startup);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, shutdown);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, pm);
+		ASSIGN_IF_EXIST(&uart->port, &up->port, handle_break);
+
+		ASSIGN_IF_EXIST(uart, up, dl_read);
+		ASSIGN_IF_EXIST(uart, up, dl_write);
 
 		if (uart->port.type != PORT_8250_CIR) {
 			if (uart_console_registered(&uart->port))
-- 
2.7.4

