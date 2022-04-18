Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D6C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 18 Apr 2022 15:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbiDRPvB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbiDRPtu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3545E101C8;
        Mon, 18 Apr 2022 08:28:05 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 92BB792009E; Mon, 18 Apr 2022 17:28:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8BB2992009C;
        Mon, 18 Apr 2022 16:28:04 +0100 (BST)
Date:   Mon, 18 Apr 2022 16:28:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] serial: 8250: Export ICR access helpers for
 internal use
In-Reply-To: <CAHp75Vem7twcS4bKXJZM4SfE+g9qC3rxtytTKpQsyszZpnrLqw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204181527220.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204162154250.9383@angie.orcam.me.uk> <CAHp75Vem7twcS4bKXJZM4SfE+g9qC3rxtytTKpQsyszZpnrLqw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 18 Apr 2022, Andy Shevchenko wrote:

> > Index: linux-macro/drivers/tty/serial/8250/8250.h
> > ===================================================================
> > --- linux-macro.orig/drivers/tty/serial/8250/8250.h
> > +++ linux-macro/drivers/tty/serial/8250/8250.h
> > @@ -120,6 +120,29 @@ static inline void serial_out(struct uar
> >         up->port.serial_out(&up->port, offset, value);
> >  }
> >
> > +/*
> > + * For the 16C950
> > + */
> > +static void __maybe_unused serial_icr_write(struct uart_8250_port *up,
> > +                                           int offset, int value)
> 
> I think you may drop __maybe_unused here, because it's always used by
> the code below. So it will be eliminated altogether when the below
> won't be used.

 Right, the absence of this annotation doesn't cause GCC to complain about 
sources that define this function but do not make use of it, so I have 
removed the atttribute in v5.

  Maciej
