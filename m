Return-Path: <SRS0=3tiM=ZS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F3C432C0
	for <linux-serial@archiver.kernel.org>; Tue, 26 Nov 2019 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B9020748
	for <linux-serial@archiver.kernel.org>; Tue, 26 Nov 2019 09:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKZJxO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:53:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:42426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfKZJxN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Nov 2019 04:53:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0528BEE7;
        Tue, 26 Nov 2019 09:53:11 +0000 (UTC)
Date:   Tue, 26 Nov 2019 10:53:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: fix sysrq
 lockdep issue
Message-ID: <20191126095310.4hr3qc7pckuwakfq@pathway.suse.cz>
References: <1574416632-32321-1-git-send-email-fugang.duan@nxp.com>
 <20191122103359.fud44lh5wl5d3gxe@pengutronix.de>
 <VI1PR0402MB3600D0762BCB83C480AF6EB5FF4A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0402MB3600D0762BCB83C480AF6EB5FF4A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 2019-11-25 01:23:14, Andy Duan wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> Sent: Friday, November 22, 2019 6:34 PM
> > Hello,
> > 
> > On Fri, Nov 22, 2019 at 10:00:53AM +0000, Andy Duan wrote:
> > > From: Fugang Duan <fugang.duan@nxp.com>
> > >
> > > commit dbdda842fe96 ("printk: Add console owner and waiter logic to
> > > load balance console writes") introduces the lockdep issue for imx
> > > serial driver in sysrq case:
> > >      CPU0                    CPU1
> > >      ----                    ----
> > > lock(&port_lock_key);
> > >                              lock(console_owner);
> > >                              lock(&port_lock_key);
> > > lock(console_owner);
> > >
> > > It should unlock port_lock_key in handle_sysrq().
> > 
> > I already discussed this problem some time ago but then failed to complete
> > the topic. You might want to look at the old discussion, see
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.s
> > pinics.net%2Flists%2Fkernel%2Fmsg3266353.html&amp;data=02%7C01%7Cf
> > ugang.duan%40nxp.com%7C88047af87afa448bddaf08d76f377e8b%7C686ea
> > 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637100156446083651&amp;
> > sdata=mLk%2BLEyiJjIuRlLs0STJpWJ8K7Q2uPa2fL44bcf2mgY%3D&amp;reserv
> > ed=0.
> > 
> > Best regards
> > Uwe
> 
> Thanks for point out the old discussion.
> The issue seems exist all most of serial drivers. It is better to fix it on common code.

Do you have an idea how to fix this in a common code, please?

I am afraid that all affected drivers need to be fixed separately
as discussed in the above mentioned thread.


> How about the next step, we hope to the lockdep issue is fixed ASAP. 
> Thanks!

I would prefer if

   + uart_prepare_sysrq_char() gets renamed to uart_store_sysrq_char()

   + uart_unlock_and_check_sysrq() gets replaced with:

	sysrq_ch = uart_get_sysrq_char(port);
	spin_unlock(&port->lock);

	if (sysrq_ch)
		handle_sysrq(sysrq_ch);

as metnioned in
https://lore.kernel.org/lkml/20190926085855.debu7t46s7kgb26p@pathway.suse.cz/

Would you like to prepare the patchset, please?

Best Regards,
Petr
