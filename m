Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4841D659
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521051; cv=none; b=kGCMKya1qzgevciEQKKVIAyduTZfvSXak04FHZ2LmRmqUwjzhY4i6CFxwHsDgLqp9gzvWutY711E0ivQg6BW4zfogHO7/xfiJXV7xN5ORzycrSkL/3hS2tNY3xFuErXz15wKQJ3ufsmK8Ls5apl6zMJQJWXjrybr6lJAYH28eMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521051; c=relaxed/simple;
	bh=YOKf9/usp4erLkDN0Msqj3Z2/dbnL0uqaOiOLKQ/ALI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WlGcsUi6oWIMGQt5o37nUygCDXz1QCNPKnmVI81HG//d4dY2yriKoiec/0K9fSn6YXT+BphPIT/yNkqcY1Bjv+z2Kv7hZGZnSHyCM7gxf5NTCpjw+i6kS2XtE3rGkNKvO2JOubFB0cW0hzotF8BZEcI68FWX4xtfftO0jxI3hyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkFUF0Ey; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkFUF0Ey"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso604523f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521042; x=1786125842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pw2+6W330KNNbLzF0QvSgAqSLp8AT2ZZJuEbFAlLaQ4=;
        b=EkFUF0EyC2l1zDP5ggI98o0ggD9dLJhhJzV0x8LYQlfLEZjTaBCxNuetQ+iuG20Mm2
         4Fib/OhhvzL86rqjdxViW6G9Wlhaor3qlxtePL42gMlqnUnOjIRxEogrLAuI6OHKp/gm
         nJnmgdQtkPJE2N3qabjpwnJdHFhAuqzza1L23uByeHbMhhv5Q4Lhu8mYz4Zpq4xov3Dn
         uYdPlmZicXB9XA5x67WisRYjXDf/gqQ1Lj/KNXI5mtrQ1fptSx7yf7H9z2m9Bqy0tLFv
         JnmDyoJbCrptBgV5gAK1ypuzJAtlKIcaWv074sStLV51pq9a/SFH1xt8oSNPyZaYLl8A
         0Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521042; x=1786125842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pw2+6W330KNNbLzF0QvSgAqSLp8AT2ZZJuEbFAlLaQ4=;
        b=oIpDkos2noQtjj2FqFOHc0Ct1D2fv3vQY1yqkfg52/y1esqiMqSmpIh+Pw+BQ9n/3m
         0qca/4KBrI1Z/nwuRTkH0l/GSbRdLZ8LSLZFkt8G7d9EgxTQDtLdq41FFxX0C/Qv9U3z
         ZyR0PHKVEXlwzuWp21iczOno1IrfVfjbTGpi1SmDmL8+UpnG0ha4ZhjPKX/cgo9w/UQi
         lNPBFqtUZ1nt+jZY9XVcarxE4LwVe8jKezZvwNSylVRgJqN85JxZ9juDngN0vhe9RKZM
         gGQOcomMLH/1PEYbFF86Z0kNQEpGPAde6AXf0mmOyK5GO51h/NWWj2F23XMmai+aZhG7
         tK5g==
X-Forwarded-Encrypted: i=1; AHgh+RruaMIutzHrhlhRINy+j8vX9vxjz9Z3rP81mUn13ziBTAmvAM4FtGeHMUlMnDp+9T0vZQzqnYnJ0JpRxIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9O2QMWlsa2eXgdITRAo2NA3/uA1duuCtJ5EbUo8Bw741T+Yiy
	8KJotHffsptzCeAxKeC6cqxii06B8eUQ9Y5oKjAIWqelOtqqnV29EjzP
