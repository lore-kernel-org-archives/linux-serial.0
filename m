Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC09DC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Jan 2022 13:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiASNqc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Jan 2022 08:46:32 -0500
Received: from mailgw.felk.cvut.cz ([147.32.82.15]:52094 "EHLO
        mailgw.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiASNqb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Jan 2022 08:46:31 -0500
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 4FDEA30B035B;
        Wed, 19 Jan 2022 14:46:30 +0100 (CET)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 4F5EF30ADE4A;
        Wed, 19 Jan 2022 14:46:29 +0100 (CET)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 20JDkTMC020722;
        Wed, 19 Jan 2022 14:46:29 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 20JDkSv9020721;
        Wed, 19 Jan 2022 14:46:28 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: TTY layer discussion about generic FIFO depth and Rx iddle timeout control
Date:   Wed, 19 Jan 2022 14:46:28 +0100
User-Agent: KMail/1.9.10
Cc:     Wander Lairson Costa <wander@redhat.com>,
        linux-serial@vger.kernel.org,
        Rostislav =?iso-8859-1?q?Lisov=FD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jiri Slaby <jslaby@suse.cz>
References: <202201170006.31440.pisa@cmp.felk.cvut.cz> <YeVpFozoVQo1vbKS@kroah.com>
In-Reply-To: <YeVpFozoVQo1vbKS@kroah.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202201191446.28415.pisa@cmp.felk.cvut.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Greg,

thanks for the reply.

On Monday 17 of January 2022 14:03:18 Greg Kroah-Hartman wrote:
> On Mon, Jan 17, 2022 at 12:06:31AM +0100, Pavel Pisa wrote:
> >   https://github.com/lin-bus
> >
> > Kernel part - slLIN TTY discipline - can be found there
> >
> >   https://github.com/lin-bus/linux-lin/tree/master/sllin
>
> So it's just a 2000 line kernel module?  That should be easy to turn
> into a patch and submit for review, right?
>
> Odds are it can be made much smaller based on an initial glance at it.
> Review comments can help show what to do.

Thanks for encouragement for mainlining or at least review on the list.
I agree that it can shrink when patch for mainline without sections
providing compatibility with old kernels is prepared.
Generally, I think that it is doable and important is feedback
from the user base that there is interrest... and time...

I think that resolution of APO for the trigger/FIFO control
is critical for thinking about mainlining. Rest is the usual
work...

> >   https://github.com/lin-bus/linux-lin/issues/13
> >
> Discuss it here by submitting patches please.  Links to random github
> repos do not do much as we can do nothing with them, sorry.

Yes, I understand but I would like to hear some suggestion
the first where/into which object operations structure
should be the function added.

There is required functionality in 8250 driver linux/drivers/tty/serial/8250/8250_port.c

     do_set_rxtrig(struct tty_port *port, unsigned char bytes)
     do_serial8250_set_rxtrig(...)
     serial8250_set_attr_rx_trig_bytes(...)
     DEVICE_ATTR_RW(rx_trig_bytes)

But to make slLIN generally usable, we would need to have functionality
reachable from the line discipline

Do you agree that right place is struct uart_ops?

  https://elixir.bootlin.com/linux/latest/source/include/linux/serial_core.h#L38

What should be a prototype?

In general, it would worth to have possibility to set Rx trigger level
and Rx iddle timeout. It would be ideal if the set function would
adjust value down to the first equal or smaller level supported
by uart HW and in the case of lack of support can switch FIFO off.
The iddle time can be specified in microseconds, nanoseconds and or
number of character times.

So questions:

Is more preferred to add two functions, one for iddle time, one
for trigger level or combined function is better?

How should work reporting of the supported values?

Should there be more functions etc...

I can imagine generic API which would provide all functionality
by single function to not inflate struct uart_ops too much.

  int (*rx_trigger)(struct uart_port *, int mode, int *rx_trigger_bytes,
                  int *rx_trigger_iddle_time)

The rx_trigger_bytes equal to 0 would mean switch FIFO off.
Trigger time can be in nanoseconds??? and would be recomputed
to number of character for some, most of the HW???

The mode could have

  UART_RX_TRIGGER_MODE_SET
  UART_RX_TRIGGER_MODE_CHECK_ROUND_DOWN
  UART_RX_TRIGGER_MODE_CHECK_ROUND_UP

When specified parameters cannot be set, the function returns
error. When called with ROUND_UP/DOWN it modifies parameters
to the first available value in given direction
and next call to UART_RX_TRIGGER_MODE_SET would be guaranteed
to succeed.

Other option is to combine functionality to set_termios
call, but it is quite convoluted by its history and connection
to user space API. Not that maintaining trigger levels from
userspace is not usefull, but...

I would be happy if you or somebody other with linux
kernel and serial port style taste would comment.

Best wishes ant thanks for your time and work,


                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home


