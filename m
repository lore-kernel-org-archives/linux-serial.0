Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7240BCCE
	for <linux-serial@vger.kernel.org>; Tue, 16 Jun 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596387; cv=none; b=sgvwm+mSCqCo+w5mXoK0eJFm6Pz9a8rvtVhHTYCYnqjvpruwJ4dqqW7xUod4QRbdp0AmFnlMHsA53vkhk48+hdyJeByBeSr7qdpY/Trn90MwBqC3k94E+AkKdtWMp87Ke0AwHNZCmKN7uFlu3QVRE8DYLIZgbZ9+DECuOLNJ+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596387; c=relaxed/simple;
	bh=2N5U4VR48x+ICZ/epXJr7ST4+COUb0jAIFnFK0cVD40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls/7X5kRcHHkIvuEybo8bjUwXibYJISSY2Yquu+9Q/ak8hTFSPp1oL6bv1Hf07kKvAAJB7pn78mm1daOKyvVCoIgSnvCpTV6CFUJD+ffezhPb9zMLl6uokbSA9ZLC3TT8UtEqllCSoG8+h+HV9VfAUp/+bQuEELtDlnXiw8EVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OB/P3RxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OB/P3RxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065171F00A3A;
	Tue, 16 Jun 2026 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781596385;
	bh=0oBpqwzzJqQw8juymF4MW/C4m6TlvwbgiV/XQjptyRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OB/P3RxMfbS3noDglftWyquRH1ZmHTzdo7RgZidvcEW7PLY6OBvIpwSatw0ZJNMRH
	 gpybfsxzTSTA5Z04QDdaUJO6/UgzxiAbFNwtMIMpnYQIsJTTlwYp2DqD3QPaG9TtMw
	 ynti6ZQQaP8iHkc+c/2s3Ejfa0zIdsfT/KtDOOn0=
Date: Tue, 16 Jun 2026 13:22:01 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Craig McQueen <craig@mcqueen.au>
Cc: linux-serial <linux-serial@vger.kernel.org>
Subject: Re: 8250_dw system pause due to IRQ load
Message-ID: <2026061634-phonics-carpenter-3ba1@gregkh>
References: <19eba567d94.1f5854744141363.4614464714670279886@mcqueen.au>
 <19ecf63b8bf.3059f90c1678338.4949518025835217958@mcqueen.au>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ecf63b8bf.3059f90c1678338.4949518025835217958@mcqueen.au>

On Tue, Jun 16, 2026 at 05:44:39PM +1000, Craig McQueen wrote:
> I previously wrote:
> 
>  > I have a Rockchip RK3328 based embedded Linux system, using the 8250_dw driver (device tree "snps,dw-apb-uart") for serial console and other serial ports. I'm using Yocto scarthgap with kernel v6.6.123. 
>  >  
>  > It is talking to a microprocessor via a serial protocol at 921600 bps. Multiple times per hour, I see the serial protocol TX pause for 100 to 4500 ms. Usually the whole Linux system pauses during this time (realtime and monotonic clocks don't tick). mpstat shows high irq load. /proc/interrupts shows the 8250_dw interrupt count is going significantly higher during this time. 
>  >  
>  > I'm also seeing complete system lock-ups occur every 1 to 72 hours, with no diagnostic information shown in the kernel serial console output. 
>  >  
>  > Are there any known issues with the 8250_dw interrupt handler causing high CPU load, that I should try backporting to kernel v6.6? 
>  >  
>  > I've written some kernel drivers, but I have no experience debugging interrupt handler issues, especially when it's an issue that prevents the kernel doing console output. I would appreciate any advice on kernel facilities that are suitable to debug this type of bug. 
> 
> I have been able to diagnose serial TX pauses, using trace_printk() in the interrupt handler. The cause of TX pauses is many repeated `UART_IIR_RX_TIMEOUT` interrupts. The serial device appears to randomly get out of this state.
> 
> I see the 8250_dw interrupt handler has a work-around to stop these `UART_IIR_RX_TIMEOUT` interrupts when the FIFO is empty. But it has only been enabled for non-DMA mode. But for the Rockchip RK3328, the serial device is configured for DMA mode. But in our usage, we're still seeing this issue randomly appear.
> 
> I have modified the 8250_dw interrupt handler to do the work-around even in DMA mode. This seems to resolve the repeated `UART_IIR_RX_TIMEOUT` interrupts, and eliminate the TX pauses.
> 
> My testing shows that this doesn't fix my other problem, of complete system lock-ups. I don't yet know if that is also 8250_dw related.

Note, many changes have happened in this driver since 6.6.y, can you try
the 7.1 release to see if it has been resolved there?

thanks,

greg k-h
