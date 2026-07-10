Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACB426689;
	Fri, 10 Jul 2026 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686886; cv=none; b=h25U0rznDC4agp/0EeHisTeVJ3SpY3IILZSxM+bLMoOhjgx324WqZhhGefL/WrQTsHyDwxyPjo6+bvOXVdi9nIwK3HRcxswKKKgBxQdpB1DKnLKy9b5araumCSeRrRE8rfJahGXIs9aIoHE82YfMxEvWg0zu9LfxNw/wVTv4+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686886; c=relaxed/simple;
	bh=HDTxe6xiRRo69tVt4vRfP07e38SHgjIcfxiImNWIgYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwvRtudzynmrJ2Ex2xp+QWoleVJv1Pac2vyYR06I56msjEmSj7ccvwOi2GANmqUjQqta+2/3WOWCqX+Sf5IYPkImoXPqjQcHXlTa8uUJsO1l6pufqKRiV9ksfuSeUtKJMcLPAO9hUMN6WREA3w2qh1gY2E+VpQGHRxngE2g2D5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfW1YrL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfW1YrL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA61F000E9;
	Fri, 10 Jul 2026 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783686883;
	bh=29r2WDwJmH10NZK24eXPq16WSbuygX+3I1ZV8mJmKUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UfW1YrL3NbwajMFFv8vhDVWTssNAUKM3uoYaDldqao5GLe9CBCuT9BMZZmJj+npew
	 OPfgvgjePlIhLXebpyFXGtZudfz0tuNXnGyCLKHRoOFi9F5Ue2GaAaHzpuPupmBWB8
	 oprBkPuMnEFtNCqYfzlxnFs1SlqDZpCl3T5Dgs/o=
Date: Fri, 10 Jul 2026 14:34:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ACPI: SPCR: Support UART clock frequency field
Message-ID: <2026071007-amaze-tartly-6282@gregkh>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
 <20260615-acpi_spcr-v3-2-9a59ebad74ea@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-acpi_spcr-v3-2-9a59ebad74ea@posteo.de>

On Mon, Jun 15, 2026 at 12:40:22AM +0000, Markus Probst wrote:
> The Microsoft Serial Port Console Redirection (SPCR) specification
> revision 1.08 comprises additional field: UART Clock Frequency [1].
> 
> It contains a non-zero value indicating the UART clock frequency in Hz.

Ok, but then what are we going to do with this?  Please make this a lot
more descriptive, I have no idea what this is supposed to be doing at
all.

> 
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table [1]
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/acpi/spcr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 73cb933fdc89..c79c809f49d4 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -228,7 +228,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>  	pr_info("console: %s\n", opts);
>  
>  	if (enable_earlycon)
> -		setup_earlycon(opts);
> +		setup_earlycon_with_uartclk(opts,
> +					    table->header.revision >= 3 ? table->uart_clk_freq : 0);

Why the magic number 3?

thanks,
greg k-h
