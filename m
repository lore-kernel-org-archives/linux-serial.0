Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B4C433ED
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4465E6143D
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 14:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhEMOZ0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 10:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhEMOZY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 10:25:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18B9461438;
        Thu, 13 May 2021 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620915854;
        bh=SW1ymyNTu4aCXy6HP1+WjOhWh+LV/joCZ43Hn91qvsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdaFDuw5r7zBesVjHO6elOHNpi1MmXhJ3Gcr5Cq9jEkBU+rMEN2q4zhklkQbYs1Gf
         +XToyDC9n+hMObzZKgrqzjNNORFzh6Ni9EiUXW3ppEnhzgZLcbp3GOGmViVUaXAUBB
         m4YY+dfinalmO3jLTqj3kylgXmQlXRtQmLg5EpEI=
Date:   Thu, 13 May 2021 16:24:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-serial@vger.kernel.org,
        syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com,
        syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Hurley <peter@hurleysoftware.com>,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] serial: 8250: fix NULL pointer dereference in
 serial8250_do_startup()
Message-ID: <YJ02jIEDHduLbQ3f@kroah.com>
References: <00000000000044a65205994a7e13@google.com>
 <20210426161433.20829-1-vegard.nossum@oracle.com>
 <YIbnq2ljdQzaN8gy@kroah.com>
 <e3617587-7ff1-720c-00ab-434608705652@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3617587-7ff1-720c-00ab-434608705652@oracle.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 06:33:01PM +0200, Vegard Nossum wrote:
> On 2021-04-26 18:17, Greg Kroah-Hartman wrote:
> > On Mon, Apr 26, 2021 at 06:14:33PM +0200, Vegard Nossum wrote:
> > >   static void set_io_from_upio(struct uart_port *p)
> > >   {
> > >   	struct uart_8250_port *up = up_to_u8250p(p);
> > > @@ -2151,6 +2178,11 @@ int serial8250_do_startup(struct uart_port *port)
> > >   	unsigned char lsr, iir;
> > >   	int retval;
> > > +	if (WARN_ON_ONCE(needs_membase(port->iotype) && !port->membase))
> > > +		return -ENODEV;
> > > +	if (WARN_ON_ONCE(needs_iobase(port->iotype) && !port->iobase))
> > > +		return -ENODEV;
> > 
> > These WARN_ON() will still trigger syzbot.  Are you sure you tested this
> > and had syzbot verify it?
> 
> I tested it locally and the WARN_ON()s don't trigger -- presumably
> because serial8250_verify_port() is called from uart_set_info() before
> we get to serial8250_do_startup():
> 
>         /*
>          * Ask the low level driver to verify the settings.
>          */
>         if (uport->ops->verify_port)
>                 retval = uport->ops->verify_port(uport, new_info);
> 
> [...]
> 
>                 retval = uart_startup(tty, state, 1);
> 
> At least, this was my intention. Although now that I look at it again,
> it looks like this check may be skipped in some cases; is that what
> you're referring to?
> 
> I didn't have syzbot verify it -- I thought it would do that when
> submitting my patch. Looks like I need to push somewhere and ask syzbot
> to test it using this?
> 
> #syz test: git://repo/address.git commit-hash
> 
> (I assume I can send this privately as long as I use the right
> syzbot+...@ To-address?)
> 

Dropping this now until you get this tested properly...

thanks,

greg k-h
