Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DEC3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4641F24688
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582891418;
	bh=F45jGR8inVL7uQakJCTk4TJQljfIU/v10IwPWuZmNdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZUQtIDtdHcIkxMIOw3RczW3P6T8iE5OCtSVlLPitMTam/zRaS4walGYanQf7cuNLa
	 hXrSBncr4mDANKU0Tq8KjaNyJPgomvum4vyXfsARTTIojVjcXZCqqRvKSKWhsxAt/3
	 olmTD7rLV85M9PvcoiKIx5mtW/9OIZICwenrhwLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1MDh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgB1MDh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 07:03:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E0A24688;
        Fri, 28 Feb 2020 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582891414;
        bh=F45jGR8inVL7uQakJCTk4TJQljfIU/v10IwPWuZmNdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gf8dZbZn574ttT6srYnvUYy0E89cvAC1Sd5XR9pqOO0h7BRMGWAz47/FAXmB1dsbM
         3TOQc2obLGaC92eP9VxGyj1XxR7Jad+oT0m6qsoZj7IM+23hscemuObJwHkH0K179j
         SPvxWEi3tN+u9q2aqCQBpnMN6ybrujz/RFr0oKg8=
Date:   Fri, 28 Feb 2020 13:03:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] vt: selection, push sel_lock up
Message-ID: <20200228120332.GA3011426@kroah.com>
References: <20200228115406.5735-1-jslaby@suse.cz>
 <20200228115406.5735-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228115406.5735-2-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 28, 2020 at 12:54:06PM +0100, Jiri Slaby wrote:
> sel_lock cannot nest in the console lock. Thanks to syzkaller, the
> kernel states firmly:
> 
> > WARNING: possible circular locking dependency detected
> > 5.6.0-rc3-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.4/20336 is trying to acquire lock:
> > ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
> >
> > but task is already holding lock:
> > ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374
> >
> > which lock already depends on the new lock.
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #2 (sel_lock){+.+.}:
> >        mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
> >        set_selection_kernel+0x3b8/0x18a0 drivers/tty/vt/selection.c:217
> >        set_selection_user+0x63/0x80 drivers/tty/vt/selection.c:181
> >        tioclinux+0x103/0x530 drivers/tty/vt/vt.c:3050
> >        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
> 
> This is ioctl(TIOCL_SETSEL).
> Locks held on the path: console_lock -> sel_lock
> 
> > -> #1 (console_lock){+.+.}:
> >        console_lock+0x46/0x70 kernel/printk/printk.c:2289
> >        con_flush_chars+0x50/0x650 drivers/tty/vt/vt.c:3223
> >        n_tty_write+0xeae/0x1200 drivers/tty/n_tty.c:2350
> >        do_tty_write drivers/tty/tty_io.c:962 [inline]
> >        tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046
> 
> This is write().
> Locks held on the path: termios_rwsem -> console_lock
> 
> > -> #0 (&tty->termios_rwsem){++++}:
> >        down_write+0x57/0x140 kernel/locking/rwsem.c:1534
> >        tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
> >        mkiss_receive_buf+0x12aa/0x1340 drivers/net/hamradio/mkiss.c:902
> >        tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
> >        paste_selection+0x346/0x470 drivers/tty/vt/selection.c:389
> >        tioclinux+0x121/0x530 drivers/tty/vt/vt.c:3055
> >        vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
> 
> This is ioctl(TIOCL_PASTESEL).
> Locks held on the path: sel_lock -> termios_rwsem
> 
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   &tty->termios_rwsem --> console_lock --> sel_lock
> 
> Clearly. From the above, we have:
>  console_lock -> sel_lock
>  sel_lock -> termios_rwsem
>  termios_rwsem -> console_lock
> 
> Fix this by reversing the console_lock -> sel_lock dependency in
> ioctl(TIOCL_SETSEL). First, lock sel_lock, then console_lock.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
> Fixes: 07e6124a1a46 ("vt: selection, close sel_buffer race")

As 07e6124a1a46 was marked for stable, both of these should be as well,
right?

And did you happen to test these two with the syzbot tool to see if it
really did fix the report?

thanks,

greg k-h
