Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B149659;
	Tue, 25 Nov 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764037242; cv=none; b=to/OiM1huhyIHwAQpZaiJR8bad07HQFRMYithYz/h3C7+Wi9/SOn4J0KDi3QH1RDvYxa/QKDImO3EE0h4BtYaegw+FnAR+odfIAIJUkmSfnlRSdR3+Pvb5qaZm0pr/MgH2+3wDXw8fompQjRxVYhIJo7FwoLrGEwhUAIRIzZ+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764037242; c=relaxed/simple;
	bh=+cdG56+SI3JnpwvTMkbNntwrTC440QTrhSMF2OcXtWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PfIQZc52YAxCVvZ9wj+tN13ASu8gahImzygDXUI8E9YlwgdluVahsPPY0GO0DBf1c06qu5LIpMEinuTm11t3AxXojvnSTLz7nxHsxabuHkOZjUvxLj8we8pQutyKAR6qf5q107vpHibKqNJ5zgHIJQizrzvAtQiqd5OsISPP8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qi4NM7CV; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qi4NM7CV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4b
	Nm6Rq+xULjAPTn2KfJcrfryVNv0SKK3tJLDHzOZ/E=; b=Qi4NM7CVMKaPFZ3FJ4
	ngSpF0IaGbnOkZKXGruO80fp1wRO0BnbQN63aGYOWBZ1A8yk3Fuo7SCYBmvWFkU7
	bX4Rp9RN4zfm9cQ7xCHKWCIBeJFH0QOWWPpdrhmFXE0SwziavAgtAkFSnaaBMTse
	5pKKCxflCynOWe5bK9Xxggehg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAnj8dPEiVp0JkBCw--.42274S2;
	Tue, 25 Nov 2025 10:20:00 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hch@infradead.org,
	jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3] tty: tty_port: add workqueue to flip tty buffer
Date: Tue, 25 Nov 2025 10:19:59 +0800
Message-Id: <20251125021959.1509256-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aSSBfwm6L4jXqYor@slm.duckdns.org>
References: <aSSBfwm6L4jXqYor@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnj8dPEiVp0JkBCw--.42274S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryxJry8Cr1DWFyUCr18uFg_yoW8tw45pF
	WYyFW7tay8JrWjkw1qg3W7Ar9F9w48Ar1UCr15X345Wrn8AFy3K3WYgrWUCryrCr18C34Y
	vFWvyF97C3ZIv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR773gUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwBA8RmklElAuSgAA3A

On Mon, Nov 24, 2025 at 06:02:07AM -1000 Tejun Heo <tj@kernel.org> wrote:

> > On Mon, Nov 24, 2025 at 01:17:51PM +0800, Xin Zhao wrote:
> > > > +/**
> > > > + * tty_flip_wq_init -- prepare workqueue for tty/pty flip buffer work
> > > > + * @port: tty_port of the device
> > > > + * @driver: tty_driver for this device
> > > > + * @index: index of the tty
> > > > + *
> > > > + * Not all tty_port will be initialized by tty_port_init where tty_flip_wq will
> > > > + * be set to system_unbound_wq as default. Allocate workqueue with WQ_SYSFS for
> > > > + * flip buffer, so that cpumask and nice can be changed dynamically.
> > > > + */
> > > > +void tty_flip_wq_init(struct tty_port *port, struct tty_driver *driver,
> > > > +		      unsigned int index)
> > > > +{
> > > > +	char name[64];
> > > > +
> > > > +	if (driver->type == TTY_DRIVER_TYPE_PTY) {
> > > > +		port->buf.tty_flip_wq = pty_flip_wq;
> > > > +		return;
> > > > +	}
> > > > +	tty_line_name(driver, index, name);
> > > > +	if (!port->buf.tty_flip_wq
> > > > +		|| port->buf.tty_flip_wq == system_unbound_wq) {
> > > > +		port->buf.tty_flip_wq = alloc_workqueue("%s-flip-wq",
> > > > +							WQ_UNBOUND | WQ_SYSFS,
> > > > +							0, name);
> > > > +		if (unlikely(!port->buf.tty_flip_wq))
> > > > +			port->buf.tty_flip_wq = system_unbound_wq;
> > > > +	}
> > > > +}
> > 
> > These look overly elaborate to me. Just fail init if workqueue allocation
> > fails? Also, is it necessary for each port to have separate port?
> 
> Sorry, I meant a separate workqueue.

I admit it is a bit complex.
I searched for a long time and found in function tty_port_link_device seems to be an
appropriate place to initialize the workqueue. However, the tty_port_link_device
interface does not return a value, so error handling seems to be quite difficult.

Greg KH suggested creating a workqueue for each tty port, as follow:
> >  
> >  	tty_flip_buffer_commit(buf->tail);
> > -	queue_work(system_unbound_wq, &buf->work);
> > +	queue_work(port->wq_tty_flip ?: system_unbound_wq, &buf->work);
> 
> Why not just do this for all tty ports?  What is the benifit of keeping
> this on the system_unbound_wq for all other tty devices?

I think if there are many tty devices on the system, having separate workqueues
might be the right approach. Or should a single tty_driver share one?

Greg and Jiri Slaby have any comments on this?

--
Xin Zhao

