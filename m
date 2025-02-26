Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B626E62F;
	Wed, 26 Feb 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565857; cv=none; b=ingjci+aW9OflOfwlgBxEc5/tAwbLIaxKamgay9eWxiz1WRtNYsqtsAYMoSxZzpuANgc5UldnXvNmIFTpv0JOXR3kCxqf7fWJUBGNZ3ND65qOULbjlf+uIghUDlUmBq9ikZt7aS1Ix62nRCaMjt+Kvyx1b/OogGTCkyOG0dimf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565857; c=relaxed/simple;
	bh=1ZAHdC2Y37gCh7qOM6vyURJ2MhLryVz7qduf3r/k/0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbfgyfbVkPOeV6wlD6WT6rKc4IYmRQRVL+NdvPs23wpLIPaYvdYinpL1EtE2AKm1+Pd2MQlx2r82Ef/0WU+vu/GSD1r2H6v3JGplWBW4RhYenAFZXpC1YbAyEuk9xn+EmU5+jJrX/rcLaM0v7ePxZxokT+rqs8XO8XLm4ryBNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oY2I4BNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oY2I4BNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A719C4CEE7;
	Wed, 26 Feb 2025 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740565856;
	bh=1ZAHdC2Y37gCh7qOM6vyURJ2MhLryVz7qduf3r/k/0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY2I4BNZuDBzdFwgQrPjbspkyxIuDk4kYfb2otT23dIGypfYvDeB5R8ErYRuNi9+f
	 w9uAGh8kPUfflns7um67MZTXzpZxDndjXZCNPlQ5hmL9wP6xINtSrcl2jHxZzIGAAK
	 E9pdVzJGbSsRueCVmvC+5y7oZt6D1M985n49v/tA=
Date: Wed, 26 Feb 2025 11:09:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <2025022652-uptown-cheating-5df8@gregkh>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
 <Z73sqvjlbJ54FCtH@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73sqvjlbJ54FCtH@MAC.fritz.box>

On Tue, Feb 25, 2025 at 04:15:38PM +0000, Alan Mackenzie wrote:
> Hello, Jiri.
> 
> On Mon, Feb 24, 2025 at 21:08:50 +0100, Jiri Slaby wrote:
> > On 24. 02. 25, 19:22, Alan Mackenzie wrote:
> > > Hello, Greg.
> 
> > > On Sun, Feb 23, 2025 at 08:47:53 +0100, Greg Kroah-Hartman wrote:
> > >> On Sat, Feb 22, 2025 at 03:36:12PM +0000, Alan Mackenzie wrote:
> > >>> On Sat, Feb 22, 2025 at 09:48:32 +0100, Greg Kroah-Hartman wrote:
> 
> > > [ .... ]
> 
> > >>> But I think you are also asking why I use the console at all.  That's
> > >>> a fair question which I'll try to answer.
> 
> > >> I'm not disputing using the console, it's the vt layer that I'm talking
> > >> about.  The DRM developers have the long-term goal of getting rid of
> > >> CONFIG_VT which will remove a ton of mess that we have overall.
> > >> DRM-based consoles should provide the same functionality that a vt
> > >> console does today.  If not, please let them know so that the remaining
> > >> corner cases can be resolved.
> 
> > > Does a DRM based console exist at the moment?  I spent quite some time
> > > looking for it yesterday, but found nothing.
> 
> > I didn't read the thread, but are you looking e.g. for kmscon?
> 
> No, I wasn't.  I was looking for a drm replacement for the drivers/tty/vt
> code inside the kernel.  I may have misunderstood Greg when he referred
> to a replacement which uses drm.

No, this is what I was referring to.  Also maybe we should be asking on
the drm list?  The developers there were working to get rid of CONFIG_VT
so I know they have plans for what they see replacing it.

> kmscon doesn't seem to be a suitable replacement for the Linux console.
> According to Wikipedia, it stopped being maintained ~10 years ago.  Also,
> it is a user level program, not a kernel level program, so will only become
> active later in the boot process than the current console, which is not
> a good thing.  It might well steal key sequences from application
> programs, the way X and X window managers do, but maybe it doesn't.  On
> Gentoo, kmscon is "masked", i.e. strongly recommended not to be
> installed, and installable only after taking special measures.

Yes, it will be "after" the boot console, but that should be it.  It
shouldn't be stealing any keys away from anything, but rather going
through the existing apis we have for input devices and the like.

I don't know why distros seem to not be using it anymore, maybe there's
something else?

thanks,

greg k-h
