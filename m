Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9E2566F5;
	Fri, 24 Oct 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304909; cv=none; b=PDNo31iYfRL6hyYgizoIzr7RMvV8xXlWOQSidssMAj/kFRZMU8BO4I9oTjNTP46rbiv6ViKxE64JYJ2vHR1/y7hgc87sM+cHFFXNQ05JqkAalSVplAyK9FOYZ+iadIGZkonCHjjiiKUTNlmlglQNWDnPOazI3CKLUSwwPENrKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304909; c=relaxed/simple;
	bh=WVlWBgMcAuxyFhK1LJ4LllnwyQPDiIhUoSnMvvmVLoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Syyg2+tLWjVq/YXoORnR7QKTLfIJLnJzGYz4xAhj9NtFMgEjJ6ZmobIHSZ5nDon4QHdlhKv/3/FM6l+CurYX0lwLL3Aj2f9A7LdX6n9kxy+KqEChJt6WWirGsUKxvlyY+5fIecLCi+IYj5CYiGMr3JA9n140q8VD2UwRrYcV4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBqwV0Co; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBqwV0Co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3E6C4CEF1;
	Fri, 24 Oct 2025 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761304909;
	bh=WVlWBgMcAuxyFhK1LJ4LllnwyQPDiIhUoSnMvvmVLoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBqwV0CoOIwOaTVQ7S++bqnqxORg7Bkm4+I5uPKo9tLfuWEsV9i2lKHFq4BNmcxH8
	 i4jMPzALf48oxLKYOSwBqHdtQNXWgFMhf+kd0dezZB3i1euBm7SKpDdbQNAns96PBP
	 3SGRYWsMKKU7zwzH+gsDCiV7z+7C5BFzf40x2iSw=
Date: Fri, 24 Oct 2025 13:21:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, tj@kernel.org, hch@infradead.org
Subject: Re: [PATCH] serial: 8250_dma: add workqueue to flip tty buffer
Message-ID: <2025102434-stoppage-stagnate-5f0e@gregkh>
References: <20251024065120.1951924-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024065120.1951924-1-jackzxcui1989@163.com>

On Fri, Oct 24, 2025 at 02:51:20PM +0800, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push interface in the TTY
> layer uses system_unbound_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preeempted by real-time
> tasks or other high-prio tasks. dma_rx_complete calls spin_lock_irqsave
> which do not disable preempt but disable migrate in rt-linux, leading to
> the kworker thread running the dma_rx_complete work cannot be pulled by
> other cpu when idle_balance, causing long delays.
> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.
> Introduce wq_tty_flip in tty_port, allocating a workqueue using WQ_SYSFS,
> so that we can set cpumask and nice dynamically.
> We set the cpumask to the same cpu where the IMU data is handled and has
> less long-time high-prio jobs, and then set nice to -20, the frame
> processing interval remains between 10 and 15ms, no jitter occurs.
> 
> ---
> Change in v2:
> - Do not add new module parameters
>   as suggested by Greg KH
> - Set WQ_SYSFS to allow properties changes from userspace
>   as suggested by Tejun Heo
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 19 ++++++++++++++++++-
>  drivers/tty/tty_buffer.c           |  2 +-
>  include/linux/tty_port.h           |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index bdd26c9f3..7ff705a78 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -207,6 +207,7 @@ EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
>  int serial8250_request_dma(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma	*dma = p->dma;
> +	struct tty_port		*tport = &p->port.state->port;
>  	phys_addr_t rx_dma_addr = dma->rx_dma_addr ?
>  				  dma->rx_dma_addr : p->port.mapbase;
>  	phys_addr_t tx_dma_addr = dma->tx_dma_addr ?
> @@ -244,6 +245,11 @@ int serial8250_request_dma(struct uart_8250_port *p)
>  		goto release_rx;
>  	}
>  
> +	/* Use the default workqueue then if alloc_workqueue failed */
> +	tport->wq_tty_flip = alloc_workqueue("ttyS%d-flip-wq",
> +					     WQ_UNBOUND | WQ_SYSFS,
> +					     0, p->port.line);
> +
>  	dmaengine_slave_config(dma->rxchan, &dma->rxconf);
>  
>  	/* Get a channel for TX */
> @@ -252,7 +258,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
>  						       p->port.dev, "tx");
>  	if (!dma->txchan) {
>  		ret = -ENODEV;
> -		goto release_rx;
> +		goto release_rx_wq;
>  	}
>  
>  	/* 8250 tx dma requires dmaengine driver to support terminate */
> @@ -294,6 +300,11 @@ int serial8250_request_dma(struct uart_8250_port *p)
>  	return 0;
>  err:
>  	dma_release_channel(dma->txchan);
> +release_rx_wq:
> +	if (tport->wq_tty_flip) {
> +		destroy_workqueue(tport->wq_tty_flip);
> +		tport->wq_tty_flip = NULL;
> +	}
>  release_rx:
>  	dma_release_channel(dma->rxchan);
>  	return ret;
> @@ -303,6 +314,7 @@ EXPORT_SYMBOL_GPL(serial8250_request_dma);
>  void serial8250_release_dma(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma *dma = p->dma;
> +	struct tty_port *tport = &p->port.state->port;
>  
>  	if (!dma)
>  		return;
> @@ -322,6 +334,11 @@ void serial8250_release_dma(struct uart_8250_port *p)
>  	dma->txchan = NULL;
>  	dma->tx_running = 0;
>  
> +	if (tport->wq_tty_flip) {
> +		destroy_workqueue(tport->wq_tty_flip);
> +		tport->wq_tty_flip = NULL;
> +	}
> +
>  	dev_dbg_ratelimited(p->port.dev, "dma channels released\n");
>  }
>  EXPORT_SYMBOL_GPL(serial8250_release_dma);
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 67271fc0b..7f83f377f 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
>  	struct tty_bufhead *buf = &port->buf;
>  
>  	tty_flip_buffer_commit(buf->tail);
> -	queue_work(system_unbound_wq, &buf->work);
> +	queue_work(port->wq_tty_flip ?: system_unbound_wq, &buf->work);

Why not just do this for all tty ports?  What is the benifit of keeping
this on the system_unbound_wq for all other tty devices?

>  }
>  EXPORT_SYMBOL(tty_flip_buffer_push);
>  
> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index 332ddb936..f5a5e50ff 100644
> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -121,6 +121,7 @@ struct tty_port {
>  	int			drain_delay;
>  	struct kref		kref;
>  	void			*client_data;
> +	struct workqueue_struct *wq_tty_flip;
>  };

You forgot to document this new member, and so the documentation build
will throw a warning.

thanks,

greg k-h
