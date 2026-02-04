Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F6353ED1;
	Wed,  4 Feb 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193239; cv=none; b=aiT3FOpcDa/XmEBJIPqALDL4fyrWaYRAcW6zy50zW5SX0ttjXYUD2f2b5rGwdKQ5u7zbUwSQnvlIPMULGG2n6kQhvsAYECvjFlT3QptFhZI/tFxiRkJYp03TYZXARbjvVfkW1sYys2OzpsQIwfdy3bW8yIMsfmgPySWVSM+OHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193239; c=relaxed/simple;
	bh=yUYwL4XsrR+ssKF3suhcgL7xpxD2Y1iYxcpkETNLAv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qng847bw6uBnrXMSEnTJYtfwKJ2o32W09Q/L/N/3agzlKSjg3BG3oev2kHQu+GbCyAia8X5vKLBexcwzQPZpa7QIVA/bvFrmByXS7DAVwnSYg3Kbr0/UPqYpuuErP+LVaBRVZ4Kn0Kx7CF5mvbyOdalHH9/yGq46WX4jgfWxM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiPC4yRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiPC4yRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A4CC4CEF7;
	Wed,  4 Feb 2026 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770193238;
	bh=yUYwL4XsrR+ssKF3suhcgL7xpxD2Y1iYxcpkETNLAv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xiPC4yRZsd3oXgvJOEFE16bdJ+ta8VA5pTnj+295pgJbTe5B2kTQeo2H+K2sbcaPp
	 fBVLxynvl5bVwWDToGiNLbVpZxY7h/ClVDEkKLat1P1V6Fh8sCcWS1aI//Tsl3P6E8
	 JldMCQn/h6HSQLJpsycTy8mkiEMIeRo01mIJLaoc=
Date: Wed, 4 Feb 2026 09:20:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-serial@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Joseph Tilahun <jtilahun@astranis.com>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] serial: core: fix infinite loop in handle_tx() for
 PORT_UNKNOWN
Message-ID: <2026020459-lisp-display-0506@gregkh>
References: <20260204074327.226165-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074327.226165-1-jiayuan.chen@linux.dev>

On Wed, Feb 04, 2026 at 03:43:20PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> uart_write_room() and uart_write() behave inconsistently when
> xmit_buf is NULL (which happens for PORT_UNKNOWN ports that were
> never properly initialized):

How does this happen?  Why were they not initialized properly, what
drivers/hardware cause this?

> - uart_write_room() returns kfifo_avail() which can be > 0
> - uart_write() checks xmit_buf and returns 0 if NULL
> 
> This inconsistency causes an infinite loop in drivers that rely on
> tty_write_room() to determine if they can write:
> 
>   while (tty_write_room(tty) > 0) {
>       written = tty->ops->write(...);
>       // written is always 0, loop never exits
>   }
> 
> For example, caif_serial's handle_tx() enters an infinite loop when
> used with PORT_UNKNOWN serial ports, causing system hangs.
> 
> Fix by making uart_write_room() also check xmit_buf and return 0 if
> it's NULL, consistent with uart_write().
> 
> Reproducer: https://gist.github.com/mrpre/d9a694cc0e19828ee3bc3b37983fde13
> 
> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")

This really isn't a fix for that driver, but rather something else.

> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This doesn't make sense, signing off twice for the same person?

As you did this from your shopee.com account, that should be sufficient.

> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 2805cad10511..0b2edf185cc7 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -643,7 +643,10 @@ static unsigned int uart_write_room(struct tty_struct *tty)
>  	unsigned int ret;
>  
>  	port = uart_port_ref_lock(state, &flags);
> -	ret = kfifo_avail(&state->port.xmit_fifo);
> +	if (!state->port.xmit_buf)

This feels odd.  What ports have no transmit buffers?  And why would
this be the only check that is needed for such broken devices?

Maybe let's fix the root cause here, the driver that does not have a
transmit buffer at all?

thanks,

greg k-h
