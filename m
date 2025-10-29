Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59271E766E;
	Wed, 29 Oct 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733038; cv=none; b=fhQFubQ/Whtc6MkbdwBCKxMd8if7RJOd4eRqCqhjwuGe3lwLKDGhcH77v9PSe4EM6tmYmeb4fPgG5KziCM9ijVwQw1PQMEh64S5j4F5hlXeYvVZf9fskj6tfw709PbLHrPugkL1RwHEAG0pCxEv2kkqXDs25lzzFNIwBsB8A77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733038; c=relaxed/simple;
	bh=LByAXLZ9ll/ixgdmWs87gLszdmGDNLHhwbBIKEopj/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heHbfjz74qXqFyaMOw1ajkVG7i2mHOzc9seduvzrQ1YuxQd29qR6CKElzTNAWBXkYsUg2mWbgD0oHpM9cl9TkkuJ4zQsCer0s5oig8KVSvyr8rcvFjLCoksXQXVnZJD1O8X2+wU/bZkrHDK1358oPXugPItowyLWcc5ZKekz4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYPOHMqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYPOHMqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A04C4CEF7;
	Wed, 29 Oct 2025 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761733038;
	bh=LByAXLZ9ll/ixgdmWs87gLszdmGDNLHhwbBIKEopj/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYPOHMqt0YYSrDAC6pql5TZ/fDIPxKboiqxD8+fvq7qR8xl9H1ajp2WN75nJH+WKC
	 bMc+naCctmVuFB9JimG8t3J/kDEBBl8EBraXFGj6UWAN5XXNe+cqurF8rCl1mFzKJ2
	 kNQ2NQPVpklaimtMv0SdP1P0ZStyxwQtbeUnZd7E=
Date: Wed, 29 Oct 2025 11:17:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: jirislaby@kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: ma35d1: Fix resource leaks on driver removal
Message-ID: <2025102900-rebound-semicolon-0d98@gregkh>
References: <20251029080039.1010-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029080039.1010-1-vulab@iscas.ac.cn>

On Wed, Oct 29, 2025 at 04:00:39PM +0800, Haotian Zhang wrote:
> The driver fails to release resources acquired during probe. It calls
> of_clk_get() to obtain the clock reference but never calls clk_put()
> in the remove path, leaking the clock reference count. Similarly, it
> calls ioremap() to map UART registers but never calls iounmap() during
> removal, leaking the I/O memory mapping.
> 
> Switch to devm_clk_get() for automatic clock resource management and
> add iounmap() call in ma35d1serial_remove() to properly release the
> memory mapping.
> 
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
