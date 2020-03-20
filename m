Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043BBC4332B
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C763B20781
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584732868;
	bh=aEvsi6aPUPNwJ9dvXmrIO+AidW7tr3gfQQCtLkGp4ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RpIGmEKrfYS5X+UrTQNFTTrRk6FhymFYoiDwE2wtAylMyCfch7StKEq2VK9Z+VHbq
	 Pyd8hQJhdLy79fX2f4i1WSIZW87fuxsHNjUyfz2bk1flRvLREPigvnMlv+XyCJE+Ky
	 Sctino73yISLO8CAMJjkZBKGrWFwaHmuugcsepnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTTe2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCTTe2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 15:34:28 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAE020777;
        Fri, 20 Mar 2020 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584732867;
        bh=aEvsi6aPUPNwJ9dvXmrIO+AidW7tr3gfQQCtLkGp4ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B204xgDCd/79pkFl0pZhrNAW/wtFHXPaj+3w1T2k9EkoOjStCtRapyXkiRH5LhwVz
         TU/uDFvO+QYceG3GvRchskKMjYL6pmyctGfE8Q/rFkwD3nef2cFGtwUY2hOUGGJYHg
         zv1oO+Zn9bAU8dExcZi3D3CYxOL/LJtEYqwJnOww=
Date:   Fri, 20 Mar 2020 12:34:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 2/2] vt: vt_ioctl: fix use-after-free in vt_in_use()
Message-ID: <20200320193424.GM851@sol.localdomain>
References: <20200318222704.GC2334@sol.localdomain>
 <20200318223810.162440-1-ebiggers@kernel.org>
 <20200318223810.162440-3-ebiggers@kernel.org>
 <e2846610-ae0b-8e50-0fc4-c2cad6b23e9a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2846610-ae0b-8e50-0fc4-c2cad6b23e9a@suse.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 20, 2020 at 02:42:12PM +0100, Jiri Slaby wrote:
> On 18. 03. 20, 23:38, Eric Biggers wrote:
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -43,9 +43,11 @@ bool vt_dont_switch;
> >  
> >  static inline bool vt_in_use(unsigned int i)
> >  {
> > -	extern struct tty_driver *console_driver;
> > +	const struct vc_data *vc = vc_cons[i].d;
> >  
> > -	return console_driver->ttys[i] && console_driver->ttys[i]->count;
> > +	WARN_CONSOLE_UNLOCKED();
> > +
> > +	return vc && kref_read(&vc->port.kref) > 1;
> >  }
> >  
> >  static inline bool vt_busy(int i)
> > @@ -643,15 +645,16 @@ int vt_ioctl(struct tty_struct *tty,
> >  		struct vt_stat __user *vtstat = up;
> >  		unsigned short state, mask;
> >  
> > -		/* Review: FIXME: Console lock ? */
> >  		if (put_user(fg_console + 1, &vtstat->v_active))
> >  			ret = -EFAULT;
> >  		else {
> >  			state = 1;	/* /dev/tty0 is always open */
> > +			console_lock();
> 
> Could you comment on this one and the lock below why you added it here?
> 
> To me, it seems, we should rather introduce a vt alloc/dealloc lock
> protecting cases like this, not console lock. But not now, some time
> later. So a comment would help when/once we/I get into it...

I think the locking I added to VT_GETSTATE and VT_OPENQRY is pretty
self-explanatory: it's needed because they call vt_in_use() which now requires
console_lock.  So I'm not sure what you'd like me to add there?

As for vt_in_use() itself, I already added WARN_CONSOLE_UNLOCKED() to it.
But I can add a comment to it too if it would be useful, like:

static inline bool vt_in_use(unsigned int i)
{
        const struct vc_data *vc = vc_cons[i].d;

        /*
         * console_lock must be held to prevent the vc from being deallocated
         * while we're checking whether it's in-use.
         */
        WARN_CONSOLE_UNLOCKED();

        return vc && kref_read(&vc->port.kref) > 1;
}


> The interface (ie. the ioctls) also look weird and racy. Both of them.
> Like the "OK, I give you this number, but it might not be correct by
> now." kind of thing.
> 
> This let me think, who could use this? The answer is many 8-/. openpt,
> systemd, sysvinit, didn't check others.
> 
> Perhaps we should provide openvt -- analogy of openpty and deprecate
> VT_OPENQRY?
> 
> With VT_GETSTATE, the situation is more complicated:
> sysvinit uses VT_GETSTATE only if TIOCGDEV is not available, so
> VT_GETSTATE is actually unneeded there.
> 
> systemd uses it to find the current console (vtstat->v_active) and
> systemd-logind uses it for spawning autovt on free consoles. That sort
> of makes sense...
> 

Yes, these are bad APIs.

Once I did remove a buggy ioctl elsewhere in the kernel rather than fixing it.
But you have to be very, very confident that nothing is using it.  That doesn't
seem to be the case for VT_GETSTATE and VT_OPENQRY as it's not hard to find code
using them.  E.g. here's another user of both of them:
https://android.googlesource.com/platform/system/core/+/ccecf1425412beb2bc3bb38d470293fdc244d6f1/toolbox/setconsole.c

So we're probably stuck with them for now.  If you'd like to explore adding a
better API and trying to get all users to use it, you're certainly welcome to.
But it would be orthogonal to fixing this bug.

- Eric
