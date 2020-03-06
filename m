Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B3C10F00
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 07:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E23321744
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583480280;
	bh=voT/cWvwNXY16YnhCXFBFR7aoDVGI99Duz4h/4bwyKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VEhy3TferFa4Wo1drdfq5VNsWoHTJfs2uWjKdIR6O7KhlT11qdeEmyKXh+lPv3WDL
	 A4hDYvVJ0Cx/qYsLivAlJ3yXzpR4COpCvcCDzlOShlwKWHUqgawsjcXVN1++ZGekuR
	 WXknnHuBF+t7HBu61rYXlovcopWm7OdF9ze+trl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCFHh7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgCFHh7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 02:37:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA9521739;
        Fri,  6 Mar 2020 07:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583480278;
        bh=voT/cWvwNXY16YnhCXFBFR7aoDVGI99Duz4h/4bwyKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2u+NXrkk8yq3Jrf0KNv2GY7XOtTpNZMQ4itPBr+1q7rTj8+i5HSWTAIqSK/IVsmwY
         A3gjJHfaJaivxCYRoD9dC6FIZx1ZTVEGBwE9sgxFrfxNoqHQubSkMWvCFup0k7jNYJ
         +4Zf3GZE1R0z39/3wVBesoYJKNuD7At23IRCgubc=
Date:   Fri, 6 Mar 2020 08:37:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] vt: selection, remove 2 local variables from
 set_selection_kernel
Message-ID: <20200306073745.GA3618933@kroah.com>
References: <20200219073951.16151-1-jslaby@suse.cz>
 <20200219073951.16151-3-jslaby@suse.cz>
 <20200221093251.GA90355@kroah.com>
 <75287ce8-d2ce-9c00-601a-486757e8860b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75287ce8-d2ce-9c00-601a-486757e8860b@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 24, 2020 at 10:26:50AM +0100, Jiri Slaby wrote:
> On 21. 02. 20, 10:32, Greg KH wrote:
> > On Wed, Feb 19, 2020 at 08:39:45AM +0100, Jiri Slaby wrote:
> >> multiplier and mode are not actually needed:
> >> * multiplier is used only in kmalloc_array, so use "use_unicode ? 4 : 1"
> >>   directly
> >> * mode is used only to assign a bool in this manner:
> >>   if (cond)
> >>     x = true;
> >>   else
> >>     x = false;
> >>   So do "x = cond" directly.
> >>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >> ---
> >>  drivers/tty/vt/selection.c | 14 +++++---------
> >>  1 file changed, 5 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> >> index 714992693974..6541c09d8bba 100644
> >> --- a/drivers/tty/vt/selection.c
> >> +++ b/drivers/tty/vt/selection.c
> >> @@ -191,9 +191,9 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
> >>  	struct vc_data *vc = vc_cons[fg_console].d;
> >>  	int new_sel_start, new_sel_end, spc;
> >>  	char *bp, *obp;
> >> -	int i, ps, pe, multiplier;
> >> +	int i, ps, pe;
> >>  	u32 c;
> >> -	int mode, ret = 0;
> >> +	int ret = 0;
> >>  
> >>  	poke_blanked_console();
> >>  
> >> @@ -224,11 +224,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
> >>  		clear_selection();
> >>  		sel_cons = vc_cons[fg_console].d;
> >>  	}
> >> -	mode = vt_do_kdgkbmode(fg_console);
> >> -	if (mode == K_UNICODE)
> >> -		use_unicode = 1;
> >> -	else
> >> -		use_unicode = 0;
> >> +	use_unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
> >>  
> >>  	switch (v->sel_mode)
> >>  	{
> >> @@ -312,8 +308,8 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
> >>  	sel_end = new_sel_end;
> >>  
> >>  	/* Allocate a new buffer before freeing the old one ... */
> >> -	multiplier = use_unicode ? 4 : 1;  /* chars can take up to 4 bytes */
> >> -	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, multiplier,
> >> +	/* chars can take up to 4 bytes with unicode */
> >> +	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, use_unicode ? 4 : 1,
> >>  			   GFP_KERNEL);
> >>  	if (!bp) {
> >>  		printk(KERN_WARNING "selection: kmalloc() failed\n");
> >> -- 
> >> 2.25.0
> >>
> > 
> > This patch fails to apply to my tree, so I stopped here.  Can you rebase
> > and resend the rest of these?
> 
> Could you be a little bit more specific? After the rebase, it still
> applies cleanly for me. Perhaps the tree you are applying this to was
> missing this 5.6-rc3 commit:
> commit 07e6124a1a46b4b5a9b3cacc0c306b50da87abf5
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Mon Feb 10 09:11:31 2020 +0100
> 
>     vt: selection, close sel_buffer race
> ?

Yes, I did not have your other patches in the branch I was using, as
those were to go to Linus for this current release.

I've fixed this up now and applied the rest, thanks.

greg k-h
