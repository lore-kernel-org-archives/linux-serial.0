Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E11514F8;
	Sat, 29 Aug 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005564; cv=none; b=mjAv7AELk+ovf4xv7p0/m04SVRzSd2Qci+asq2vYcydImt1OqngvplUW293iGSJifZwTsdAR++K1Ff73blN6llXzuiF/9u4IpYPZp+sAU1yUkMAzk5H6HLozbCJQ1sN/tJhNsK41ATCf4NNhIvxtZzGz3BGlym5pDymVfIofjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005564; c=relaxed/simple;
	bh=sA3rCUC+5xRclWJyUf1t4Fr2BaRCaMbLeFydGE3fXmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwUc0kxj1KgBSFuGVC3PEJ6pS7lveIe9QQPc8AkWkWwOPq8NBHK2u5/jTTv7ANlFb6kEVd1TzK3tPqrXv0egFwFjWlag4eJQP2iXjmd1aaoju/EgqVcxv9mYIapuMZ4brCz1JCLqvGjVBMfJC1WK870TXZ8dkb7qPihg1PyRKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sk1SCSYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sk1SCSYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206241F000E9;
	Sat, 29 Aug 2026 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788005562;
	bh=e+inmMTn5EWTXc8jQrDrgX1pRmK3I54kXP3re76Ib9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sk1SCSYTK8jsRWXUxGDvLO5u4LVLBh8/rNdoOu7Hv/qF2fYA81EwRT2MfDqvzOYzh
	 6Rg7hLXVvSpfh6oAq+oiD5ZZo9BsJs6UMWjfkZmr/oR5DiUrJUmeIQACPv2hmYxqe3
	 5R7OqldmPdFrim52DvjWQTodJz8yGMkJa2BlA4nY=
Date: Sat, 29 Aug 2026 14:11:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Patch 3/9]: Replace scr_readw/writew by scr_readg/writeg, etc
Message-ID: <2026082934-irrigate-tastiness-c4ff@gregkh>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCGKUotSUZLvngV@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCGKUotSUZLvngV@MAC.fritz.box>

On Thu, Aug 27, 2026 at 06:47:05PM +0000, Alan Mackenzie wrote:
> 
> vt: 32b glyph: 3. replace scr_readw/writew by scr_readg/writeg, etc.

I don't understand these lines in your patches, where are they from and
what are they for?

thanks,

greg k-h
