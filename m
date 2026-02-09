Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302771A9FB0
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2026 04:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770611208; cv=none; b=c3YUAuCMajqURM6rKkpwkWjxS4eQ1qFel/e4SRuLgLIu6W1vkDlA/QM+n5bo0yL8COwWQQG8TMJLx1gbqvNbhtz8PK0ZvNh7BnXowHlGNVObG11Yb9WTXVbr0Ks5T8dW4DA4WSc+C4tNqXy4gabZRU8Kem7hIqZX72sI7oCbufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770611208; c=relaxed/simple;
	bh=SC6iyuE9FLsBLZu+us/ZdLZdILZ1PUnLg1Iepn/JC4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XubyB0VqP8h0q2wHS3XGLP2R1PC+9WGtIrs/RfmiapDTCdIycOv7hx0Lcao79se1Ddrfu8/rsA8fGHbr8kP/CedXLAukbY+R8s1hLHVSts3XV06q2yFDpRv9tcnJJJR5/+XhpyYX6ucKXL4s0ls2ly7DUYPlUWoinojp7XeFPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/v6Cjt0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/v6Cjt0"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c629a31d1d0so207981a12.1
        for <linux-serial@vger.kernel.org>; Sun, 08 Feb 2026 20:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770611207; x=1771216007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHUEf2Ny35bmzTVEALeN5/xchQqozhm4kIjHReVSHME=;
        b=b/v6Cjt00ylc+JP3cBTBF5J3opi5HLJvMcRufGO2lCLxi1COyDbIIZ7KVplqCqHuoq
         ibgR5qnsr4dTGlJ9+SMYAKNI0CZABeu0x2xbMIiROgJEbfZiYuPttujxwLJVHOqLqIIY
         Gd6tFRPLIDPbbiig4w1ue6/4gjlZsRdEv2XZBeL8cuBLSVg6TQjixoDF+YXcuzue1Jy1
         VTcW3saKzg1qpULAHkZ0e0zojB2ddT0Zul0GIp+BkIT/ULIHl2ih+iBVIPgnP7x4w+m2
         I7gg9CdPOt/bpW8z8XjFsg0oqa4cdvhMDfonnKczq7xVgg7HM0SHlReJEnI4g0+ypJmz
         jLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770611207; x=1771216007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHUEf2Ny35bmzTVEALeN5/xchQqozhm4kIjHReVSHME=;
        b=gtJRw+Tiwqkg+ivxkAea1MQcqcBAGDlL+AIHs1bq3ucUUtZqQ4PnvojFu1EXwynJ6J
         TXYW9uvIsjy3PC/DSgViScw4gLMPaNrb+ziPu06N8R9Suz41ufFejqVe0SURbOT/RtNv
         TFQnAUCLmQ/3MDJnb16WKpNP+OkEeVC3tDhkAN7JS2rQ46zVD6vXkQrQo0nQyOYXh9MB
         T3DqWnvlSY9yB5extKxqnisI5I7EtPpP7V4AYyVlxoKu02/GMGal4kbLx0bHqVJtvE5K
         f66P8n503t2kF1fp+8Du4buqfapOXFReSI2xL+kY6KRRCfKAlejtTJouz0Wnabv5oE1C
         PCDA==
X-Forwarded-Encrypted: i=1; AJvYcCWfkrSi2H9IG219AIkMPIk3OrXvTRN88Vwl2JgWzDyZHGN+LNktfC3C8KtLySvAAnuxMyUbzplsz/IX8r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YychDZcPVafxu28RBKhqhh8ZcFhLuzGl9Z7OyBHHNU1Ojigliea
	Ri3e6zjWkfslcjudaGhL46qqAOfnRrFkrJyK0PPY567n4RnmzNpm6RCj
