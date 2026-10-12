Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2B4ACC94;
	Mon, 12 Oct 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821624; cv=none; b=dEgyAAOKc+Wi0mg5S0EJL9ibDzuWUghH9LkJEvaD77WAEYHbCi1Jex7LllPkffiuZfLVk3ShuF8US6OLUe4YmR6vZWf0FGEqqfNWj6772n8xRvlfa0zI5pZ8ewEv22giPXFwWhcJFz242J68QpSUcAql6z6gd7fFOXSmbc9PpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821624; c=relaxed/simple;
	bh=VnUgvhekT2CkIj8Wza4EB/CsgfDSyBd0FRK4QXOUaZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2B6oFxXPNbtgSHb/Dk5QqRBnXV4EV222xSK5yj2NHHC2z5fnYb5O8wmTM+1gsznqeaKsSE05vA8fG7S9t9Ju88LBgM3ojyPEDNXOVO62AP9PWFsV2SMBAuav/R7kZrT06cr0Ln7K58UWnUCJcq8jQ0vqNx6sPdKK5kv+WcA2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v04EPpsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v04EPpsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F851F0089B;
	Mon, 12 Oct 2026 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791821623;
	bh=IEvo9ENkwkWplxj1NTic5h2muwUJVN5MraC5LTJMp7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=v04EPpsIsX8PrEAYKxATrJcP3IWbDkWFyn2LdFg8UMvzpT4gvhNCKzmuZJ8Onuz/+
	 nI5aj/Zn66c06jh2WmiwdHNnL789ocz1m5L/rzJ5M5cApB2ZQaR+u0S+CSuQofcQ/H
	 M4KG8eeZJGm3z8/ZqYjLySPjQ0XYshgelzCxAdw0=
Date: Mon, 12 Oct 2026 18:13:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jirislaby@kernel.org, deller@gmx.de,
	James.Bottomley@hansenpartnership.com, simona@ffwll.ch,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/2] vt: Use boolean as parameter to do_blank_screen()
 and do_unblank_screen()
Message-ID: <2026101205-deserve-flinch-d584@gregkh>
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-2-tzimmermann@suse.de>
 <2026101228-unfreeze-drearily-670f@gregkh>
 <1ad9f380-7efe-4323-acbc-a3cca3420184@suse.de>
 <6f774188-86ef-4a84-84c9-d8e45fa3db45@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f774188-86ef-4a84-84c9-d8e45fa3db45@suse.de>

On Mon, Oct 12, 2026 at 02:41:34PM +0200, Thomas Zimmermann wrote:
> 
> 
> Am 12.10.26 um 14:28 schrieb Thomas Zimmermann:
> > Hi
> > 
> > Am 12.10.26 um 13:30 schrieb Greg KH:
> > > On Mon, Oct 12, 2026 at 11:27:38AM +0200, Thomas Zimmermann wrote:
> > > > The parameters to do_blank_screen() and do_unblank_screen() signal
> > > > whether the call is part of a switch between text and graphics mode.
> > > > Convert to boolean. No functional changes.
> > > > 
> > > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > ---
> > > >   drivers/tty/vt/vt.c              | 20 ++++++++++----------
> > > >   drivers/tty/vt/vt_ioctl.c        | 12 ++++++------
> > > >   drivers/video/fbdev/core/fbcon.c |  4 ++--
> > > >   include/linux/vt_kern.h          |  5 +++--
> > > >   4 files changed, 21 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > > index 57edf37495a8..9e7b4419b422 100644
> > > > --- a/drivers/tty/vt/vt.c
> > > > +++ b/drivers/tty/vt/vt.c
> > > > @@ -3374,7 +3374,7 @@ static void console_callback(struct
> > > > work_struct *ignored)
> > > >           scrollback_delta = 0;
> > > >       }
> > > >       if (blank_timer_expired) {
> > > > -        do_blank_screen(0);
> > > > +        do_blank_screen(false);
> > > Same type of comment here, this bool doesn't really tell what is
> > > happening at all (not your fault, 0/1 doesn't either.)
> > > 
> > > I'm all for this patch but shouldn't this be fixed up to be 2 different
> > > named functions entirely?
> > 
> > Can you elaborate?  Do you mean there should be a separate helper and
> > callback for switching between KD_TEXT and KD_GRAPHICS?
> > 
> > Looking through the *_blank_screen() helpers and the console
> > implementations, I think we'd mostly duplicate code. Mode-switching and
> > blanking are tightly coupled.  Semantics get a bit cleaner with the
> > change you proposed to patch 1, I think.
> 
> And looking even further, it's not entirely clear why consw.con_blank even
> receives the mode_switch parameter.  The consoles track it with some
> internal state, but all of the mode information is available in struct
> vc_data.vc_mode as well.  I think mode_switch and similar booleans could be
> replaced with using vc_mode directly.

Yeah, that would be best overall, as the structure has the "state"
needed, no need to keep it separate in random variables.  This is some
old code before we all learned not to have global variables :)

thanks,

greg k-h
