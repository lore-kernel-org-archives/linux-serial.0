From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Fwd: [PULL REQUEST] Tweak to support 1Mbaud and similar baudrates
 that require Mode16 instead of Mode13
Date: Tue, 27 Nov 2012 23:35:07 +0200
Message-ID: <CAOmKuSpjitfTeeXz6VKQbhe+iUFb8wYy4n3tAzbjr9g_GOAn4g@mail.gmail.com>
References: <CAOmKuSpRJhBibSDxTFCH157-XokhaFhvQ-gYxKZe+PfzokaBoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46137 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab2K0VfI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 16:35:08 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so7364619vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 27 Nov 2012 13:35:07 -0800 (PST)
In-Reply-To: <CAOmKuSpRJhBibSDxTFCH157-XokhaFhvQ-gYxKZe+PfzokaBoA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

Hello everyone,

Original table in OMAP TRM named "UART Mode Baud Rates, Divisor
Values, and Error Rates" determines modes not for all common baud
rates. E.g. for 1000000 baud rate mode should be 16x, but according to
that table it's determined as 13x. According to current implementation
of mode
divisor selection, after requesting 1000000 baudrate from driver,
later one will configure chip to use MODE13 divisor. Assuming 48Mhz as
common UART clock speed, MODE13 divisor will effectively give 1230769
baudrate, what is quite far from desired 1000000 baudrate. While with
MODE16 divisor, chip will produce exact 1000000 baudrate.

In old driver that served UART devices (8250.c and serial_core.c) this
divisor could have been configured by user-space program, but in
omap_serial.c driver implementation this ability was not implemented
(afaik, by design) thus disallowing proper usage of MODE16-compatible
baudrates.

Best regards,
Alexey Pelykh

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://github.com/alexey-pelykh/linux.git omap_serial_mode_fix

for you to fetch changes up to cf827bb4057fdcdaeac20b95b01c29c068109185:

  Tweak to support 1Mbaud and similar baudrates that require Mode16
instead of Mode13 (2012-11-12 19:29:27 +0200)

----------------------------------------------------------------
Alexey Pelykh (1):
      Tweak to support 1Mbaud and similar baudrates that require
Mode16 instead of Mode13

 drivers/tty/serial/omap-serial.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)
