Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2CEC6FA90
	for <linux-serial@archiver.kernel.org>; Sat, 17 Sep 2022 14:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIQOZn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Sep 2022 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIQOZj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Sep 2022 10:25:39 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C032EEE
        for <linux-serial@vger.kernel.org>; Sat, 17 Sep 2022 07:25:36 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 07CBE28100812;
        Sat, 17 Sep 2022 16:25:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E1D5018126; Sat, 17 Sep 2022 16:25:32 +0200 (CEST)
Date:   Sat, 17 Sep 2022 16:25:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Su Bao Cheng <baocheng.su@siemens.com>, baocheng_su@163.com,
        Chao Zeng <chao.zeng@siemens.com>,
        Peter Hung <hpeter+linux_kernel@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Codrin Ciubotariu <Codrin.Ciubotariu@microchip.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        Bich Hemon <bich.hemon@st.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] serial: Deassert RS485 Transmit Enable on probe in
 driver-specific way
Message-ID: <20220917142532.GB1584@wunner.de>
References: <b17842d9792762948f75d74205596d36bdd27f22.1663310999.git.lukas@wunner.de>
 <94e754d-12ae-271c-9462-7f90ebb2b164@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e754d-12ae-271c-9462-7f90ebb2b164@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 16, 2022 at 03:27:58PM +0300, Ilpo Järvinen wrote:
> On Fri, 16 Sep 2022, Lukas Wunner wrote:
> > When a UART port is newly registered, uart_configure_port() seeks to
> > deassert RS485 Transmit Enable by setting the RTS bit in port->mctrl.
> > However a number of UART drivers interpret a set RTS bit as *assertion*
> > instead of deassertion:  Affected drivers include those using
> > serial8250_em485_config() (except 8250_bcm2835aux.c) and some using
> > mctrl_gpio (e.g. imx.c).
> > 
> > Since the interpretation of the RTS bit is driver-specific, it is not
> > suitable as a means to centrally deassert Transmit Enable in the serial
> > core.  Instead, the serial core must call on drivers to deassert it in
> > their driver-specific way.  One way to achieve that is to call
> > ->rs485_config().  It implicitly deasserts Transmit Enable.
> > 
> > So amend uart_configure_port() and uart_resume_port() to invoke
> > uart_rs485_config().  That allows removing calls to uart_rs485_config()
> > from drivers' ->probe() hooks and declaring the function static.
> > 
> > Skip any invocation of ->set_mctrl() if RS485 is enabled.  RS485 has no
> > hardware flow control, so the modem control lines are irrelevant and
> > need not be touched.  When leaving RS485 mode, reset the modem control
> > lines to the state stored in port->mctrl.  That way, UARTs which are
> > muxed between RS485 and RS232 transceivers drive the lines correctly
> > when switched to RS232.  (serial8250_do_startup() historically raises
> > the OUT1 modem signal because otherwise interrupts are not signaled on
> > ancient PC UARTs, but I believe that no longer applies to modern,
> > RS485-capable UARTs and is thus safe to be skipped.)
> > 
> > imx.c modifies port->mctrl whenever Transmit Enable is asserted and
> > deasserted.  Stop it from doing that so port->mctrl reflects the RS232
> > line state.
> > 
> > 8250_omap.c deasserts Transmit Enable on ->runtime_resume() by calling
> > ->set_mctrl().  Because that is now a no-op in RS485 mode, amend the
> > function to call serial8250_em485_stop_tx().
> > 
> > fsl_lpuart.c retrieves and applies the RS485 device tree properties
> > after registering the UART port.  Because applying now happens on
> > registration in uart_configure_port(), move retrieval of the properties
> > ahead of uart_add_one_port().
> > 
> > Fixes: d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart open")
> > Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Link: https://lore.kernel.org/all/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/
> > Reported-by: Roosen Henri <Henri.Roosen@ginzinger.com>
> > Link: https://lore.kernel.org/all/8f538a8903795f22f9acc94a9a31b03c9c4ccacb.camel@ginzinger.com/
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v4.14+
> > ---
> >  Based on v6.0-rc3 + this dependency:
> >  https://lore.kernel.org/linux-serial/72fb646c1b0b11c989850c55f52f9ff343d1b2fa.1662884345.git.lukas@wunner.de/
> 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 907c5ff..a6f03b1 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -600,7 +600,7 @@ void serial8250_rpm_put(struct uart_8250_port *p)
> >  static int serial8250_em485_init(struct uart_8250_port *p)
> >  {
> >  	if (p->em485)
> > -		return 0;
> > +		goto deassert_rts;
> >  
> >  	p->em485 = kmalloc(sizeof(struct uart_8250_em485), GFP_ATOMIC);
> >  	if (!p->em485)
> > @@ -616,6 +616,7 @@ static int serial8250_em485_init(struct uart_8250_port *p)
> >  	p->em485->active_timer = NULL;
> >  	p->em485->tx_stopped = true;
> >  
> > +deassert_rts:
> >  	p->rs485_stop_tx(p);
> 
> 	if (p->em485->tx_stopped)
> 		p->rs485_stop_tx(p);
> 
> ?
> 
> Because if p->em485->tx_stopped is false and serial8250_em485_init() is 
> called again (the comment above it says it is safe to do so), it would 
> stop tx at wrong point.

Right, sounds reasonable.

The ->rs485_config is serialized with e.g. serial8250_tx_chars() through
the port spinlock, but I think it may be called while the TX FIFO still
holds characters and no other function is holding the lock.  In that case,
indeed we don't want to deassert RTS.

I'll wait for other comments and respin probably mid next week.

Thanks,

Lukas
