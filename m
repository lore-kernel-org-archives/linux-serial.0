Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F796314D10;
	Mon, 24 Nov 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000129; cv=none; b=UhIym1lxQSn//upOVIIJFkKzE58Wwq36bEN4bkSbUPEhXA06r/toXBlnR0f1p1pu6iWj6OI6XAvV3PHH9zOJap+2XXM2NvfXR7re6brUj7iBU+N36JscCaN3iIrzpknuF+esnBniYqMFUEnXFOSVL/x49qqTbpLQNW8INAoOsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000129; c=relaxed/simple;
	bh=0u385lOK89SCsQP0LSKVMeSym3BaSwxB38uvRWiSAxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdTpY8YFg+/r0J/cdzpZC17316FVPtXBlXLAzPu6F3uyygRDPIIyRNfOwHv4BZPNBWE5PuT9ICKe5VH+nam9MXqfUebyDQRAhOMNw+X7CWjzRUIcBGUNxlxjlNc4L+ceOgStXGuZNoYkOaBQJbYRKNuyzJVP8qwqy9u+CgMAvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe68BQ0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe68BQ0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A70C4CEF1;
	Mon, 24 Nov 2025 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000128;
	bh=0u385lOK89SCsQP0LSKVMeSym3BaSwxB38uvRWiSAxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe68BQ0cG49iWFPB3ckKphWWut2XE8kQ+3ilVFpk3lQW8PFrXtdIkkI6NNwo7h6SV
	 AbtQeLXx1TGeQNjZ8ogj2nDRrJsPnsSt+y0BLAwlPyse0uQfYhfa0e5PWbvLMGNNmd
	 xScyhBJtewwq5rDGXzlT1zIspan0RE5FcW1y14deOH/6f0X8cqEFMqohXFkNk938D1
	 Qz80Lsx9+bXX/w7xEzfLiBxsnH4emboXxJeRGrIZbr3INdfG/a3boQZuSqrJx18Vrx
	 tYRfDVrAu0vJuWD5qX1hRoP5D4ycT0/p2t+Nf/RErUhSobK7kQzizQ1CRqsKami2Hm
	 KEKR2GIqrorNQ==
Date: Mon, 24 Nov 2025 06:02:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Message-ID: <aSSBfwm6L4jXqYor@slm.duckdns.org>
References: <20251027060929.394053-1-jackzxcui1989@163.com>
 <20251124051751.787161-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124051751.787161-1-jackzxcui1989@163.com>

On Mon, Nov 24, 2025 at 01:17:51PM +0800, Xin Zhao wrote:
> > +/**
> > + * tty_flip_wq_init -- prepare workqueue for tty/pty flip buffer work
> > + * @port: tty_port of the device
> > + * @driver: tty_driver for this device
> > + * @index: index of the tty
> > + *
> > + * Not all tty_port will be initialized by tty_port_init where tty_flip_wq will
> > + * be set to system_unbound_wq as default. Allocate workqueue with WQ_SYSFS for
> > + * flip buffer, so that cpumask and nice can be changed dynamically.
> > + */
> > +void tty_flip_wq_init(struct tty_port *port, struct tty_driver *driver,
> > +		      unsigned int index)
> > +{
> > +	char name[64];
> > +
> > +	if (driver->type == TTY_DRIVER_TYPE_PTY) {
> > +		port->buf.tty_flip_wq = pty_flip_wq;
> > +		return;
> > +	}
> > +	tty_line_name(driver, index, name);
> > +	if (!port->buf.tty_flip_wq
> > +		|| port->buf.tty_flip_wq == system_unbound_wq) {
> > +		port->buf.tty_flip_wq = alloc_workqueue("%s-flip-wq",
> > +							WQ_UNBOUND | WQ_SYSFS,
> > +							0, name);
> > +		if (unlikely(!port->buf.tty_flip_wq))
> > +			port->buf.tty_flip_wq = system_unbound_wq;
> > +	}
> > +}

These look overly elaborate to me. Just fail init if workqueue allocation
fails? Also, is it necessary for each port to have separate port?

Thanks.

-- 
tejun
