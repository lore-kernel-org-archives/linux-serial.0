Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A52451E2;
	Wed, 11 Dec 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903380; cv=none; b=TcMHH4dXKcRXvNYmjz9quTMOMHHtWI8X90jC9swK7/McdEEJvv6nH7udKTiNSjcFCB5JO9uUI9UGlwxHbYVeGhJgm4ofk7mg7MK61Oz4oXuatYg7LEK4I0t2L+7Kuwne5QnveULFTm/VkfWY+GL1ohvpodrWTtd9FS/7IruV+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903380; c=relaxed/simple;
	bh=w8mx6em4N8Cv7XDTnNj4Jx6lH58BcxmzbRzSfY76IZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN1RC0SQK0rfKhS5qcmZXj/VJy2o7uPFsnOnFkgpvlNa5RHZjKy8pquZi/KuNqJk5kqOUJ+52Nyp43N+B1FfIPuOlShQMVLD5yGwUR1nHS9bhkywdyq2+FaPBzumimiC1opcD3TvCaqfFVq4D75InRI9KnWubngUfWcZhdsfzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUnpcDeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUnpcDeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F60C4CEE2;
	Wed, 11 Dec 2024 07:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733903380;
	bh=w8mx6em4N8Cv7XDTnNj4Jx6lH58BcxmzbRzSfY76IZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUnpcDeTc9eh0hjMnOVaMkAfmxKH7ywlCkUrBqQ2oWFuA+fYezjJNurNzRjpuC5dK
	 8zMcVKObG5z5AeULujhIw8LCtVSfO7tluj8kB+QKPpYBkLp516CimQYQBjWM8njjdL
	 RLftcCTPCkEh0dKpZFSkbpVUPrk5jAUPuf8nj9hyEM80HEhLGI9cwpwH9G1n93VRl+
	 LhgXfzPs4iZCu7Pypjg0cMIe+h7qZC25y2a0ilbrRSlGG6slx2xFsKGb63mAJqAmdS
	 azorVYJVVWTjCe3wTXJ18meWzaIdzvpYr7DJLWFiMQAXhvgORG/Cg+QZGIaR8DvjQd
	 3YFgCAp+9bNow==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/3] tty: serial: get rid of exit label from uart_set_info()
Date: Wed, 11 Dec 2024 08:49:32 +0100
Message-ID: <20241211074933.92973-3-jirislaby@kernel.org>
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

The label is unneeded since 7ba2e769825f (tty: Split the serial_core
helpers for setserial into two). Until then, there was a lock held in
uart_set_info().

Now it is not, so we can remove the label. This involves reordering the
code, so that it is clear what values are returned, where and why. Until
now, it was really hard to follow.

The "change_port" part of the function is extracted into a separate
function in the next patch. This patch makes the transition there easier
too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 116 ++++++++++++++-----------------
 1 file changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f595f2336fc0..ce3cf95fc910 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -843,7 +843,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	unsigned int change_irq, change_port, closing_wait;
 	unsigned int old_custom_divisor, close_delay;
 	upf_t old_flags, new_flags;
-	int retval = 0;
+	int retval;
 
 	if (!uport)
 		return -EIO;
