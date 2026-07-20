Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89063400979;
	Mon, 20 Jul 2026 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553023; cv=none; b=nOVr4/8gC3tQQd+Gvs/n4s9073tGnB4OLvyEa8lwE5xp9qXuVwvEl65mSra/IB0SCBhn3Ua9uZYq5F5cKJKSCBW84fgehpcEexEQJvor5uKyZ7C/7c8KSGF0TE5Q1fmTxgpsiDS9cHC6gdUAkBaaNOQ+wqRW+ipS3uvqfRL74uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553023; c=relaxed/simple;
	bh=4mE9ymXj9G6URAz64dJXSZ0hX2yXPjz/vlSnw5aVgNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VcHD4R/SXJs4iyIwCON/854J1MdSHkd6Z/TYlwJNvcNYryzhbqHLcKHdPbALvRW24mdUxyC9vl8kbntuvsdyQHhnc4YcKZcpBe3RFuaMRrRsofawuBOijsIcI8YdUdECsEF4fRB7a6JZjIANNheL29HDRAOgQgoTp8D2ooE6O9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqZw3sCC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnE0ap/X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqZw3sCC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnE0ap/X"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784553020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qr/5K5FBb4dJhCRS4cHvCeakWJv49TXQl7hlcNy3OQY=;
	b=aqZw3sCC8wpKyyGzCzoTbfBn4+O6vKVugyXwrZn+gyEBo3Uo3vSyeGYdKDZdiYvqyeCzqw
	BPuq/QjyfX2/uADZQnzhEeLYoJqVAOIhvTQf4m3EZcJaAtJXQrpq6FKaKN5252BisGcitV
	DjixI3xM/aq9Y4QQYetcAYxiDjIfsS9OrSDiw1bKC2BUnyGhAmcq1vU30qrVQKzCzCpLcu
	on3usvgdt/7O7lyIuXboIHd2PmhMwOxgdylApX/5uiOpsBIQtKOE3SaIv+T4/QUSYXhNBC
	NBzTy4/DK8e1uj6EsXSqyCmhE+0et5VocE/gi7bJ5qfx9GWTjJAb5/zSK3CA4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784553020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qr/5K5FBb4dJhCRS4cHvCeakWJv49TXQl7hlcNy3OQY=;
	b=BnE0ap/X80vEYIZ94K2v4t1M9G4Oa/NZ5K+wP4iAkYtpsoZPhqEtp0HeGsSho9pazEdgvW
	pjnBQKKAUOvOYyCw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek
 <pmladek@suse.com>, linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4r?=
 =?utf-8?Q?vinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Manuel Lauss
 <manuel.lauss@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v6 2/2] serial: 8250: Revert "drop lockdep
 annotation from serial8250_clear_IER()"
In-Reply-To: <20260720103242.7265-3-john.ogness@linutronix.de>
References: <20260720103242.7265-1-john.ogness@linutronix.de>
 <20260720103242.7265-3-john.ogness@linutronix.de>
Date: Mon, 20 Jul 2026 15:16:20 +0206
Message-ID: <878q75u7r7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-20, Sashiko wrote:
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 3e623b71dadbc..ca736b1bd0726 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -719,6 +719,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
>>  
>>  static inline void serial8250_clear_IER(struct uart_8250_port *up)
>>  {
>> +	/* Port locked to synchronize UART_IER access against the console */
>> +	lockdep_assert_held_once(&up->port.lock);
>> +
>>  	__serial8250_clear_IER(up);
>>  }
>
> Will restoring this lockdep assertion cause a false-positive warning
> during KGDB polling?
>
> Looking at serial8250_put_poll_char(), it explicitly avoids taking the
> port lock because CPUs are quiesced during KDB/KGDB use:
>
>     /*
>      * Normally the port is locked to synchronize UART_IER access
>      * against the console. However, this function is only used by
>      * KDB/KGDB, where it may not be possible to acquire the port
>      * lock because all other CPUs are quiesced. The quiescence
>      * should allow safe lockless usage here.
>      */
>
> However, it then calls serial8250_clear_IER():
>
>     ier = serial_port_in(port, UART_IER);
>     serial8250_clear_IER(up);
>
> Should serial8250_put_poll_char() be updated to use
> __serial8250_clear_IER() instead to avoid triggering this lockdep
> splat?

Sashiko is correct. For v7 this will be changed to call
__serial8250_clear_IER().

John
