Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329B1CACF7;
	Wed, 11 Dec 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903379; cv=none; b=XwIKPBf18iOij2PU7XqIMnUQLiAY+deRIsbRhX6Pw2MH+retay+W/45xZfa1YL5CI9lJ1aGdu+hY7QXWHJSEY6ITwz7i3ZaBHOicaoCjJCIZlraNRB/FZfxg1wfBZrmYi11mgG2Fvujfmser2zH4xTKSejEP3Qs7EEzcOm+s73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903379; c=relaxed/simple;
	bh=M+GPp2PhLuzLfhyGGVDgj3+tpOTnqeKvlB8222iQ8JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmVOcsVPFbjYlNHtZrFhBVmzJOF8wqQ1lgV50Mhk4KnYdokSHv3SdakFeokl6JUsGhZOVfdgWHrjvVs/z1rgJs22CPIsLmmSTki4Rv/yJ3KcDxmA4/Aww8MdUKidv/54QSDFFkbCm85wbL1n65qyyiK2v0fi5BUplZASI2Feytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br/U7aPp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br/U7aPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C0C4CEE1;
	Wed, 11 Dec 2024 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733903378;
	bh=M+GPp2PhLuzLfhyGGVDgj3+tpOTnqeKvlB8222iQ8JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Br/U7aPpYCyy2louHosmlvalVD6cZyHjK+I73gIuHGtxFMTXaBaJR245o5JWSaj2g
	 uxmWZq9n1vNYMRjuC5O9y6jmWYM0V/fiWE35p7ldYiiqAXoIYe7nmNEyANwLtobLQs
	 gs4489X2TgF+W/ZHaZzLiEYqxVKTAnGNB+xwMVCo3bi7CzNKaxJL6e1f0L1xwPZnQX
	 nNIsxytsdo+VUAC7n/GvCNV0Gasb1sdvIs/0OZndrzBvx6OFqbXa+7GeYUWAkIDa9K
	 ol5Ygddnv25fQDpvJ9zRZZUwf5zy+ANylhaf7x3VK7A9NigyVGo+KmT9RCfTd8SmHy
	 BSv2lsvOOULdg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/3] tty: serial_core: use more guard(mutex)
Date: Wed, 11 Dec 2024 08:49:31 +0100
Message-ID: <20241211074933.92973-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211074933.92973-1-jirislaby@kernel.org>
References: <20241211074933.92973-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify 4 more functions using guard(mutex): uart_get_info(),
console_store(), serial_core_add_one_port(), and
serial_core_register_port(). Especially console_store() is now much less
convoluted. In the others, we save some goto-s and even local variables
are dropped in some.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 83 ++++++++++++--------------------
 1 file changed, 31 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74fa02b23772..f595f2336fc0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -790,7 +790,6 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
-	int ret = -ENODEV;
 
 	/* Initialize structure in case we error out later to prevent any stack info leakage. */
 	*retinfo = (struct serial_struct){};
@@ -799,10 +798,10 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 	 * Ensure the state we copy is consistent and no hardware changes
 	 * occur as we go
 	 */
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 	uport = uart_port_check(state);
 	if (!uport)
-		goto out;
+		return -ENODEV;
 
 	retinfo->type	    = uport->type;
 	retinfo->line	    = uport->line;
@@ -823,10 +822,7 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 	retinfo->iomem_reg_shift = uport->regshift;
 	retinfo->iomem_base      = (void *)(unsigned long)uport->mapbase;
 
-	ret = 0;
-out:
-	mutex_unlock(&port->mutex);
-	return ret;
+	return 0;
 }
 
 static int uart_get_info_user(struct tty_struct *tty,
@@ -3061,26 +3057,25 @@ static ssize_t console_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 	uport = uart_port_check(state);
-	if (uport) {
-		oldconsole = uart_console_registered(uport);
-		if (oldconsole && !newconsole) {
-			ret = unregister_console(uport->cons);
-		} else if (!oldconsole && newconsole) {
-			if (uart_console(uport)) {
-				uport->console_reinit = 1;
-				register_console(uport->cons);
-			} else {
-				ret = -ENOENT;
-			}
-		}
-	} else {
-		ret = -ENXIO;
+	if (!uport)
+		return -ENXIO;
+
+	oldconsole = uart_console_registered(uport);
+	if (oldconsole && !newconsole) {
+		ret = unregister_console(uport->cons);
+		if (ret < 0)
+			return ret;
+	} else if (!oldconsole && newconsole) {
+		if (!uart_console(uport))
+			return -ENOENT;
+
+		uport->console_reinit = 1;
+		register_console(uport->cons);
 	}
-	mutex_unlock(&port->mutex);
 
-	return ret < 0 ? ret : count;
+	return count;
 }
 
 static DEVICE_ATTR_RO(uartclk);
@@ -3136,7 +3131,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 {
 	struct uart_state *state;
 	struct tty_port *port;
-	int ret = 0;
 	struct device *tty_dev;
 	int num_groups;
 
@@ -3146,11 +3140,9 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state = drv->state + uport->line;
 	port = &state->port;
 
-	mutex_lock(&port->mutex);
-	if (state->uart_port) {
-		ret = -EINVAL;
-		goto out;
-	}
+	guard(mutex)(&port->mutex);
+	if (state->uart_port)
+		return -EINVAL;
 
 	/* Link the port to the driver state table and vice versa */
 	atomic_set(&state->refcount, 1);
@@ -3170,10 +3162,8 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
-	if (!uport->name) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!uport->name)
+		return -ENOMEM;
 
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
@@ -3189,10 +3179,9 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 
 	uport->tty_groups = kcalloc(num_groups, sizeof(*uport->tty_groups),
 				    GFP_KERNEL);
-	if (!uport->tty_groups) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!uport->tty_groups)
+		return -ENOMEM;
+
 	uport->tty_groups[0] = &tty_dev_attr_group;
 	if (uport->attr_group)
 		uport->tty_groups[1] = uport->attr_group;
@@ -3215,10 +3204,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 		       uport->line);
 	}
 
- out:
-	mutex_unlock(&port->mutex);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -3384,7 +3370,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
 	int ret;
 
-	mutex_lock(&port_mutex);
+	guard(mutex)(&port_mutex);
 
 	/*
 	 * Prevent serial_port_runtime_resume() from trying to use the port
@@ -3396,10 +3382,8 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
 	if (!ctrl_dev) {
 		new_ctrl_dev = serial_core_ctrl_device_add(port);
-		if (IS_ERR(new_ctrl_dev)) {
-			ret = PTR_ERR(new_ctrl_dev);
-			goto err_unlock;
-		}
+		if (IS_ERR(new_ctrl_dev))
+			return PTR_ERR(new_ctrl_dev);
 		ctrl_dev = new_ctrl_dev;
 	}
 
@@ -3420,8 +3404,6 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_port_dev;
 
-	mutex_unlock(&port_mutex);
-
 	return 0;
 
 err_unregister_port_dev:
@@ -3430,9 +3412,6 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
 
-err_unlock:
-	mutex_unlock(&port_mutex);
-
 	return ret;
 }
 
-- 
2.47.1

