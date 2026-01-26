Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A823B63F;
	Mon, 26 Jan 2026 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438191; cv=none; b=AOcYhwcEpIP/IoW+cx+e8JuHFDK0KoX1bHyF6xzse1ASStSOh4xFvwtXdEjY42Wy3Su4hdhDQ1SH5c29b9zs3TWanwGbRT9IBchzb1cugRDN7yzLo0MaFnd5GLYfWPpxB29p8Jd9WlBxmW1ky9IxOvfj4GRVFE02ytjca8za1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438191; c=relaxed/simple;
	bh=9d8llw0uisQATLN984HzQztTU/gHMb5mWhXIhwAIi6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhlFUrCDEBC791styeoymilVJEQEn4s/Bgrje4DqrJFJoJ1Go4sirF1yVuUWW3+3CHvg/yI1N845LCYiQ69HAYiCguN7E1WqaBRWizFXcMe5loPV2GiOFkPcx4V2KozFHvLRBzCHzwBw1DzCBJLOOj3np62rmhgjma7VbNzgzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TvO4miA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TvO4miA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A91C116C6;
	Mon, 26 Jan 2026 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769438190;
	bh=9d8llw0uisQATLN984HzQztTU/gHMb5mWhXIhwAIi6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1TvO4miAKvUg563ZDwEarVpHx9VbqXzIOpTgAqZQtRy12Fk75XRrFca+ydGqzqIHZ
	 89eDKcuK3i4YJX71L61RPQ6h2c8b4+EIg1Vbagi2e73ZtUazAjqNZjtpLB4jgw67TE
	 /LRBlGjztHgeUUhQ8mfJ9matrjjrb4qJpP4apdgE=
Date: Mon, 26 Jan 2026 15:36:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012620-retool-gloater-6cd3@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
 <2026012648-vantage-mummified-2a43@gregkh>
 <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>
 <2026012642-threefold-atypical-a3ad@gregkh>
 <99371939-e9b2-4114-8e27-e605ebf941de@redhat.com>
 <2026012653-designer-capably-d575@gregkh>
 <286bfe2e-796e-4c71-a75c-4967450edaab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286bfe2e-796e-4c71-a75c-4967450edaab@redhat.com>

On Mon, Jan 26, 2026 at 02:05:36PM +0100, Jocelyn Falempe wrote:
> On 26/01/2026 13:46, Greg Kroah-Hartman wrote:
> > On Mon, Jan 26, 2026 at 01:26:34PM +0100, Jocelyn Falempe wrote:
> > > On 26/01/2026 11:59, Greg Kroah-Hartman wrote:
> > > > On Mon, Jan 26, 2026 at 11:48:50AM +0100, Jocelyn Falempe wrote:
> > > > > On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
> > > > > > > On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> > > > > > > > On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> > > > > > > > > This allows to build the kernel with CONFIG_VT enabled, and choose
> > > > > > > > > on the kernel command line to enable it or not.
> > > > > > > > 
> > > > > > > > This says what is happening, but not why?
> > > > > > > > 
> > > > > > > > > Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> > > > > > > > 
> > > > > > > > Why are we using a 1990's technology for a new feature?  What is this
> > > > > > > > going to allow to have happen?  Who needs/wants this?  Who will use it?
> > > > > > > > For what?
> > > > > > > 
> > > > > > > The goal is to ease the transition to disable CONFIG_VT.
> > > > > > > 
> > > > > > > So if this is merged, you can boot without VT on any Linux distribution,
> > > > > > > without rebuilding the kernel.
> > > > > > 
> > > > > > But that's a distro-specific thing, the distro should be enabling or
> > > > > > disabling the option as it needs, it should not be a user-configurable
> > > > > > boot-time selection option as userspace depends entirely on this either
> > > > > > being there or not.  Why would you have a kernel with both options but
> > > > > > userspace without that?
> > > > > 
> > > > > Actually the userspace side works with or without VT, at least with Fedora,
> > > > > I've my Gnome session in both cases.
> > > > 
> > > > Great!  Then why is this even needed?  Who wants such a "let's not make
> > > > up our mind until we boot" type of system?
> > > > 
> > > > Given that traditionally the command line is a "secure" thing, that is
> > > > locked down by distros and orginizations, who would ever be able to be
> > > > changing this type of thing?  Who would want to support userspace that
> > > > handles both at the same time?
> > > > 
> > > > I don't see the issue here, if a distro doesn't want to support VT, then
> > > > disable it in the kernel and all is good.  If they do want to support
> > > > it, than enable it.  Don't do both :)
> > > 
> > > Maybe the real issue is that VT cannot be built as a module.
> > > That way the userspace would be able to load it only if it needs it.
> > > 
> > > That's probably more complex than my 3 lines patch, but I can try.
> > > Would you prefer it that way?
> > 
> > If that would make it simpler for a distro to handle this, perhaps.  Try
> > it and see, I think the last time this came up, unwinding this into a
> > module just wasn't possible, but that might have been a long time ago, I
> > can't recall.
> > 
> > But again, why wouldn't a distro pick a "this is what we are going to
> > support" line and stick with it?  Why would they want to support both?
> > 
> 
> It's all about the transition. Talks about VT-less system started in 2012,
> but since then no major desktop Linux distribution have done it.

Then perhaps it's not really ever going to happen if no one actually
does the work and wants their distro to change to not have it.

> I think that one of the reason, is that if you switch off VT, of course some
> users will complain, as it has a lot of implications.

Again, that's a distro's policy decision to make, don't force the kernel
to support a wishy-washy distro's decision :)

> Telling them to go rebuild their kernel is not good.

Agreed, this is a policy decision a distro needs to make.

> Telling them to run
> grubby to change the kernel command line until they find alternative for
> their use case is better. They can experiment and do the switch when they
> are ready.
> Really it's nothing more than that.

Again, policy decision that a distro needs to make.

> I don't think a distribution will want to maintain VT and noVT for a long
> time.

Please define "long time" given that no distro has even done this yet?

thanks,

greg k-h
