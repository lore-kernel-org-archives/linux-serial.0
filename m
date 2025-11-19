Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25B2F12A9;
	Wed, 19 Nov 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544306; cv=none; b=C5KWQSLNuOX3AUe0GWIr5sVTjksJiGaoKvOxyYugSdMNImc9xup7Vveo1kkzQfWq6ozw2bEJFEQOflzlWnPeMhgmWO+22N65qBWEaDlo/jTWQIbjkZ9sQkeeCzHNphXX3ZQ9xIDEsi1PRAuTlBFirekoMib3nEcSn7Vep7uaqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544306; c=relaxed/simple;
	bh=7CFuSj4IG2U8EHX0SPSAk32/9j7h/b0rTxyBDxOWsfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fx3xEPG8WCxf+jkX1+uq4Hj5jwHcdVNkEM4QgDm4v/tmpwaQhzT8YN9xRo6yodScVM8HAUQ2R0/l4XGUIAVGDUqbC15qpOaoJNFfA5+/KkqpdmSUTKa3RcBzHIbvY0juNRbQqmojIMXak6JRf5s1pW9PLgEhA5Ep5Xv7yTrF8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfF5G8a5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfF5G8a5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CE9C19424;
	Wed, 19 Nov 2025 09:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544305;
	bh=7CFuSj4IG2U8EHX0SPSAk32/9j7h/b0rTxyBDxOWsfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfF5G8a5i8tMZSgemK6nOdyDUBJko+TBjRiB7VlpL/x0pjrWJHlx23VxsOJAb7ItB
	 RUdjb00cA6JqQhL4KwVz6opuc1dkiZZAZTAk01/RKc+i6zCiPakXANCe2Pss3EI6V2
	 bJ/YDiH0zKxjaNbqSOOOtWi51PDyFLHxQ8DybqXyCrT3dL9DZIBU0JUmyc07vlykQe
	 tZNR+Xb3GLnsXFZylu844n9K48BNHMPM1RGB4+t1d1QfGXerRtPou2sxBaGHkISkS7
	 tbDGdvpJlXjddK7+uvfHTIT/Ca0YYWhyi+YLteYUif7huS6L+8vXKM9zKTQtppIoEJ
	 KncW5XJsEDQEg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] serial: xilinx_uartps: drop cdns_uart::cdns_uart_driver
Date: Wed, 19 Nov 2025 10:24:53 +0100
Message-ID: <20251119092457.826789-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119092457.826789-1-jirislaby@kernel.org>
References: <20251119092457.826789-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provided the uart driver is available globally, there is no need to
store a pointer to it in struct cdns_uart. Instead, use the global
cdns_uart_uart_driver in the code directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/xilinx_uartps.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a66b44d21fba..c793fc74c26b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -190,7 +190,6 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @port:		Pointer to the UART port
  * @uartclk:		Reference clock
  * @pclk:		APB clock
- * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
@@ -204,7 +203,6 @@ struct cdns_uart {
 	struct uart_port	*port;
 	struct clk		*uartclk;
 	struct clk		*pclk;
-	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
@@ -1465,7 +1463,6 @@ static struct console cdns_uart_console = {
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
-	struct cdns_uart *cdns_uart = port->private_data;
 	int may_wake;
 
 	may_wake = device_may_wakeup(device);
@@ -1489,7 +1486,7 @@ static int cdns_uart_suspend(struct device *device)
 	 * Call the API provided in serial_core.c file which handles
 	 * the suspend.
 	 */
-	return uart_suspend_port(cdns_uart->cdns_uart_driver, port);
+	return uart_suspend_port(&cdns_uart_uart_driver, port);
 }
 
 /**
@@ -1550,7 +1547,7 @@ static int cdns_uart_resume(struct device *device)
 		uart_port_unlock_irqrestore(port, flags);
 	}
 
-	return uart_resume_port(cdns_uart->cdns_uart_driver, port);
+	return uart_resume_port(&cdns_uart_uart_driver, port);
 }
 #endif /* ! CONFIG_PM_SLEEP */
 static int __maybe_unused cdns_runtime_suspend(struct device *dev)
@@ -1686,8 +1683,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
-
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
 		const struct cdns_platform_data *data = match->data;
@@ -1862,7 +1857,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
 	if (!instances)
-		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+		uart_unregister_driver(&cdns_uart_uart_driver);
 	return rc;
 }
 
@@ -1880,7 +1875,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
-	uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
+	uart_remove_one_port(&cdns_uart_uart_driver, port);
 	port->mapbase = 0;
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
@@ -1896,7 +1891,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
 	reset_control_assert(cdns_uart_data->rstc);
 
 	if (!--instances)
-		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
+		uart_unregister_driver(&cdns_uart_uart_driver);
 }
 
 static struct platform_driver cdns_uart_platform_driver = {
-- 
2.51.1

