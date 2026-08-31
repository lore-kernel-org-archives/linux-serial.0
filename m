Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906243C09F5;
	Mon, 31 Aug 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164937; cv=none; b=sSsc8rXXOLj0pcAt2wTDoJFYdSDdUvE1HOiaudbbmHF0qIs6ZJ2Kd918L7BrRUst51R3txUuqbwFIRxO8WVkWIbmFothwglZu9JehUtb3xMxya26cpwRrbAgYvYc2rI15kq9I+nz8ieweC9vV3dw9WNMvBQHKGJEobXfiOGoebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164937; c=relaxed/simple;
	bh=uRkDcTOAn+R7TrgMni0mcixbt97rdUXaaARcPdcnnL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA6JGmq1Nk8I4tJcxsR8XpJJBwJjmxLX8CSG0bxHR4T4G+ijjvpGF+Z1roPOzSTaxvhmIiOV9jtoVVUjEIGKGOc/fgFXqnywk63uv8V0q9DsYgntTg3LS9pU1Kvq+EMiq580bGFgm4ijlDopdv7r3NyrjSJWgC/vkpxS8fFJ/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4ZAcMaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4ZAcMaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F240B1F000E9;
	Mon, 31 Aug 2026 08:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164936;
	bh=VQpc8lTOdX3xSHi8EiRB4f2hLx8t85VdxKOuNWE2LD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4ZAcMaGmhWkbt0Rh1OPbj1YlvacnstiEn1h6FFml6IuFq+3UCfM+lcx8aLY2H5Sb
	 aTcviB67lh56jpthcbuARnaiLX4X0zEJ5iPxkrisAndSC28M/yhEdVLGlUkt0diRxO
	 9bduFdfWk+hI7CWNkelr83aVU9pAyG0ntG7S56uds6uH8gbohovzZGzBTSkSIocm39
	 gnGlVJEZbg6CRfoOomrsStasSuqGXnXNNxknZttY9AdVDI4XPTmJ93LIezloeltrna
	 rqfo0Swu4IbyUCEIkpSb0iea7aqu2MJDVQwQFkcSN19DRtkiVxfkbBz7lauGqWknXo
	 5oualX6cx/Q9g==
Date: Mon, 31 Aug 2026 11:28:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] serial: core: replace get_zeroed_page() with
 kzalloc()
Message-ID: <apU7QSOV22VJL3ay@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
 <20260830-tty-v1-2-0cbe6170649b@kernel.org>
 <602bdc5f-e9fa-4ed5-a009-03af860d31a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602bdc5f-e9fa-4ed5-a009-03af860d31a6@kernel.org>

On Mon, Aug 31, 2026 at 05:02:54AM +0200, Jiri Slaby wrote:
> On 30. 08. 26, 9:49, Mike Rapoport (Microsoft) wrote:
> > uart_alloc_xmit_buf() allocates the transmit buffer of a serial port. The
> > buffer only backs the port's kfifo, the data being sent is copied in and
> > out of it.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > While on it, make the local variable holding the buffer a pointer to get
> > rid of the casts.
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Assisted-by: copilot:claude-opus
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   drivers/tty/serial/serial_core.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 95774b0f1484..f12ce7d190fe 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
> >   	struct uart_state *state = container_of(port, struct uart_state, port);
> >   	struct uart_port *uport;
> >   	unsigned long flags;
> > -	unsigned long page;
> 
> 1:
> 
> > +	unsigned char *buf;
> >   	/*
> >   	 * Initialise and allocate the transmit and temporary
> >   	 * buffer.
> >   	 */
> > -	page = get_zeroed_page(GFP_KERNEL);
> > -	if (!page)
> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!buf)
> >   		return -ENOMEM;
> >   	uport = uart_port_ref_lock(state, &flags);
> >   	if (!state->port.xmit_buf) {
> > -		state->port.xmit_buf = (unsigned char *)page;
> > +		state->port.xmit_buf = buf;
> 
> xmit_buf is u8 *. This uchar was omitted when I was changing the type back
> then. Could you use the right type at 1b now?

Sure, I also made this change in uart_free_xmit_buf().
 
> thanks,
> -- 
> js
> suse labs

-- 
Sincerely yours,
Mike.
