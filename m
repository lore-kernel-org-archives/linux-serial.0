Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB90C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DAD61220
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 08:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhDLI0D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236920AbhDLI0B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 04:26:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F372C611C9;
        Mon, 12 Apr 2021 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618215942;
        bh=o2FA/cIfp81ieww6cQ4V8vdIeDnkjNOcliiu7ETQHpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHnMsNneetAzNDdLcS/md0lm9nlFNbK5iX6CMGjtvhvCkGUXfhTDBvSbjuuVA7ZKF
         qj8b8plBSB1bCVGVKT3k1hD1GZPdAYg+zHdgMjyGxf84Un7uA5Qw46RoIFDoTwhm1J
         4acu6SGUE6kN+llel9jRLE7HGsVR6ayGkJ7OmNcM=
Date:   Mon, 12 Apr 2021 10:25:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     jirislaby@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: stm32: optimize spin lock usage
Message-ID: <YHQEA9jn5uXQCtrN@kroah.com>
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
 <YHPgGI6EmTzmVH7g@kroah.com>
 <CAL9mu0Lt-3_O7V5HLxd5Hbt9afx9ryBUzWqmsc+2n3SP7JS6ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL9mu0Lt-3_O7V5HLxd5Hbt9afx9ryBUzWqmsc+2n3SP7JS6ig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 12, 2021 at 02:50:20PM +0800, dillon min wrote:
> Hi Greg，
> 
> Thanks for the quick response, please ignore the last private mail.
> 
> On Mon, Apr 12, 2021 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 12, 2021 at 12:34:21PM +0800, dillon.minfei@gmail.com wrote:
> > > From: dillon min <dillon.minfei@gmail.com>
> > >
> > > To avoid potential deadlock in spin_lock usage, change to use
> > > spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn) context.
> > > spin_lock(), spin_unlock() under handler context.
> > >
> > > remove unused local_irq_save/restore call.
> > >
> > > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > > ---
> > > Was verified on stm32f469-disco board. need more test on stm32mp platform.
> > >
> > >  drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
> > >  1 file changed, 17 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> > > index b3675cf25a69..c4c859b34367 100644
> > > --- a/drivers/tty/serial/stm32-usart.c
> > > +++ b/drivers/tty/serial/stm32-usart.c
> > > @@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
> > >       struct tty_port *tport = &port->state->port;
> > >       struct stm32_port *stm32_port = to_stm32_port(port);
> > >       const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> > > -     unsigned long c;
> > > +     unsigned long c, flags;
> > >       u32 sr;
> > >       char flag;
> > >
> > > @@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
> > >               uart_insert_char(port, sr, USART_SR_ORE, c, flag);
> > >       }
> > >
> > > -     spin_unlock(&port->lock);
> > > +     if (threaded)
> > > +             spin_unlock_irqrestore(&port->lock, flags);
> > > +     else
> > > +             spin_unlock(&port->lock);
> >
> > You shouldn't have to check for this, see the other patches on the list
> > recently that fixed this up to not be an issue for irq handlers.
> Can you help to give more hints, or the commit id of the patch which
> fixed this. thanks.
> 
> I'm still confused with this.
> 
> The stm32_usart_threaded_interrupt() is a kthread context, once
> port->lock holds by this function, another serial interrupts raised,
> such as USART_SR_TXE,stm32_usart_interrupt() can't get the lock,
> there will be a deadlock. isn't it?
> 
>  So, shouldn't I use spin_lock{_irqsave} according to the caller's context ?

Please see 81e2073c175b ("genirq: Disable interrupts for force threaded
handlers") for when threaded irq handlers have irqs disabled, isn't that
the case you are trying to "protect" from here?

Why is the "threaded" flag used at all?  The driver should not care.

Also see 9baedb7baeda ("serial: imx: drop workaround for forced irq
threading") in linux-next for an example of how this was fixed up in a
serial driver.

does that help?

thanks,

greg k-h
