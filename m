Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85895211A29;
	Fri, 10 Jan 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520737; cv=none; b=BeOq5Ly4nu1+IZSiScRUuU0C/mqpiK4YPCMA3UcxUG6le7v5XBJNup+0mDcN6/b3jkE/pyH60O/FrTbOMLZWiZkadUjPbjAecqh4e4u/5B5M/qkez6UwrI+0mNzVGuGY0QVas/XKx27eGE3RSHoTgGs/nAAq59jwEmaLjq1gJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520737; c=relaxed/simple;
	bh=URJ2fRADpNRuL7RvgTxc+uDlaIBrVK0rpommc9vPHNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQACtvKv2dcxBc8hLUYkTvbC2GGL3lDmgouTenCGQm3NvZcw0SaeP8gxn2g9OjKzSAPF8r1AIQCtK/htJMJM5Sc4QabgsbjncuGb0gIO2qP7rgdoelX1kjE78iU0dgLeaxsDfT+KX0FM6ixZFB1UDAqT2lLfBUsXkK7RjwRxwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ok/lapAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ok/lapAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ECFC4CED6;
	Fri, 10 Jan 2025 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736520737;
	bh=URJ2fRADpNRuL7RvgTxc+uDlaIBrVK0rpommc9vPHNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ok/lapACcjQEGnwQFLombornoN/cqsa/x75E88UkF2hPx9eyNil7Jxzj6r968xFuc
	 USw6hCmh3+cMkywv5kSB4JUjxDX0qNqSIyajVjYpXPRuQ0HcNmETJD3AL3SSRevpf7
	 /1dxEG9+RdjIkB+ijr8YcRO7kfJFiU4/SXSmHWBc=
Date: Fri, 10 Jan 2025 15:52:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gil Pedersen <gpdev@gpost.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/1] tty: respond to TIOCGWINSZ when hung
Message-ID: <2025011041-refocus-operator-f48e@gregkh>
References: <20241121111506.4717-1-gpdev@gpost.dk>
 <20241121111506.4717-2-gpdev@gpost.dk>
 <2024122329-jockey-delouse-71a7@gregkh>
 <110BE776-AA74-4DDC-87F1-453B164D25D2@gpost.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110BE776-AA74-4DDC-87F1-453B164D25D2@gpost.dk>

On Tue, Jan 07, 2025 at 12:44:28PM +0100, Gil Pedersen wrote:
> > On 23 Dec 2024, at 18.56, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, Nov 21, 2024 at 12:12:54PM +0100, Gil Pedersen wrote:
> >> Userspace libc implementations of the isatty() POSIX system interface
> >> are currently unable to reliably determine if a fd is really a tty when
> >> it is hung.
> >> 
> >> Specifically glibc libc returns the success status of a TCGETS ioctl.
> >> This will return an incorrect result when the TTY is hung, since an EIO
> >> is unconditionally returned. Ie. an isatty() will return 0, wrongly
> >> indicating that something that definitely is a TTY, is not a TTY.
> >> 
> >> Userspace implementations could potentially remap EIO errors to a
> >> success to work around this. This will likely work in 99.99% of cases,
> >> but there is no guarantee that a TCGETS ioctl on a non-TTY fd will not
> >> also return EIO, making the isatty() call return a false positive!
> >> 
> >> This commit enables a specific non-driver, non-ldisc, ioctl to continue
> >> working after the TTY is hung. The TIOCGWINSZ ioctl was chosen since it
> >> is readonly, and only access tty_struct.winsize (and its mutex), and is
> >> already used for the isatty() implementation in musl. The glibc
> >> implementation will need to be updated to use the TIOCGWINSZ ioctl,
> >> either as a direct replacement, or more conservatively, as a fallback
> >> test when the TCGETS ioctl fails with EIO.
> > 
> > This is a fun "hack", yes, but now you are encoding an odd "side affect"
> > into the system that everyone is going to rely on, well, eventually rely
> > on.  What code needs to be changed in userspace to determine this?
> 
> The patch can definitely be considered a hack, but viewed with another
> lens: a bugfix.

All hacks could be viewed that way :)

> There is no specific reason that the call should return an EIO on hung
> terminals, so making it always return the current value could be
> considered more correct. POSIX tcgetwinsize(), which this ioctl maps
> to, does not consider hung terminals, and expects it to return suitable
> values whenever possible.

There's no specific reason, but we are stuck with what we have today as
that is how things work.  I'm more worried about making this change and
then nothing ever changes in userspace.  And userspace would never
"know" if it could or could not rely on this change, as some
necro-enterprise-systems never update their kernel.

> Userspace implementations will have to reconsider their handling of an
> EIO error, as the isatty() call could still return an EIO if calling
> into a non-TTY device. Unconditionally mapping it to a success, like
> isatty_safe() in systemd, would be an error. Supporting both versions
> would require a runtime check to determine which variant is used, where
> the legacy version would accept the risk of a "wrong" EIO, while the
> new version would treat it as a proper error.

How would such a runtime check work?  Do you have working patches for
existing userspace programs that want to know this that shows how this
all works?

We can't take api changes without a working userspace user, you know
that...

> > Why not just have a new ioctl that tells you if the tty really is hung
> > or not?  Why does isatty() need to know this, does POSIX require it?
> > And if it does, what does it say the ioctl command should be?
> 
> isatty() should not need to know if the TTY is hung, and besides cannot
> safely call any ioctl to check this before it knows that it is indeed a
> TTY. POSIX does not seem to include the concept of hung terminals.
> 
> A case could be made for introducing a new ioctl though, but it would
> need a more generic approach, like the BSD FIODTYPE ioctl that exposes
> a d_type property on chardev & block driver interfaces. If implemented
> before calling into the VFS layer, it could make the isatty() call 100%
> safe (on kernels that support the ioctl). Additionally, this would mean
> that it can never return EIO, which makes userspace adaptions simpler,
> since it can know that any returned EIO means that it is running on an
> unpatched/legacy kernel and/or libc.

Yes, that's why I suggested a new ioctl.

thanks,

greg k-h
