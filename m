Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFA3E0C7B
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630631; cv=none; b=H71jcA9JyxkVzooy6DNumqCvBPFDF4Cxu7Dn8KWbPV/oTH4BRZbowyVGMX9ckZ1U+ULKnqcwj0gx4Hr4j5B+ELTuxA3Jx+8owxqNjGCQBgpL+z6oKUNQjJdMF8GUBBKM28vd6fClvezi1of9p7qxS/vpK5yBNVwglsKplf6DYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630631; c=relaxed/simple;
	bh=UOPWLLrKQJKvBsQKzVTiSHTFrQsDchtB/T3uQMykkS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv4m1k9/YvXOE+Cu9QgBKMHotLHyz9PCRag1tGYqUh7rRKTiGR5W9NqkC3BDuH5DjZ6C/xw5wxh7TVDI9CRAF5zC4364f/pAuSNZPnqNKVpT5tkWNg/NlvD81/NXPqY16xCEqWiL9ehY/EJjl3Cnb1cCuKU34M/wVgde0ePP2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIiTkPd5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIiTkPd5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso2057755e9.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630628; x=1784235428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z/ZeejehRBl9KeHPFOFStf/P5Levb0cXZN01ZYiLMbo=;
        b=MIiTkPd5zkXCC7biUgRXJt3z5vix61twjF9BX/eAJ797x/4wAH03wT3KdknN5QbuVx
         8dAXsDKe7ncncSnuq6omEmau1bcmkd3cObzfjXAevS262BCQW0vvQB8xWC7aJemwlWkU
         1tKnpTJdaPYSlguAOODw5c2uMLZ/QQGxNe+99agpOZXbxwS+a6WErxl5XwaOSUvTx5Pi
         s1LHVT+ZJPC0eDwJWjImTa1N3goRbMykwB1nK2J4e1fOMdCkHNKsDnqXWzHEEvZQbpg1
         uuhhJCgz9EZ8Tr6iXqhb5aV3BTdhxNBeogD6n0VaaZ7N1STWVq8QHiGBZ+nzRC6wRUsm
         7Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630628; x=1784235428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z/ZeejehRBl9KeHPFOFStf/P5Levb0cXZN01ZYiLMbo=;
        b=YF9QoLJyBzaflE39GnThE0ioqiUiVohrk7j1LXq5eStMuza7e8BD4Mf/GkKGthUWpF
         seBPPnFOwdgIififO899M424iItPSMx1qfT53xN1EiMd+j5evb2mtN4BROa+vdj37aKL
         TSXUA8vDHVYBfXxnIpu6aqw03sr4THdz1JytFPnz00UwWVqphBiUUFQYyx9adDjLAuak
         Pjz/t/xZiyMoOSxjXm9n5z/YtRJLgyZBlSgKyU0oYta+kuqDzYpvYqfLKid2wazfYSLs
         pSj8Y3oen/rC+4hSbkGKCJ/bT6S5Ro6lXnNqCJ30LndSBlQdpqudvmBkkxjxUMM2fmIv
         CRjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmsBZ096hE7ebj4r+zAwUPpAEf3a22zbv1euwxyQ19lAUzI+5N28C88dxIprEsu6tdFJpz4DixWte4gu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9JcCyp+tRLMUDPK7OL9bdJt+Z4/l1SWC1NFNkeimJ26LU1p8
	sxuREfaQru+w1abIA0x70OP7hSbPSBy4SWCgKhwBufqUT9Nn8Zl5hngl
X-Gm-Gg: AfdE7cneYWI964QzyqTlFenco17PCET0lJRHeqYF0xHa3dUfsJqjR+PbVRi5hiOZ5kW
	s2v1XHtHFhhT633SWrNx6xxEmt+zhKlBjoERZHAEcTSX5yVkX3LWq3b+PTi+gS9TTHMY9tBhQhM
	U2c12oiNPIjdtyKY6f3XLolsTvnLhNadTA7jknZ16HYz413ava8l01INHF6DWeCfpWXyUE/rVfr
	B2CvXuZx2sjCkrowMD+S0yqrIe6Os0l1WdZ53k0c2m/lUS1dll4ysG70uDNCTCb9aYk8ON42yi2
	NPH+xsTkUxhtoyjmzHi1uB6Wf8qVkfFtURKLAL544eRK0TE7zQ4OV6dwCbWjJVGt07a7FrH5Kgr
	hTlafuCDPmD2zDSzmYAIChACM/v7ycnWW6WkD/BhV/bXIz2XshCex7HlsadR0XX1nDkt4BsKleO
	L0+RlC7ZjtfaWNAHNsxbrHEoWuQf6+RjJxAx99pVe8MEbdp506EcW7KyPKhMu7Hm10mAfRh74Lu
	/wACUOe
X-Received: by 2002:a05:600c:6289:b0:493:b647:1acd with SMTP id 5b1f17b1804b1-493e68dbd98mr85115815e9.36.1783630627912;
        Thu, 09 Jul 2026 13:57:07 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm52894965f8f.6.2026.07.09.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:57:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/4] serial: 8250: export serial8250_get_baud_rate()
Date: Thu,  9 Jul 2026 22:56:50 +0200
Message-ID: <20260709205656.319531-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709205656.319531-1-ansuelsmth@gmail.com>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some driver might need to access the current baud rate to correctly
configure it.

Export the serial8250_get_baud_rate() function to limit code duplication.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 ++++---
 include/linux/serial_8250.h         | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 630deb7dd344..033d8fb8bb23 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2560,9 +2560,9 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 		serial8250_do_set_divisor(port, baud, quot);
 }
 
-static unsigned int serial8250_get_baud_rate(struct uart_port *port,
-					     struct ktermios *termios,
-					     const struct ktermios *old)
+unsigned int serial8250_get_baud_rate(struct uart_port *port,
+				      struct ktermios *termios,
+				      const struct ktermios *old)
 {
 	unsigned int tolerance = port->uartclk / 100;
 	unsigned int min;
@@ -2589,6 +2589,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	 */
 	return uart_get_baud_rate(port, termios, old, min, max);
 }
+EXPORT_SYMBOL_GPL(serial8250_get_baud_rate);
 
 /*
  * Note in order to avoid the tty port mutex deadlock don't use the next method
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a95b2d143d24..8d26fa2008b6 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -208,6 +208,10 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
+unsigned int serial8250_get_baud_rate(struct uart_port *port,
+				      struct ktermios *termios,
+				      const struct ktermios *old);
+
 void serial8250_set_isa_configurator(void (*v)(int port, struct uart_port *up,
 					       u32 *capabilities));
 
-- 
2.53.0

