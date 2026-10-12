Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F940DB2E;
	Mon, 12 Oct 2026 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786709; cv=none; b=EdlKPTT+VEG60VKNk+Bfc+fhGcO+UaqbzkrJZ3mS6E+prAe9OuSMsNqdcRDzrV0kfSU7UfF+T/K1xIAKMYmDlqy3scEq7LkueQiSDCoLs8MUdrAvhY0lYqrgdQB8n+1FPVftK8jcP4AEyNtN9Qwdyqf7Fv0KLPRLJfSXt8ZLrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786709; c=relaxed/simple;
	bh=pcAAxOQYR2s4WCd+/VUKmNEMWu1J+vuW2LKZIKEnymM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK10M5Gyju8BAY9EjGQod6y22lDnK5kXqw3WjTjUEIUheBZliEUUBeVBSHcsRAss+NOzx9zqxVytBzixweZAEnWhB2tvMCaob9TNkCGfVmdEA1LGMmyMyZqALRY4ysQPzDIww823LyHssAmiztpqAKM1CL7t4RljOca06r/5+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIwNGAvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIwNGAvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500231F0089B;
	Mon, 12 Oct 2026 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791786707;
	bh=jrRNIoeqFmfUf2HXNDVID6+1BKPd3Foz89yyIKCKf6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIwNGAvGI95KBDZRcg96NUkYrHvskf0ec/2Dhx6YD6LzZA4BO1ASY68Cbsm6WWsjB
	 xmD0q6NERZGhXPecQxwp5OIsGVTFwrpz7TDTkB6m7oAB7RyjeIf4d/kz+wyAShbrs7
	 J/NFkD3zhXqMbqqWeTyGLc4eP3VlJxtprRO5oZsk=
Date: Mon, 12 Oct 2026 08:31:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: khaliforce <kforce@gmail.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_dw: retain programmed timing for BUSY waits
Message-ID: <2026101225-footman-retail-1338@gregkh>
References: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>

On Mon, Oct 12, 2026 at 06:10:20AM -0000, khaliforce wrote:
> Baud changes update frame_time before the programmed divisor changes.
> A switch to a faster baud rate therefore shortens the DesignWare BUSY
> wait.
> The wait can expire while a frame at the old baud rate remains active.
> 
> Use the programmed frame duration for FIFO and BUSY waits.
> Account for UART clock changes.
> 
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Signed-off-by: khaliforce <kforce@gmail.com>
> ---
> Compared the complete patch off/on on MangoPi MQ Pro UART0.
> Kept other port patches, kernel options and DTB identical.
> Tested BUSY changes from 9600, 1200 and 300 to 115200.
> All 11 paired changes fail without the patch and pass with it.
> Each trial returns 64 matching loopback bytes.

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