X-Gm-Gg: AR+sD11vWL6wGO05HCqVD+GrAOSe2GKxUw28K3jgt+gS4PQa73pG9+GL8YfilPdSK21
	kt4xeRR8H3uLFbaO7bFEEHQZ9XViicg72NvpUzuu1H05uMWUW7HvWF7RM2M+znc2UtGQnX2RRTc
	32ataNe21Td1cDyDF6qjMdghDSDf5jn610wOAUu3iW+PrbljPqICQ4c6eEHLBuEghc7AoarSlAg
	DvErlE+caGgeJIUuNIaapiFEFde4lnWz6fVan5oAwyRGWxKPg+MJSfOGmlU2S1jFNDpsyuRf2sC
	4tV6H6AE4C3pt/Rex7/quUmovvuGTN3NRGsEBgSm5KMWEkXsrX5nH5+hqISQjxQbPjEPfD7gcl3
	UnvueQRbpyljBYxqWu1xqT3wPw/G96Hz1c8pFDxhA8P+2H1Qru/nYnPbUX0yV48lr19o5ag98Pr
	Xk8k8l6rBafUHiztItNP1rOGls6LEdyOlBT6elsn71vP5k6Fc+vQnNcvNczDT1LRooj0AWDtFj1
	xJRjfwCTTKTiH/5UOodw12pTq2Nk8Q2OEU9AQYsI+Z+xwHqgGQsroQZDiDM4JXpbdaIkNhv4AaK
	qgKfUkFGmubzsqDI6LwZEwsqYeEjH4ChAatf72s3rqknm60xR6usrANxJwtisQM2pZyE
X-Received: by 2002:a05:6000:1366:b0:47f:77a4:fd0 with SMTP id ffacd0b85a97d-47fd72a8e32mr1022136f8f.22.1785521041538;
        Fri, 31 Jul 2026 11:04:01 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a1240sm7164084f8f.36.2026.07.31.11.04.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:04:01 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/5] serial: core: do fallible allocations before the console can be registered
Date: Fri, 31 Jul 2026 20:03:57 +0200
Message-Id: <20260731180357.10843-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_add_one_port() allocates uport->tty_groups after
uart_configure_port(), which may register the console. If the allocation
fails, the driver unwinds the port while its console remains registered.
The earlier uport->name allocation has a related failure path that leaves
state->uart_port linked to a port being freed.

Failslab reproduced a NULL dereference in PL011 console output and a KASAN
use-after-free in i.MX console output after failed binds.

Allocate the name and tty_groups before linking the port and configuring
it. Reserve space for the optional driver attribute group because
config_port() may populate uport->attr_group during configuration.

Fixes: 266dcff03eed ("Serial: allow port drivers to have a default attribute group")
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260719070454.D6FA21F000E9@smtp.kernel.org/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b43..03ee3d038f4e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3056,7 +3056,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	struct uart_state *state;
 	struct tty_port *port;
 	struct device *tty_dev;
-	int num_groups;
 
 	if (uport->line >= drv->nr)
 		return -EINVAL;
@@ -3068,6 +3067,22 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (state->uart_port)
 		return -EINVAL;
 
+	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
+				drv->tty_driver->name_base + uport->line);
+	if (!uport->name)
+		return -ENOMEM;
+
+	/*
+	 * uart_configure_port() may set uport->attr_group and register the
+	 * console. Allocate room for both groups and a NULL terminator first.
+	 */
+	uport->tty_groups = kzalloc_objs(*uport->tty_groups, 3);
+	if (!uport->tty_groups) {
+		kfree(uport->name);
+		return -ENOMEM;
+	}
+	uport->tty_groups[0] = &tty_dev_attr_group;
+
 	/* Link the port to the driver state table and vice versa */
 	atomic_set(&state->refcount, 1);
 	init_waitqueue_head(&state->remove_wait);
@@ -3084,10 +3099,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
-	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
-				drv->tty_driver->name_base + uport->line);
-	if (!uport->name)
-		return -ENOMEM;
 
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
@@ -3102,15 +3113,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 
 	port->console = uart_console(uport);
 
-	num_groups = 2;
-	if (uport->attr_group)
-		num_groups++;
-
-	uport->tty_groups = kzalloc_objs(*uport->tty_groups, num_groups);
-	if (!uport->tty_groups)
-		return -ENOMEM;
-
-	uport->tty_groups[0] = &tty_dev_attr_group;
 	if (uport->attr_group)
 		uport->tty_groups[1] = uport->attr_group;
 
-- 
2.53.0
