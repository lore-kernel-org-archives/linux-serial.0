Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295821257F
	for <linux-serial@vger.kernel.org>; Sun,  1 Feb 2026 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769920668; cv=none; b=mN9hJLucObBM0GxqewQGGvbMFZqP5As7RRLLMAhV6kT+09z52OYlFcBVXryRLqxI4ToqSBqBvqLM5k8ROHoHA5KTr9VdwHBOJXg5QbWZiBARwxxD6+DzXnPcEPEc1dAO8FghQetbe9kxOinII9CGeg1DiujKHM42i86cU/JZaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769920668; c=relaxed/simple;
	bh=l75NC+dMGo52Z/lqI8Tklxzk49YVO9S4uo0C8MSPvQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9BvbjpFoGZiS3E2oqDhS/kV5EjYmAkEN5ANHgYakl3Zg0RRYkX0tgk/jp4sxXfgUyyhL/s/jTO1MY4paJ1Mxga3F8KyJVntEOagPynqKsngm77LmZq9/qIJ/8jDuLJrtY8HSAnSEcAK60tPY1vVVJ/7UFklRF9g4unJbrqt4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss/8O/Cm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss/8O/Cm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7baa28f553dso30955b3a.3
        for <linux-serial@vger.kernel.org>; Sat, 31 Jan 2026 20:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769920666; x=1770525466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lro5M12HN28kueqyuSddo9Mm5/79VAOOVxaIFPHYvAw=;
        b=Ss/8O/Cmp5+nwNJAeFMNuG3jtzWaCOxQNn5v5+GZeGPwA/GP/3B1KkTaZSvUE2zQTw
         6qQ5h8oDJtm68KdcgIGwilbMcUu+lMwCEZBhvQIQscsR5vzHC2Jbkh1tGjqVJZJDs+qN
         bipVo0dP/34UKHx0NkHjnqcHQNydpuN0DPwZWUSnNYYbcfRPrbEKfj5JJsLUoOGCbYpP
         g0xFOMr8D9h3fdTd7K+4jOOsZsvmAQyuxvwh6B9LGlbFZaxrcQxi886WuQKom+VmVhJE
         oRv6vv5OyYPa1qt+QyALzJmmdLZr8St9uJsueu2PxjoViJmQoW4WukuEFCTFZfgtTCiT
         b1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769920666; x=1770525466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lro5M12HN28kueqyuSddo9Mm5/79VAOOVxaIFPHYvAw=;
        b=a+9ClMes/GWaAUU6ZEQGuYA7q7sxXPlFK2tyCA26EoScX9YNWRqvCXJsWXFi+X6bl1
         DdPdz/622YLC1koKV6TmmpI3hTZlODh7gO8/f3vE/wLfWRVkMYr1hFXw5DGnctcK9kqn
         fsLG3vRxez1iPYcCi3b9OMDJx3WiEEIcW2HF3xj+EWEkazkLmP73I7LBkmtlyMokN9/v
         hgICvyiKpXpBcH9/qAjxkLlF4S+uPyCpqG5dK3U4L/aNMzR1f54tgv/d9PYJYjpQz1Ji
         cADbfPEzBBICN5CgE3L2X44ZbBuKn8uLvViU2s4bHvNJJEbg7CpeXDvfFd8zOeOpV9Ne
         fbpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdbUgt6fl8n8jZ0mmv7q8ZBTtBuNOSgTsMQ62b7vSHMawTl/+wVAYO67JLFJCVUKA+I6E/Ai7b6yHChJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYFZeio60WMmI+UavMtuV/WOQpiGpL5rQKwjYHcEFWBt2C76h
	6xYBwdPH7O2qWLuC88I+pkXKn30T0doff2jYmEtgputGIV8/mNfP8fZr/uPNSw==
X-Gm-Gg: AZuq6aImITjQVGjxKYJhtGs+3YCpDXst7BFrmS15fm76OTTQB/kFglYuT/myYZHKDDY
	1atjMcDmaLdd2TSs/jVmkrQ0Wfgk5AetwI2hsKb+IjFR02JFgyG4nsjxsC4erPAdVTFUzcjghuz
	Uium42J8noUX0C5tXEbmJm/8eaT9KNoXo31MnRSsyjmd5oacRFfJFPMkAHzUDSZ8sPH1Hl+D3Pd
	Eg2v6jMwF5drV862TIk7Vtbaou5V922ZEOIKCsSiD8LYgZjFA86aFQt1N65MtI6oBon3Fw52bU9
	jyxBpbxNFBvIQrjZriRvK/YHR2vRnDzuKjab1MEQsye0+P7VGHy/y26tCJLDtgZ+aJe6wqiNGju
	J50fIaM81aLyjJoodX0Gh3rim3utEk/PyOn93FEQcIptx0kMAiCSw8ZEYo68zgU0BdYflFFg1UR
	agM/w/hakJ8r2AqkZXIW8EDyAXeSXAysQUy585iSW0um7bZFAdbhjT40SsaNYoEQ==
X-Received: by 2002:a05:6a00:bd02:b0:81f:e791:ea3d with SMTP id d2e1a72fcca58-823ab42ec6emr5920465b3a.0.1769920666442;
        Sat, 31 Jan 2026 20:37:46 -0800 (PST)
Received: from syu-OptiPlex-3010.lan ([2001:569:5a4c:2100:4f8c:995d:2e16:10c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcaadsm13229401b3a.37.2026.01.31.20.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 20:37:46 -0800 (PST)
From: Sheng Yu <yushenglive@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Yu <yushenglive@gmail.com>
Subject: [PATCH] serial: 8250: add CONFIG_SERIAL_8250_PROBE_BAUD option
Date: Sat, 31 Jan 2026 20:36:14 -0800
Message-ID: <20260201043615.524435-1-yushenglive@gmail.com>
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

