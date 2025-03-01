Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD291C3C18;
	Sat,  1 Mar 2025 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807139; cv=none; b=h0+yH/Uhm5VYafLS6tS5MbhsKbR/Bqg9bgWOPuIldomIknP3xGWESHfQXWiJJddbKeyV5jX45zrdc14rHkeOoC3FcjP7cwqUA6hWqEAP1xI1yo4sm+r+10zxMEkDAY8U3x5i0FmTInjKg/tx7i6mukJL4K+IdC9nwtqHfMLorEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807139; c=relaxed/simple;
	bh=KKVi74kpUu0ygHc61lgg/aI04hMYp/Wr1LRoMX+zUhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOeKW2EBHSyvbWpQxQSISBEWhYsGqdAZpaNwryxKX7t60daXj0vH/QOuLzMSSOKHL3HCYllhYlJwEiyLoJ4aemFMFjf/FuJhvhE0aDKVTmXxbGajaXdLCdz5npetv4MwZZrP1aITOU1Qr75pmBbXone5TkApLuAUee9dPjHTNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HU4yrou7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HU4yrou7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD652C4CEE8;
	Sat,  1 Mar 2025 05:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740807139;
	bh=KKVi74kpUu0ygHc61lgg/aI04hMYp/Wr1LRoMX+zUhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HU4yrou7/8ji6P1cGTGr4piBkqoTwOzr2xpbz0W5cQ5xDjyBLaG6Fd1r8aaFcslAx
	 73/QqNZQd2jVmkF+uBWnM54WpGbpOdS0UNctEOLZ5KcTvTdd0wtdejlpmJffT8t7JN
	 F4vQagze5CUmx+Kmny+IjUxgocSwgW7MRMsSk528=
Date: Fri, 28 Feb 2025 20:24:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <2025022802-monitor-moneyless-0f84@gregkh>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
 <2025022243-street-joylessly-6dfa@gregkh>
 <Z7nu7HqKn4o2rMd5@MAC.fritz.box>
 <2025022355-peroxide-defacing-4fa4@gregkh>
 <Z7y4yHT0fNYYiPI8@MAC.fritz.box>
 <d5e05c61-d796-4e5c-9538-a1e068631bba@kernel.org>
 <Z73sqvjlbJ54FCtH@MAC.fritz.box>
 <2025022652-uptown-cheating-5df8@gregkh>
 <Z8BjC_TzuDVaFC_3@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8BjC_TzuDVaFC_3@MAC.fritz.box>

On Thu, Feb 27, 2025 at 01:05:15PM +0000, Alan Mackenzie wrote:
> Hello, Greg.
> 
> On Wed, Feb 26, 2025 at 11:09:57 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 25, 2025 at 04:15:38PM +0000, Alan Mackenzie wrote:
> > > On Mon, Feb 24, 2025 at 21:08:50 +0100, Jiri Slaby wrote:
> 
> [ .... ]
> 
> > > > I didn't read the thread, but are you looking e.g. for kmscon?
> 
> > > No, I wasn't.  I was looking for a drm replacement for the drivers/tty/vt
> > > code inside the kernel.  I may have misunderstood Greg when he referred
> > > to a replacement which uses drm.
> 
> > No, this is what I was referring to.  Also maybe we should be asking on
> > the drm list?  The developers there were working to get rid of CONFIG_VT
> > so I know they have plans for what they see replacing it.
> 
> Which list would that be?  There are over 100 occurrences of "DRM" in the
> file MAINTAINERS.  I am also interested in this.  There is a very great
> deal of functionality in drivers/tty/vt.  It will be quite a task to
> replace it.

dri-devel@lists.freedesktop.org is the list.

thanks,

greg k-h
