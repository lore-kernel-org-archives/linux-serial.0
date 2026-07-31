Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCD3B3C01;
	Fri, 31 Jul 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490785; cv=none; b=ZRsS7pXzDrKN+59zeMItr4lEAKMarjZJsUqZ6Moo7rt8w3Vc2XRyvs7NGP6Mkx7fzDgxR2gcMyMi5yqLQHzcu/Cr38dmTSgWfK9WpQNzlVH1yO3xP7k3bDWBzew+t0ClWKG9qcKgGgBh9cxHlEBFRKxPjDwhoeTF+Yji1YKeBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490785; c=relaxed/simple;
	bh=BuctfOC8i6cKchdnIiDE94iJ0LouwLYFc/zc3PhPiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG0bJa0fIVg8A0tPUht4mDu3JcS7gW8B4c+JTB0kK5hr9IOwyRbZIWm/t38Hx5jEHSjWoXX026e/zF1lRqF42WQkygF4op5GrUaVXUD71Pqzi/jWbr39v5Z5tIie666ne9atN9rMvEyPhe8dYhZHGpct5nYPOcjHc1T4V+zh46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGaKNPXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGaKNPXp"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C412D1F00A3A;
	Fri, 31 Jul 2026 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490783;
	bh=7rWkVEBbXHPWFlMkYxOYL/pB06ym1Kh75wRMniM1bhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGaKNPXpNS84y/O0w0/FfnxhfhaaoUkCMNDNVC4E01PlLSJ85fFQ1SK2l3UaqoblQ
	 SNfFvIx0MoG6JFb6WeK25HcVOhuJDGSrOC+ySfHx/rKdU8eLYM0FfRrv2gT3/E/Zk2
	 qwjYUvgvHqvHJdEXdHvcQk8oOu2Cy8x4ZeFun4v3BEZ0xFu66KBtgnRgp2WNVceSLA
	 WN5pP4DMqP8rLHxa4p+zkJofEARavz2App9fXZEbwqK1v4/YWzi5HZ74UxEHtT4Hh3
	 uPKcqcBEI9g5hk7Gg6C00fig6fQ8J7OoeKoQgjRss8LwFDa1WK6GF91UC0Mktj9w4T
	 cW6ZRX8Tvnvpw==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 3/6] serial: 8250: Make uart_match_port() a 8250 specific function
Date: Fri, 31 Jul 2026 11:39:06 +0200
Message-ID:  <8f707b41d462afcf7a2237869adece5fc16a9a77.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4950; i=ukleinek@kernel.org; h=from:subject:message-id; bh=BuctfOC8i6cKchdnIiDE94iJ0LouwLYFc/zc3PhPiuE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqbG1HxXnff/geZcbUysE5+C6xmiUCoQ4OJWGik sYqhFKUTaqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCamxtRwAKCRCPgPtYfRL+ To1fCACR5dNpcpzmDL7bEc+JE/I6k6lSCRgxUWJpZLtuIE3fzP6OYYKkC9gIwXRn8sJHWW7R4vF 5sY7MdBb8f7LVPV8pPSn79+1goaUe/Dw6q8sZGY+yzdc+LBBIsx01BqC2UuDFPpAVKEdAAxj5mX Toc5oaaiNOoFmbUQwHjOVdGt12MteoIOt6aaNjaBcoS68I3NaOjND/3E+3GCRH1mIZ1X30+QkEJ bjYFOjNqJ4lp2rNl/uYXz6c7fEF1S4KZET9HPS0zjJNab0bWedCSN8i3A2dQLNSVVB74NetWEgQ JOOu1CIlnVdE70y11ZxlQfhq9Gj26f3MHKBUbi5u42JKxFXR
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The 8250 driver conglomerate is the only user of this function and in
fact it already is 8250 specific as it uses hub6_match_port() which is
defined in drivers/tty/serial/8250/8250_hub6.c unless the dummy
implementation is in use.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 Documentation/driver-api/serial/driver.rst |  2 +-
 drivers/tty/serial/8250/8250_core.c        | 27 +++++++++++++++++++++-
 drivers/tty/serial/serial_core.c           | 27 ----------------------
 include/linux/serial_core.h                |  2 --
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index c1db6a1a67c4..975b0ba53e98 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -70,7 +70,7 @@ Other functions
 
 .. kernel-doc:: drivers/tty/serial/serial_core.c
    :identifiers: uart_update_timeout uart_get_baud_rate uart_get_divisor
