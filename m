From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: drivers/tty/serial/8250/8250_early.c:160:18: error: 'BASE_BAUD' undeclared
Date: Wed, 31 Oct 2012 11:35:28 +0300
Message-ID: <CAMo8BfKEcXe5+MwHt1_12Hgq4LXz4SuA_1FoWz_yNRArbPPW6w@mail.gmail.com>
References: <50906924.youLpm6PCxNnfMeP%yuanhan.liu@linux.intel.com>
	<20121031003644.GB28279@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33036 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935097Ab2JaIfa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Oct 2012 04:35:30 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so767328qcr.19
        for <linux-serial@vger.kernel.org>; Wed, 31 Oct 2012 01:35:29 -0700 (PDT)
In-Reply-To: <20121031003644.GB28279@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Chris Zankel <chris@zankel.net>, linux-serial@vger.kernel.org, linux-xtensa@linux-xtensa.org

On Wed, Oct 31, 2012 at 4:36 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> Hi Max,
>
> FYI, kernel build failed on
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> head:   35fd3dc58da675d659513384221349ef90749a01
> commit: 695c617ceec7954545285f1aa065edcbfe71fcee xtensa: ISS: add dummy serial.h for ISS platform
> date:   4 weeks ago
> config: make ARCH=xtensa allyesconfig
>
> All error/warnings:
>
> drivers/tty/serial/8250/8250_early.c: In function 'parse_options':
> drivers/tty/serial/8250/8250_early.c:160:18: error: 'BASE_BAUD' undeclared (first use in this function)

arch/xtensa/platforms/iss/include/platform/serial.h doesn't define BASE_BAUD,
I will post a fix, thank you.

> drivers/tty/serial/8250/8250_early.c:160:18: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +160 drivers/tty/serial/8250/8250_early.c
>
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  144     c = serial_in(port, UART_LCR);
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  145     serial_out(port, UART_LCR, c | UART_LCR_DLAB);
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  146     serial_out(port, UART_DLL, divisor & 0xff);
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  147     serial_out(port, UART_DLM, (divisor >> 8) & 0xff);
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  148     serial_out(port, UART_LCR, c & ~UART_LCR_DLAB);
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  149  }
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  150
> ce2e204f drivers/serial/8250_early.c Alan Cox       2008-02-08  151  static int __init parse_options(struct early_serial8250_device *device,
> ce2e204f drivers/serial/8250_early.c Alan Cox       2008-02-08  152                                                             char *options)
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  153  {
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  154     struct uart_port *port = &device->port;
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  155     int mmio, mmio32, length;
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  156
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  157     if (!options)
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  158             return -ENODEV;
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16  159
> ^1da177e drivers/serial/8250_early.c Linus Torvalds 2005-04-16 @160     port->uartclk = BASE_BAUD * 16;
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  161
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  162     mmio = !strncmp(options, "mmio,", 5);
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  163     mmio32 = !strncmp(options, "mmio32,", 7);
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  164     if (mmio || mmio32) {
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  165             port->iotype = (mmio ? UPIO_MEM : UPIO_MEM32);
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  166             port->mapbase = simple_strtoul(options + (mmio ? 5 : 7),
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  167                                            &options, 0);
> 1917ac76 drivers/serial/8250_early.c Samium Gromoff 2010-07-20  168             if (mmio32)
>
>
> ---
> 0-DAY kernel build testing backend         Open Source Technology Center
> Fengguang Wu, Yuanhan Liu                              Intel Corporation



-- 
Thanks.
-- Max
