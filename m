Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBA351C03;
	Thu, 12 Mar 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323316; cv=none; b=GNPR+y8JKU6sTRSD2bhYr1uCG72dkFyBJqoJmimSvWkhEqboT4SZpmI0TdSZx9S9X14JYA+4lCzzPMIFa1NwASZl8ouB/moyKcEE714CkmnYCfSRw+FhJL6ncymyr9tFEG0umJE5NIgot06EPzjelJOYBfDHdBAe0aK7H4cGeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323316; c=relaxed/simple;
	bh=LXzWk9Dk2u3syKJj4iSOsmlQ3qpOQFPOQqu+vntpYvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoHpxWZ+77+hNN/ArzYUEPsiFpwrUgcPO+UNeM7aKq32d5TBrqGAz7SkWZL4uzJXupHUoa7EtGKyj5WZAuYEA+CeAP7KMeFiJNQQSp85ZJaya2JMT+047n1c3obUG4LKM84PFwj3DzCADzPTY9RyU6Xm+uQcwgxXmuEp+ueiJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YajpBhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YajpBhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34914C4CEF7;
	Thu, 12 Mar 2026 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773323316;
	bh=LXzWk9Dk2u3syKJj4iSOsmlQ3qpOQFPOQqu+vntpYvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2YajpBhDR+DEhEJNBXPiigQniDUITvkjgkNtvDZpTs2TOZJShYrnwuiS3Hd74Y7x7
	 7cZLZOa6J93qkabrnN2JrOaMTUB7/012/qWX/EC/sVLnxfQDiS9d/AhuEqM2SQ3FEI
	 hFaAZGRzjR+6yyQTpC5MoFBknGThkdNXbTUc/DVg=
Date: Thu, 12 Mar 2026 14:48:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
Message-ID: <2026031225-daylong-uselessly-1821@gregkh>
References: <20260203045457.1049793-1-nico@fluxnic.net>
 <2026020851-bullhorn-glitch-0e37@gregkh>
 <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>
 <2026021006-reenact-suave-c86c@gregkh>
 <p6r658p5-4q55-8pn6-q78n-107599qq653n@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6r658p5-4q55-8pn6-q78n-107599qq653n@syhkavp.arg>

On Fri, Mar 06, 2026 at 01:26:56PM -0500, Nicolas Pitre wrote:
> On Tue, 10 Feb 2026, Greg Kroah-Hartman wrote:
> 
> > On Sun, Feb 08, 2026 at 11:22:27AM -0500, Nicolas Pitre wrote:
> > > On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:
> > > 
> > > > Argh, sorry, I saw this patch series too late for this merge window.
> > > > I'll review it after -rc1 is out.
> > > 
> > > Too bad.
> > > 
> > > But please at least consider  this one now
> > > https://lkml.org/lkml/2026/1/27/1886
> > > and queue it for the stable tree as well.
> > 
> > Sorry, that slipped through as well, I'll grab it after -rc1 is out and
> > get it backported to stable kernels.
> 
> Ping.  ;-)

Sorry, am catching up now...
