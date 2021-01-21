Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A417C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E020522B45
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 17:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbhAUR7P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389386AbhAUR6A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 12:58:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2C8622B2B;
        Thu, 21 Jan 2021 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611251839;
        bh=CPvmyOW2bRiXfP//uUD6u2Ir6tIrXcUxIlhVD+i7/wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzx0KWCegesg8aIqxYvZtpPkMgSeKKmP0HbR10VJEiE8sppwLXjyCKeD7FfDMno08
         aQFw7pEgPOopSn5y18csmWHVeaGptF4mZ5NykxYfVT/cNQcihPxVe94YqYla5ricD+
         Z/jg3e9Ht3z+N4d4uUicakMOrXVRGnRrp0bGLCTo=
Date:   Thu, 21 Jan 2021 18:57:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Subject: Re: [PATCH 1/6] tty: implement write_iter
Message-ID: <YAnAfNcE8Bw95+SV@kroah.com>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org>
 <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 21, 2021 at 09:44:17AM -0800, Linus Torvalds wrote:
> On Thu, Jan 21, 2021 at 1:40 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > Ok, here belongs my earlier note: "if ld == NULL => crash here." That is
> > if hangup happens during the ldisc wait, the kernel will crash in
> > tty_ldisc_deref.
> 
> Right you are, good catch.
> 
> > Is there a reason not to convert hung_up_tty_fops too and leave the
> > return hung_up_tty_write here intact? This would also solve the comments
> > above.
> 
> No, no reason. I started out just changing that one tty_write, then
> noticed that I had to change the redirect case too, but never then got
> to "yeah, I should have changed the hup case as well".
> 
> Greg, do you prefer a new series, or incremental patches?

Incremental patches please as these are already in my public branches
and I would have to revert them and add new ones but that's messy, so
fixes on top is fine.

thanks,

greg k-h
