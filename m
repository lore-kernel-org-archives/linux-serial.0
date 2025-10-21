Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DA2F4A1B;
	Tue, 21 Oct 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046133; cv=none; b=kX9tRwwqgyF0iYioE7BZ9sR4R0tD/jEFq6QNcB++rG+3mlReUJBNFKh6+sCv6W8XMAYGIC5YFbGlkkWH1E4YrktjGDWLKnEPNPGJnTebYVb2RuxaDLYM4bzLrJboCBC2Y3lCTIKklA8OBsXbtTk54XRFBr3Y9xppAgHvMYaMEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046133; c=relaxed/simple;
	bh=/LAo/XgiJw3yP/NruDjQn14rn0dicvR7MvhTnc73HZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F53pVLEc4pRFRbPVFiW3toLMCerFphndoZLBZDUlQ9PCO2k26BDOjiHt/0pSSNJB8Ffa/XPGd/vCmGoFBe4J4LNiOdRu/0K3FltTfEPyyG97o/fzmRyrLT95mtqRaCc5iDcbiwdDObslpwYnetqYR3PLuC+M4wU754Ib3oYz5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+Le7Y7c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+Le7Y7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D72EC4CEF1;
	Tue, 21 Oct 2025 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761046132;
	bh=/LAo/XgiJw3yP/NruDjQn14rn0dicvR7MvhTnc73HZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+Le7Y7cpYeyev2yLI9fzD4vPa1GFAzLnlyXdtGJ2G/OzBCZ/rmyFfbtAmSdhWFnY
	 tdlGke0RVGfH3A/Z9rbS25PEtlS8JanYEL9mckK+LQzGwa0kCqaHby3UXUv6VXiucy
	 UmP+ZTsDWXCW3fGYEZCArgXP/YlPH9VhlPB9FD5k=
Date: Tue, 21 Oct 2025 13:28:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, tj@kernel.org, hch@infradead.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on
 specific cpu
Message-ID: <2025102157-goal-grandma-36d4@gregkh>
References: <20251021083947.705135-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021083947.705135-1-jackzxcui1989@163.com>

On Tue, Oct 21, 2025 at 04:39:47PM +0800, Xin Zhao wrote:

Meta-comment, this is a v2, and was not threaded with patch 1/1.  Please
use a tool like b4 or git send-email to send patches out so that we can
properly review/apply them.

> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push interface in the TTY
> layer uses system_unbound_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, the priority of the kworker thread
> itself is not high. Even if the CPU running this work was idle just a
> moment ago, it may be preempted by real-time tasks or other high-priority
> tasks.

Are you using the RT kernel?  It seems odd that this is just coming up
now, given our normal latency issues in the tty layer.  What changed to
cause this?

> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.

Again, are you using the RT kernel?  If not, can you try that?

> Add module param tty_flip_cpu to queue rx complete work on the specific
> cpu by tty_flip_buffer_push_wq.

This is not the 1990's, we don't add new module parameters :)

This will not work for systems with multiple tty devices/drivers, please
use a correct api for this if you really really need it.

But again, I think this might not be needed if you use the RT kernel
issue.

> The default value of tty_flip_cpu is
> WORK_CPU_UNBOUND which means using the default system_unbound_wq called
> by tty_flip_buffer_push, otherwise we use the newly added workqueue
> wq_tty_flip which is set to WQ_HIGHPRI to promote performance.
> We set tty_flip_cpu to a specific CPU core that has relatively few
> real-time tasks running continuously for long periods. Additionally,
> tasks on this core have some correlation with the UART data related to
> the 8250 DMA operation. After queuing work to this designated CPU and
> set workqueue to WQ_HIGHPRI, we can stably eliminate the jitter and
> ensure that the frame processing interval remains between 10 and 15 ms.
> If we do not add the WQ_HIGHPRI flag, our testing on the platform shows
> that there are still spikes occurring approximately once every hour.
> Considering that projects utilizing this optimization feature must have
> encountered similar issues to ours, just add the WQ_HIGHPRI flag in the
> patch, without adding new module parameters for selection.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
>  drivers/tty/serial/8250/8250.h     |  2 ++
>  drivers/tty/serial/8250/8250_dma.c | 46 ++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index cfe6ba286..e6da925df 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -20,6 +20,8 @@ struct uart_8250_dma {
>  	void (*prepare_tx_dma)(struct uart_8250_port *p);
>  	void (*prepare_rx_dma)(struct uart_8250_port *p);
>  
> +	struct workqueue_struct *wq_tty_flip;
> +
>  	/* Filter function */
>  	dma_filter_fn		fn;
>  	/* Parameter to the filter function */
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index bdd26c9f3..9a0abee62 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -38,6 +38,35 @@ static void __dma_tx_complete(void *param)
>  	uart_port_unlock_irqrestore(&p->port, flags);
>  }
>  
> +#define TTY_FLIP_WORK_CPU		WORK_CPU_UNBOUND
> +
> +static int wq_tty_flip_cpu = TTY_FLIP_WORK_CPU;
> +
> +static int param_set_tty_flip_cpu(const char *val,
> +					const struct kernel_param *kp)
> +{
> +	int cpu;
> +	int ret;
> +
> +	ret = kstrtoint(val, 0, &cpu);
> +	if (ret)
> +		return ret;
> +
> +	if ((cpu >= 0 && cpu < nr_cpu_ids) || cpu == WORK_CPU_UNBOUND)
> +		wq_tty_flip_cpu = cpu;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops tty_flip_cpu_ops = {
> +	.set	= param_set_tty_flip_cpu,
> +	.get	= param_get_int,
> +};
> +
> +module_param_cb(tty_flip_cpu, &tty_flip_cpu_ops, &wq_tty_flip_cpu, 0644);
> +
>  static void __dma_rx_complete(struct uart_8250_port *p)
>  {
>  	struct uart_8250_dma	*dma = p->dma;
> @@ -61,7 +90,10 @@ static void __dma_rx_complete(struct uart_8250_port *p)
>  	p->port.icount.rx += count;
>  	dma->rx_running = 0;
>  
> -	tty_flip_buffer_push(tty_port);
> +	if (wq_tty_flip_cpu == WORK_CPU_UNBOUND)
> +		tty_flip_buffer_push(tty_port);
> +	else
> +		tty_flip_buffer_push_wq(tty_port, dma->wq_tty_flip, wq_tty_flip_cpu);

So you just bound ALL tty devices to the same cpu?  That feels very
wrong, how will that work with multiple devices on different interrupts
coming in on different cpus?

Why not just queue this up on the cpu that the irq happened on instead?

thanks,

greg k-h
