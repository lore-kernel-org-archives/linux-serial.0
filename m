Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9F34388A
	for <linux-serial@vger.kernel.org>; Fri, 22 May 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443548; cv=none; b=fBH1doeq8CWvuuwsU01py9syRnKY5uXJFl3z0haX3HZJPtpmeTX+FK6YXgbNJxTt1pi1YRCot6ocL02BoMZPEEkJrSLS0cKupFrS+/YHbrLJo4zsW5RxzNWQg3bkRD5CuDQmakkEQ3xNQiiUpWSiio+3vtXqrR1Aa+lZldpbBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443548; c=relaxed/simple;
	bh=2V/ptAi3YEwCWU4qw1T1DphZugsv3nwtyNVsqQ9H6Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPbIXyUgyUSYUBCSsQAbjf4jAbXobXen83g9lBXlRfGR27Zeab+GD9ioJbxx3SEhjLVx6nbsjbUSmMRALgMC8U8E25mEqhmjfKqocZ1/vA8CStEPSbm8jZtqFSs4eYQl1crfr7e/pl7G/MPr3kcExCu5WeoT48ncowa3z2P2tyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CzJE9MqT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CzJE9MqT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779443544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3YIZTgby1qSmeT2N469NhIZJok7acXDsuk51RmiPsU=;
	b=CzJE9MqTSxiFl5AlbF/wfw2gfHhgC830IskykesaYkE0a1xhn/Tr+2jYeVCr0wGOuKALpQ
	sZo6KKxbY6FypylDLIyxPP1KRExDZAw8PyVtepxgm44/iyzFmLBGE7YrGALd2hBgdvz6r3
	Ma5VWNQH8HvJfjgQ3Sj2alecR9nq7cI=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: gregkh@linuxfoundation.org
Cc: andy.shevchenko@gmail.com,
	fushuai.wang@linux.dev,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	osama.abdelkader@gmail.com,
	wangfushuai@baidu.com
Subject: Re: [PATCH v2] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
Date: Fri, 22 May 2026 17:52:03 +0800
Message-Id: <20260522095203.20796-1-fushuai.wang@linux.dev>
In-Reply-To: <2026052203-glutinous-smudge-91ab@gregkh>
References: <2026052203-glutinous-smudge-91ab@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> >> --- a/drivers/tty/serial/8250/8250_core.c
>> >> +++ b/drivers/tty/serial/8250/8250_core.c
>> >> @@ -694,6 +694,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>> >>  {
>> >>  	struct uart_8250_port *uart;
>> >>  	int ret;
>> >> +	bool was_removed = false;
>> >>  
>>> >>  	if (up->port.uartclk == 0)
>> >>  		return -EINVAL;
>> >> @@ -716,8 +717,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>> >>  	if (uart->port.type == PORT_8250_CIR)
>> >>  		return -ENODEV;
>> >>  
>> >> -	if (uart->port.dev)
>> >> +	if (uart->port.dev) {
>> >>  		uart_remove_one_port(&serial8250_reg, &uart->port);
>> >> +		was_removed = true;
>> >> +	}
>> >>  
>> >>  	uart->port.ctrl_id	= up->port.ctrl_id;
>> >>  	uart->port.port_id	= up->port.port_id;
>> >> @@ -819,6 +822,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>> >>  					&uart->capabilities);
>> >>  
>> >>  		serial8250_apply_quirks(uart);
>> >> +
>> >> +		if (was_removed && uart_console(&uart->port))
>> >> +			uart->port.cons->flags &= ~CON_PRINTBUFFER;
>> > 
>> > Why not set the flag up above when you remove the port?  Why down here?
>> > 
>> > thanks,
>> > 
>> > greg k-h
>> 
>> Hi, Greg
>> 
>> I just felt it's cleaner to clear it only when re-registration happens.
>> Do you think there is any problem with doing it right after the removal?
>
> If you do that, no flag is needed.

OK, I will send a v3 shortly.

-- 
Regards,
WANG
