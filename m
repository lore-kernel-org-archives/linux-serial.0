Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897E3148AC;
	Mon, 24 Nov 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000154; cv=none; b=DTdyrSgOvzK474NRdbyOnc5nCDpEl/YTQc+9R1vgovm4kK7klkeW66TKIBcD2F5ZRdc5+d0BQdhc7gARePZAFPi5T78bPdZv1BSzTiJo0BodTqO0hPbDno90ed1Jq9oWER0LR/VUFRrL/cihKNFSTd8IX4MnNG4vCAD8SSjIJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000154; c=relaxed/simple;
	bh=OSi4ZJKGdGP/3t5RRaWWFdDqz9rVP4KCD0GQp0gZY2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5+5TNkQE5tqT2kbgWGEj9U0Am3cDCk1DZZ/GeUgo3Vu5J6jlM2SNRW7oABW6cPxH3R8jbByVRKELOZEgJTATX+0pvqXgw1OAf40QRA9PKnmJtdXJSav6YO6WJ8Nf3wg6+oJWrvexWJilUrfex5cqXaM+J/0VrUqjN6egzEFypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEhuPevG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEhuPevG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0F0C4CEF1;
	Mon, 24 Nov 2025 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000154;
	bh=OSi4ZJKGdGP/3t5RRaWWFdDqz9rVP4KCD0GQp0gZY2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEhuPevGHu8V2F6FH6cEvyKAvOYFt3yHAbfzvpqCKMk1oZbWup9BpvVTC44b6eQMJ
	 8SGQ6jVVGa3AobQDp45ThFHtMbtJiauRVB52j22nVEqZiwQNiG/fNrqFk5BNoyg1Nd
	 nRHttLAZ0VP575VlyoBgqUX8wHxMZknY6iGVbkd5d0Kh6GL7g6nYxOW7oeGTyBfasD
	 Iqlnl7sL5SksqPCooKQyPHq7LPu/j0BsSkSjmkBCDM5j3hODvZJtTQYW2zav4P/Mzc
	 qpjsbfKTsnB/4O54/0RzlPEAERhzGqG6p/36ch58nJjZbj3Plbd/7BH5JnlhS2w342
	 TtdQTGPo7reWg==
Date: Mon, 24 Nov 2025 06:02:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Message-ID: <aSSBmStZfV9XL7IL@slm.duckdns.org>
References: <20251027060929.394053-1-jackzxcui1989@163.com>
 <20251124051751.787161-1-jackzxcui1989@163.com>
 <aSSBfwm6L4jXqYor@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSBfwm6L4jXqYor@slm.duckdns.org>

On Mon, Nov 24, 2025 at 06:02:07AM -1000, Tejun Heo wrote:
> On Mon, Nov 24, 2025 at 01:17:51PM +0800, Xin Zhao wrote:
> > > +/**
> > > + * tty_flip_wq_init -- prepare workqueue for tty/pty flip buffer work
> > > + * @port: tty_port of the device
> > > + * @driver: tty_driver for this device
> > > + * @index: index of the tty
> > > + *
> > > + * Not all tty_port will be initialized by tty_port_init where tty_flip_wq will
> > > + * be set to system_unbound_wq as default. Allocate workqueue with WQ_SYSFS for
> > > + * flip buffer, so that cpumask and nice can be changed dynamically.
> > > + */
> > > +void tty_flip_wq_init(struct tty_port *port, struct tty_driver *driver,
> > > +		      unsigned int index)
> > > +{
> > > +	char name[64];
> > > +
> > > +	if (driver->type == TTY_DRIVER_TYPE_PTY) {
> > > +		port->buf.tty_flip_wq = pty_flip_wq;
> > > +		return;
> > > +	}
> > > +	tty_line_name(driver, index, name);
> > > +	if (!port->buf.tty_flip_wq
> > > +		|| port->buf.tty_flip_wq == system_unbound_wq) {
> > > +		port->buf.tty_flip_wq = alloc_workqueue("%s-flip-wq",
> > > +							WQ_UNBOUND | WQ_SYSFS,
> > > +							0, name);
> > > +		if (unlikely(!port->buf.tty_flip_wq))
> > > +			port->buf.tty_flip_wq = system_unbound_wq;
> > > +	}
> > > +}
> 
> These look overly elaborate to me. Just fail init if workqueue allocation
> fails? Also, is it necessary for each port to have separate port?

Sorry, I meant a separate workqueue.

-- 
tejun
