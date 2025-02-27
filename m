Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3C1662EF
	for <linux-serial@vger.kernel.org>; Thu, 27 Feb 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661527; cv=none; b=tca4HS52lLbHYac+AGlZiWxnQRzWSNmBjunrj5/vSmmEEMuecEKkAkfvJhYFn0Vu8H2o/ih2KcQPifM6gFHLKVUyDJz5XXLZJ/NjH5eleNRjuwbj4DZL/ZQjCe0l961+BJTlDnXx3HiuLcbNFVb1Jg4fxbou9jeLOzsg3loJ1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661527; c=relaxed/simple;
	bh=yMjWERQO7tb9dKxz8yG/jWDz2IVS11vV3vvewjuaCIs=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=s+TX3vqVlEaQOxX4I2g2QbC5uylsbC5+P9rf6Nqj6Klliq/VJlVLvpZtj7UElPTVQB7inyy2bIadRjRk1xXFICfUawaFBRqWBk6jDkqFH4BxQ+gYsYNTDS9+dOhnZSZguf56Gabr31R6vkgfYnjkFTyXSU6HXHXTtTfZN1na5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 52939 invoked by uid 3782); 27 Feb 2025 14:05:16 +0100
Received: from muc.de (pd953af25.dip0.t-ipconnect.de [217.83.175.37]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Feb 2025 14:05:15 +0100
Received: (qmail 6065 invoked by uid 1000); 27 Feb 2025 13:05:15 -0000
Date: Thu, 27 Feb 2025 13:05:15 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <Z8BjC_TzuDVaFC_3@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
 <Z73sqvjlbJ54FCtH@MAC.fritz.box>
 <2025022652-uptown-cheating-5df8@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022652-uptown-cheating-5df8@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, Greg.

On Wed, Feb 26, 2025 at 11:09:57 +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 25, 2025 at 04:15:38PM +0000, Alan Mackenzie wrote:
> > On Mon, Feb 24, 2025 at 21:08:50 +0100, Jiri Slaby wrote:

[ .... ]

> > > I didn't read the thread, but are you looking e.g. for kmscon?

> > No, I wasn't.  I was looking for a drm replacement for the drivers/tty/vt
> > code inside the kernel.  I may have misunderstood Greg when he referred
> > to a replacement which uses drm.

> No, this is what I was referring to.  Also maybe we should be asking on
> the drm list?  The developers there were working to get rid of CONFIG_VT
> so I know they have plans for what they see replacing it.

Which list would that be?  There are over 100 occurrences of "DRM" in the
file MAINTAINERS.  I am also interested in this.  There is a very great
deal of functionality in drivers/tty/vt.  It will be quite a task to
replace it.

> > kmscon doesn't seem to be a suitable replacement for the Linux console.
> > According to Wikipedia, it stopped being maintained ~10 years ago.  Also,
> > it is a user level program, not a kernel level program, so will only become
> > active later in the boot process than the current console, which is not
> > a good thing.  It might well steal key sequences from application
> > programs, the way X and X window managers do, but maybe it doesn't.  On
> > Gentoo, kmscon is "masked", i.e. strongly recommended not to be
> > installed, and installable only after taking special measures.

> Yes, it will be "after" the boot console, but that should be it.

What would the boot console be?  Some console needs to be in place early
enough to be able to display "Kernel panic - unable to mount the root
partition".

> It shouldn't be stealing any keys away from anything, but rather going
> through the existing apis we have for input devices and the like.

Agreed.

> I don't know why distros seem to not be using it anymore, maybe there's
> something else?

Jiri pointed to some problems yesterday from his point of view as a SuSE
maintainer.  Perhaps kmscon just needs bringing back into maintenance.  I
haven't actually looked at it yet.

> thanks,

By the way, I'll be away from my email for a few days, so won't be able
to answer any posts in that time.

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).
