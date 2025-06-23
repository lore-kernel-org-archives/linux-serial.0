Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FC1F03DE;
	Mon, 23 Jun 2025 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659039; cv=none; b=oDQmq5z7KSArkYHXPY5JEYDRcVMDWBl3r6/FhEGJPQv2XHEoOU73XDmaIdDMoJnSyrvM4XSFgTHM+c1zZO0gXF7DYKCjK6Hgrq14eBeEuIJy37Q1+BjTIYTJU02BNknd8w9YpSwQSzAb6wab2/eiI6eCA9oFpLfFyYGeNZz+eas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659039; c=relaxed/simple;
	bh=CHl8Bc1LPxNncbSW22kKIdroqpbenW6GL3LHLeZfJvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzjlHPRn/3Q3REJ+/gYU1Mv9ICN3vvaGG6NWgPZGhZjBvP9Jc8u/gYcdFketr1KBUk7Cry9+ATbQHV12z/y9oDFKz3TB6OynslWMTUy5bp7b+XEJA9gFU9SbZMe5w33NHKU9d1taa9yfujEE0an3h14XWzsWZ9u7Zvlel9/gp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTcGzDkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTcGzDkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C02BC4AF09;
	Mon, 23 Jun 2025 06:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750659038;
	bh=CHl8Bc1LPxNncbSW22kKIdroqpbenW6GL3LHLeZfJvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=sTcGzDkbyAFU66AoDlnGdHsccLgblIYbZp10hDpVDh16BARbT81rVewLF0g+PriVU
	 4Ja4jm8rtnWTUkWV+dqSBgA5h0w2Ig7tRk6MIHCVTXUxyo/vriZpXXnz2MA0a5YO4f
	 5Rdj9oW5NHxM4DEnJ5wT42nhNIWUO/JsQZ717TzQc3U2zLyiWw7u1HcmMzRYko8q4z
	 E235v3R+mfmrJzk6GopvyVMHSxKokJpaLTW10E2FJy9WkAdn3yA2WX+OpTAHbMjP9J
	 hpz/XpZXYCkMwYYb3UnVVgZUZx5wa9sQrKiUVrOZcMyf9RlrkstgM9WhxD70TVgiDE
	 g9FH/XWwADC7Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] serial: 8250: export RSA functions
Date: Mon, 23 Jun 2025 08:10:35 +0200
Message-ID: <20250623061035.436414-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSA functions moved by the below commit to 8250_rsa.c are used in
8250_base.c. Since that can be a module (when CONFIG_SERIAL_8250=m),
this causes build failures:
  ERROR: modpost: "rsa_autoconfig" [drivers/tty/serial/8250/8250_base.ko] undefined!
  ERROR: modpost: "rsa_reset" [drivers/tty/serial/8250/8250_base.ko] undefined!
  ERROR: modpost: "rsa_disable" [drivers/tty/serial/8250/8250_base.ko] undefined!
  ERROR: modpost: "rsa_enable" [drivers/tty/serial/8250/8250_base.ko] undefined!

Fix them by exporting the functions. But only to the base module using
EXPORT_SYMBOL_GPL_FOR_MODULES(). (And not to the whole world.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20250619165607.33403e19@canb.auug.org.au/
Fixes: 5a128fb475fb ("serial: 8250: move RSA functions to 8250_rsa.c")
---
 drivers/tty/serial/8250/8250_rsa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index 2f1ee693103d..ff52ad02f6be 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -146,6 +146,7 @@ void rsa_enable(struct uart_8250_port *up)
 	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 		serial_out(up, UART_RSA_FRR, 0);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_enable, "8250_base");
 
 /*
  * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
@@ -177,6 +178,7 @@ void rsa_disable(struct uart_8250_port *up)
 	if (result)
 		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_disable, "8250_base");
 
 void rsa_autoconfig(struct uart_8250_port *up)
 {
@@ -189,6 +191,7 @@ void rsa_autoconfig(struct uart_8250_port *up)
 	if (__rsa_enable(up))
 		up->port.type = PORT_RSA;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_autoconfig, "8250_base");
 
 void rsa_reset(struct uart_8250_port *up)
 {
@@ -197,6 +200,7 @@ void rsa_reset(struct uart_8250_port *up)
 
 	serial_out(up, UART_RSA_FRR, 0);
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_reset, "8250_base");
 
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
-- 
2.49.0

