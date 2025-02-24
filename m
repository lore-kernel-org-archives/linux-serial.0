Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE56198A38
	for <linux-serial@vger.kernel.org>; Mon, 24 Feb 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421333; cv=none; b=d+79mb6KvCIADwyE2C0ViMjbIuwOHVK6qoqFtVCfgmrjN8L0scsQzDfceOSJp9mWORHqHah7CqnHHrUnQOyrlGUNSRvxcC8bljYjvunzwHqvnmb5L9mu6+Pzj+2PX9EabGB75vtX1btCZGmyNojncmY1iDRfWDjhAWN1/82WLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421333; c=relaxed/simple;
	bh=LapUr4uhDE8WT47s1iRnSBv3OPnVfs++Nynyc7QEa20=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=IRcpz+HMIbGb2juAwwfHJT5IgKZ0vGrBRG6dqMOo6xbn3qjIeAjY+IDH6Of8rlRfMG85H40tm0n8zy4lmHA4kSgqdEr4lgcJGFVpwOrog4noZ9WyCYJOjaSSb462RHMMY94Hy+0O3P9mATDrt3NWDNRd0HFc4iOAQRS0If8er1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 76695 invoked by uid 3782); 24 Feb 2025 19:22:01 +0100
Received: from muc.de (p4fe15466.dip0.t-ipconnect.de [79.225.84.102]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Mon, 24 Feb 2025 19:22:00 +0100
Received: (qmail 19105 invoked by uid 1000); 24 Feb 2025 18:22:00 -0000
Date: Mon, 24 Feb 2025 18:22:00 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022355-peroxide-defacing-4fa4@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, Greg.

On Sun, Feb 23, 2025 at 08:47:53 +0100, Greg Kroah-Hartman wrote:
> On Sat, Feb 22, 2025 at 03:36:12PM +0000, Alan Mackenzie wrote:
> > On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:

[ .... ]

> > But I think you are also asking why I use the console at all.  That's
> > a fair question which I'll try to answer.

> I'm not disputing using the console, it's the vt layer that I'm talking
> about.  The DRM developers have the long-term goal of getting rid of
> CONFIG_VT which will remove a ton of mess that we have overall.
> DRM-based consoles should provide the same functionality that a vt
> console does today.  If not, please let them know so that the remaining
> corner cases can be resolved.

Does a DRM based console exist at the moment?  I spent quite some time
looking for it yesterday, but found nothing.

[ .... ]

> > > What about the move to get rid of the vt code entirely, ....

> > Getting rid of the vt code would be a Bad Thing.  People depend on it.
> > What is the alternative?

> The drm console layer.

Again, does it exist yet, or alternatively are there plans to introduce
it into the kernel in the near future?

> > > .... if you do that, can't you get proper glyphs with the drm
> > > subsystem?

> > I don't know.  I've looked briefly at fbterm, a terminal which uses drm.
> > It steals key sequences too, some of which are needed in Emacs.
> > Although not as bad as GUIs, it puts awkward layers between the user and
> > Linux too.

> I don't know what fbterm is, sorry.

It's a user level terminal emulator for the framebuffer.  It's not
important.

> > I think using drm in place of fbterm.c and bitblit.c would need a lot of
> > design and implementation work.  The change I'm proposing barely changes
> > the design at all.

> Ok, but we haven't seen the patches to know this :)

> > > Doing huge changes for a subsystem that almost everyone agrees should
> > > only be kept around for legacy reasons is a rough undertaking.

> > Isn't there a principle in Linux that preserving existing user
> > interfaces is of utmost importance?

> I agree, keeping the existing ones is key.  You are talking about
> extending the existing ones in a way that adds additional complexity
> when there might already be a solution for this for you.  That's why I
> brought that up.

Where/how can I find the DRM console?

> > As I've already written, I've got working code, but it needs refinement
> > before I submit it.  Otherwise reviewers would likely reject it for
> > "inessential" reasons like code formatting.  This will likely take me
> > several days.

> code formatting is NOT "inessential", please never think that.

However necessary code formatting is (and it is necessary), it doesn't
form part of the essence of the changes.  I'm sure we're agreed that
proposed changes are best judged by that essence.  That was all I meant.

> Our brains run on patterns and common code formatting allows us to see
> the real issues here.  To not follow those formatting rules means we
> just can't review your code properly.

I understand.

[ .... ]

> > What is the best way of submitting such a large patch (~3,500 lines)?
> > I committed it to my own local git repository in three main stages
> > (around equal size), and have applied corrections after rebasing and
> > the odd bug fix.

> Break down the changes into "one logical change per patch" to make them
> easy to review.  It's an art form, think about how you want to get to
> your end result and then take us on a path that is "obvious" to get
> there over a series of changes.

> Think of it as "showing your work" when solving a math or physics
> problem that your teacher told you to follow.  No one wants to just see
> the end result, they have to see all the steps along the way to even
> begin to understand if the end result is correct or not.

Thanks.  I have a fair amount of work to do to achieve this.

> But again, before doing that work, see how using the drm console works
> for you, or not.  If not, let us and the drm developers know so that we
> can work toward solving those issues, as that might actually be easier
> to do.

I would actually appreciate the work I've done being superfluous.  ;-)
But where can I find the drm console?

> thanks,

> greg k-h

And thank you, too.

-- 
Alan Mackenzie (Nuremberg, Germany).
