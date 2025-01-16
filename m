Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BF233532
	for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051791; cv=none; b=F7bEKl6FRYfK75CVgCZXJ2rX/V1W22suoFBw9UXo8oZA7Z/kXwLAX9DPC8f0UUz+QCDP0iUTDgFQr75psVcwA3NAH2I4Bcsq0/4QT9vajoLYXGFsS+Ro1HBvoRmPyxdtINMehpgJ+nMNIPQHRnRl/68GXBC22jWcXtxb3G0jvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051791; c=relaxed/simple;
	bh=4o76eL3JN8Rw/PF8oYl6df0FpGa0o1Kgqe00X1TGqRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMcqrhCxx/N3qhedlhA3ocRNj3lbhjVcrp/7PNu8/Jj5URrM8TM91fcmItbx/oIVxV5fWVsN77EFcNcFuDK4SIDGz/XB7jq1LJOYYPcP3ojwNSEVT1qJwwzGW5fZUrNzJa1qWkjBma6z8eqPO5rlzPN4k2TypwlTmJYz/oTOqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nyG6k9WB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nyG6k9WB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436249df846so8343935e9.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051788; x=1737656588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSWSInwqzRrvj358vgmNewsmiwlVd1V3Egd84Fq6+DE=;
        b=nyG6k9WBZn694dEj5tKi8s8XArmuRWF0gC7KukTluh7UDc/Adiys65eMkrsy4VLxca
         dmW1ly2CWI48rhsrVR8ksVwRacjGNF2rL8OdFudqdF8XJLHg2Kw+bEYbDjmBaBm1c+bR
         YW/JqKV2d8wvAB2rXKqyt9PS6jCUFloBjIrenFXE5Nfrpyp2dsL4dhCqvT6MEmTpOKR7
         UoFtdM8B1z+BC5kBiFgaSYMGD/bURp0qPUf549H1qU0Rykr+9xJAPcfr7QH80dPCg0nj
         E7ApXfLiynbLvzohQHKwOJcBrSMTPn/P1Ax7R+UtuZn46XhY86I1IZ3ktBsirv8zRBn3
         uLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051788; x=1737656588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSWSInwqzRrvj358vgmNewsmiwlVd1V3Egd84Fq6+DE=;
        b=tNuhr6RYYgkWAA5Fa4fYTxIGe/zsSPdmCFpJ5bStGEVmBQnhyNBV5o/Zt1SXgvpT0K
         4gzQSIv1OG/CQBo9ekXY5J4tu5XcQIhOv2ig0h2i7sGMtvdA1y71bw4wnRA9KajTTpIL
         rcsFN7lioX4BhryRWwTYmEQwIdO4ipOCHbIzjohXLoZgCpJrFoyuV08LwfueQyv2xiY/
         8gr8MwW2bWhH2Z0DWDNlRfa6PwrM6SAGiwfD3fsm9JhO8AaZt4YvVcuQWy58BV0afmNM
         9w/Cup1BQmOcd7vEuPRJgBiYFRVRmYZSFUCCZQYTR4bSiLERplF6dx9LerTZb4SQPQYi
         7Jng==
X-Forwarded-Encrypted: i=1; AJvYcCWC/O/1GWtMWbbSLP2SD7XtKaIEyUisQPcZn2H7qdXkNx0urbTPe1/YCEPKFfZZ9C9E2d/zzxgo59E7pw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+AX7JQgnCgwL/EdcRScaBqsX7pPO9ERiDELiPWjamMvXfGHb
	KIoSKJXwcGll5ucIfaiK1xjBO+mUClg6JqxRh+uLKCfsn7+c5/gjI9OHzegh7as=
X-Gm-Gg: ASbGnctMAVe4j8jPUEkg9dAnLLg+nmYxT2txGSZBckCVriPUOE0zMjtfGYMUs7EazVi
	HWxk+0zNMPa+xR3ZD60ZzanDiLMXOmpqTVnr7kUtJjLB11spp8fL+PNbQ6hUTeHCZ8ZojpyUVfu
	EBsskypCqZcU37mBGiPRgrYFtakztij2IL7peUMXSTyjwlW5SJPO53oWwf2Kn5+3KMM0Me8NQqP
	0uc7c+jnk8Xk5203qxztteyzKwotb0GVGJPmC9w3KjRXpeYD+IuPkjWNWOaMSca6V75PxgMfKdT
	ZFfx5qDTOYI=
X-Google-Smtp-Source: AGHT+IGUweqinG8rg/Sf2hD0L9NG7qTG0owwOTsCQGrrCdsjg/K0rXhjdPlmSjQhzJYk3zjmQ5mU2A==
X-Received: by 2002:a5d:64af:0:b0:38a:8e2e:9fcc with SMTP id ffacd0b85a97d-38a8e2ea11cmr28412330f8f.45.1737051787816;
        Thu, 16 Jan 2025 10:23:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Thu, 16 Jan 2025 20:22:48 +0200
Message-ID: <20250116182249.3828577-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The early_console_setup() function initializes sci_ports[0].port with an
object of type struct uart_port obtained from the struct earlycon_device
passed as an argument to early_console_setup().

Later, during serial port probing, the serial port used as earlycon
(e.g., port A) might be remapped to a different position in the sci_ports[]
array, and a different serial port (e.g., port B) might be assigned to slot
0. For example:

sci_ports[0] = port B
sci_ports[X] = port A

In this scenario, the new port mapped at index zero (port B) retains the
data associated with the earlycon configuration. Consequently, after the
Linux boot process, any access to the serial port now mapped to
sci_ports[0] (port B) will block the original earlycon port (port A).

To address this, introduce an early_console_exit() function to clean up
sci_ports[0] when earlycon is exited.

To prevent the cleanup of sci_ports[0] while the serial device is still
being used by earlycon, introduce the struct sci_port::probing flag and
account for it in early_console_exit().

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since RFT:
- converted "probing" member of struct sci_port to a local variable
  (named sci_uart_earlycon_dev_probing
- used sci_uart_earlycon instead of sci_port::earlycon from RFT
  version
- dropped the double "up" in the added comment
- changed the cleanup condition in early_console_exit() to
  if (!sci_uart_earlycon_dev_probing)
- set sci_uart_earlycon = false in early_console_exit()


 drivers/tty/serial/sh-sci.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b85a9d425f7e..e64d59888ecd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -166,6 +166,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3386,7 +3387,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3433,6 +3435,14 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * Skip cleanup the sci_port[0] in early_console_exit(), this
+		 * port is the same as the earlycon one.
+		 */
+		sci_uart_earlycon_dev_probing = true;
+	}
+
 	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
@@ -3491,7 +3501,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3574,6 +3584,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg;
 
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port = &sci_ports[0];
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	if (!sci_uart_earlycon_dev_probing) {
+		memset(sci_port, 0, sizeof(*sci_port));
+		sci_uart_earlycon = false;
+	}
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3591,6 +3617,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
-- 
2.43.0

