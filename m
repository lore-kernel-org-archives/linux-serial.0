Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A5C3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D271C222C4
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582895046;
	bh=d56XVgErUm3M1UW5MCErbwksy80x9w5E1eEGJl2WGuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wy2F5l3mTBDdOWAvSAk7v257jR41a8tCKtlofT039FFXN6P0n8UJHbO5U+YSqYzZQ
	 TucNTuAi0n57LgSBzHPHnMSOhnWBUmhpDuNNwOy97iJXQIXhkgJGgsLOLTQcEP6XdW
	 IQ43TWX3EmJDAQKrytrAcep1mEXXnPOtYmjjWJbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgB1NEG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1NEG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:04:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E933222C4;
        Fri, 28 Feb 2020 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582895044;
        bh=d56XVgErUm3M1UW5MCErbwksy80x9w5E1eEGJl2WGuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYqrtZFzmpvXr1DfpXvIIUQUQvGkd0sDZ8An/StOHWKsUN4hqvvmDnwXlcV646D9p
         n42y7b/BcTWLDtsaqwvj2PrRGqpCYI/PILaz4LJc/K414FlD6fGkJaIddCCP9AsjGj
         2G+m9sH++Wex0PEYmSHOAyoeqscKhKDT+QDzL4zg=
Date:   Fri, 28 Feb 2020 14:04:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vt: selection, push sel_lock up
Message-ID: <20200228130400.GA3017265@kroah.com>
References: <20200228115406.5735-1-jslaby@suse.cz>
 <20200228115406.5735-2-jslaby@suse.cz>
 <20200228120332.GA3011426@kroah.com>
 <71582fee-257c-3ef4-7c03-3d43651898ff@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71582fee-257c-3ef4-7c03-3d43651898ff@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 28, 2020 at 01:59:36PM +0100, Jiri Slaby wrote:
> On 28. 02. 20, 13:03, Greg KH wrote:
> > On Fri, Feb 28, 2020 at 12:54:06PM +0100, Jiri Slaby wrote:
> >> sel_lock cannot nest in the console lock. Thanks to syzkaller, the
> >> kernel states firmly:
> >>
> >>> WARNING: possible circular locking dependency detected
> >>> 5.6.0-rc3-syzkaller #0 Not tainted
> >>> ------------------------------------------------------
> >>> syz-executor.4/20336 is trying to acquire lock:
> >>> ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
> ...
> >>> other info that might help us debug this:
> >>>
> >>> Chain exists of:
> >>>   &tty->termios_rwsem --> console_lock --> sel_lock
> >>
> >> Clearly. From the above, we have:
> >>  console_lock -> sel_lock
> >>  sel_lock -> termios_rwsem
> >>  termios_rwsem -> console_lock
> >>
> >> Fix this by reversing the console_lock -> sel_lock dependency in
> >> ioctl(TIOCL_SETSEL). First, lock sel_lock, then console_lock.
> >>
> >> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> >> Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
> >> Fixes: 07e6124a1a46 ("vt: selection, close sel_buffer race")
> > 
> > As 07e6124a1a46 was marked for stable, both of these should be as well,
> > right?
> 
> Ah, yes. My bad again, sorry.
> 
> > And did you happen to test these two with the syzbot tool to see if it
> > really did fix the report?
> 
> Nope, this syz* stuff is a black magic for me. How can I do that?

From the syzbot report at the bottom it says:
	syzbot will keep track of this bug report. See:
	https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
	syzbot can test patches for this bug, for details see:
	https://goo.gl/tpsmEJ#testing-patches

Try running these through that and let's see if we get a "success"
report or not.

thanks,

greg k-h
