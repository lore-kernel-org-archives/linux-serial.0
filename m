Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C291FF5E3;
	Sun, 30 Aug 2026 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788079485; cv=none; b=EYSv2+5aB4ejsfPsbHUqZMmnWBN9NZJEoTiQ3BliIO/6jRrrkITSJ/acWlanD2vjzkV/KsB+jaVUl0zN7WSlYCZJQE3GT6AWR9cKBOl14sM2ap3z1y4Y4mjkvmZaL9o5so0Fby9MQPacsdSdLy78OhPYCLLAhk2nA+w1k/1/YQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788079485; c=relaxed/simple;
	bh=kccXCW2uwnC32aorsuk+fOLL91eOa0XeyF/GJZUkpDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNpq0JbN5jJbvN1e3KZveEjpg5ol5SW76F8RGzY+zlYVXEegb6s141zfbn/+ea6eJnSifHTJk4zFA7sH19ebBtD6qKCM8WxBx+A2YVah40hp7CiUH0bh0BUB575jXeMBjb8HY69NdJoN2vv0F5FPq2BSslayCRpwnHz2uClhZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDpIINyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDpIINyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644981F000E9;
	Sun, 30 Aug 2026 08:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788079483;
	bh=RIBS2+qN8Vms4CQG2rS3b0ns/uUUCcnttypH9627KS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDpIINyA6qnZzOR+Nuu3MdsyNuFZ/s+DyXCSbQgGIeCH9HK0xKwaElRKosC1r3fNi
	 9K7VHzp9dl/AgghQjGSk04dj9HbnxbxGLbr+YEjBFO5Ec+NRWZHsXWPaeU8L7M6KpS
	 NKGNfBcVJytzrgBAW1ZCgO1WXgaJPZlVHAg5927HaG/vzZBIebPNAbSYNv0QvQkkZj
	 4Qu8IPrhKXGwwx96usMfwXIeTphJInlyna/k8VHsyAkZ590J6EAtHSrfGD/T7oMjUR
	 QK+RzeNJSqIxaPuGYARgSJ5R9wsW41VyN2oGxUHCt+VFrUXoygsuKQfOliQoyqIgVp
	 Rq+1hAwiQz8qQ==
Date: Sun, 30 Aug 2026 11:44:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: core: replace get_zeroed_page() with
 kzalloc()
Message-ID: <apPtdnAPBR6RwJAk@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
 <20260830-tty-v1-2-0cbe6170649b@kernel.org>
 <20260830080055.1BDF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830080055.1BDF41F000E9@smtp.kernel.org>

On Sun, Aug 30, 2026 at 08:00:54AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] The transition from `get_zeroed_page(GFP_KERNEL)` to `kzalloc(PAGE_SIZE, GFP_KERNEL)` for allocating the serial port transmit buffer (`tport->xmit_buf`) breaks the strict page-alignment guarantee. Several serial drivers inherently rely on this buffer being page-aligned. `atmel_serial` explicitly panics via `BUG_ON(!PAGE_ALIGNED(tport->xmit_buf))`, and `pch_uart` corrupts DMA scatterlist addresses by masking out the lower bits (`sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)`) assuming the base address is page-aligned. If `kzalloc` returns an unaligned address (e.g., when SLUB debugging adds redzones), this results in DMA reading adjacent out-of-bounds kernel memory and transmitting it over the serial line.
> --
> 
> commit 56b6291d1a96458932c4b0e5de37ae0df9e37c2d
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> serial: core: replace get_zeroed_page() with kzalloc()
> 
> This commit replaces the page allocator with kzalloc() for the serial port
> transmit buffer. It aims to simplify the API and remove casts, noting that
> performance differences are negligible.
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 95774b0f1484b..f12ce7d190fe6 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
> >  	struct uart_state *state = container_of(port, struct uart_state, port);
> >  	struct uart_port *uport;
> >  	unsigned long flags;
> > -	unsigned long page;
> > +	unsigned char *buf;
> >  
> >  	/*
> >  	 * Initialise and allocate the transmit and temporary
> >  	 * buffer.
> >  	 */
> > -	page = get_zeroed_page(GFP_KERNEL);
> > -	if (!page)
> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> 
> [Severity: Critical]
> Does replacing get_zeroed_page() with kzalloc() break page alignment
> requirements for the transmit buffer?

No, commit 59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for
kmalloc(power-of-two)") guarantees that PAGE_SIZE allocations are page
aligned.

-- 
Sincerely yours,
Mike.