@@ -882,13 +882,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	if (!(uport->flags & UPF_FIXED_PORT)) {
 		unsigned int uartclk = new_info->baud_base * 16;
 		/* check needs to be done here before other settings made */
-		if (uartclk == 0) {
-			retval = -EINVAL;
-			goto exit;
-		}
+		if (uartclk == 0)
+			return -EINVAL;
 	}
 	if (!capable(CAP_SYS_ADMIN)) {
-		retval = -EPERM;
 		if (change_irq || change_port ||
 		    (new_info->baud_base != uport->uartclk / 16) ||
 		    (close_delay != port->close_delay) ||
@@ -896,7 +893,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		    (new_info->xmit_fifo_size &&
 		     new_info->xmit_fifo_size != uport->fifosize) ||
 		    (((new_flags ^ old_flags) & ~UPF_USR_MASK) != 0))
-			goto exit;
+			return -EPERM;
 		uport->flags = ((uport->flags & ~UPF_USR_MASK) |
 			       (new_flags & UPF_USR_MASK));
 		uport->custom_divisor = new_info->custom_divisor;
@@ -906,30 +903,24 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	if (change_irq || change_port) {
 		retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
 		if (retval)
-			goto exit;
+			return retval;
 	}
 
-	/*
-	 * Ask the low level driver to verify the settings.
-	 */
-	if (uport->ops->verify_port)
+	 /* Ask the low level driver to verify the settings. */
+	if (uport->ops->verify_port) {
 		retval = uport->ops->verify_port(uport, new_info);
+		if (retval)
+			return retval;
+	}
 
 	if ((new_info->irq >= irq_get_nr_irqs()) || (new_info->irq < 0) ||
 	    (new_info->baud_base < 9600))
-		retval = -EINVAL;
-
-	if (retval)
-		goto exit;
+		return -EINVAL;
 
 	if (change_port || change_irq) {
-		retval = -EBUSY;
-
-		/*
-		 * Make sure that we are the sole user of this port.
-		 */
+		 /* Make sure that we are the sole user of this port. */
 		if (tty_port_users(port) > 1)
-			goto exit;
+			return -EBUSY;
 
 		/*
 		 * We need to shutdown the serial port at the old
@@ -967,40 +958,33 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		 */
 		if (uport->type != PORT_UNKNOWN && uport->ops->request_port) {
 			retval = uport->ops->request_port(uport);
-		} else {
-			/* Always success - Jean II */
-			retval = 0;
-		}
-
-		/*
-		 * If we fail to request resources for the
-		 * new port, try to restore the old settings.
-		 */
-		if (retval) {
-			uport->iobase = old_iobase;
-			uport->type = old_type;
-			uport->hub6 = old_hub6;
-			uport->iotype = old_iotype;
-			uport->regshift = old_shift;
-			uport->mapbase = old_mapbase;
-
-			if (old_type != PORT_UNKNOWN) {
-				retval = uport->ops->request_port(uport);
-				/*
-				 * If we failed to restore the old settings,
-				 * we fail like this.
-				 */
-				if (retval)
-					uport->type = PORT_UNKNOWN;
-
-				/*
-				 * We failed anyway.
-				 */
-				retval = -EBUSY;
+			/*
+			 * If we fail to request resources for the
+			 * new port, try to restore the old settings.
+			 */
+			if (retval) {
+				uport->iobase = old_iobase;
+				uport->type = old_type;
+				uport->hub6 = old_hub6;
+				uport->iotype = old_iotype;
+				uport->regshift = old_shift;
+				uport->mapbase = old_mapbase;
+
+				if (old_type != PORT_UNKNOWN) {
+					retval = uport->ops->request_port(uport);
+					/*
+					 * If we failed to restore the old
+					 * settings, we fail like this.
+					 */
+					if (retval)
+						uport->type = PORT_UNKNOWN;
+
+					/* We failed anyway. */
+					return -EBUSY;
+				}
+
+				return retval;
 			}
-
-			/* Added to return the correct error -Ram Gupta */
-			goto exit;
 		}
 	}
 
@@ -1017,9 +1001,9 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		uport->fifosize = new_info->xmit_fifo_size;
 
  check_and_exit:
-	retval = 0;
 	if (uport->type == PORT_UNKNOWN)
-		goto exit;
+		return 0;
+
 	if (tty_port_initialized(port)) {
 		if (((old_flags ^ uport->flags) & UPF_SPD_MASK) ||
 		    old_custom_divisor != uport->custom_divisor) {
@@ -1035,15 +1019,17 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			}
 			uart_change_line_settings(tty, state, NULL);
 		}
-	} else {
-		retval = uart_startup(tty, state, true);
-		if (retval == 0)
-			tty_port_set_initialized(port, true);
-		if (retval > 0)
-			retval = 0;
+
+		return 0;
 	}
- exit:
-	return retval;
+
+	retval = uart_startup(tty, state, true);
+	if (retval < 0)
+		return retval;
+	if (retval == 0)
+		tty_port_set_initialized(port, true);
+
+	return 0;
 }
 
 static int uart_set_info_user(struct tty_struct *tty, struct serial_struct *ss)
-- 
2.47.1

