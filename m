Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39EDC28CF5
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jan 2022 08:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiAZIzy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:55:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43336 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiAZIzx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 03:55:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E81A6149A
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 08:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E5FC340E3;
        Wed, 26 Jan 2022 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643187353;
        bh=woMrHaRKxCVwzgwiqq6x6b6DB29JcHJ6gmo1GyZ2l0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KsefCHEpdYEOd/XAA1AZJH78Os5BP6Q9/ZLtCWPN3Z8g2TFQnNCflxkRhTIDzMR6F
         qM19hm+SMsDC6kjJhFuajlhUUX7kyncnWaLwIz5XxXJNzVWdIYZ86Oos9Ipk+sn7jF
         GrQLg3NWHo9I2TReocHBn5g21O0C4jGXTTC0CpVI=
Date:   Wed, 26 Jan 2022 09:55:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        linux-serial@vger.kernel.org,
        Rostislav =?iso-8859-1?Q?Lisov=FD?= <lisovy@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: TTY layer discussion about generic FIFO depth and Rx iddle
 timeout control
Message-ID: <YfEMkHvDb6KJjh3h@kroah.com>
References: <202201170006.31440.pisa@cmp.felk.cvut.cz>
 <YeVpFozoVQo1vbKS@kroah.com>
 <202201191446.28415.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201191446.28415.pisa@cmp.felk.cvut.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 19, 2022 at 02:46:28PM +0100, Pavel Pisa wrote:
> Dear Greg,
> 
> thanks for the reply.
> 
> On Monday 17 of January 2022 14:03:18 Greg Kroah-Hartman wrote:
> > On Mon, Jan 17, 2022 at 12:06:31AM +0100, Pavel Pisa wrote:
> > >   https://github.com/lin-bus
> > >
> > > Kernel part - slLIN TTY discipline - can be found there
> > >
> > >   https://github.com/lin-bus/linux-lin/tree/master/sllin
> >
> > So it's just a 2000 line kernel module?  That should be easy to turn
> > into a patch and submit for review, right?
> >
> > Odds are it can be made much smaller based on an initial glance at it.
> > Review comments can help show what to do.
> 
> Thanks for encouragement for mainlining or at least review on the list.
> I agree that it can shrink when patch for mainline without sections
> providing compatibility with old kernels is prepared.
> Generally, I think that it is doable and important is feedback
> from the user base that there is interrest... and time...
> 
> I think that resolution of APO for the trigger/FIFO control
> is critical for thinking about mainlining. Rest is the usual
> work...
> 
> > >   https://github.com/lin-bus/linux-lin/issues/13
> > >
> > Discuss it here by submitting patches please.  Links to random github
> > repos do not do much as we can do nothing with them, sorry.
> 
> Yes, I understand but I would like to hear some suggestion
> the first where/into which object operations structure
> should be the function added.
> 
> There is required functionality in 8250 driver linux/drivers/tty/serial/8250/8250_port.c
> 
>      do_set_rxtrig(struct tty_port *port, unsigned char bytes)
>      do_serial8250_set_rxtrig(...)
>      serial8250_set_attr_rx_trig_bytes(...)
>      DEVICE_ATTR_RW(rx_trig_bytes)
> 
> But to make slLIN generally usable, we would need to have functionality
> reachable from the line discipline
> 
> Do you agree that right place is struct uart_ops?
> 
>   https://elixir.bootlin.com/linux/latest/source/include/linux/serial_core.h#L38
> 
> What should be a prototype?

For all of these questions, I do not know.  Try it out yourself first
and see what you feel works best.  We will be glad to review working
patches, but to discuss options before that is difficult and not
something we normally worry about.

thanks,

greg k-h
