Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2419148833;
	Wed, 24 Jul 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816143; cv=none; b=qgujJDC48Kx2/kuNJERtW+5XpOzxoigbPPj5cBYgrrcfhif5z5bZgqhBfyqS2ECOMNzwVFcvMEcP2vZuBz90Al7lUcmY7BRcxa8+8S1nl0Xk/mJpYfci2Cxeh8VOONQRsfvN9QkriDzuZBXw1uHw/aW+ymExilI3N7fhmzL5A1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816143; c=relaxed/simple;
	bh=sFMZIf2ihav5KWBNwZUG6rIsjfc4DYBGazgFV+3l1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBzqq0OX65vS8JMtPUFzKB4iJtKUxJsUqxZlS+slw/2zC1leEGl2PQUqM6rTtd1IeM3vG2nJuN/+kp3F18nhq8PKs1yqafTWkluc4A3F+IDI2us0AklGQQz0J90M44t5DuHSNlF0+YrKJscgS0AXh8Penya/KhS62sBloDa3qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LkJJVW8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LkJJVW8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A759C32782;
	Wed, 24 Jul 2024 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721816142;
	bh=sFMZIf2ihav5KWBNwZUG6rIsjfc4DYBGazgFV+3l1/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkJJVW8yjty5etW7/zx/HPuSXPnlwzRZP9v1mNIRtVMswIB4cxHU8xH7WASSdWQXF
	 Huh2T+ejAiI84ecqRcxrgfX7avp75rZrd8aqubDY8+ywDOqETCkKV9I01gyzlwkGc2
	 UOQDN8bn8R0nMQX/NGN2R4567egXJyHEFzewpJp8=
Date: Wed, 24 Jul 2024 12:15:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: stsp <stsp2@yandex.ru>
Cc: linux-serial@vger.kernel.org,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <2024072401-obtain-heap-6d8d@gregkh>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
 <2024072401-spearfish-gnarly-a09e@gregkh>
 <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>

On Wed, Jul 24, 2024 at 12:55:22PM +0300, stsp wrote:
> 24.07.2024 12:08, Greg KH пишет:
> > On Wed, Jul 24, 2024 at 11:07:32AM +0300, stsp wrote:
> > > 24.07.2024 09:51, Greg KH пишет:
> > > > What caused this change/regression?
> > > I have absolutely no idea.
> > > I've found it by debugging userspace,
> > > and wrote a test-case to make sure the
> > > problem is not in user-space.
> > So this has always worked this way?  Or has it changed?  If changed,
> > when did it work before?
> 
> OK, I did some extensive digging, and
> now am pretty sure its this one:
> 
> commit 1b8b20868a6d64cfe8174a21b25b74367bdf0560
> Author:     Johan Hovold <johan@kernel.org>
> AuthorDate: Wed Apr 7 11:52:02 2021 +0200
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Sat Apr 10 10:36:34 2021 +0200
> 
>     tty: fix return value for unsupported ioctls
> 
>     Drivers should return -ENOTTY ("Inappropriate I/O control operation")
>     when an ioctl isn't supported, while -EINVAL is used for invalid
>     arguments.
> 
> > > >     And does any real-world programs
> > > > rely on this?
> > > dosemu
> > It does this today or wants to do this in the future?
> 
> It does so since 2003/03/15, according
> to a change-log (so for 21 year now).
> Adding Herbert Xu to CC as an author of
> that feature.
> 
> > > >     What exactly are you trying to determine with this ioctl
> > > > test?
> > > Whether it is a PTS (Pseudo-Tty-Slave), or
> > > a real comport with MSR signalling.
> > Why is that needed?
> 
> To fake modem status lines, mustly DCD.
> 
> 
> >    And why not do it how other programs (like stty)
> > does it?
> 
> I am not sure stty is interested in faking
> modem status lines. It doesn't seem to be
> using TIOCM ioctls at all.
> 
> > > >     Is there a different way to determine that?
> > > I am not aware of any "canonical" way
> > > of determining this. Maybe you tell me. :)
> > > So far the only fix I know, is to stop checking
> > > errno. But you return ENOTTY for a tty-associated
> > > fd (isatty(fd)==1), so I believe this is a
> > > bug in a kernel.
> > isatty() is a libc provided function, not a kernel call.
> It seems to be using TCGETS ioctl() and looks
> for it to not return an error.
> I still think returning ENOTTY where TCGETS
> succeeds, is more than strange.
> I looked at the tty code of current linux kernel,
> and it returns EOPNOTSUPP in most such cases.
> At least that makes sense, but ENOTTY?

-ENOTTY is the documented result of invalid ioctl arguments sent, I am
pretty sure POSIX requires this somewhere.  So this was fixing a
requirement here...

thanks,

greg k-h
