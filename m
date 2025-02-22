Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DE3224
	for <linux-serial@vger.kernel.org>; Sat, 22 Feb 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238585; cv=none; b=FnieifngDBubVX21R433K5XfN9NrfOWSiUobbevXarjTidvAlM4ZObyZSCbhM/QsbLkpijGTbbv1tyvMRyQeXOqWDm+eexsoDfqgyzCvbXlpGJVkQsJ/KhHGGHhHmOVzeqzZBpJGBSb6/BkNO2DwthPFn3D5uJzhf/EQGe9hTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238585; c=relaxed/simple;
	bh=q0sYhvG6QRBlTbAt5UtgA6djZsVa50a/93MMrD9O110=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=e/r0oK7YzFJQM0yaJtFrUg6H+eHTAygJt2FvNCsxuf1ctRlR5nw9KdMLtyjaWL7ChSGI87eO19G6jX4x5jFsTRPklpXOcOhv7AeCR/q6mMOHGALhaB5pbj1ZMsZ7nEZayjAKKP2B/Ufai+WequJvl/7llTlQwNbUliRxWp//Qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 28440 invoked by uid 3782); 22 Feb 2025 16:36:13 +0100
Received: from muc.de (pd953a520.dip0.t-ipconnect.de [217.83.165.32]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Sat, 22 Feb 2025 16:36:12 +0100
Received: (qmail 10943 invoked by uid 1000); 22 Feb 2025 15:36:12 -0000
Date: Sat, 22 Feb 2025 15:36:12 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022243-street-joylessly-6dfa@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, Greg.

Thanks for the reply.

On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 21, 2025 at 03:35:59PM +0000, Alan Mackenzie wrote:

> > Dear Linux Maintainers,

> > The Linux console is currently restricted to 256/512 glyphs, the VGA
> > standard from the 1980s.  I would like that restriction to be lifted, and
> > believe that many other console users would agree.

> First off, why?

I use the console as my primary means of interacting with my PC, and in
recent years have become increasingly irritated by the appearance of
Ufffd in place of, for example, eastern European characters in people's
names.  I've often wished "somebody" would fix this.  In the end, that
somebody had to be me.

But I think you are also asking why I use the console at all.  That's a
fair question which I'll try to answer.

For pure text work (such as hacking code, reading emails), the main
alternative is a GUI such as X-Windows (or Wayland).  These insert
several layers of "fat" between the user and the "muscle" of the kernel.

Like many drivers of modern cars, who would dearly love to get rid of
electronic this and that, electric mirror adjustment, electric window
opening and so on, I need a simple uncluttered environment.  I want to
drive a speedboat, not a luxury yacht.

All the features of GUI systems take up space on the screen, thus
reducing the space available for the user's work.  All these systems
"steal" key sequences from application programs, making them less
useful.  For example <alt>-<tab> is a useful key sequence in Emacs,
provided it is running on the console.  In text work, I have absolutely
no use for scroll bars, menus, window decorations, and the like - they
just get in the way.

The console is a stable interface.  My use of it has barely changed in
around 25 years.  By contrast, GUI environments are continually
changing, forcing users to spend time learning new features and
(arbitrarily) changed existing features.  I don't like this.

The console is also rock-solid reliable - just as other parts of the
kernel are.  X-Windows, for example is not so reliable.  Back in
December, the root partition on my new Gentoo system became full.  This
prevented X from even starting.  With the console (and a rescue CD) I
was able to recover the situation.

> What about the move to get rid of the vt code entirely, ....

Getting rid of the vt code would be a Bad Thing.  People depend on it.
What is the alternative?

> .... if you do that, can't you get proper glyphs with the drm
> subsystem?

I don't know.  I've looked briefly at fbterm, a terminal which uses drm.
It steals key sequences too, some of which are needed in Emacs.
Although not as bad as GUIs, it puts awkward layers between the user and
Linux too.

I think using drm in place of fbterm.c and bitblit.c would need a lot of
design and implementation work.  The change I'm proposing barely changes
the design at all.

> Doing huge changes for a subsystem that almost everyone agrees should
> only be kept around for legacy reasons is a rough undertaking.

Isn't there a principle in Linux that preserving existing user
interfaces is of utmost importance?

> <snip>

> > I would very much like further to develop and to refine this code to the
> > point where it is suitable for inclusion in the mainline kernel.  What do
> > you say?

> Only you can decide what you want to work on.  If you have working
> patches, and submit them so that they can be reviewed, we'll be glad to
> do so.

As I've already written, I've got working code, but it needs refinement
before I submit it.  Otherwise reviewers would likely reject it for
"inessential" reasons like code formatting.  This will likely take me
several days.

What is the best way of submitting such a large patch (~3,500 lines)?  I
committed it to my own local git repository in three main stages (around
equal size), and have applied corrections after rebasing and the odd bug
fix.

> But again, you are going to have to answer the reason "why" first.

I hope this email goes some way towards this.

> thanks,

> greg k-h

Thank you too!

-- 
Alan Mackenzie (Nuremberg, Germany).
