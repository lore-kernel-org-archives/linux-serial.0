Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70C2ED873;
	Mon, 26 Jan 2026 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425169; cv=none; b=jqIBHzvsYzCNGT0VT7m5vTMQHKSIdOiHp20F7sdMrkytE/NANPHCZVMh81nFEoFKG9UUON6u94t8zs09vjJLgOBv11ucadyqFjFgdJzi+QVymIcoRKA1KBemzuPaWsAmuam4choAa/9boRCDkTqSlhbSXbkXRqc2s5pgzcsC4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425169; c=relaxed/simple;
	bh=eZ5p4Ny5b7lwsXq4CUCfc+g8/Tkh6PHhEgDfS5hJqzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nks2AycdPRYLPt6qMC59Y1QsxewkPYoqGoIHmzM7hMdatXwXXtawVG7TbUlliUd7iIYE1Q87zY8DEA+kS5t0VkWp+U5bFuiQ+c2aYSoO7GyFnc2joaYmZUXoXLqs8FvwrKGqNOggYmmeAo+oSUc+6Tk9SmW/RyPymCbjIHBIAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdK84gcq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdK84gcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26135C116C6;
	Mon, 26 Jan 2026 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769425168;
	bh=eZ5p4Ny5b7lwsXq4CUCfc+g8/Tkh6PHhEgDfS5hJqzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdK84gcqFR4N8BFmNepK3XDYT95Tq8/HxedVOg7F2h6b5P7Pk1juwy4D3xDhO+EeP
	 JSBEJmEFhz0/KB5agTEmU7UaJmHtzni5PN/7ewKHNkqVtNYJqyVz3/inCmHz9XdyvQ
	 U/4mrCxiOuh+ASZyQURblAegFawYcUfFQsmmlM5o=
Date: Mon, 26 Jan 2026 11:59:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: Add enable module parameter
Message-ID: <2026012642-threefold-atypical-a3ad@gregkh>
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
 <2026012648-vantage-mummified-2a43@gregkh>
 <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>

On Mon, Jan 26, 2026 at 11:48:50AM +0100, Jocelyn Falempe wrote:
> On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
> > On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
> > > On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
> > > > On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
> > > > > This allows to build the kernel with CONFIG_VT enabled, and choose
> > > > > on the kernel command line to enable it or not.
> > > > 
> > > > This says what is happening, but not why?
> > > > 
> > > > > Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
> > > > 
> > > > Why are we using a 1990's technology for a new feature?  What is this
> > > > going to allow to have happen?  Who needs/wants this?  Who will use it?
> > > > For what?
> > > 
> > > The goal is to ease the transition to disable CONFIG_VT.
> > > 
> > > So if this is merged, you can boot without VT on any Linux distribution,
> > > without rebuilding the kernel.
> > 
> > But that's a distro-specific thing, the distro should be enabling or
> > disabling the option as it needs, it should not be a user-configurable
> > boot-time selection option as userspace depends entirely on this either
> > being there or not.  Why would you have a kernel with both options but
> > userspace without that?
> 
> Actually the userspace side works with or without VT, at least with Fedora,
> I've my Gnome session in both cases.

Great!  Then why is this even needed?  Who wants such a "let's not make
up our mind until we boot" type of system?

Given that traditionally the command line is a "secure" thing, that is
locked down by distros and orginizations, who would ever be able to be
changing this type of thing?  Who would want to support userspace that
handles both at the same time?

I don't see the issue here, if a distro doesn't want to support VT, then
disable it in the kernel and all is good.  If they do want to support
it, than enable it.  Don't do both :)

thanks,

greg k-h
