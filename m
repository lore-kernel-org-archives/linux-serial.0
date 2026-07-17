Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED13CF97F;
	Fri, 17 Jul 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285529; cv=none; b=H4kEjVm9vijajCZJ/G33wDtpIkDYb5avTpE9yZTbPIKfJ90aS8HaKZyiwSVOH+Ezmjri6yrBluJjFQYOeWTfU6Vtp0GqIsP+yA5O8y/VZ8Y3bJpAdGWa5c7G/ki6M57/OLitvugoDq/4Ae/vvxBJKdnl5fOVW1c0dkvc7N/bH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285529; c=relaxed/simple;
	bh=Q4F7ku9swsMtM+pJXBne9japIebQTPIiXc7W99t+5wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny9LLYxBxJA54lh40/sOiYjXWVeBvkcM6CU09liEerQsAeYkGWtjekf9VOX0DoRs3ELCkl/+22yh3qxEPTBzLqZPRJCuEYFHGYTYYLVirv9aExUS8ryEmtKgeuG7o+kntpwMfmT70C/5wL2c1ppbcXjnOWdwS7BGY1vAzpGKJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/Zg9IYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/Zg9IYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606511F000E9;
	Fri, 17 Jul 2026 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784285524;
	bh=HvRZAxz20iZhfxtDz4oijjKo8Euv+xm5LViHXUUaMQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R/Zg9IYTE2U0uV/DoDGRiBbaLBW3xOzr3r+Gx1/Dp+TsjehZvUquVx5eoccgMadcb
	 AsJeLJ1IymSQDNebxVm21mqYL90k78kJ7pTCXJllpPrcbWPLONcP54WzTipve7/51Z
	 4gW8aaokll/XHuSjy8mu5/uYt6SiftCzL1nm5ItA=
Date: Fri, 17 Jul 2026 12:51:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: sdf.kernel@gmail.com, jirislaby@kernel.org, socketcan@hartkopp.net,
	linux-serial@vger.kernel.org, mkl@pengutronix.de,
	linux-can@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Message-ID: <2026071745-product-rogue-c364@gregkh>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
 <2026071655-steering-cardstock-cd06@gregkh>
 <87ea3ae8-8196-4f6f-bb03-d139f2f6c806@windriver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ea3ae8-8196-4f6f-bb03-d139f2f6c806@windriver.com>

On Fri, Jul 17, 2026 at 11:03:18AM +0800, Zhou, Yun wrote:
> 
> 
> On 7/16/26 15:57, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Thu, Jul 16, 2026 at 02:47:19PM +0800, Yun Zhou wrote:
> > > syzbot reported a circular lock dependency involving tty ldisc_sem and
> > > the networking rtnl_mutex. The full chain is:
> > > 
> > >    rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rtnl_mutex
> > > 
> > > The last edge (ldisc_sem -> rtnl_mutex) is created because tty line
> > > discipline .open() callbacks (slcan, slip) call register_netdev() which
> > > acquires rtnl_mutex, and .open() runs under ldisc_sem write lock in
> > > tty_set_ldisc().
> > > 
> > > Fix by moving the .open() call outside the ldisc_sem write lock. The
> > > ldisc .open() is initialization of the NEW discipline after the old one
> > > has been closed - there is no need for ldisc_sem protection at this
> > > point since:
> > > 
> > >   - tty_lock is held throughout, preventing concurrent tty_set_ldisc,
> > >     hangup, or close
> > >   - tty->ldisc is set to NULL during the window, so concurrent readers
> > >     (tty_ldisc_ref, tty_ldisc_ref_wait) see NULL and return immediately,
> > >     which callers already handle as a hangup condition
> > >   - tty buffer data stays queued until the ldisc is installed
> > > 
> > > The sequence becomes:
> > >    1. Hold ldisc_sem(write): close old ldisc, set tty->ldisc = NULL
> > >    2. Release ldisc_sem(write)
> > >    3. Call new_ldisc->ops->open() without ldisc_sem
> > >    4. Re-acquire ldisc_sem(write): install new ldisc (or restore old)
> > >    5. Release ldisc_sem(write)
> > > 
> > > Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
> > > Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> > > ---
> > >   drivers/tty/tty_ldisc.c | 17 +++++++++++++++--
> > >   1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > What commit caused this to be a problem and why have we not seen this in
> > any real-world usages?
> > 
> 
> The circular dependency has existed for a long time - it just requires
> ldisc_sem -> rtnl_mutex (from slcan/slip registering a netdev in
> .open()) and the reverse path through nft_commit_mutex, epoll, and
> tty_poll back to ldisc_sem.
> 
> The recent dev_instance_lock series (5326fefb9fe8 "net: hold instance
> lock around NETDEV_DOWN/GOING_DOWN") increased lockdep's observability
> by adding lock acquisitions in more notifier paths, making it easier for
> lockdep to collect all edges in a single run. It did not create the
> cycle.
> 
> We have not seen this in real-world usage because triggering the actual
> deadlock requires 6 unrelated subsystems to contend simultaneously -
> something only a fuzzer like syzkaller would construct.
> 
> > 
> > > 
> > > diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> > > index 27fe8236f662..248a6995cc53 100644
> > > --- a/drivers/tty/tty_ldisc.c
> > > +++ b/drivers/tty/tty_ldisc.c
> > > @@ -556,15 +556,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
> > >        /* Shutdown the old discipline. */
> > >        tty_ldisc_close(tty, old_ldisc);
> > > 
> > > -     /* Now set up the new line discipline. */
> > > -     tty->ldisc = new_ldisc;
> > > +     /* Clear tty->ldisc so concurrent readers back off during transition */
> > > +     tty->ldisc = NULL;
> > >        tty_set_termios_ldisc(tty, disc);
> > > +     tty_ldisc_unlock(tty);
> > > 
> > > +     /*
> > > +      * Open the new discipline outside ldisc_sem. The ldisc .open()
> > > +      * may acquire locks (e.g., rtnl_mutex) that would create circular
> > > +      * dependencies if taken under ldisc_sem. tty_lock is still held,
> > > +      * preventing concurrent ldisc changes and hangup.
> > > +      */
> > >        retval = tty_ldisc_open(tty, new_ldisc);
> > 
> > Now you are calling open when previously we were not, are you sure this
> > isn't going to cause problems?
> > 
> 
> This is not a new .open() call - it is the same tty_ldisc_open() that
> was always called here. The change only moves it outside ldisc_sem.
> tty_lock is still held throughout, so .open() sees the same environment
> as before.

Ah, you are right, my bad read of the patch, sorry.

thanks,

greg k-h
