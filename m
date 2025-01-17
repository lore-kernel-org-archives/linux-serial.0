Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E5155300;
	Fri, 17 Jan 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117632; cv=none; b=baxNraXtri63sv3GZ+kw2lLImaUy3OFZJNmv4ZUXfJsffImm8pw7RAwp4TY/eYGogxIxVuckkiWuJXLlVxBP59aKD/QSYh0W29RRUw5u5GFLkH1C+nrRi0wZHBce46Cx0BWtKTA45pAMpf1mam46rgzdQiyFTIDUB+IDLbXuvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117632; c=relaxed/simple;
	bh=CXd70FmVtOkCmXauBpQyKobKqIICZYXwNctCKZyogbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL8HW2NSVczUVA1kHDAZ9zA79CYt5skj3nbmpWL/6Go+lYbZwLM4a0Z5J2dk4BEEJETus+fPLZgGl5BcQWHlODlOyM/TY+o0hCLM4vE6DrjudnNlJ7ELfak5PwUx6aB+EAjVG4cA9I1Rita2tX7qjU1F/r30tpALfc9UZ3hxmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLG1Lu/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLG1Lu/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EB0C4CEDD;
	Fri, 17 Jan 2025 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737117632;
	bh=CXd70FmVtOkCmXauBpQyKobKqIICZYXwNctCKZyogbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLG1Lu/7FKtKAUHVY9bKAg32v7OUD2xSPSKS744sxQLqEK343xSJw+55c4f7UD2LU
	 WOBu2uXGMolkjuiGXCMohy3iGSCfXIxU4p4IWhhkH9g5T3/tWonuDR6BHaCFNAmDJ9
	 v6XbhwV2Isu9+zY+M946X79g1IhdIS1xbbQGEmUs=
Date: Fri, 17 Jan 2025 13:40:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lech.perczak@camlingroup.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [External Email] Re: [PATCH v7] serial: sc16is7xx: Add polling
 mode if no IRQ pin is available
Message-ID: <2025011757-unwrapped-evergreen-20a6@gregkh>
References: <CAHp75Vc==m3mE1TtxjHnpwL-d8W4rFnKreu7XB7MWspJKCCOGA@mail.gmail.com>
 <20250116083447.453615-1-andre.werner@systec-electronic.com>
 <2025011739-tavern-carpenter-86c3@gregkh>
 <b24fba36-48bd-103b-8a6b-386d050ae5f6@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24fba36-48bd-103b-8a6b-386d050ae5f6@systec-electronic.com>

On Fri, Jan 17, 2025 at 01:37:54PM +0100, Andre Werner wrote:
> Dear Greg,
> 
> > On Thu, Jan 16, 2025 at 09:34:47AM +0100, Andre Werner wrote:
> > > Fall back to polling mode if no interrupt is configured because there
> > > is no possibility to connect the interrupt pin.
> > >
> > > If no interrupt pin is available the driver uses a delayed worker to
> > > poll the state of interrupt status registers (IIR).
> > >
> > > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > > Link: https://lore.kernel.org/r/20250110073104.1029633-2-andre.werner@systec-electronic.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > This whole commit is already in my tree, why is it submitted again?
> 
> This is my fault. I misunderstood a comment from a reviewer.
> There is a patch that i still discussed in this thread:
> 
> https://lkml.org/lkml/2025/1/16/398
> 
> Also the thread has a weird structure. Sorry!

Yes, please send a new version so that it can be considered to be
applied properly, I can't dig it out of that thread easily, could you if
you had to do it? :)

thanks,

greg k-h
