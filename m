Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6A1F8BCC
	for <linux-serial@vger.kernel.org>; Tue,  4 Mar 2025 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120268; cv=none; b=i3RzWSKspxdTfftZPqw5ITZLcule6v6Ctj0vTbSIlJW0cks/lADMh0Pgsd9qn4BMGOw4ba4a90Mqk0tNCyXkkE+IwcphS9cQGw+GRSBZslYuJBGsSGoNHYv7DCOyAXEzyPnNxQteH3mxlDa12fm3jlfj/U0IbruxnpVBJhbeTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120268; c=relaxed/simple;
	bh=mzdC7fkkCvMgbcc9+AFuPPSV2MdSt3HX1JwBHsD4cP8=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=mlpweQLYewufRkBwTVwf4NacDznECQvzNwoCh7V2ABzzh88XX/upBTqNOo83S8IAzPaLxNwesYaiV3fXc3hejTS2HxjsxjW1HxWtU/7YYITof8I8LTi66kzgdgRFIZejNqbelbbhXB9CsL1GrGMu/wJ5n0XyEpLlZ5geRXRZZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 5333 invoked by uid 3782); 4 Mar 2025 21:30:57 +0100
Received: from muc.de (pd953a22b.dip0.t-ipconnect.de [217.83.162.43]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Tue, 04 Mar 2025 21:30:56 +0100
Received: (qmail 12384 invoked by uid 1000); 4 Mar 2025 20:30:56 -0000
Date: Tue, 4 Mar 2025 20:30:56 +0000
To: dri-devel@lists.freedesktop.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <Z8djAD5WgpyPTnpa@MAC.fritz.box>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
 <Z73sqvjlbJ54FCtH@MAC.fritz.box>
 <2025022652-uptown-cheating-5df8@gregkh>
 <Z8BjC_TzuDVaFC_3@MAC.fritz.box>
 <2025022802-monitor-moneyless-0f84@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022802-monitor-moneyless-0f84@gregkh>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello, dri-devel.

The context of the following post is a thread on Linux kernel lists where
I am proposing to extend the Linux console to handle more than 256/512
distinct glyphs.

On Fri, Feb 28, 2025 at 20:24:33 -0800, Greg Kroah-Hartman wrote:
> On Thu, Feb 27, 2025 at 01:05:15PM +0000, Alan Mackenzie wrote:
> > Hello, Greg.

> > On Wed, Feb 26, 2025 at 11:09:57 +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 25, 2025 at 04:15:38PM +0000, Alan Mackenzie wrote:
> > > > On Mon, Feb 24, 2025 at 21:08:50 +0100, Jiri Slaby wrote:

> > > > > I didn't read the thread, but are you looking e.g. for kmscon?

> > > > No, I wasn't.  I was looking for a drm replacement for the
> > > > drivers/tty/vt code inside the kernel.  I may have misunderstood
> > > > Greg when he referred to a replacement which uses drm.

> > > No, this is what I was referring to.  Also maybe we should be
> > > asking on the drm list?  The developers there were working to get
> > > rid of CONFIG_VT so I know they have plans for what they see
> > > replacing it.

Is this (still) the case?  Have people on dri-devel developed a Linux
console which supersedes the code in drivers/tty/vt, or are they in the
midst of doing so?

Where can I best inform myself about this, and (possibly) install this
replacement console on my system for my own use?

Thanks for any information!

[ .... ]

> dri-devel@lists.freedesktop.org is the list.

> thanks,

> greg k-h

-- 
Alan Mackenzie (Nuremberg, Germany).
