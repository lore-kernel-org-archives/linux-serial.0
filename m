From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: Re: serial: mxs-auart: gpios as modem signals (dirty)
Date: Sat, 27 Sep 2014 22:32:47 +0200
Message-ID: <1411849969-12543-1-git-send-email-j.uzycki@elproma.com.pl>
References: <20140927100737.GC5182@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:54484 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751651AbaI0Uau (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 16:30:50 -0400
In-Reply-To: <20140927100737.GC5182@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Is it better in mxs_auart_init_gpios():
a) to block DMA by disabling MXS_AUART_RTSCTS (misleading name problem)
b) or just warn (depends on DT) if MXS_AUART_RTSCTS is set and CTS or RTS
   is defined as GPIO line? Then MXS_AUART_RTSCTS could be used
   instead of CTS_AT_AUART() in the interrupt and mxs_auart_settermios().

What do you think about RTSEN? It is set in mxs_auart_settermios()
and mxs_auart_set_mctrl().

[PATCH 1/2] serial: mxs-auart: use mctrl_gpio helpers for handling
* RTS_AT_AUART() and CTS_AT_AUART() macro defined
* DMA engine disabled if RTS or CTS is GPIO line
* CTSEN can't be enabled for hardware flow control block
  if CTS is defined as GPIO line
* RTSEN can be enabled for hardware flow control block
  even if RTS is defined as GPIO line.
  RTS pin depends on pinctrl configuration which
  selects RTS output from hardware flow control block or GPIO line.
* mxs_auart_settermios(): RTS_AT_AUART() and CTS_AT_AUART() used
* mxs_auart_irq_handle(): CTS_AT_AUART() used
* mxs_auart_init_gpios() returns true(success)/false(failure)
* dev_err() message fixed in mxs_auart_probe()

[PATCH 2/2] serial: mxs-auart: add interrupts for modem control
* rebased

