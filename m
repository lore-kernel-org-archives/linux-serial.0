Return-Path: <SRS0=Q4yL=AE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DADC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 11:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7BD20774
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592913116;
	bh=PRiIEPRfoDE9qN6mNANp8/xK2rdRTCAM55mKRzCf7og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wQOH/x5djZOvuJNWE1/Kio8jmRXANTX5MmFWRRsu16oRcF6DiZXJUXyBRRZ7By4dQ
	 65XAfEzpU5onLbyyReADI4I+zenb32bb5wfRCtcLvf4sbedGFOnkHHsT6Z/xrCyv3l
	 CnwSslORcoy3GmNpafubEtTTiAe3toOibAz5PEMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbgFWLvz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbgFWLvz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jun 2020 07:51:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2F820771;
        Tue, 23 Jun 2020 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592913115;
        bh=PRiIEPRfoDE9qN6mNANp8/xK2rdRTCAM55mKRzCf7og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEYUdvBrkaMZbust0fh7Lrrq7MFG43eT12CgOPqF9/9mOMi381tu8AMKG3CoQ0+Ry
         LrxUrtDU3ys4lWbp7XN91rvZe+sDElyBfQhclJiJWXQRBCMVJgWPRFYh3FBX0kS5cG
         Z91FeaqpEs4iyc4je8xnIzrc4gUeq9v3lbMOuyQs=
Date:   Tue, 23 Jun 2020 13:51:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anthony Canino <anthony.canino1@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Possible bug in drivers/tty/vt/vt.c
Message-ID: <20200623115148.GC1963415@kroah.com>
References: <CA+dbEpsJs8AgcpjU_-Vwh60BRL4Eq21L1=3sDNJRGHr2acLWLg@mail.gmail.com>
 <CA+dbEpt3YmDE7Q_BBhZZw9CfrUJfrhfR16XVoevXSqi=kOQjJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+dbEpt3YmDE7Q_BBhZZw9CfrUJfrhfR16XVoevXSqi=kOQjJg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 23, 2020 at 05:27:33AM -0400, Anthony Canino wrote:
> Hi all,
> 
> I hope this is the right place to ask about a potential bug in the TTY
> that I may have found in the TTY layer in the linux kernel. I have
> failed a bug report
> (https://bugzilla.kernel.org/show_bug.cgi?id=208293) but wanted to
> email the list for the TTY layer directly. In summary, in the con_init
> function of drivers/tty/vt/vt.c, I think this code is possibly buggy
> is kzalloc fails to allocate:
> 
>   3391   for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>   3392     vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data),
> GFP_NOWAIT);
>   3393     INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   3394     tty_port_init(&vc->port);
>   3395     visual_init(vc, currcons, 1);
>   3396     vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
>   3397     vc_init(vc, vc->vc_rows, vc->vc_cols,
>   3398       currcons || !vc->vc_sw->con_save_screen);
>   3399   }
>   3400   currcons = fg_console = 0;
>   3401   master_display_fg = vc = vc_cons[currcons].d;
>   3402   set_origin(vc);
> 
> If kzalloc returns null on 3396, I think during set_origin(vc) it is
> possible vc_screenbuf will be dereferenced. I'd be happy to discuss
> further if needed.

Yes, horrible and bad things will happen if kzalloc fails at that point
in time.

Luckily, it is impossible for that to happen, so we really do not need
to worry about it at all.  This comes up every other year or so, and the
gyrations that people have gone through to try to fix this up, for
something that is impossible to ever hit, always end up breaking the
codebase or doing other horrible things.

In short, don't worry about it, unless you can show me how that can ever
happen in a normal (i.e. not instrumented) system?

thanks,

greg k-h
