Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2A442106;
	Tue,  4 Aug 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832843; cv=none; b=qMXs9lLZLAbQG6AG3jrAE/T1S5DDx7WD1aQM3/2IL0ScLbbzvXDpH+EKuUWFwrLKjPMqkD8SwpMMkpZTWi6oWrnn2lSJzF2owAUmWrox2lciiCRxqcrPne55kMswQC1J/ngFavMihtB7doVcRSLR2EYpMMmlsYTWsVg01AtWfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832843; c=relaxed/simple;
	bh=Ns8FWpv4ANB7lti4RujNXPSgtjuVDU0RzFixQquT+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNit+daJYGKgWcGh+WcDmzRKqy1IJftGziWFGcbUu/RJhZ/jWwwFRo/s75bwDDNeoIeFDWndmtWBWEkyTi5TswQvjyS/Lu5WGt/ivnlQ6P6HVRnOdyeQ1Lb6mjPLvf2b3FTiS5NxceBe4PMtyfoFUBZ/QwrwXtJGCeCULwZW6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v7OPrTDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7OPrTDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70881F000E9;
	Tue,  4 Aug 2026 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785832842;
	bh=VvMkQdF0e8wKvtyBWsqY/LgVc8zlR7+sogivex7bppA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=v7OPrTDT2yEVEy/pO9UmSihE7ZgAIf6/UYvdn4XSGxj9pXXpx/z/E6qF5A2jAzy1m
	 z54EQz6T1qzGtOTjtLTfmrImn9Nk6rm7a9aZCrzVEclxHO/BkkSqpVQycyWTELDiFQ
	 h3P1XAOGrsbzihtKoEs6tXJqr0xpOlRb73Qtrhzc=
Date: Tue, 4 Aug 2026 10:40:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: jirislaby@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
	kees@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts: fix pty count limit off by one
Message-ID: <2026080419-chatting-curve-e49c@gregkh>
References: <20260804082321.884880-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804082321.884880-1-chenyichong@uniontech.com>

On Tue, Aug 04, 2026 at 04:23:21PM +0800, Yichong Chen wrote:
> devpts_new_index() increments the global pty count before checking it
> against the effective global limit. The check currently rejects a new pty
> when the incremented count is equal to the limit.
> 
> This makes kernel.pty.max allow only max - 1 ptys. For example, if
> kernel.pty.nr is 3 and kernel.pty.max is set to 4, opening /dev/ptmx
> fails with -ENOSPC even though one more pty should be allowed.
> 
> Allow the incremented count to be equal to the effective limit and reject
> only counts above it.
> 
> Fixes: 0f0a0e54a2a1 ("devpts: Convert to new IDA API")

As this is a user-visible change, what is now going to break because of
this?  It's been this way for a very long time now.

thanks,

greg k-h
