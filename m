Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEDD19341D;
	Thu, 31 Oct 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366037; cv=none; b=H6MQIiQhPZlHnstz0d12sQI7vwvwVXLpUkRBUx9cqWd73lF0i1/R4ax+bfgAA9Buo78yEEeMu/mkIpgL3IGUf+2Q8o9/f1W+DXtvP6xxtfIff8NrWoBzbVZ8K+DKV4M9jn520w+h+/iHzsX5HqdLYsai9TGgXzUnWa03weqJoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366037; c=relaxed/simple;
	bh=zXT/PgNOBSorDcFpVKMfQwyGZVWmcB8yF73UsbQqhvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u13auRrSHZbFGChmDeONgjq/E5nrWAYP270pXe3Zf0BcUoiJpwJ+mT9KFQa3c84cCbv5EX4DXmpkN7sFqtETd/8uAIMHUSMR0GND0yvB/vEiYNkVp+booAUTuYVZbmbzSPlfYhzs0u1rFaUHIgAQ46Qa02FuUOXKIS5be+SBngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3cXMAKP9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKko7n5T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3cXMAKP9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKko7n5T"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730366034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrD0ZfuHoa6x/lqplhytCjOw0Xel3ZOQUIA62v3IfKk=;
	b=3cXMAKP9i9urmv40oh5aOvpiqjxr5tJ38d79UA5I636s3QeCC16+tHval5Nk0DSaNZCiJl
	T8Z+RcZg8ciKTwXFm8lx/+KLg6t9af1W52MV7T8sXgZs49TMkcT/ax8VczQ/iEjfUWwigA
	Mz6X/UV489Kg3iKgYFLBGTuTmBph7jXddgS721mzVgFIdzaotaQCSVt/v48VKFRBQ6AZh7
	1K0UU6n6Ps1K67S0aMzPUl7vSW2sZwfc3Zdi9WIw0UGw9s79hVzIL5rgFgKQuwSj4AU5lJ
	1bYpuo+LZRywXWAeNLvXlO/hsCWbf9IvO6PkEWe5Z1p0sQ9rbmxSyQ7Xmsss/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730366034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrD0ZfuHoa6x/lqplhytCjOw0Xel3ZOQUIA62v3IfKk=;
	b=CKko7n5TAyXddi94osYz3Z1LksU9iEockc/SoL53s5olauKZSw6RBCaZD7sFQX1qqSo+eh
	MU9CYrJuxciUi2Ag==
To: Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Wahren
 <wahrenst@gmx.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Kevin
 Hilman <khilman@baylibre.com>, Markus Schneider-Pargmann
 <msp@baylibre.com>, Ronald Wahl <ronald.wahl@raritan.com>, Udit Kumar
 <u-kumar1@ti.com>, Griffin Kroah-Hartman <griffin@kroah.com>, Rengarajan S
 <rengarajan.s@microchip.com>, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v3 4/6] serial: 8250: Specify console context
 for rs485_start/stop_tx
In-Reply-To: <91303556-2632-49ca-be5d-9105c75b8a63@kernel.org>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-5-john.ogness@linutronix.de>
 <91303556-2632-49ca-be5d-9105c75b8a63@kernel.org>
Date: Thu, 31 Oct 2024 10:19:53 +0106
Message-ID: <84plngljn2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-30, Jiri Slaby <jirislaby@kernel.org> wrote:
>> -void serial8250_em485_start_tx(struct uart_8250_port *up)
>> +void serial8250_em485_start_tx(struct uart_8250_port *up, bool in_con)
>>   {
>>   	unsigned char mcr = serial8250_in_MCR(up);
>>   
>> -	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
>> -		serial8250_stop_rx(&up->port);
>> +	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
>> +		/*
>> +		 * In console context, caller handles interrupt disabling. So
>> +		 * only LSR_DR masking is needed.
>> +		 */
>> +		if (in_con)
>> +			__serial8250_stop_rx_mask_dr(&up->port);
>> +		else
>> +			serial8250_stop_rx(&up->port);
>
> Would it make sense to propagate in_con into serial8250_stop_rx() and do 
> the logic there? That would effectively eliminate patch 2/6.

I considered this, however:

1. The whole idea of stopping RX in order to do TX is an RS485
issue. Modifying the general ->stop_rx() callback for this purpose is
kind of out of place.

2. The ->stop_rx() callback is a general uart_ops callback. Changing its
prototype would literally affect all serial drivers. OTOH the
->rs485_start_tx() callback is specific to the 8250 driver. (It seems
each driver has implemented their own method for handling the RS485
hacks.)

So I would prefer to keep the necessary RS485 changes 8250-specific for
now.

John
