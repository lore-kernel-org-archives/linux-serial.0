Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3721EFFA1;
	Sun, 12 Jul 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874414; cv=none; b=TonZpwDdhkvsbESb+yoh9AT7FlnBa3dWQIk4CkKNaO53d9GUoa+Zg7PGw9SrfVh8xNPxnBlJXXv8WTAtSFTecL/qvSmfhTUjPD5XieqCUnKlpBeJB39ay+JTRt1l+K1e+vq/hzsPF/HSKW5LqEEA5xUyH9RsYAoILU0yZ6rm/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874414; c=relaxed/simple;
	bh=xpe6P8MGSoK2iWS/G53+LxPdIgvxP7ZBXuVE4paNO0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaM6VeL4Qen8yf9mVx7KqkbD3KEQ75xY4Zi/HtSJJFwWvdbh5HdH1lVKwJ2oJamDbbfwYNqtdzCEpZkwArbF9oj673qkvOkZBGvtsKb7UbZX7DE8F6I3lcJsI52M1GSnBnY27EmPuKJLLDh0r3YaGGCPi+PpfH4eQnLVZvz1PJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uMAR8sNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uMAR8sNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7C61F000E9;
	Sun, 12 Jul 2026 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783874412;
	bh=jzZYUBLa2zRjaUg83C1spZE+DSeSJ7M8UUEWSWL+3lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uMAR8sNQsFRwJTXVguxjgRBPaZzTGaQJ9COnsvNh9hgsvDXNkdEGDiiOfOTRgvwBk
	 b449ciSWYCfWPeppJr4GTHWbo8prpnsTQ4mpmjFUsuB9hU2LcOwab6Sbv5dtZpFBVC
	 qwYCLOzHgAPksRK3pa86B/lf9mfxX+iy1FsLaQeQ=
Date: Sun, 12 Jul 2026 18:40:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] serial: earlycon: add uart_clk_freq parameter
Message-ID: <2026071251-unifier-vastly-dce4@gregkh>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
 <20260615-acpi_spcr-v3-1-9a59ebad74ea@posteo.de>
 <2026071048-imprudent-pumice-9b28@gregkh>
 <41b6b5d8810dc9ab658541840c1ebf8ad31ca8bc.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b6b5d8810dc9ab658541840c1ebf8ad31ca8bc.camel@posteo.de>

On Sun, Jul 12, 2026 at 04:36:17PM +0000, Markus Probst wrote:
> On Fri, 2026-07-10 at 14:36 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 15, 2026 at 12:40:21AM +0000, Markus Probst wrote:
> > > Add function `setup_earlycon_with_uartclk`. This allows the
> > > options string to be reused with `add_preferred_console`, while still
> > > allowing to set the uart clock frequency. This will be used in the
> > > following commit ("ACPI: SPCR: Support UART clock frequency field").
> > > 
> > > No logical change intended.
> > > 
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > >  drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
> > >  include/linux/serial_core.h   | 11 +++++++++--
> > >  2 files changed, 21 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> > > index ab9af37f6cda..5a20fe9e3fb6 100644
> > > --- a/drivers/tty/serial/earlycon.c
> > > +++ b/drivers/tty/serial/earlycon.c
> > > @@ -135,11 +135,14 @@ static int __init parse_options(struct earlycon_device *device, char *options)
> > >  	return 0;
> > >  }
> > >  
> > > -static int __init register_earlycon(char *buf, const struct earlycon_id *match)
> > > +static int __init register_earlycon(char *buf, unsigned int uart_clk_freq,
> > > +				    const struct earlycon_id *match)
> > >  {
> > >  	int err;
> > >  	struct uart_port *port = &early_console_dev.port;
> > >  
> > > +	port->uartclk = uart_clk_freq;
> > 
> > This looks like a logical change, the code today does not do that
> > anywhere, right?
> 
> `register_earlycon` only gets executed once.
> Thus early_console_dev.port->uartclk is always 0.
> Since all current callers in this patch series use `setup_earlycon`,
> the uart_clk_freq parameter is also always 0.
> 
> So in case of behaviour/logic, this line does nothing without the 2.
> patch.

Then it belongs in the second patch, right?

thanks,

greg k-h
