Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B21E9B3A
	for <linux-serial@vger.kernel.org>; Sun,  1 Feb 2026 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769919497; cv=none; b=e7236dtJMS5RemL3ZEwH3fW5Bh55m8k0uld2RQbc+TPggxmySDsvJNtuc6H/rYYODrOxY9jXxOMNDYfEJBn4cmnKYcZuldv19vbveU6usrOP5zaeD15nbvMlQempDoS0Ns1YZWgvQIuClUA3cJExQWB4cuf27XUrz21ywHvGzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769919497; c=relaxed/simple;
	bh=/snMkqA7Et8ZH1WOjyXfR67tFXsbjARBTR2KV0MW/bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qxh60bQAv9eUIO54y5E/NJIvhxIF+VzdvNhtP/CETE+C39rfEi2HSXdxMB3Th+5bEbHSU5v9K/RSQfR12PeY9tWxsmx3ol9o2/cNv0ZFSA1YGF5dYtGJvIuqmmr3jBrtTRgioIKKLRLWyWOeRmJo+EbPDGgAbGiPOjJnMujo8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9RVD0Tw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9RVD0Tw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a08cb5e30eso4461505ad.1
        for <linux-serial@vger.kernel.org>; Sat, 31 Jan 2026 20:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769919495; x=1770524295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvvl3iAKbAgCYx4gt1xiD+2SkCOVEBm5+O7+NxrV/0w=;
        b=j9RVD0Tw9Ty1dscCIhKG5qcgUVzPjfrjctDz4h6pHgTaYumrGh0GKgqveeaBlIzSMM
         GXO8971wsCKCsdoBSmh8of+TsNrqWWIyUkAVEeejimbjg4Sk+CRhDoLRiPlagfa5Igmb
         i3ZXmCFVyGvvY7mkRxzk7jpN99NAHeqNWKipatElM3pLm5dLMJuKm1rL1WLWuNcRcTJL
         etx7pmgSXnX4umLgkPAlNb9fTgq0mSUxZbNoDOmRMN4m3p2DJ5Q50NDBjHk2WHtq2byC
         ABmlgmFxba5M+wxi0XCwA1FyTp9tR8HQy13ixeWWwI3i4ZEEEWU5X2icwLvpYlu6Euym
         9ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769919495; x=1770524295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvvl3iAKbAgCYx4gt1xiD+2SkCOVEBm5+O7+NxrV/0w=;
        b=tYEMxmwzXDocLyKjroL06jKjgjw+oF22x3r7NkD9o8iOCzgkoDOoH5YMjvOVsJ09id
         X7y5kmLEYv+HkbyJp40+VmxVD3bocP3DAmINZYk1EDGNagCDNu6P4stD3KCJ624aG1ne
         7maMMdTH8FqjJKQZA4LE2rali4q/slCUJxPCjppmGGaVf8+ssHOn/rwDfEjeN5uC7wOK
         0atYKBc6AIqufwBoJQhZjBXfZe5lPicuDd0JqWLXiJkfKhujnyEW0C3C0eeiFF9scBPN
         pXQXl4oa7bnT82ORjMxkvrtiVaO2qlyioA3cLt3+hK/B4oaDZTSdMTmIIX+1tEj3aVA3
         17kw==
X-Forwarded-Encrypted: i=1; AJvYcCWuP/AziRRvNUuETEuCrqN25mjwgHti5oz6zVond73dRtdRvBDr/3XZl5qrzGgp+1eTaOL1nq3k5dF2nM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/RhJoaTUzQnU3gi9vM6vgAuu05VsPx+XXTqwNnHwgzIKTW31c
	MZdM1RYmAVyo6ooXHFdotdnQvudowwMSVBjKAPXNKrV6gIon/+SEOUvrRfVlbA==
X-Gm-Gg: AZuq6aLszJKJM0nZTtn0DuxogEVmmA8Esf/gsbe5HzP6edzR88djZoRB5LnxsyHOBVL
	4OwioAh+sbUVUgEVirW8zh4jghu2qH7srhf1aWMTwoyxpZ1R4otS0iAyh/pzOQn61mvTQNx+q3c
	/WLf04kVftlKNfroBSRPzA/4nsQWcJKcT6sk/Y6bin3p3PRHJjxNj7zMLhPkDTHSw80E8YyZibv
	f3KMqFoKLY3xiWnEWPszxiby7BIxcyrf030sJOtbP5J1W5JrB4AYFOnJ8nZAL8la34z/U0Ydjs8
	1QKd2QFbOnuaE0y7oQsMQezudqn4c0FhDtJohV8PYW4dP4HkJrQ1XipuAwOq1qv0oxzZAXqkPEx
	J2p7WiE7QbgUAZ/NgjfGe0QOSIfbuf6ZpOPYTb9VM0VNjOqYLg/GNZqjihroHmw03v0DBpxpOzd
	f4XLKoRNmoSMqoxlHaErogqAmqjfDqIoRVNdTdsrYTaHKuECrgyI93PLxrDdEADw==
X-Received: by 2002:a17:903:15ce:b0:2a0:f0c7:9998 with SMTP id d9443c01a7336-2a8d9949670mr62371115ad.6.1769919494983;
        Sat, 31 Jan 2026 20:18:14 -0800 (PST)
Received: from syu-OptiPlex-3010.lan ([2001:569:5a4c:2100:4f8c:995d:2e16:10c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b41390bsm109628635ad.23.2026.01.31.20.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 20:18:14 -0800 (PST)
From: Sheng Yu <yushenglive@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Yu <yushenglive@gmail.com>
Subject: [PATCH] serial: 8250: add CONFIG_SERIAL_8250_PROBE_BAUD option
Date: Sat, 31 Jan 2026 20:18:11 -0800
Message-ID: <20260201041811.520010-1-yushenglive@gmail.com>
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
 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/8250/8250_port.c |  6 +++++-
 drivers/tty/serial/8250/Kconfig     | 12 ++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

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
index 719faf92aa8a..dbc0ef56f995 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3399,8 +3399,12 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	else if (probe)
+	else if (probe) {
 		baud = probe_baud(port);
+		pr_info("console [%s%d] probed baud rate: %d\n",
+			port->cons->name, port->cons->index, baud);
+
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

