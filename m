Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA82319601;
	Wed, 10 Dec 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765369664; cv=none; b=BijexsMasHY9pspbvHrz00MXBVsj6XDqddF1oS4RNWX+qd2VYrSEZqYkHKh8tyZZ5SJRNRbPrm2X/0Q6w9H44sAWxXaVVU5wDzOzWPTeQidkBBBq2+YA8lqT7ZLx3blczfma15Wr+eOGSHU70jtZFCSBc0OnTougea//ZB3Nd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765369664; c=relaxed/simple;
	bh=raLbRxhOu3f5UCzKuQW6kjysoy+kHiB30fBwuBOSLgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9VQURQFSgCVJXdfpNreRoC0RfIg1GX+2CQPzIxIotwSTFS1gxm2FQn1xvVZ0wOLtnIBnfdSHDdy7yYrGgIth0BDx2Kh98Lzl/hUh9WVmLvtRuQg9ULVUlqr23g0peFbSVqZcNgJAj3BAi8ZPVcWK8/h07d0oqLIu0BZAhJfzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nQ2lweAE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nQ2lweAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jG
	mAsBQvitU1D+MTobtYVmx30G9a53Rm5Jqq5viDTgA=; b=nQ2lweAE6hYdgajhp9
	TLKKGLTXxo6XDKx50ag7KU+7/r12V6f8I+C355Us3nlSOKQnoO29Fo1t0laWV+PI
	FmZjFOnljhOaFB6AyaW9AxtqPFl9jaQXZeajEYniVEm2VzSeb9IpflfB6tKEwp+E
	An65zUujNzqyUMfh+ri3m3Jrg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAX13wZZzlpgUp4Aw--.3861S2;
	Wed, 10 Dec 2025 20:27:07 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: jirislaby@kernel.org
Cc: gregkh@linuxfoundation.org,
	hch@infradead.org,
	jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v5] tty: tty_port: add workqueue to flip tty buffer
Date: Wed, 10 Dec 2025 20:27:05 +0800
Message-Id: <20251210122705.4142873-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6f23b96f-003f-482e-90b6-6db89083407d@kernel.org>
References: <6f23b96f-003f-482e-90b6-6db89083407d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX13wZZzlpgUp4Aw--.3861S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDAF17uFyrJw47Cry5twb_yoW5Cw17pa
	yYkrWUt3ykJr4jv398t3W5AFya9anxJr9Fgrn8W34xtws8tryjqF409F90ya4xAF97Z34a
	vFyUA398AFWjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYPUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6BuIkmk5ZxsYRQAA3Y

Dear Jiri,

On Wed, 10 Dec 2025 09:24:30 +0100 Jiri Slaby <jirislaby@kernel.org> wrote:

> I think Greg would mind missing "Change in v6" here :).
> 
> > Change in v5:

Sorry, I will add the descriptions of v6 and v7 in v7.

> > +static struct workqueue_struct *pty_flip_wq;
> 
> Can't pty simply "link" to system_unbound_wq instead of allocating a 
> custom one:

It's a great idea! I'll revise it.

> > > + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, you must link every tty port to
> > 
> > Passive voice, please:
> > every tty port shall be linked to a workqueue manually by this function
> 
> 
> > +/**
> > + * tty_port_link_wq - link tty_port and flip workqueue
> > + * @port: tty_port of the device
> > + * @flip_wq: workqueue to queue flip buffer work on
> > + *
> > + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, you must link every tty port to
> 
> Passive voice, please:
> every tty port shall be linked to a workqueue manually by this function
> 
> > + * workqueue manually by this function, otherwise tty_flip_buffer_push() will
> > + * see NULL flip_wq pointer when queue_work.
> 
> %NULL flip_wq pointer on queue_work().
> 
> > + * When %TTY_DRIVER_CUSTOM_WORKQUEUE is NOT used, you can also use the function
> 
> this function can be used
> 
> > + * to link a certain port to a specific workqueue, instead of using the
> > + * workqueue allocated in tty_register_driver().
> > + *
> > + * Note tty port api will not destroy the workqueue in the TTY port API.
> 
> You sometimes write "tty port", other times "TTY port" -- unify to 
> whatever surrounding code does.

Okay, here is the revised section:

/**
 * tty_port_link_wq - link tty_port and flip workqueue
 * @port: tty_port of the device
 * @flip_wq: workqueue to queue flip buffer work on
 *
 * When %TTY_DRIVER_CUSTOM_WORKQUEUE is used, every tty_port shall be linked to
 * a workqueue manually by this function, otherwise tty_flip_buffer_push() will
 * see %NULL flip_wq pointer on queue_work.
 * When %TTY_DRIVER_CUSTOM_WORKQUEUE is NOT used, the function can be used to
 * link a certain port to a specific workqueue, instead of using the workqueue
 * allocated in tty_register_driver().
 *
 * Note that TTY port API will NOT destroy the workqueue.
 */

> > + * @TTY_DRIVER_CUSTOM_WORKQUEUE:
> > + *	Do not create workqueue when tty_register_driver(). In the case, you must
> > + *	set flip buffer workqueue by tty_port_link_wq() every port.
> 
> Do not create a workqueue in tty_register_driver(). When set, flip 
> buffer workqueue shall be set by tty_port_link_wq() for every port.

Okay, here is the revised section:

 * @TTY_DRIVER_CUSTOM_WORKQUEUE:
 *	Do not create workqueue when tty_register_driver(). When set, flip
 *	buffer workqueue shall be set by tty_port_link_wq() for every port.
 */

> > +/*
> > + * Never overwrite the workqueue set by tty_port_link_wq().
> > + * No effect when %TTY_DRIVER_CUSTOM_WORKQUEUE, as driver->flip_wq is NULL.
> 
> when %TTY_DRIVER_CUSTOM_WORKQUEUE is set
> 
> %NULL

Okay, here is the revised section:

/*
 * Never overwrite the workqueue set by tty_port_link_wq().
 * No effect when %TTY_DRIVER_CUSTOM_WORKQUEUE is set, as driver->flip_wq is
 * %NULL.
 */


--
Xin Zhao

