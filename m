Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8EAC433F5
	for <linux-serial@archiver.kernel.org>; Sat, 20 Nov 2021 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhKTR3M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 20 Nov 2021 12:29:12 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:41685 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhKTR3M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 20 Nov 2021 12:29:12 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Nov 2021 12:29:11 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 706E1300469AB;
        Sat, 20 Nov 2021 18:18:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6133B30A8CB; Sat, 20 Nov 2021 18:18:10 +0100 (CET)
Date:   Sat, 20 Nov 2021 18:18:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Su Bao Cheng <baocheng_su@163.com>
Cc:     Su Bao Cheng <baocheng.su@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, chao.zeng@siemens.com
Subject: Re: [PATCH] Revert "serial: 8250: Don't touch RTS modem control
 while in rs485 mode"
Message-ID: <20211120171810.GA26621@wunner.de>
References: <20211027111644.1996921-1-baocheng.su@siemens.com>
 <20211027113938.GA9373@wunner.de>
 <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a9b9bf-45a4-6e71-09f4-1ae730284778@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 12, 2021 at 02:14:11PM +0800, Su Bao Cheng wrote:
> On 2021/10/27 7:39, Lukas Wunner wrote:
> > On Wed, Oct 27, 2021 at 07:16:44PM +0800, Su Bao Cheng wrote:
> > > During tty_open, the uart_port_startup sets the MCR to 0, and then use
> > > set_mctrl to restore the MCR, so at this time, the MCR read does not
> > > reflect the desired value.

So only the *initial* value of MCR[1] is wrong and prevents receiving.
But once you've sent some data, RTS is deasserted correctly and you can
receive again.  Did I understand that correctly?


> The MCR is set to 0 at this line within uart_port_startup():
> 	retval = uport->ops->startup(uport);
> 
> On omap8250, the startup() points to omap_8250_startup(), within it:
> 	up->mcr = 0;
> 
> For software controlled RTS pin of RS485 half-duplex, when not in the
> transmitting, the MCR[1] should be constant to indicate the current
> direction is receiving. This is set in serial8250_em485_stop_tx().

I'm missing an important piece of information here:  Are you using
inverse polarity for RTS?  Normally MCR[1] should be 1 to transmit
and 0 to receive, per the figure on page 8734 of this document:

https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

Thus, setting up->mcr = 0 should be perfectly fine because it results
in RTS being deasserted, so the transceiver is in receive mode.

I suspect that you're using inverse polarity for RTS, so the desired
initial value of MCR[1] is 1 in your case.  Is that correct?

You write above that "the MCR[1] should be constant to indicate the
current direction is receiving".  That sentence is missing the desired
value, i.e. should MCR[1] be constant 1 or constant 0?

I suspect that the incorrect value in MCR[1] is evaluated by
omap8250_set_mctrl() via this call stack:
  omap_8250_set_termios()
    omap8250_restore_regs()
      up->port.ops->set_mctrl()

Could you confirm this please by inserting a dump_stack() in
omap8250_set_mctrl()?

I would also like to know if you have set UPSTAT_AUTORTS on the port
by enabling hardware flow-control (CRTSCTS) on the tty.  That would
cause omap8250_set_mctrl to fiddle with UART_EFR_RTS bit and I think
the user-visible result is that the transceiver is switched to
transmit mode when the "RX FIFO HALT trigger level" is reached.
We should probably stop it from doing that.

Thanks,

Lukas
