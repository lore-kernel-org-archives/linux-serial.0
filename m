From: Dan Carpenter <error27@gmail.com>
Subject: [smatch stuff] altera_uart: inconsistent checks for null
Date: Sat, 19 Feb 2011 12:31:07 +0300
Message-ID: <20110219093107.GC4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59400 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab1BSJbW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 Feb 2011 04:31:22 -0500
Received: by bwz15 with SMTP id 15so1442161bwz.19
        for <linux-serial@vger.kernel.org>; Sat, 19 Feb 2011 01:31:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw

Hi Tobias,

Patch 2780ad42f5fe67 "tty: serial: altera_uart: Use port->regshift to
store bus shift" added a NULL check for platp in altera_uart_probe() but
not consistently through out the function.

drivers/tty/serial/altera_uart.c +553 altera_uart_probe(43)
	error: we previously assumed 'platp' could be null.

   545          if (platp)
                   ^^^^^^^
checked here.

   546                  port->regshift = platp->bus_shift;
   547          else
   548                  port->regshift = 0;
   549
   550          port->line = i;
   551          port->type = PORT_ALTERA_UART;
   552          port->iotype = SERIAL_IO_MEM;
   553          port->uartclk = platp->uartclk;
                                ^^^^^^^
potential NULL dereference?

   554          port->ops = &altera_uart_ops;

I don't know the right way to address this.

regards,
dan carpenter
