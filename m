Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE83195E8;
	Wed, 26 Nov 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159053; cv=none; b=g9LI676UAYrNfWXIRD+PLOz60MWQOQpKgyO7+OeabhQc7jtAC8F0nd2fUInYGqq0NASaqIjzF3KQFtunkjsOj3irWO0dteIIDjeDW2jUaORbmso9ZRAA6YrjEtAb27UU+eJgk3lF5EUbO4oMt2c0/fdULaXeFj7D76r5hOQdtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159053; c=relaxed/simple;
	bh=QwbWcfcQFyX/LKtEAUpA3ixW7FvWTh6FC3/HlmhidxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHiVu6gqAzy2lkVnhnUJJIjGjInxPPkruGcXSSaXm3XfrfgMoD11YBUYVZZnJvCdHy7KeD0TgNKCenVrz4c0ec/aGdrdYjdU3o4cFzflDw7M/AIC0XTSjy179XLKSTeB6qZVygd3/1o5CkIMs/5iaIWTSBO1tpdRLg6Jd3CdIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gNlCTb6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gNlCTb6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A04CC113D0;
	Wed, 26 Nov 2025 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764159052;
	bh=QwbWcfcQFyX/LKtEAUpA3ixW7FvWTh6FC3/HlmhidxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNlCTb6KX+SJG66tljFBijnd39R9srcuQ37hxq6hq4M2Yu5HIQmg3alcQdw89UDAl
	 rRUBDEXG6FonlD2OUNKiBognvHNdZuyCDN2IJeRaa6/ruw4Gga3HF8eADknr9JLvQn
	 R2aoicgNLjWN1nF4hlkukbQ5hYcaShI9aJqP0648=
Date: Wed, 26 Nov 2025 13:10:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: tj@kernel.org, jirislaby@kernel.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Message-ID: <2025112654-shaping-undoing-afe4@gregkh>
References: <aSSBfwm6L4jXqYor@slm.duckdns.org>
 <20251125021959.1509256-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125021959.1509256-1-jackzxcui1989@163.com>

On Tue, Nov 25, 2025 at 10:19:59AM +0800, Xin Zhao wrote:
> On Mon, Nov 24, 2025 at 06:02:07AM -1000 Tejun Heo <tj@kernel.org> wrote:
> 
> > > On Mon, Nov 24, 2025 at 01:17:51PM +0800, Xin Zhao wrote:
> > > > > +/**
> > > > > + * tty_flip_wq_init -- prepare workqueue for tty/pty flip buffer work
> > > > > + * @port: tty_port of the device
> > > > > + * @driver: tty_driver for this device
> > > > > + * @index: index of the tty
> > > > > + *
> > > > > + * Not all tty_port will be initialized by tty_port_init where tty_flip_wq will
> > > > > + * be set to system_unbound_wq as default. Allocate workqueue with WQ_SYSFS for
> > > > > + * flip buffer, so that cpumask and nice can be changed dynamically.
> > > > > + */
> > > > > +void tty_flip_wq_init(struct tty_port *port, struct tty_driver *driver,
> > > > > +		      unsigned int index)
> > > > > +{
> > > > > +	char name[64];
> > > > > +
> > > > > +	if (driver->type == TTY_DRIVER_TYPE_PTY) {
> > > > > +		port->buf.tty_flip_wq = pty_flip_wq;
> > > > > +		return;
> > > > > +	}
> > > > > +	tty_line_name(driver, index, name);
> > > > > +	if (!port->buf.tty_flip_wq
> > > > > +		|| port->buf.tty_flip_wq == system_unbound_wq) {
> > > > > +		port->buf.tty_flip_wq = alloc_workqueue("%s-flip-wq",
> > > > > +							WQ_UNBOUND | WQ_SYSFS,
> > > > > +							0, name);
> > > > > +		if (unlikely(!port->buf.tty_flip_wq))
> > > > > +			port->buf.tty_flip_wq = system_unbound_wq;
> > > > > +	}
> > > > > +}
> > > 
> > > These look overly elaborate to me. Just fail init if workqueue allocation
> > > fails? Also, is it necessary for each port to have separate port?
> > 
> > Sorry, I meant a separate workqueue.
> 
> I admit it is a bit complex.
> I searched for a long time and found in function tty_port_link_device seems to be an
> appropriate place to initialize the workqueue. However, the tty_port_link_device
> interface does not return a value, so error handling seems to be quite difficult.
> 
> Greg KH suggested creating a workqueue for each tty port, as follow:
> > >  
> > >  	tty_flip_buffer_commit(buf->tail);
> > > -	queue_work(system_unbound_wq, &buf->work);
> > > +	queue_work(port->wq_tty_flip ?: system_unbound_wq, &buf->work);
> > 
> > Why not just do this for all tty ports?  What is the benifit of keeping
> > this on the system_unbound_wq for all other tty devices?
> 
> I think if there are many tty devices on the system, having separate workqueues
> might be the right approach. Or should a single tty_driver share one?
> 
> Greg and Jiri Slaby have any comments on this?

I don't know, what have you found in your testing?  Will multiple
workqueues cause too much overhead for large multi-port systems (i.e.
modem banks?)

Perhaps start with just a single workqueue and then increase it if there
is contention later if people notice?

thanks,

greg k-h