-           uart_match_port uart_write_wakeup uart_register_driver
+           uart_write_wakeup uart_register_driver
            uart_unregister_driver uart_suspend_port uart_resume_port
            uart_add_one_port uart_remove_one_port uart_console_write
            uart_parse_earlycon uart_parse_options uart_set_options
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index c0e8a4efbdcc..6059b84d8364 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -630,6 +630,31 @@ EXPORT_SYMBOL(serial8250_resume_port);
  */
 static DEFINE_MUTEX(serial_mutex);
 
+/**
+ * serial8250_match_port - are the two ports equivalent?
+ * @port1: first port
+ * @port2: second port
+ *
+ * This utility function can be used to determine whether two uart_port
+ * structures describe the same port.
+ */
+static bool serial8250_match_port(const struct uart_port *port1,
+				  const struct uart_port *port2)
+{
+	if (port1->iotype != port2->iotype)
+		return false;
+	else if (port1->iotype == UPIO_PORT)
+		return port1->iobase == port2->iobase;
+	else if (port1->iotype == UPIO_HUB6)
+		return hub6_match_port(port1, port2);
+	else if (uart_iotype_mmio(port1->iotype))
+		return port1->mapbase == port2->mapbase;
+	else if (port1->iotype == UPIO_BUS)
+		return true;
+	else
+		return false;
+}
+
 static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_port *port)
 {
 	int i;
@@ -638,7 +663,7 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
 	 * First, find a port entry which matches.
 	 */
 	for (i = 0; i < nr_uarts; i++)
-		if (uart_match_port(&serial8250_ports[i].port, port))
+		if (serial8250_match_port(&serial8250_ports[i].port, port))
 			return &serial8250_ports[i];
 
 	/* try line number first if still available */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index edd1e7be2a5c..8a6c53a9996e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -33,7 +33,6 @@
 #include <linux/uaccess.h>
 
 #include "serial_base.h"
-#include "8250/8250.h" /* For hub6_match_port() */
 
 /*
  * This is used to lock changes in serial line configuration.
@@ -3229,32 +3228,6 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	state->uart_port = NULL;
 }
 
-/**
- * uart_match_port - are the two ports equivalent?
- * @port1: first port
- * @port2: second port
- *
- * This utility function can be used to determine whether two uart_port
- * structures describe the same port.
- */
-bool uart_match_port(const struct uart_port *port1,
-		const struct uart_port *port2)
-{
-	if (port1->iotype != port2->iotype)
-		return false;
-	else if (port1->iotype == UPIO_PORT)
-		return port1->iobase == port2->iobase;
-	else if (port1->iotype == UPIO_HUB6)
-		return hub6_match_port(port1, port2);
-	else if (uart_iotype_mmio(port1->iotype))
-		return port1->mapbase == port2->mapbase;
-	else if (port1->iotype == UPIO_BUS)
-		return true;
-	else
-		return false;
-}
-EXPORT_SYMBOL(uart_match_port);
-
 static struct serial_ctrl_device *
 serial_core_get_ctrl_dev(struct serial_port_device *port_dev)
 {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c4cc4f66af4b..1659805e2233 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1137,8 +1137,6 @@ int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_read_port_properties(struct uart_port *port);
 int uart_read_and_validate_port_properties(struct uart_port *port);
-bool uart_match_port(const struct uart_port *port1,
-		const struct uart_port *port2);
 
 /*
  * Power Management
-- 
2.55.0.11.g153666a7d9bb

