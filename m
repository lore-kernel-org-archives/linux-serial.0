Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C341AF0B3;
	Mon,  2 Dec 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157669; cv=none; b=ZdjzbRCCg1oUnvgSbIlJRH/DfqRsGmQHu4nCnb0nx7BsJs7p0n1BON8hd917KzrNqzt4xkaSUrtBf0qV1m+Oc87Og0Bo4UXneyxfi/2JerWmT3u5T7ZO80TglhjM07VJpzemYSeO+nnbSftPnMAxrLm75GV6r4Tj3dffKiS+doE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157669; c=relaxed/simple;
	bh=leCKbxXrI8wOLZxFyRTuo9pW3OvHH7MOuarDkdbV/4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHhXOrfPwwH+wnYtpOquybM168uTfyxXS4VhwlpDQ3EwNznAnmq4UUA+DH88wXufQJSwP2bYviThMLAAIxfzniyn65R3Ka9fvoj4QQu+3+p4yA54IWuivIpzh5jgZO2wLvwJ/9kf+mp/wQifdO45f8yRBdo5/vUlTKoxQ+yWG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XkUZn/kB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoWNt32n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XkUZn/kB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoWNt32n"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733157664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leCKbxXrI8wOLZxFyRTuo9pW3OvHH7MOuarDkdbV/4U=;
	b=XkUZn/kByETtNzQabzyrF/RDaWznNj2eeuVVCN13PO5XhhZHnDaeUPkjrsRz6HbNKEeN3u
	M5dyzHYUfMh8Dgu+GweshmtUmGs0MdD8sbzIOWsYC6VD7qhOjv8hILe4Q/BchK9y5wdD6/
	bAoa9EQFX+O3s3W2KEVxaEav3jfPrIShQfoOuyyQIbTGZGR0I7eHECd/0rRg0lNLYiYcFQ
	Ks527QjS5c1VJj+N0WJAtmW3TqJ0/TA9h59uAwaY1XYHM/3FnWbFFZmbyyklujJDE/a3t4
	IkPXJBMdRxc4eLlPfiXNosBlVlhTDEtRNvVYqKznZNj8boFr5NC3gz6MvViGMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733157664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=leCKbxXrI8wOLZxFyRTuo9pW3OvHH7MOuarDkdbV/4U=;
	b=uoWNt32n96u7wwzMS/SKGXY8QsrRXaB5EMsFdLAxfmeA0yzQmXNMYWhVQ5eeF6wmV9CY+I
	11GaNejeX65xpaDg==
To: Jiri Slaby <jirislaby@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek
 <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rengarajan S
 <rengarajan.s@microchip.com>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Serge Semin <fancer.lancer@gmail.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>, Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
In-Reply-To: <848cbe1c-d84d-4377-8709-bb98d1d83146@kernel.org>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
 <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
 <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
 <84ldxzccjl.fsf@jogness.linutronix.de>
 <848cbe1c-d84d-4377-8709-bb98d1d83146@kernel.org>
Date: Mon, 02 Dec 2024 17:47:03 +0106
Message-ID: <841pyqavhc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-02, Jiri Slaby <jirislaby@kernel.org> wrote:
> I am still asking why do you want to wait for the TX machinery at the
> *end* (for the last 64 B of the 640 B line) of transmission at all? It
> occurs to me as wasted cycles.

The printk-framework has always expected that when console->write()
returns, the data has been flushed out of the hardware. I am guessing
because it is easiest to avoid possible data loss, for example, due to
suspending hardware.

If you want me to change the current behavior, I can do that in a
separate patch. I would like this patch to only be about fixing the FIFO
timeout issue.

John
