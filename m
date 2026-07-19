Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A6313E03
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499054; cv=none; b=ZtgdpWz4b65BD6qg5HEOXcY498wQdFOBMcz7hvg4QnWR19JvzuYU2DEGXQv1N5QBSdrvWm5h0U7DcwE1p4jwBs/jFBl/tWC1GTsxY/Lv3qSy/YIb/61tLyIgCUM6yfbaRFtqNki0cjotRvFbBYkNC9xBwUf/7SnnsdilaqBzTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499054; c=relaxed/simple;
	bh=e/TsC2jyQghy+fHjzGFRoV6KHp39YYSJL7Ig0TqCdS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfhI+ALLrJcWPI/BCME7mVsZ9HDe2QmU5ibX7ChKb/+xMfKs5lZzLXmGBv1wwhBf9WoVYgp3sx0xz8mrRBUgX0qD3pbchTCG4N6VvH+DYyYrLKDY8rljGPmyM+VljfOvpnWpGxN6JW/qFjraCOc4Js8JJY+PoeOgGz4lh3Mt5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFVxb1dW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFVxb1dW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so9526965e9.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499051; x=1785103851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PWe1Y8pYuAa7B+GagSYE8D0P3UeZCJcEkhdzL5G7fY=;
        b=CFVxb1dWBYUtUYBD2MKGawFay9IOV2JUYjaW/oPtAcQCtENU2uAL/R21mLOWsV8xRf
         BAmHnND+Ml5I2QI6ZmNPV1q7Y7EztOjetIieH72FZazQv4gFd6IpZT/2Lv2mNzUhzQtb
         pkswJGtK0HbYud9SIRyzfp3qjISSkFDInqlG0KSunTzOcQIpgHpTQYammdZlfZJbRtxj
         wH4a4idmuHt5h2gTvDrq8Xlg7qQhx0buq3NxdQbFrbZzPiuDxoaVIabXLBrdGtAYLrtK
         fywCUGVwuSl12/smI8SFwC6qObd3JxWfQnMbNr7fKAt1yhk/aPtXC5JdkmI7JdR8qeCa
         JThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499051; x=1785103851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3PWe1Y8pYuAa7B+GagSYE8D0P3UeZCJcEkhdzL5G7fY=;
        b=rXeyMeuTy+yyXIz605OVT5rj9PfvcuvOiNF72JRH1Gdzt2B4Iy8id0ShrwOUdZg3Xb
         N7X7ZGhefnPy/M6LBzi0jysJJeIYtrAa9KSVnUtmxwq4uHX/ryO/lAOt2IJ2KA+IxOQk
         W3y3rqCYo6xsXbIsK5/jTSwAX8zls/3KkA+/y9chiy55Anl+amlTEUC/U0C9FlPklfaj
         wSrUjmvknKHnK3oZ1jWZota1PiYLLRDtayn/nYbeVjqEJNIXG0yTiA1pV3CAlSE0VNve
         pcmkRVIWdpEol9nzhifGp4joysofj0c2Ey3nynCjx2Ci9Hpy/aIYnf0KadY5w7hFbXAn
         9FcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7YTPLCYrqrZY3EDP5sOzBpV9Db93D118DE6e+ybA+oONhuSj7A2ad8Gc1NfFKTteGBktFN4l8TR/FKfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Yr9tHla3dTPWR1+XQg2uJR5+204FwtY9hX9fclSb/xnISOL9
	fUDyxpn6GhVQI1UG6wBo/zD1pBfRtk10MdvX+OWWpuTIEhoc5AB4UidT
X-Gm-Gg: AfdE7cm4WLgQdrauG4CPTQ+L8lPtNnZONzmETAX9LCSQrz6v3k6Yi2tnE9b6zg1WqF2
	bzYBeNGMEY0dv20r+H0ptaXrw6h94KRD9OFt/E98zA2EI+3Wagm9FghouEayPxfmWKiT5x0ilXV
	kuKM8+HQHJ1PwGVF/esxk6i1BlSZjgfbK+3TVWbWJWv7RMo4V7Zoqt3GHbz5uvjyk+RLE5w27gL
	ZzV0HvU3o7cZ4SB9/4GnVoLx2BMt1uJnDUqNA7WcIHzPEhaZBFFsACmEOo/gPJsZ274haDsn7ea
	V4o8OWj3en95W0Vx9gStIhlm2slzrW/f/mH3+etsUPCUTYhnioIKwYtd2aH07yiJ+sD9t+JtIYt
	mLdSnxDzMgu5zzDVW4yUUlP6ynmKdUwKVLBs+ciNcm/Afswz6jKattYpTXE63cmQj+416J8rtwO
	bHK8tJTxAFVlo11ast5tccnBJdXQBWfgV74LA/Xjt/JqYGUeMUp6vo2/DAjr7cHtf7CTzXHhfGE
	pNnURaceasDcw8p4q9o1F8TzmW+19yETlTfefJ6QCceGCsdixgfsBm/4i/eciJFwOJoOut5nUKa
	/iiN2U2jiL77dVb5MBblNjaLVr6JMRqMHtI=
X-Received: by 2002:a05:600c:1f93:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-4954a3d64d4mr124694595e9.6.1784499050684;
        Sun, 19 Jul 2026 15:10:50 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Date: Mon, 20 Jul 2026 00:10:14 +0200
Message-Id: <20260719221014.44354-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_uart_probe() publishes the port in imx_uart_ports[] before
uart_add_one_port(), because console setup during that call uses the
table. The entry is not cleared if adding the port fails or after
imx_uart_remove() removes it.

The port is devm-allocated, so a failed probe or unbind leaves the table
pointing at freed memory. A later registration of the shared console can
then dereference the stale entry. Reproduced on QEMU's mcimx6ul-evk by
unbinding a sibling UART, unbinding the console UART and rebinding the
sibling:

  BUG: KASAN: slab-use-after-free in imx_uart_console_setup+0xd0/0x3d8

The entry must remain valid until uart_remove_one_port() unregisters the
console. Clearing it afterward without serialization still races a
sibling probe: the sibling can register the shared console using the
dying entry before it is cleared. The next console write then
dereferences NULL.

Use a driver-wide mutex to serialize table publication, port addition
and rollback with port removal and table clearing. Console callbacks
remain lockless because uart_add_one_port() may invoke setup while
probe holds the mutex.

The probe-failure path also relies on "serial: core: do fallible
allocations before the console can be registered", which moves the
uport->name and uport->tty_groups allocations before console
registration. Both changes should be backported together.

Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/imx.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..def874f9cd00 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
@@ -2080,6 +2081,15 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/*
+ * Store the port in imx_uart_ports[] before uart_add_one_port() and clear
+ * it only after uart_remove_one_port() returns. Console callbacks in both
+ * calls use the table, so this mutex serializes these sequences between
+ * sibling ports. Callbacks must not take it because uart_add_one_port()
+ * may invoke setup while it is held.
+ */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
@@ -2632,11 +2642,14 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx_uart_ports[sport->port.line] = sport;
-
 	platform_set_drvdata(pdev, sport);
 
+	mutex_lock(&imx_uart_ports_lock);
+	imx_uart_ports[sport->port.line] = sport;
 	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	if (ret)
+		imx_uart_ports[sport->port.line] = NULL;
+	mutex_unlock(&imx_uart_ports_lock);
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2647,8 +2660,12 @@ static int imx_uart_probe(struct platform_device *pdev)
 static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	unsigned int line = sport->port.line;
 
+	mutex_lock(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[line] = NULL;
+	mutex_unlock(&imx_uart_ports_lock);
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0
