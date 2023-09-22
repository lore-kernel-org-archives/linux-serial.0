Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2508E7D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 04:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjIVEYD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 00:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVEYC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 00:24:02 -0400
X-Greylist: delayed 1159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 21:23:56 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8218F
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 21:23:56 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DBFF7100DCEFB;
        Fri, 22 Sep 2023 06:23:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A1FA11087A; Fri, 22 Sep 2023 06:23:54 +0200 (CEST)
Date:   Fri, 22 Sep 2023 06:23:54 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
Message-ID: <20230922042354.GC9800@wunner.de>
References: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
 <87zg1fees3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg1fees3.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 21, 2023 at 05:24:04PM +0206, John Ogness wrote:
> On 2023-09-21, Lukas Wunner <lukas@wunner.de> wrote:
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 7bdc21d5e13b..ca26a8aef2cb 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
> >  static int uart_rs485_config(struct uart_port *port)
> >  {
> >  	struct serial_rs485 *rs485 = &port->rs485;
> > +	unsigned long flags;
> >  	int ret;
> >  
> > +	if (!(rs485->flags & SER_RS485_ENABLED))
> > +		return 0;
> > +
> >  	uart_sanitize_serial_rs485(port, rs485);
> >  	uart_set_rs485_termination(port, rs485);
> >  
> > +	spin_lock_irqsave(&port->lock, flags);
> >  	ret = port->rs485_config(port, NULL, rs485);
> > +	spin_unlock_irqrestore(&port->lock, flags);
> >  	if (ret)
> >  		memset(rs485, 0, sizeof(*rs485));
> 
> Is there some kind of guarantee that 2 CPUs cannot go into
> uart_rs485_config() simultaneously? Otherwise it seems dangerous to be
> using and clearing @port->rs485 outside of the spin_lock.

uart_rs485_config() is only called on probe and resume.
I don't quite see how 2 CPUs can probe or resume the same UART
simultaneously?

Granted, it *is* possible to access or modify port->rs485 from
user space through uart_{get,set}_rs485_config() in parallel to
uart_resume_port(), but as Ilpo has correctly stated, that's
serialized using port->mutex.

To provide some background information:

The majority of products *hardwire* the UART port to the RS485
transceiver and thus the UART should be switched to RS485 mode
on probe (through a "linux,rs485-enabled-at-boot-time" devicetree
property).  User space generally has no business fiddling with
RS485 properties in those cases, save for enabling/disabling
termination etc.

A minority of products has serial ports which can be switched
between RS232 and RS485 mode.  For those products, user space
may indeed have the need to enable/disable RS485 at runtime.
The Siemens IOT2040 is a case in point:

https://assets.new.siemens.com/siemens/assets/api/uuid:7b2c5580-7436-4081-9ae6-7c4eba29ddd1/version:1562856379/simaticiot2040.pdf

Thanks,

Lukas
