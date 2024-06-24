Received: from vpsf.regnarg.cz (vpsf.regnarg.cz [37.205.8.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B63A27E
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212939; cv=none; b=B/PwCMT4DQ4G/g+++XGM2JA/SBe7XyCXJ9gvhPLBJSPlVZoZ6emRTqMCapRoT9ssVAOPB1s2poR/WbtPz51MqhsocoIPUPAgXN60xznti1IoDC07amCWS4qSo61nrk0oM5yLCQSymPQTNr8VWkJEcvSrMKTjWn5qf80QsaqjVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212939; c=relaxed/simple;
	bh=dHvT+Ckb4dYQhjSrkHJf3htGeUTsUbupYqX4YCPGO9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LrnwK2nv0QE0+Gkp0E2uVOizZ0lStqESviCimQMyKGAN5Fis8eVlHq/TTukIOnPMcSjur7As4qGc1dNV8nOY9jpkf+tSy8+4ri6JpyVCOAFlLK9jyNRoIdtCGUC+4bFY+2ChgidkURNPeiN/DEaKFAoAcB9VudHSbQQouRWxYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=regnarg.cz; spf=pass smtp.mailfrom=regnarg.cz; arc=none smtp.client-ip=37.205.8.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=regnarg.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=regnarg.cz
Received: by vpsf.regnarg.cz (Postfix, from userid 1001)
	id BA3F396A4B; Mon, 24 Jun 2024 08:59:33 +0200 (CEST)
Date: Mon, 24 Jun 2024 08:59:33 +0200
From: Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <r.lkml@regnarg.cz>
To: linux-serial@vger.kernel.org
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: DW UART EM485 broken because autoconfig resets UART_CAP_NOTEMT
Message-ID: <x6mi5lvykjfzk7alvivuuefwc5ya5mykirtrmfcum4t5sgrqaj@icbl5wjgj2h6>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

it seems that the EM485 mode on Designware UART controller is broken.
At the start of transmission, the RTS line is correctly asserted, but
it never gets deasserted.

Checked this with a logic analyzer. See:

    https://regnarg.cz/tmp/em485_bad.sr (PulseView dump)
    https://regnarg.cz/tmp/em485_bad.png

The test system is FriendlyElec NanoPi Neo-LTS (Allwinner H3).
For reference, the test userspace program I used:

    https://regnarg.cz/tmp/485.c

The mechanism seems to be this:

- The DW UART driver sets UART_CAP_NOTEMT when creating the port
  (8250_dwlib.c:dw8250_setup_port) to indicate that the controller
  does not generate interrupt on emptying the shift register.

- This should be then used in 8250_port.c:__stop_tx to use a timer
  instead of an interrupt to trigger DE deassertion.

- However, the port also goes through the 8250 autoconfig mechanism.
  For my controller, dw8250_setup_port does _not_ set UPF_FIXED_TYPE,
  so it tries to autodetect port type. As part of this, the
  up->capabilities field is reset, dropping the UART_CAP_NOTEMT
  (8250_port.c:autoconfig).
    * On this particular controller, the Component Version Register
      (DW_UART_UCV) returns zero, so the dw8250_setup_port function
      returns after this block:

          reg = dw8250_readl_ext(p, DW_UART_UCV);
              return;

- Without UART_CAP_NOTEMT, __stop_tx does not set up a timer and instead
  leaves deasserting DE to an interrupt that never comes.

If I hotfix autoconfig to preserve UART_CAP_NOTEMT, the
EM485 functionality seems to work correctly:


diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 893bc493f662..1c2d24074722 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1140,6 +1140,7 @@ static void autoconfig(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 	unsigned int old_capabilities;
+	unsigned int preserved_capabilities;
 
 	if (!port->iobase && !port->mapbase && !port->membase)
 		return;
@@ -1155,7 +1156,8 @@ static void autoconfig(struct uart_8250_port *up)
 	 */
 	uart_port_lock_irqsave(port, &flags);
 
-	up->capabilities = 0;
+	preserved_capabilities = up->capabilities & UART_CAP_NOTEMT;
+	up->capabilities = preserved_capabilities;
 	up->bugs = 0;
 
 	if (!(port->flags & UPF_BUGGY_UART)) {
@@ -1266,7 +1268,7 @@ static void autoconfig(struct uart_8250_port *up)
 
 	port->fifosize = uart_config[up->port.type].fifo_size;
 	old_capabilities = up->capabilities;
-	up->capabilities = uart_config[port->type].flags;
+	up->capabilities = uart_config[port->type].flags | preserved_capabilities;
 	up->tx_loadsz = uart_config[port->type].tx_loadsz;
 
 	if (port->type == PORT_UNKNOWN)

And the result:

    https://regnarg.cz/tmp/em485_good.sr (PulseView dump)
    https://regnarg.cz/tmp/em485_good.png

But I am not quite sure what the 'proper' fix is, as I am missing a lot
of context regarding the relationship between DW UART, 8250 and the
various port types.

Filip Štědronský
