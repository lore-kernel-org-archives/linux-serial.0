Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F63B6BE5
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521126; cv=none; b=oFWPokxrXuV5oJFdME5astqBmYfC2QvJGFl9Y5UvEwQ9XGtyXLr1iPYCvFokFwDMA0Z+Yke0f7At621hu0EGXShQCC2DB7iFARfUaSZvNFQV4Gd79A5R5TIdgknCxg9Cz6HE1m1Xudhl8qwHSc2Ya6rEFMaRVnhg9MiX1j3a+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521126; c=relaxed/simple;
	bh=PsKOHHQKdkTPVr5CbgWuTRjCZmIzAuWQ/T5zBgCOXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fT1vb8+Y+WdsFJ79UCErt68y1Hz4pXI1qrZhvG4M76tKQ9itzuNDYr7hXJDkqYN4B/pcA870WEyClLwLaVALeaqRbE3FPm4fWAIibVg3/M0rEtP7mo5Fb01G8hcZjFpB3cGZxc6VznyUgj8KOrJtN+s9RfAEMDQsHb8HVWsvXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRUYLd+X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRUYLd+X"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de008b020so932010f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521123; x=1786125923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6m+8w0QVgGm8urXe/cU07WfU5xAZ+QJVFPsiFH0egMo=;
        b=dRUYLd+XZDObOfJu7MYRna9XibQmadJYmxFq3QwgpDohKY40cTu72fcHSnYtooKM4F
         Cu5OBIrI6PcZvhnuHRZ9X4mTK67hgeLzdWDzor82yCM0g91xT4qYpiZqGxuRu0H0ONIC
         q5dcaSUmIzQ7N2piCxiK3SluYjRe18qUvQJICwNFyIQGnfu6nFT7pQlQb02WD8BIQnwJ
         up0e4aKM3TcYSRb5gcJlq6bpLSxGYEbbhKPXSepErqLyIKtBeIcPHowq19wX3sQ0q07Z
         2/H0F41wezJbcJRnMNYPq2ddHQwp6mQdHYXzERsrRxeGrE3/7NfyWHxmRv70S9e19BX2
         JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521123; x=1786125923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m+8w0QVgGm8urXe/cU07WfU5xAZ+QJVFPsiFH0egMo=;
        b=q+yTrKe5Zg7veZICbqqVNePW4f7JAWtRawySEnhnleVElB+DhtJIWYdJ0NQgC+ZDAA
         +IuWVIs7iwCNsyVtmIJBDSQ8HyTTXNO6l1qx81xo/U1XE9N9jN7QazbQzxok/z6+uxSP
         UdvHllaw1+to9HATW1f6QTLOM3IPuPO8ij8f29S2zNt/wjLwaRue93dX0T5XlPkhwBzW
         crBXpNM+QTwxs0o4PaB5c9yQZinrX5C2WSVddcEB2AN/IkNTaEeFApcLmbwpQXbMLwAm
         rFlKl05qTVtWvNEehBiKaQFFbIalrvBGkFE0SR2sE/YsqNEND8X9kQDdrJlrMV5qRqwK
         CiXg==
X-Forwarded-Encrypted: i=1; AHgh+RrgMrk+R8T82t1m/4z69axCDCqwGNq/ZLwWCW9/94c6fltuxUasVYE6XfgTuY4IC9pdboYARuWLTtUS0cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfXVvNX+WErTb/lZhUJAgPGtNS0Ui74xGS9x7kshlQk4qBq9B
	D19CtuQISmSOUHTktxTY/EwyhZjVzTJVgxBohOOVwA7B8FcXaQq/EAZV
