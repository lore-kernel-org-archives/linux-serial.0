Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EC369D57
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521935; cv=none; b=GR6Dkxjk4kekVwAAIbGHaB9BfOxvzxs+e+4IHna4IRhPkCnPmCmplgoP8vkywNZFfQQZa/yv+fy6Np3eH4WlTve0eH5mx2RTFu3gfHsTA2UFeddhYRBCkHPmMXjsVdt8avK+mPNOQIehKlcR7ShNeByGnEa9//Usu3oxvnVcLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521935; c=relaxed/simple;
	bh=YOKf9/usp4erLkDN0Msqj3Z2/dbnL0uqaOiOLKQ/ALI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cm4EolOW3YQlodyK2nhGdmI19k76vXsk0oWPLLc+58XQzHNBrtYyS9IZZItXZ8Cmbe5q4r3qlqGHceg8y3zGEtoGzaUqYRbQCxBKzjAc/A9fvSPYHLavRafH4kMkhytMfniZtpMyNI3piJQ5t4FdAtjA4MdiX+CUCWoguCshdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtVz4dVH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtVz4dVH"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1524363f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521932; x=1786126732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pw2+6W330KNNbLzF0QvSgAqSLp8AT2ZZJuEbFAlLaQ4=;
        b=EtVz4dVHTHuDqKyYvFn3DFpFmPXz6urhsZYrCnT8xDDbpvcTIZGhc+4yqY1A53eYOW
         +yDX4XPvI/SB28K+bdjfu98362vCGuzxbK6lcAhRt9QIfrlYk3UqRGJiqbGk1N6ijBXK
         APcRgca7fBiD7TubX2vHL6ABy6mFfc8RYl/2G7wQevJGiPnZqKbJJWuA1YwYKAMz764r
         yrFo6rWzaXvWj6fdZmm9YKiKm+Cz7yLz/oFLElwM0PTsmhKeE2Z7CVYAtkSlc1C/BCFE
         wMSTgNPpUPKdQT/IYY3f63+ao/0EW/8YqOlQBVG6u9RYAD+/rSgwTvsDqF+TwHQw4Guu
         tt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521932; x=1786126732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pw2+6W330KNNbLzF0QvSgAqSLp8AT2ZZJuEbFAlLaQ4=;
        b=aW9pY2D8PzGJw+Zsf+ZipvOBucTHthISommcCvAXaAUe+axU4mRrMittwQYzyFTbVJ
         bDQQ9YOXwvrYfGc/kaO9Aci7X7e+bNoQCmaHGIhTmkVYXtwgX0SqftoldPU9dKvIBzjO
         3a3AbEfaACF6ihd+9m29CPvVavARSUU1e20Dm0tTLcGxeSM9c1lWvtjSumHdJ0rp9NZq
         YntRO/Lyw+SRHwqdqKz0Rb9ftQispfOLqAJKtHZ0ueouuRvMMyqKBY40J1lpBB2mlggg
         +8jNUYo8QJIIxmbqbaCxByI43A3xd468j2vFB7FAsqO1lzmeb2l7K1AOSy43A3Be/zLU
         Z8BA==
X-Forwarded-Encrypted: i=1; AHgh+RptdLahOOaLuJWuvKW3xuo2yoVO/huA4NPu/2gZdolr3Z7g4kPWKK9mLwnXwdVWTKimxinXVqgSVBk5vK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYggmRIIMMmh3kif2QPgXoFQMvBgPQ2pWQhefL5hcA5iue2jIi
	SbGQhVc18Wpc0xKue+F1jhyAC7VLcrceBtPfirOHD0jVlaX/kdXuPuuy
X-Gm-Gg: AR+sD11XdCtmgG80kZlvRI1OAEpxIfvTUXHBQH1M/BdTqnwWXHJIsWa1Vp6hGjS1Ku1
	rdcmwSGR4H7uSQ+HJcDAk7K3GjP2Y+q2X2wBqDC0U9SWqoipXLPoRxcrRVSdDobYkUqxJOVJMZD
	7XPMlgqvhwi9nS691kCy/I+fmi7rV6ya6Shdgq1cENZbsPD3conN5KTpsofTmbRNyDzuTjoxwjZ
	NV9WeqZzU/dv7ihypzGnYWvgQfcZUTkLq8eWyDy3Cwtj1zsLPBLrxxnJsl0+YYjcdabmgh+nLlX
	pW79nTgsk1ER3gziUmN9Jrc3lEKiHWQnTYO7X7JaLj4K0VPdjy6ukrCUVzdN/XoIF+9yxkFDjQG
	QrJ2Vv2LkvAi+M4Dklc4N7VIdLyRgp9VQsjNULzpGkIhxqG7zs/VThww+/A3F2sBoD3npY8CoB8
	LF6B7YeVdu0mNGylqfU0BWbDQrdWQ5HJJ45JRwj8EscZTn6tNkZFJxyutZsF+IWDpWdnBl9odc4
	4SZml6r9b3dbmPX390XB5L2zHJ4vp2D1enptR95jDJiXyfx6jw6X1OtIg/g1PEoxJ5Jvh1SRHK6
	r96DFrxj7rsOJNpOR8W/6dPTrxgX6snqWi2x94QnTX6KKThtX6KvNwXrjHPVgyAB9MNb
X-Received: by 2002:a5d:5f09:0:b0:47f:97e9:fe55 with SMTP id ffacd0b85a97d-47fd32ea399mr6710072f8f.22.1785521931614;
        Fri, 31 Jul 2026 11:18:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm7293694f8f.4.2026.07.31.11.18.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:18:51 -0700 (PDT)
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
Subject: [PATCH v4 1/5] serial: core: do fallible allocations before the console can be registered
Date: Fri, 31 Jul 2026 20:18:40 +0200
Message-Id: <20260731181844.11330-2-kmehltretter@gmail.com>
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
