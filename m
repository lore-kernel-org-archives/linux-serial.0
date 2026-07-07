Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A1329396;
	Tue,  7 Jul 2026 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437754; cv=none; b=aV6R04EhdvGpwAFR1QPIM19kR7Vr+0RIcuqHLqXNe/+4fB3jlmXqttzTRZx6bsQ/yszGIm2+NQb+4On7pJCDQE68wBT+zqlKT5MSKdpc+KnRR/twiYOFVFCK4vT4QUj7KtA69aybP/XfQjCs8y9AzxQeROd62C6qGwtvDpE4Hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437754; c=relaxed/simple;
	bh=QzOYHeZ8NckzZ8e3eh+0wsWfymXKo+FUv7IXyWHlo5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgQyMG9+NIfiXbCjZoXXdlWs8H2wMMo67vhbv/PWqnXsyU7ufM2vnDztbemkgrDzG2a63lZC2QnhxHchcbOySkIxRP8Onl5c182qG01rxY6zoy4PcRuZpyCbCPr/uQKNjonReDkRrknbPcnhc/CJlDXSdmSH00njXQngX0XrB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YkMkHYeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YkMkHYeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB711F000E9;
	Tue,  7 Jul 2026 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783437749;
	bh=BWbGKIL+LCjf4g0k1cYsV7MRDHagLBOBJIKEk+njlqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YkMkHYeFcGxlVekoZBIAd9nQJVKRwUVhcLNQFhDleC+BpBzir5PbuNpnfKlIyEOSJ
	 y5oGJTr8VPl7V5r7pEM/BVWAcEmg4lW2AFyHE36iGHmW4pLMCy+uHsyOVK0MyKoiSA
	 dJMmEB8WTcad6+dw5YwiBhkSOxDfnlKhtpqx9gMc=
Date: Tue, 7 Jul 2026 17:22:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: men_z135_uart: replace
 __get_free_page() with kmalloc()
Message-ID: <2026070717-elixir-pointy-c698@gregkh>
References: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
 <20260528-b4-tty-v1-3-9da9f7aec5f2@kernel.org>
 <18bb4a45-c26b-4a89-b598-a844d3aadafa@kernel.org>
 <ahlRqd3e94ojSfWE@kernel.org>
 <98ebf7d1-244f-4fbc-afc4-3e8940df5422@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98ebf7d1-244f-4fbc-afc4-3e8940df5422@kernel.org>

On Fri, May 29, 2026 at 10:52:49AM +0200, Jiri Slaby wrote:
> On 29. 05. 26, 10:43, Mike Rapoport wrote:
> > On Fri, May 29, 2026 at 09:47:33AM +0200, Jiri Slaby wrote:
> > > On 28. 05. 26, 12:24, Mike Rapoport (Microsoft) wrote:
> > > > men_z135_probe() allocates a receive staging buffer filled by the
> > > > CPU via memcpy_fromio() from the device MMIO region.
> > > > 
> > > > This buffer can be allocated with kmalloc() as there's nothing special
> > > > about it to go directly to the page allocator.
> > > > 
> > > > kmalloc() provides a better API that does not require ugly casts and
> > > > kfree() does not need to know the size of the freed object.
> > > > 
> > > > Replace use of __get_free_page() with kmalloc() and free_page() with
> > > > kfree().
> > > > 
> > > > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > ---
> > > >    drivers/tty/serial/men_z135_uart.c | 7 ++++---
> > > >    1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
> > > > index 6fad57fee912..9c32b01edc9e 100644
> > > > --- a/drivers/tty/serial/men_z135_uart.c
> > > > +++ b/drivers/tty/serial/men_z135_uart.c
> > > > @@ -17,6 +17,7 @@
> > > >    #include <linux/bitops.h>
> > > >    #include <linux/mcb.h>
> > > > +#include <linux/slab.h>
> > > >    #define MEN_Z135_MAX_PORTS		12
> > > 
> > > This one is misplaced.
> > 
> > Do you mean an empty line is missing? Or there's particular order of
> > includes here?
> 
> You added it after an empty line -- along to #defines. You should had added
> it along #includes instead -- before the empty line.

I've fixed it up when applying it, thanks.

greg k-h
