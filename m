Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DC40F8DF;
	Fri, 10 Jul 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685478; cv=none; b=P20MslEsmeJddlfqq6XBNX8qilAU2bAr/sxUdepUFUYEZ9oXyX2Ro0k5FA/JBW6mhf97TsRTqK4mnkM+IVldnDS4Kxpc5lNVGpjnBBqZ/kxesi09iWpnAIZh+AmMOJTT6ISzXuOeWbqxOXswD4L1+tX7AhnyOQumXzub8j+/Mgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685478; c=relaxed/simple;
	bh=bPUZ+W4ibolmlQDsTuRyviDqpQFyagDxlwsZorek8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+si0InGV1BSTIVou8GZo+vnvqxqZ/8dDpW9ikx2wCG9jsgQ9cnMjz4RapFl0ggbohylDlrWwrLE7JhUAuikXdJiPK9q0JUaphNSDd7WEGQZVVtIi0K9tJAtsCpOZNEhSqGBcDxFIm76b5OSc1KT34PkiLQ7FzOM8WMGv3OjOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sl8CYVrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sl8CYVrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A236E1F000E9;
	Fri, 10 Jul 2026 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783685477;
	bh=/vD5hhkTqgptj2lhelbezJzYhQSxES3J5JQI2sgC0Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sl8CYVrbU4/PVmVts1Ou7Ck3xXnvH6BJS4+4Up7ufIdGuAZSdKQ0c+j6P5ALwzEVv
	 8bH1JZMPbC32YwVSacY1ksXN8lR1CtL29/z1kXsOKGJdCCDCBaw5cSHDf4oQ/J1o3G
	 HraL0hy8X3edVdkDxV8chQFfJnSlHEUvGc7KnKOo=
Date: Fri, 10 Jul 2026 14:11:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	jirislaby@kernel.org, hvilleneuve@dimonoff.com
Subject: Re: [PATCH 0/2] serial: sc16is7xx: fix TX inter-frame gaps on SPI
 UARTs
Message-ID: <2026071002-override-android-1faa@gregkh>
References: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623112225.82386-1-paultyson.mbewe@ziehl-abegg.de>

On Tue, Jun 23, 2026 at 01:22:23PM +0200, Paul Mbewe wrote:
> This series fixes two related TX path issues in the sc16is7xx SPI UART
> driver that cause visible inter-frame gaps on the wire, breaking Modbus
> RTU communication.
> 
> Patch 1 fixes a data loss / gap caused by kfifo_out_linear_ptr() only
> returning one contiguous segment of the circular buffer. When TX data
> wraps around the kfifo boundary, the remainder is delayed until the next
> TX interrupt, producing a silence gap that violates the Modbus 1.5
> character-time limit.
> 
> Patch 2 raises the TX FIFO trigger level from 8 to 32 free spaces via
> the TLR register. The default trigger of 8 causes excessive SPI
> round-trips on slow single-core hosts, leading to TX FIFO underruns
> between bursts.
> 
> Tested on SC16IS752 (SPI, 1 MHz) on i.MX6ULL driving RS-485 at 115200
> baud. Oscilloscope confirmed both gap types are eliminated after the
> fix.
> 
> Paul Mbewe (2):
>   serial: sc16is7xx: fix TX gap caused by kfifo circular buffer
>     wrap-around
>   serial: sc16is7xx: set TX FIFO trigger level to half FIFO to prevent
>     underruns
> 
>  drivers/tty/serial/sc16is7xx.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