X-Gm-Gg: AR+sD10RJTIlYwUybIpNyO/GrVRWDNJDfpe5kjBBgxTiF4UV3G+WZY938nUZVsRuWEQ
	fGQekyA+mVwAXUbijb3cOFeLDi0MWCVlVn/L8O63KlRcOIOtZhKgYQOucBubEKslMq99vPofY8p
	pIRvqByc00NbIgRlAPSDWbgOnjeA3u/2S0quaOX1Y6OioDEkDSY2myKBZSCZ4yV4Qty2M5WlbLJ
	05xpfgSD2TN7sPFvf2vroYOeEyAmIry+0+q/c2oSinHlALU4CgpLo3xLpX8y1oA30YkJEqcvZAM
	6yOPeGKOmW06cCPQrMqXHDbNYlLUgJ4fMlBZTLCSUoqTX7dCNyM+MK5TY/9DubXeAML56hzVXdI
	M2bm2f1T4wTLBgH25X9JSr/4B2jL0I/PjlKKoRvoFvfTsL6ULD7Hm3zdnRql7ewEFJufgomVQpy
	elpVaS+PmrmoUPXWwUjd4miIDLE1cV7sfqC8+EY7GIRXQKYxgSZEejc0soo9R+8+qVzTYnXYDDn
	/8CrF91hsxSSCiyXDeKa90WGP80itlC5f5klkV2zMdh1Nz7Nesb/i7GUeCO2PpAfOv3ixI8urwg
	5xuvBOdri/9HZjDChqIX1MvI8bKv3L7G0EcAfC8tKCvgRSb0N9mfkumnTRiZOyfekxV7
X-Received: by 2002:a05:6000:310f:b0:47f:775b:f5dc with SMTP id ffacd0b85a97d-47fd32e1c76mr5907524f8f.19.1785521123140;
        Fri, 31 Jul 2026 11:05:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6besm7094559f8f.22.2026.07.31.11.05.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:05:22 -0700 (PDT)
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
Subject: [PATCH v3 5/5] serial: imx: serialize imx_uart_ports[] lifetime
Date: Fri, 31 Jul 2026 20:05:19 +0200
Message-Id: <20260731180519.10988-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_uart_probe() publishes its devm-allocated port in imx_uart_ports[]
before uart_add_one_port() because console setup uses the table. The entry
is not cleared when adding the port fails or after removal, leaving a
dangling pointer.

A sibling probe can register the shared console through that stale entry.
This was reproduced under KASAN on QEMU mcimx6ul-evk by unbinding a
sibling UART, unbinding the console UART and rebinding the sibling.

Keep the entry valid through uart_remove_one_port(), then clear it. Protect
port addition and removal together with their table updates so sibling
operations cannot interleave. Reject an occupied slot rather than
clobbering an active port during a duplicate-line probe.

Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
Link: https://lore.kernel.org/all/20260719222501.CB4CB1F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Backport note: the removal fix is self-contained. Complete probe-failure
coverage also requires patch 1. With patch 1, all fallible allocations
precede console registration, so rollback can safely clear the table.
Without it, a late allocation failure (only reachable with fault
injection) can leave the console registered after imx_uart_ports[] is
cleared, turning the pre-existing use-after-free into a NULL
dereference.

 drivers/tty/serial/imx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 251a50c8aa38..b0f34a6e7d4f 100644
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
@@ -2080,6 +2081,9 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
+/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
+static DEFINE_MUTEX(imx_uart_ports_lock);
+
 #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
@@ -2632,11 +2636,19 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx_uart_ports[sport->port.line] = sport;
-
 	platform_set_drvdata(pdev, sport);
 
-	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
+	scoped_guard(mutex, &imx_uart_ports_lock) {
+		if (imx_uart_ports[sport->port.line]) {
+			ret = -EBUSY;
+		} else {
+			imx_uart_ports[sport->port.line] = sport;
+			ret = uart_add_one_port(&imx_uart_uart_driver,
+						&sport->port);
+			if (ret)
+				imx_uart_ports[sport->port.line] = NULL;
+		}
+	}
 
 err_clk:
 	clk_disable_unprepare(sport->clk_ipg);
@@ -2648,7 +2660,9 @@ static void imx_uart_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
 
+	guard(mutex)(&imx_uart_ports_lock);
 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
+	imx_uart_ports[sport->port.line] = NULL;
 }
 
 static void imx_uart_restore_context(struct imx_port *sport)
-- 
2.53.0
