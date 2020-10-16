Return-Path: <SRS0=C9ms=DX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3BCC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEC520848
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602854415;
	bh=4n/dx1Agi00U+iZrSpfAza/Wo8+KVHxG9tsHd5dunM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nhZz0IRhtG3oBb3YYVqJk/yY9gP5tzg12hOzmziZ0AaRYJnRO+9LCDqfSlhfvZMGl
	 wUd6DwaX7qYf7jkXwr0uI7oRobciv/JcZbqIpgnducAKMkzcHp8vF/qYpUQi870d8V
	 W6AFttfxTTwTQqY/oINnn/pOah1dwI6KBje34AYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407436AbgJPNUO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407430AbgJPNUO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Oct 2020 09:20:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE812083B;
        Fri, 16 Oct 2020 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602854413;
        bh=4n/dx1Agi00U+iZrSpfAza/Wo8+KVHxG9tsHd5dunM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pf6I52kiNBeLjmH4wapL9lC/uIIH41nDZjcPtYvuRgVpOPHayCKfv5vcV22b1Zqrk
         Ny3TCQtB4sU+JeOld+4yWTcBB1c8ID+8KnWHA0O8bC5Car2fgCUl3EoW0is2+qkEms
         7JuJ1MfGh4lA0Huqoxb/DaSUIpot2uMrW3qFuQpA=
Date:   Fri, 16 Oct 2020 15:20:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minh Yuan <yuanmingbuaa@gmail.com>
Subject: Re: [PATCH 3/3] vt: keyboard, extend func_buf_lock to readers
Message-ID: <20201016132044.GA1798163@kroah.com>
References: <20201016122412.31767-1-jslaby@suse.cz>
 <20201016122412.31767-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016122412.31767-3-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 16, 2020 at 02:24:12PM +0200, Jiri Slaby wrote:
> Both read-side users of func_table/func_buf need locking. Without that,
> one can easily confuse the code by repeatedly setting altering strings
> like:
> while (1)
> 	for (a = 0; a < 2; a++) {
> 		struct kbsentry kbs = {};
> 		strcpy((char *)kbs.kb_string, a ? ".\n" : "88888\n");
> 		ioctl(fd, KDSKBSENT, &kbs);
> 	}
> 
> When that program runs, one can get unexpected output by holding F1
> (note the unxpected period on the last line):
> .
> 88888
> .8888
> 
> So protect all accesses to 'func_table' (and func_buf) by preexisting
> 'func_buf_lock'.
> 
> It is easy in 'k_fn' handler as 'puts_queue' is expected not to sleep.
> On the other hand, KDGKBSENT needs a local (atomic) copy of the string
> because copy_to_user can sleep.
> 
> Likely fixes CVE-2020-25656.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Reported-by: Minh Yuan <yuanmingbuaa@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

So all 3 of these should go to 5.10-final?

thanks,

greg k-h
