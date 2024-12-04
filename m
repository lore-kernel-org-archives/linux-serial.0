Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98521764C
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327908; cv=none; b=lirgENK/ZG2EXnr4jvaiaSaYEL3CtUIzWY3GAWrCnAfUU8cZmsevdBgo78w43xoDYZ7G5M14o+C2Qf1lMX2EDH9yLaf8khjhXcVLJ9REoZaNF2wmF7C5syL951DX1Tumdv0cBjBlygZTyYzNDRMsojBR5DkSoI1h+JQi3OXMOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327908; c=relaxed/simple;
	bh=fnmIuQ3AC6S2Pd91eCPrbiQeWsPvWcflJGps7V3hZSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEIphE4Bp85S13aPvy9tz2pmSWVBOFYgPBhZB/z3fEL3mZQYjYz4ciX0YCXVUtv51FV61kVTqtsHkWTLgbidGG4cNDj8m9VJcSdHjZl7J/VVpa07Rehn32/oSZikofTChxAGyTqe2hEKGKr55E6n5XHcWMBlCjaLYP343f0AEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PUWJhPhh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PUWJhPhh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434ab114753so59034645e9.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2024 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327904; x=1733932704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIgexULd80z2MjCqhWRkmxhXY4y89/FFLZbXUxSS9MA=;
        b=PUWJhPhhST9iGelcZq0AP77BmiT5SOZDHhxomGLaPic/OLfvRo7VXUhagBoc8a2QWF
         XprvNiAYIrw1Zrj5uot8RTazjOpdjooSYC3On9Yl8deLKNe9XAub86opHhhiQkghuqgL
         0IjG66vWcopFmIPVdKkkW88TQDpSM4yavW6ruQiSzme1LkeTHvJJ1S1rVd8dBinZ+lhQ
         aK1QY+3HduznV8cTtJOaWY2dRICsllcaedwSbleTYPWLZwRv5uKQV9YnFcJRqs2GqzF4
         2mS5nzHtpYJnLwqqq6eDcEr9rREaybS6nBRZj9kSZDylXDBh7vDOBgYycbBkRP/3Nf8L
         NKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327904; x=1733932704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIgexULd80z2MjCqhWRkmxhXY4y89/FFLZbXUxSS9MA=;
        b=WajD4aaynw4sF8bBNm0xi+esgtuF69yhGgZDhEb7+4KOaHa3NEuSjdK+y3nHXUvlpd
         heeUS7SNeWpmEwUKp5YPk4YaH4Vhc3g9K30JgbZvTOOzSdIIH5EfTdAhxSj0UfcmYKqu
         NMHP9nkLecfDZeAXKZqhUqZpTwzk7Ir7tAe2eb+whNR5AMcwHeYl6p8feKGgvIF9JHoE
         91TFUPqsPv1Ysoa/4imBqi/zNdCaA6OTiITcxShVlstiOHsyhY5VO597b33wghiLWmpJ
         YGu5clAA5Bhw2J8x5/PkUZPCEnT70PwwgNAfV1nZq8NyMPTsZVyAOVcsuHJ//85pgrTc
         MMpA==
X-Forwarded-Encrypted: i=1; AJvYcCXyorK3mMjAUd/j50DY4niMQEtrEovpGMXA2sjGiC2kj81K3INmzHGNAsa2srK9sCQzX7xajFMU4TUAFyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefiyyaSewr5c1z9tVs1NxruA3qcVrS+XxUG4/cHyOrwJT/lPm
	VFM/yHSV5EdVvNVL6t7CoNjZ/+RPK61IwaKx4p3ja6MqDfPy31vy8wcOaR1fiPQ=
X-Gm-Gg: ASbGnctSNmL8LXoV3nQlyMzX65m9cjuPdZOHB63UC3esAHFgIkVtCpgVYFqsaq8Z3jL
	JPeMVaoPPwvSVkZopuxZxHJGr057iAOhaNfqilH9MYCTTR4kbh8qVSbJAVZkL2I6MMxus6Rqy/u
	5l5c9tQcL0CFlfDV8/RSRgwvgDJZY27Jmdtw3XIC5ENyEAzzgD1Pi7/aw4E098IjXJoN6WvisWN
	C+aBK8S4l+MGlUT8xZ85vRY2xohQeHW3+acrviMwCUXeniFndkPx92Dwui0lVnjZXuOzjz2pXNQ
	SfIS
X-Google-Smtp-Source: AGHT+IFbwxrksVk/MTeFkTAjIssqvXFYbv9NCxbCkjPtRUqUluTZ9LIe0N58I+leYtxliC1iMWLK8g==
X-Received: by 2002:a05:600c:46cd:b0:434:882c:f746 with SMTP id 5b1f17b1804b1-434d09c8e42mr68216715e9.17.1733327904095;
        Wed, 04 Dec 2024 07:58:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 6/6] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed,  4 Dec 2024 17:58:06 +0200
Message-Id: <20241204155806.3781200-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
with earlycon mapped at index zero.

The uart_add_one_port() function eventually calls __device_attach(),
which, in turn, calls pm_request_idle(). The identified code path is as
follows:

uart_add_one_port() ->
  serial_ctrl_register_port() ->
    serial_core_register_port() ->
      serial_core_port_device_add() ->
        serial_base_port_add() ->
	  device_add() ->
	    bus_probe_device() ->
	      device_initial_probe() ->
	        __device_attach() ->
		  // ...
		  if (dev->p->dead) {
		    // ...
		  } else if (dev->driver) {
		    // ...
		  } else {
		    // ...
		    pm_request_idle(dev);
		    // ...
		  }

The earlycon device clocks are enabled by the bootloader. However, the
pm_request_idle() call in __device_attach() disables the SCI port clocks
while earlycon is still active.

The earlycon write function, serial_console_write(), calls
sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
remain unset indefinitely, causing the while loop in sci_poll_put_char()
to never exit. On single-core SoCs, this can result in the system being
blocked during boot when this issue occurs.

To resolve this, increment the runtime PM usage counter for the earlycon
SCI device before registering the UART port.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f74eb68774ca..6acdc8588d2d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3435,7 +3435,24 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	/*
+	 * In case:
+	 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+	 * - it now maps to an alias other than zero and
+	 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+	 *   available in bootargs)
+	 *
+	 * we need to avoid disabling clocks and PM domains through the runtime
+	 * PM APIs called in __device_attach(). For this, increment the runtime
+	 * PM reference counter (the clocks and PM domains were already enabled
+	 * by the bootloader). Otherwise the earlycon may access the HW when it
+	 * has no clocks enabled leading to failures (infinite loop in
+	 * sci_poll_put_char()).
+	 */
+
 	if (sci_ports[0].earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup up the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
-- 
2.39.2

