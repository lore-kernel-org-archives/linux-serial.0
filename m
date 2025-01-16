Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AD2361DA
	for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051794; cv=none; b=bhMNC2cj0SsBg+MprqDHnk4njNl+hPHsGZjygm46kuvW1u8bH2+9oCZ/N1fcM8+W7V8fDQGA1S1NrQlzAp6yCX3tWd20vRMTI1pbe/4aa4wWCQxXWHGcw9smvPebL3i+dTBa90nraHu8EBaOZQTev3C8mGX4ojNV/WHRmPLdkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051794; c=relaxed/simple;
	bh=+JZn/ww1FY/kTAFer89gJaTpDgTvbKcrRyepTGJVP18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVciyhshjFCFzhQlBCyS385w09eHkQ5Aw8c3NGrIokWugYLaDA/PsrRtxxDbtpJzTZXKQ+wAFMfP2Y2O4Nh+Xj3SdvSjYOhenqyTvkPBB5LBLMYsNzYVVwx+riCVJwci3msE8kNeZ+0deRyTExWiDiTKscYBV13qo3dX6oVxtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YeUU7cNt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YeUU7cNt"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385dece873cso770137f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Jan 2025 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051790; x=1737656590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmtKKaWRtLl2vifGgcWTXPqXE2lcLz7qOiG2GbtoKk4=;
        b=YeUU7cNtxyYGjobOoDN8dw1YAkZTfwMsyPu+JSlpT4eS5qcxDlxUymNWWDfZNwD+7U
         CmZR2k0Y6pColT9i8J5vUsNobVwqxCzUgd+8aARt6VeH6R7tPNfiHvX2Lr/vnxV6lVPk
         +nPrWIWQJApJqPMsLtymLbeTFbIjjfp6jllbGHshBwEK56cRVOyxtmHMZBty4ZgFWVK6
         XNhdWJgem5+EC4EbeFgx0Vos6SLMpBf0xcMMy2tsFatfb/5BKxyg0isCBbYSM3TzVglB
         f3kSNGav4gDWgEdBmBim4CtPvAzWLeGq/CvxdW7+MGOqGb6hY1AfqwIJ5UeqIwgeF3AQ
         yg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051790; x=1737656590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmtKKaWRtLl2vifGgcWTXPqXE2lcLz7qOiG2GbtoKk4=;
        b=NTatGxMIGhZyiP2JOsOUaVKI8ZfeW9VVYj5nsq/kf2onbaTv785BX40ph+fRucWplH
         WZf8F85EUQwd8Mx+aYBhkdH8jza9ju4sQa0mXaLMUjkGd6WLuto13xRxKUbAk9kzVsoW
         w3wNXTO7HMfAgBweNGnowyMdyyBS3nIkDGx6QQkZpSUJX5rzA+H88+qn59/kndO/ljCw
         b39mMLqa9yHMCmG5nvjUs2zn/lZts4T4IIOmTbx8LxQ5CvqSBkuu/UZ7ZIqJjk0X0FdN
         k8BYYFwNqCyzd+3/rBszEXNDJi9WjAMRnqXZUJ74Ych/tRjWBUJ71b0orguSVhW0A6tx
         SajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp4Q8uR5xLpWJsDlY4GkQpU5Sc2/9O2w+KOvFDfBxcBTjTtULYpiospWovFZA4JwSWpMROa6X4inFJ8PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+cZ/Ef4efheum02xOjW1qeATaMEjb4JfHVV+X1oPnuE+nqyb
	5OSHBjrITrPoiBpcBAmiwphQpyiWFx9sK43Lk/KhR+cjOtysDrw+DQn2eVtQgKc=
X-Gm-Gg: ASbGncvzr3Q1+WmCxCOG4c+3DbPtyASyWzLJK7Qs+pkVZSh7ruriLLKdjQxsAjs8Jo4
	1AoHJFFYNXmZDaZI6QPmu1N5NUL8arQLWs32xjI8z0+Ql0oM71SpRs2/U6tJKNMQ9XQBCrghMAR
	EvdWbAEMLouOtMJyeD7cZdZ+LlaCT0k3Oo+nGXLiwB9OOHdiWWv5YZozXuBdOAjzmIAynC7q1Z7
	p+Qh033gdeGHINu6zO9iXQQABQlDshUDuy+sHnwJuQ5dHXfUHqmym4FU4BC7HpKHulf74B/MfMu
	jQ354KBW9Rg=
X-Google-Smtp-Source: AGHT+IHTCLzWRVHhlR7lW8GYQyylUAfvSBIe2YvKqor2RF/6OYe8hunZYeSsvJPm4KC/0CLZzX9ROQ==
X-Received: by 2002:a05:6000:184d:b0:38b:ef22:d8ba with SMTP id ffacd0b85a97d-38bef22da4emr3656439f8f.44.1737051789820;
        Thu, 16 Jan 2025 10:23:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:08 -0800 (PST)
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
Subject: [PATCH 5/5] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Thu, 16 Jan 2025 20:22:49 +0200
Message-ID: <20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com>
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

Changes since RFT:
- used spaced instead of tabs in the call trace from patch description
- moved the comment in the code block started by
  if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start)
- still kept the sci_ports[0].port.mapbase == sci_res->start check
  as I haven't manage to find a better way

 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e64d59888ecd..b1ea48f38248 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3436,6 +3436,22 @@ static int sci_probe_single(struct platform_device *dev,
 	}
 
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
-- 
2.43.0

