Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7423BD01;
	Tue, 21 Oct 2025 04:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761020907; cv=none; b=sBcZ44Fo9kiIsUwE9dsaUOLPoSKnJDyHDC5pxx14GxCvhV4em3KVhzRggT7zHDKo48O+l3SrjcVeR9QQ1mhIH7osU22xHQgiNYRyMljaGUDWm6K70uHAkDTQxTGbVjh0jI8jrVD/oksA1R1JE7r1ZjsPsVdK8QqEMTKRz+t9x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761020907; c=relaxed/simple;
	bh=emy1pYDXajFwtXEqHorg5DOEydGYxlHWSwCycqSED3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGOhZJRx2BECzEUptE0GpGApqP9vyDcZy6dGTzVs1nxGJHTePNmLp7Kw9ruiD7ZxyTXkaiFwY/5oy1ucVtr3ZDMChaZatkFJcgSlsajR1nd2GJBr7qtnGrvhnW85icfruVSpWxDMbBrWGX8bdlnYzOn9gAU3buKZd6AuogShh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+p0Tj4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+p0Tj4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF3BC4CEF1;
	Tue, 21 Oct 2025 04:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761020906;
	bh=emy1pYDXajFwtXEqHorg5DOEydGYxlHWSwCycqSED3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+p0Tj4CpnYxI0epzkGKL3rr3q6W09ruV4NyA3AgfDsjyyiA98Xf5QwAU5Yyq1lXp
	 YEb7TPuCGjv4oF//C6J8NeOxJN8HFJ4NIv7mLydtXqy6rxPo3fFn2hbAhcA/529u1u
	 OopvVqW+RRYvWlGroEyDlz9g3RVOgtBbW0W8Uv2w=
Date: Tue, 21 Oct 2025 06:28:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, tj@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tty: tty_buffer: add interface to queue work on specific
 wq and cpu
Message-ID: <2025102141-quintuple-oozy-f2f6@gregkh>
References: <20251021042110.513095-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021042110.513095-1-jackzxcui1989@163.com>

On Tue, Oct 21, 2025 at 12:21:10PM +0800, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. We have customized our own 8250 driver, but
> we still need to reuse the kernel's TTY layer. The tty_flip_buffer_push
> interface in the TTY layer uses system_unbound_wq to handle the flipping
> of the TTY buffer. Although the unbound workqueue can create new threads
> on demand and wake up the kworker thread on an idle CPU, the priority of
> the kworker thread itself is not high. Even if the CPU running this work
> was idle just a moment ago, it may be preempted by real-time tasks or
> other high-priority tasks.
> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.
> Adding the tty_flip_buffer_push_wq interface would allow our 8250 driver
> code to push work to a specified CPU. Since CPU tasks, especially real-time
> tasks, often have a certain distribution pattern in the system, we found
> that by pushing to a specified CPU with a WQ_HIGHPRI workqueue, we can
> stably eliminate the jitter and ensure that the frame processing interval
> remains between 10 and 15 ms. Furthermore, if we implement an RT workqueue
> based on this, using the tty_flip_buffer_push_wq interface to push to the
> RT workqueue(FIFO 1) we can further stabilize the processing interval,
> significantly reducing the occurrences of 14-15 ms intervals and increasing
> the frequency of 11-12 ms intervals.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
>  drivers/tty/tty_buffer.c | 23 +++++++++++++++++++++++
>  include/linux/tty_flip.h |  3 +++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 67271fc0b..112a650e2 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -534,6 +534,29 @@ void tty_flip_buffer_push(struct tty_port *port)
>  }
>  EXPORT_SYMBOL(tty_flip_buffer_push);
>  
> +/**
> + * tty_flip_buffer_push		-	push terminal buffers
> + * @port: tty port to push
> + * @wq: workqueue on which to queue work
> + * @cpu: cpu on which to queue work
> + *
> + * Queue a push of the terminal flip buffers to the line discipline. Can be
> + * called from IRQ/atomic context.
> + *
> + * In the event of the queue being busy for flipping the work will be held off
> + * and retried later.
> + */
> +void tty_flip_buffer_push_wq(struct tty_port *port,
> +			     struct workqueue_struct *wq,
> +			     int cpu)
> +{
> +	struct tty_bufhead *buf = &port->buf;
> +
> +	tty_flip_buffer_commit(buf->tail);
> +	queue_work_on(cpu, wq, &buf->work);
> +}
> +EXPORT_SYMBOL(tty_flip_buffer_push_wq);

For obvious reasons, we can not accept new kernel apis without any
in-kernel user.  Please submit this as part of a patch series that adds
the new user.

thanks,

greg k-h
