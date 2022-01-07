Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C4C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  7 Jan 2022 08:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbiAGIwA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Jan 2022 03:52:00 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50327 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiAGIwA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Jan 2022 03:52:00 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 676652800B1D0;
        Fri,  7 Jan 2022 09:51:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 59FC61FE03; Fri,  7 Jan 2022 09:51:58 +0100 (CET)
Date:   Fri, 7 Jan 2022 09:51:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Jochen Mades <jochen@mades.net>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: core: Keep mctrl register state and cached copy
 in sync
Message-ID: <20220107085158.GA8218@wunner.de>
References: <bceeaba030b028ed810272d55d5fc6f3656ddddb.1641129752.git.lukas@wunner.de>
 <f3848788-822c-2125-0f2e-10f9962d11ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3848788-822c-2125-0f2e-10f9962d11ba@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 07, 2022 at 09:23:17AM +0100, Jiri Slaby wrote:
> On 02. 01. 22, 18:52, Lukas Wunner wrote:
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2389,7 +2389,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
> >   		 * We probably don't need a spinlock around this, but
> 
> One line above, it states:
> --- keep the DTR setting that is set in uart_set_options()

Yes:

		 * Ensure that the modem control lines are de-activated.
		 * keep the DTR setting that is set in uart_set_options()

In other words, clear all bits in port->mctrl except DTR (if it's been set
before by uart_set_options()).  That's what the code below is supposed to
achieve:

> >   		 */
> >   		spin_lock_irqsave(&port->lock, flags);
> > -		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
> > +		port->mctrl &= TIOCM_DTR;
> > +		port->ops->set_mctrl(port, port->mctrl);
> 
> So I don't think this is correct -- either the comment is wrong now or the
> code...

Why do you think so?  I don't quite follow.

Thanks,

Lukas
