Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911111C84C8;
	Sun, 23 Feb 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740296941; cv=none; b=EycQd+IF6+NH2su+3NZFiMLekR61bgDFERCwBvLUMhTxBeWaXyvMf6TLiO5CxIFk1E7mmn33PLn3tHDZS9c+SQgE7OBetjGXKBFrQulbI4ceK4kO0jQDRjHLVxsbtFGp6SbgXcigpTirEo8TrB+X8Ct9Z0rfRjVROVAOPZtC3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740296941; c=relaxed/simple;
	bh=oh6jgBwwtm4YNGGIi9b84EMsEmefhagDFlrCVogIp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=johvT78xR8njw6mG+jvdTSBm2PBcxjK+UIUhRBw+KZVVqaQ3iqa8hz+YdTIXS6Nl/bIYthh+k/uI3ds0angBf/MH1HR83546B6vc9wmaUt0P5UJTAAfqXXaiRJgwiXmYPNb6yIScJF5krWoVrifmoa8feQzA20bukhZLa0YYmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLNHyCsU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLNHyCsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A942AC4CEDD;
	Sun, 23 Feb 2025 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740296941;
	bh=oh6jgBwwtm4YNGGIi9b84EMsEmefhagDFlrCVogIp4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLNHyCsUWY87YRpgIEN81f28kFXfexrhYNerBiIMs/oR9vXhX1kY88aHAwnaXrRmX
	 0fatG+Ij5o88hkkgyu5qNx7cB53W2p7gid1Tk6L98Q8AWqUlgHUbjAuewL8bhdZGmN
	 7JoPPJyKVEkt5iE1pC8Ba7kQtO3Z2lludTvt66Xc=
Date: Sun, 23 Feb 2025 08:47:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <2025022355-peroxide-defacing-4fa4@gregkh>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7nu7HqKn4o2rMd5@MAC.fritz.box>

On Sat, Feb 22, 2025 at 03:36:12PM +0000, Alan Mackenzie wrote:
> On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 21, 2025 at 03:35:59PM +0000, Alan Mackenzie wrote:
> > > The Linux console is currently restricted to 256/512 glyphs, the VGA
> > > standard from the 1980s.  I would like that restriction to be lifted, and
> > > believe that many other console users would agree.
> 
> > First off, why?
> 
> I use the console as my primary means of interacting with my PC, and in
> recent years have become increasingly irritated by the appearance of
> Ufffd in place of, for example, eastern European characters in people's
> names.  I've often wished "somebody" would fix this.  In the end, that
> somebody had to be me.
> 
> But I think you are also asking why I use the console at all.  That's a
> fair question which I'll try to answer.

I'm not disputing using the console, it's the vt layer that I'm talking
about.  The DRM developers have the long-term goal of getting rid of
CONFIG_VT which will remove a ton of mess that we have overall.
DRM-based consoles should provide the same functionality that a vt
console does today.  If not, please let them know so that the remaining
corner cases can be resolved.

> For pure text work (such as hacking code, reading emails), the main
> alternative is a GUI such as X-Windows (or Wayland).  These insert
> several layers of "fat" between the user and the "muscle" of the kernel.

No, no need for x or wayland there from what I recall.

And there is not really any "fat" there, sorry, it's a way to give you
all of those glyph and input systems and functionality that you need.
That wasn't added for no good reason.

> > What about the move to get rid of the vt code entirely, ....
> 
> Getting rid of the vt code would be a Bad Thing.  People depend on it.
> What is the alternative?

The drm console layer.

> > .... if you do that, can't you get proper glyphs with the drm
> > subsystem?
> 
> I don't know.  I've looked briefly at fbterm, a terminal which uses drm.
> It steals key sequences too, some of which are needed in Emacs.
> Although not as bad as GUIs, it puts awkward layers between the user and
> Linux too.

I don't know what fbterm is, sorry.

> I think using drm in place of fbterm.c and bitblit.c would need a lot of
> design and implementation work.  The change I'm proposing barely changes
> the design at all.

Ok, but we haven't seen the patches to know this :)

> > Doing huge changes for a subsystem that almost everyone agrees should
> > only be kept around for legacy reasons is a rough undertaking.
> 
> Isn't there a principle in Linux that preserving existing user
> interfaces is of utmost importance?

I agree, keeping the existing ones is key.  You are talking about
extending the existing ones in a way that adds additional complexity
when there might already be a solution for this for you.  That's why I
brought that up.

> As I've already written, I've got working code, but it needs refinement
> before I submit it.  Otherwise reviewers would likely reject it for
> "inessential" reasons like code formatting.  This will likely take me
> several days.

code formatting is NOT "inessential", please never think that.  Our
brains run on patterns and common code formatting allows us to see the
real issues here.  To not follow those formatting rules means we just
can't review your code properly.

Reviewing is harder than writing code, so you have to write the code to
make reviewing easier if you wish to have anything accepted as you have
to convince everyone else that your changes are correct.

> What is the best way of submitting such a large patch (~3,500 lines)?  I
> committed it to my own local git repository in three main stages (around
> equal size), and have applied corrections after rebasing and the odd bug
> fix.

Break down the changes into "one logical change per patch" to make them
easy to review.  It's an art form, think about how you want to get to
your end result and then take us on a path that is "obvious" to get
there over a series of changes.

Think of it as "showing your work" when solving a math or physics
problem that your teacher told you to follow.  No one wants to just see
the end result, they have to see all the steps along the way to even
begin to understand if the end result is correct or not.

But again, before doing that work, see how using the drm console works
for you, or not.  If not, let us and the drm developers know so that we
can work toward solving those issues, as that might actually be easier
to do.

thanks,

greg k-h
