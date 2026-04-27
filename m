Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C72DECC2;
	Mon, 27 Apr 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320421; cv=none; b=PhdPh6GeOasM3uLmnyKoXMiE8CiQmSLMutoIQg0n1WDRyuBNhuhlcrJ+oNh6DsEZ69GSkq6GfPOcIQZF0qnHtOTGs3pjENbTq4v+5P5a5qcNWE6u0zUAl5RM6F3lnWoBqEi10DlKceXFenaJfBgJzcgtYbqj/mMt8YLMVQ/++Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320421; c=relaxed/simple;
	bh=nHcpEksPsmLpnJ1q3xrEZGsme/bRdQl6OuYZzVDWF3U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LnPlEY8fvKs1qJDUyQwYQpHK7mPW5wC5VckaSV6tg41Go7XkE6Ux+MxocqQTFObwyf1WgTYLTTM1V2mDl7zlAjPhFspD1su9p2pWmxVCopsoF/Ez1Mx6WEdL9DUsPfRlUVNYK2wBl0zPbY+ZnsfnV7+eLuCpWkUO4ODgIHs4ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 757FB9200B4; Mon, 27 Apr 2026 22:06:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6F20192009D;
	Mon, 27 Apr 2026 21:06:56 +0100 (BST)
Date: Mon, 27 Apr 2026 21:06:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Elena Reshetova <elena.reshetova@intel.com>, 
    David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>, 
    Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Revert "drivers: convert sbd_duart.map_guard from
 atomic_t to refcount_t"
In-Reply-To: <2026042737-siamese-cod-84c5@gregkh>
Message-ID: <alpine.DEB.2.21.2604272057250.28583@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604130239560.29980@angie.orcam.me.uk> <alpine.DEB.2.21.2604130416440.29980@angie.orcam.me.uk> <2026042630-diaphragm-reactor-7cfe@gregkh> <alpine.DEB.2.21.2604271435070.28583@angie.orcam.me.uk>
 <2026042737-siamese-cod-84c5@gregkh>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Apr 2026, Greg Kroah-Hartman wrote:

> > > How about fix this up to work properly with a refcount?  having "open
> > > coded" atomic variables like this is ripe for problems, like it seems
> > > this driver is abusing.
> > 
> >  Clearly refcount has odd semantics for this use case, as the failed 
> > attempt to "fix" this code has shown.
> > 
> >  The natural values for `map_guard' are 0 and 1 (FALSE and TRUE), for the 
> > resource not taken and taken respectively, however refcount code complains 
> > about this arrangement as indicated by the report quoted.
> > 
> >  I suppose I can bend backwards and adopt other values, which I'll have to 
> > figure out from the API somehow, but it's not clear to me how it would 
> > cause less confusion than original straightforward code, the whole point 
> > of which is to prevent the resource from being requested again for the 
> > second port in a DUART.
> > 
> >  Or I could use an ordinary variable, possibly of the `bool' type, guarded 
> > by a spinlock, but that would be even more of an overkill IMO.
> 
> No, that would be best because using an atomic is the same end result,
> but it confuses us humans who are the ones responsible for maintaining
> the code over time.

 Right, it's missing a MAINTAINERS entry; I'll add one with the respin as 
I wrote this stuff anyway and still care the most I believe.  And having 
thought a little about it at a bus stop I realised I got confused too, so 
it may have to be a counter after all.  I'll see what fits best, but I'm 
currently away from this hardware (which is not at my lab) until mid May, 
so it'll have to wait.

  Maciej
