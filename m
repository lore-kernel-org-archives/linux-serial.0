Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA843470111
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521944; cv=none; b=nZpmFmfbUec9jquMY121eUtO7H6DYlT8p2tG3ZxmeO0lci6ZBbEb0TN1GKubXS7zEPzau95oNcQAXDk4ACPBnormzbhNVW+Df03NkvGcfAwcuGMbavrFQvfuXa8TOz+sFBiB6DwbxcCFZFxc4ZMS15ZV6q0v5Wxms1QjvCOC93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521944; c=relaxed/simple;
	bh=PsKOHHQKdkTPVr5CbgWuTRjCZmIzAuWQ/T5zBgCOXzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/ug9KrXxHa2mm+R/cfTs0yrJ6eMemweZo/TyykOuL83/Gs54Dc08JtZzm4ZUV6UD6wua/RcqMoWmoUl5kyz4iy0QyqvViFL9l94/021/abwlVMrhLQWt3hkvtEbrJVbAJdzKXt4Jf80Zw9TDLa3vcbMBKvs1dMgLkvkqyeqmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjNFbOKB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjNFbOKB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f707e5d75so1039148f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521941; x=1786126741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6m+8w0QVgGm8urXe/cU07WfU5xAZ+QJVFPsiFH0egMo=;
        b=QjNFbOKBFjWfKYTaI5xKWP8TVY7QydKiZm6dY3qwD/asFuc7X6tEYHcbzVLQP8ClPT
         27fp6EddQEpPijFAxxYcctiO8pCoNgmSIqX7MnN1uVXgxk2e9xagwoKnZ58C09JLRdey
         BYdGnVe2IHlp+2L6kZUFEjVBBxnrrO8k1/RRt4oawQnn2jDRpU4jCTK1EuDAhLxVpwFf
         Qfnwe1cCNWqVk7/ICkigTI51tDKvnwkl+xLP6EaSdJVK1cu32JCF5lvIy6TUeJPkqYfb
         dAZoUS4bCpdEgGq9yEZn/CVUOt/VGm5agPB05NdsUaJ8qMTY4b/KJ1T/AgcBw9OcUWeb
         jQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521941; x=1786126741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6m+8w0QVgGm8urXe/cU07WfU5xAZ+QJVFPsiFH0egMo=;
        b=lEr0nr2kYyamP2/ebuOikpLTTFzCTq2y4TdRFuFxJTp4DHds+mZfXLT4JTH8Jh068S
         DcSY9ULrAmuCNny4bVJ5PhOl98eZxFoy+NCP8VAP8WtDd4anKiZRLhOt/vStiwzLtwG/
         RFbNGelhjZcvSI9mDZd8hvbWEV1WEqdOl38kWlbLJFZxKrm+UChKEMFmgC0gqOSHFxal
         Qwi2mSQH5WFnj2Qkk6TockOfE8ZHgyY5cgY1sCmqzAyMoyQLfQ3PyoD87/iXFidYY5RS
         UDaBalqOsKDt0J5MuV8d0KSNAVK37DmlQbDxZ3i5yPLbohrAJOcn2CCSrVM3XMWlfCLm
         rpXA==
X-Forwarded-Encrypted: i=1; AHgh+RoLgaWj+xCYvAmXqGA4UMZOe+MoP2IUGF9hxlJMI9Gu4gL+L974ZBRviU2Hn/eIRCAurcfHttwKICeCP3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YvD50hnkXQyA2b85dni/3K0J9PDQkwELVrIZU+q8jj+6CRpH
	QisdDKh9ah3xLD0Dgs+X9/4m+D5SlS9ZJkUzrygS1iIF4eu+0Pvx9MKp
X-Gm-Gg: AR+sD10CvQr8FRdoOQ3ImT50jw2oRCU7S2ay/OVFuiW5vDvw25zXC/eoDXMEuo0iqTB
	BXEA+IzRgrMaHBVQfide0NKy4QkQXm81Yxj5+GE+RE9D4BU7DPSDDReSr1e8TPTgPasAWuR3dgV
	LIeO0flvEUPzD8UzsRzvIXA2As96F1sok4yYH9hsk+m8XDVnow153QES7fuekxADZ52Z/n+30G5
	4eSBJm9qGZsbxVcctrd1IopVMC0l//GFh4M0HGi9SVnOtfzJM3Un/DdCvlKKq4xCHBHQkkFQ9gv
	9aHmMJ8Wt1iK9FUHn2YqrtqYfYlLplvGUcYRzQMAHQlhespUKVBctaKa8kTlecF/lwckUcDFyKF
	NVK50Njrl+Clk4LGlKfSM2qqBA5/vQyp4aR72g5WpdZGDL9Uo9TVdSo8uqshVR77mdHnp44p67e
	aazfRHJIZWZ1gmNxYM71HfSFTpLFG9vsIxkkNPVmQhWOwU2INm+Uatu7j7Ak4YBMA8Uc5jv+JB3
	2iR41p0CPzMQMj0sPPfBvcaXF+2j1IBTrObbbv4BcqlWoUC60Dnr8miSLGNphMd1vQr4yPleYup
	tVZvzn4qXBzQlNyVlw7epNMhwneOoxzxpVa6cWcTUt81jfpnZkKVB+JauEuC75Mh1xNm//CpCcn
	KWj8=
X-Received: by 2002:a5d:5002:0:b0:473:823:1924 with SMTP id ffacd0b85a97d-47fd7314b2cmr986964f8f.39.1785521940802;
        Fri, 31 Jul 2026 11:19:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm7293694f8f.4.2026.07.31.11.18.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:19:00 -0700 (PDT)
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
Subject: [PATCH v4 5/5] serial: imx: serialize imx_uart_ports[] lifetime
Date: Fri, 31 Jul 2026 20:18:44 +0200
Message-Id: <20260731181844.11330-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260731181844.11330-1-kmehltretter@gmail.com>
References: <20260731181844.11330-1-kmehltretter@gmail.com>
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
