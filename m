Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF9C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  7 Jan 2022 09:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbiAGJQH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Jan 2022 04:16:07 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:44503 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346420AbiAGJQD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Jan 2022 04:16:03 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id DDEE82801D024;
        Fri,  7 Jan 2022 10:16:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CBF0A1FE03; Fri,  7 Jan 2022 10:16:02 +0100 (CET)
Date:   Fri, 7 Jan 2022 10:16:02 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: pl010: Drop CR register reset on set_termios
Message-ID: <20220107091602.GB8218@wunner.de>
References: <fcaff16e5b1abb4cc3da5a2879ac13f278b99ed0.1641128728.git.lukas@wunner.de>
 <ffe14471-b5da-fe97-a679-f1066ed13bd2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe14471-b5da-fe97-a679-f1066ed13bd2@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 07, 2022 at 09:30:48AM +0100, Jiri Slaby wrote:
> On 02. 01. 22, 18:42, Lukas Wunner wrote:
> > pl010_set_termios() briefly resets the CR register to zero.
> > 
> > Where does this register write come from?
> > 
> > The PL010 driver's IRQ handler ambauart_int() originally modified the CR
> > register without holding the port spinlock.  ambauart_set_termios() also
> > modified that register.  To prevent concurrent read-modify-writes by the
> > IRQ handler and to prevent transmission while changing baudrate,
> > ambauart_set_termios() had to disable interrupts.  That is achieved by
> > writing zero to the CR register.
> > 
> > However in 2004 the PL010 driver was amended to acquire the port
> > spinlock in the IRQ handler, obviating the need to disable interrupts in
> > ->set_termios():
> > https://git.kernel.org/history/history/c/157c0342e591
> > 
> > That rendered the CR register write obsolete.  Drop it.
[...]
> > --- a/drivers/tty/serial/amba-pl010.c
> > +++ b/drivers/tty/serial/amba-pl010.c
> > @@ -446,14 +446,11 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
> >   	if ((termios->c_cflag & CREAD) == 0)
> >   		uap->port.ignore_status_mask |= UART_DUMMY_RSR_RX;
> > -	/* first, disable everything */
> >   	old_cr = readb(uap->port.membase + UART010_CR) & ~UART010_CR_MSIE;
> >   	if (UART_ENABLE_MS(port, termios->c_cflag))
> >   		old_cr |= UART010_CR_MSIE;
> > -	writel(0, uap->port.membase + UART010_CR);
> > -
> 
> Isn't the write of zero followed by the original CR value needed to actually
> start the chip with the updated baud rate?

Why do you think so?  Such a requirement is not mentioned in the manual
of the PL010 (the UARTCR register is documented on page 44):

https://documentation-service.arm.com/static/5e8e246dfd977155116a54be


The manual of the successor, PL011, does contain a note on page 62 which
could be interpreted in the way you've written above.  However, in reality
this procedure appears to be unnecessary:

   "Program the control registers as follows:
    1. Disable the UART.
    2. Wait for the end of transmission or reception of the current
       character.
    3. Flush the transmit FIFO by setting the FEN bit to 0 in the Line
       Control Register, UARTLCR_H on page 3-12.
    4. Reprogram the UARTCR Register.
    5. Enable the UART."

https://documentation-service.arm.com/static/5e8e36c2fd977155116a90b5


> What are you trying to fix?

This is not a fix, it's a cleanup.

Zeroing the CR register was cargo-culted to the PL011 driver and appears
to be not only unnecessary there but also harmful because it glitches
RS-485 RTS deassertion.

While digging in the git history to find out where the register write
originates from, I've come to the conclusion that it is unnecessary
in the PL010 driver as well.  So it appears to be bit rot that can be
removed.  Of course, I only have a PL011 available for testing and not
a PL010, so I cannot rule out 100% that the change does not cause
regressions.  Faced with the choice of letting the old driver bit rot
or risk a regression, I chose the latter.  I was hoping that Russell
might remember the reason for the register write and cry foul if my
change is not correct.

Thanks,

Lukas
