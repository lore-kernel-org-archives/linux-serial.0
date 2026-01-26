Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FE29DB65;
	Mon, 26 Jan 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425063; cv=none; b=ePnoDFZoIDWF91jPqdR7rGELjmsqj7lszsdtT6vCl0kPatL8JRBdtiWhEULt9XE3xMPYk2M4W9NVdkAE3sMm3UVyt6WSxYYhzT6S01g3KMIHL/5ZI+r4o4iMCCgmbuAgOqu3SXhN7dFOja5Uk9/hq6tK6iYVtmXyCBi1VcA2Q2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425063; c=relaxed/simple;
	bh=4cUWKgDWAyrbhapIOlP0Fpin+tvQj1odqMn5yCM/w5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvxjvJ5/n8/qEZjN262kqSvYh+Qam/HjwDlq2rz/nqySLiWRTdI+eWdFqIoky872TeP5w7dFvUOjPYOqRCFlHDtwCKuDHdybi90vyGDovRp1C1DaicE77GV1OSt2bxAM8hA96NfZNC9fxXhP9ESTbL80UyeTr0b7iscIwnQRSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZaJJkP9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZaJJkP9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A454C116C6;
	Mon, 26 Jan 2026 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769425062;
	bh=4cUWKgDWAyrbhapIOlP0Fpin+tvQj1odqMn5yCM/w5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaJJkP9v5mbAUiangXgTz/pSRV17AWDI8d1tJ1FqEHh+R9M3A78szLmLe+rlNwKUr
	 P7cT7zaAUgwZIlrkg3cy0gi/pWmh6kATZQho1IB4W+UnxnA7gebaOWfWlwHY3j/Fwp
	 AdWmPodM61nhWXZY4btS6bO5q8UcyxpzZpewK588=
Date: Mon, 26 Jan 2026 11:57:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012604-yelling-hurdle-ebf9@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
 <2026012648-vantage-mummified-2a43@gregkh>
 <2026012659-credit-suing-72ce@gregkh>
 <40fa8cab-af36-4420-9099-511474833fe1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40fa8cab-af36-4420-9099-511474833fe1@redhat.com>

On Mon, Jan 26, 2026 at 11:49:45AM +0100, Jocelyn Falempe wrote:
> On 26/01/2026 11:30, Greg Kroah-Hartman wrote:
> > On Mon, Jan 26, 2026 at 11:20:21AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
> > > > On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> > > > > On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> > > > > > This allows to build the kernel with CONFIG_VT enabled, and choose
> > > > > > on the kernel command line to enable it or not.
> > > > > 
> > > > > This says what is happening, but not why?
> > > > > 
> > > > > > Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> > > > > 
> > > > > Why are we using a 1990's technology for a new feature?  What is this
> > > > > going to allow to have happen?  Who needs/wants this?  Who will use it?
> > > > > For what?
> > > > 
> > > > The goal is to ease the transition to disable CONFIG_VT.
> > > > 
> > > > So if this is merged, you can boot without VT on any Linux distribution,
> > > > without rebuilding the kernel.
> > > 
> > > But that's a distro-specific thing, the distro should be enabling or
> > > disabling the option as it needs, it should not be a user-configurable
> > > boot-time selection option as userspace depends entirely on this either
> > > being there or not.  Why would you have a kernel with both options but
> > > userspace without that?
> > 
> > And to follow-up on this, if a distro wanted to support this, why not
> > just provide 2 different kernel images?  One with this enabled and one
> > without?  It's up to the distro to support such a thing, not the kernel
> > community, right?
> 
> That's clearly not an option, they will prefer to keep VT enabled forever
> than adding yet another kernel package.

But that's a distro's choice to make, why are you forcing this onto the
kernel?  Either a distro wants to support a userspace with VT enabled,
or not.  So then choose the kernel option you wish to have here and away
you go!

> And for distributions that already have kernel and kernel-rt, that
> means maintaining 4 kernels for all combination.

Again, that's a distro choice, you are now forcing us to maintain the
option due to the lack of an agreement in your organization :)

thanks,

greg k-h