X-Gm-Gg: AZuq6aItPN+ykII6VFuoT1Og6oY7wkgDrdyxJSXqsejFANZ9VqW9aGnjCEgn2rjdSK6
	UuICayfz6Nm4yehiG3l7BP0++F1/iKiI9+2YNGkm9RmSmIQZVbXe3aXEl845JBCMPTZMl94EGwp
	ukYUZ1onhsc5HRGdnyEUKef+7Aky3KTAJlPxaqUA1abUhoUL877V2VPZAIrsWVEmqeP1ssO6Duj
	y1b39Dvl0wnIUlprN8wkiZRGhSn8fUZ5rTalga9YDzpk8kWOC45aWAg4tNfGuJ/stC7Z08dPBhE
	gTSsfCckqM7H2ILB5dcODDGydmK+WVFg029NyCBdSvdlfJw6IoGspt9sKw8AtyDjCUrFMzi3OqV
	xa2jmejitJ/PlhfzNXRLtL20x4HSS6QtX5XNCJn/Ttj8hzrpJDvvXdt/KqhgeHPC0XphoC4D3a6
	JpnyqfIgG7+DDWlrGZJMcp1Vi4/kx040CBe+D4s/IHZcbq2g/fIym6lZ9An0LVMg==
X-Received: by 2002:a17:902:f647:b0:2aa:df82:ed85 with SMTP id d9443c01a7336-2aadf82f18dmr25398495ad.1.1770611207391;
        Sun, 08 Feb 2026 20:26:47 -0800 (PST)
Received: from syu-OptiPlex-3010.lan ([2001:569:5a4c:2100:5b00:32df:79d4:c0a0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ebf2asm93149375ad.75.2026.02.08.20.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 20:26:47 -0800 (PST)
From: Sheng Yu <yushenglive@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Yu <yushenglive@gmail.com>
Subject: [PATCH v2] serial: 8250: add CONFIG_SERIAL_8250_PROBE_BAUD option
Date: Sun,  8 Feb 2026 20:26:43 -0800
Message-ID: <20260209042643.565418-1-yushenglive@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the 8250 driver defaults to 9600 baud if no console options
are provided via the command line. This can result in garbled output if
the firmware or bootloader has already initialized the UART to a
different speed.

Introduce CONFIG_SERIAL_8250_PROBE_BAUD. When enabled, the driver will
attempt to read the current baud rate from the hardware registers if
no options are specified, rather than forcing the 9600 default.

Signed-off-by: Sheng Yu <yushenglive@gmail.com>
---
v2: Removed empty line accidently added.
 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/8250/8250_port.c |  5 ++++-
 drivers/tty/serial/8250/Kconfig     | 12 ++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0e81f78c6063..c11b19921a1f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -427,7 +427,7 @@ static int univ8250_console_setup(struct console *co, char *options)
 	/* link port to console */
 	uart_port_set_cons(port, co);
 
-	retval = serial8250_console_setup(port, options, false);
+	retval = serial8250_console_setup(port, options, IS_ENABLED(CONFIG_SERIAL_8250_PROBE_BAUD));
 	if (retval != 0)
 		uart_port_set_cons(port, NULL);
 	return retval;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..5309b921e7b7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3399,8 +3399,11 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	else if (probe)
+	else if (probe) {
 		baud = probe_baud(port);
+		pr_info("console [%s%d] probed baud rate: %d\n",
+			port->cons->name, port->cons->index, baud);
+	}
 
 	ret = uart_set_options(port, port->cons, baud, parity, bits, flow);
 	if (ret)
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index c488ff6f2865..bee6a82023d4 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -596,3 +596,15 @@ config SERIAL_OF_PLATFORM
 	  are probed through devicetree, including Open Firmware based
 	  PowerPC systems and embedded systems on architectures using the
 	  flattened device tree format.
+
+config SERIAL_8250_PROBE_BAUD
+	bool "Probe baud rate if console options are missing"
+	depends on SERIAL_8250
+	help
+	  If the "console=" command line parameter is missing options (e.g.,
+	  "console=ttyS0" instead of "console=ttyS0,115200n8"), this option
+	  allows the kernel to probe the baud rate from hardware instead of
+	  defaulting to 9600.
+
+	  If a baud rate is explicitly provided in the options, that value
+	  is always respected.
-- 
2.51.0

