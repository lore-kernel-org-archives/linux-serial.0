Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377F3EF667
	for <linux-serial@vger.kernel.org>; Fri, 15 May 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831063; cv=none; b=HrataOf9o+Y/6q2srSgNOHoFYVcMQc5qy5HkTtYTqguX2qhQNkjiOSmmkj/IE3N4UoDZV8baDbj81PjAxWHjODpi9fctfWiAC+rZXTmGpXwPKl5ueTYwbOUjLM9aFAQWKq/8aa6dUKbJCm+fB6gTXeUIdJU37mjgK7z1zPsZfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831063; c=relaxed/simple;
	bh=BC5yDUCtYPba8Y8YqOp7f/wpUckXX24VAv9iwDUQz5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVtcrUBVavuDoQzry8muCJBp0PC3pmWofHlGa+yk1pFirkrXGykmOXqNM9uH8JQrdI523HEikbNeB0usXZLDzKKECBrMsraAHKVNDLyLHczsXSZK+mB3i+oqFjbaZ6O7Zm7HiuJCI52P4+1UK3OTluN7CZDVnoffvZzPV+t2ZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPDXaOeg; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPDXaOeg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778831058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWlwB37HgxZj9+SUfOdH31sheEEeV24Gi8ZblY95ERA=;
	b=qPDXaOegnVLix3F7DsEsZBgSVtSNvJH7GrLfSRWmbqXG4s3xrw1XKoOxC+/spcLuX7NPlc
	hhdd46iC2MYSMyX6VQLXDRyZRM/OVjKqDDKC/jT9Em0jE5Xi2iT7fRqfgT8boeRn9PUr/D
	BS9p3hSaLWErPPt4awNK+c6K23GsrvA=
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
Date: Fri, 15 May 2026 15:44:02 +0800
Message-Id: <20260515074402.98048-1-fushuai.wang@linux.dev>
In-Reply-To: <2026051135-kung-badass-8eba@gregkh>
References: <2026051135-kung-badass-8eba@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> From: Fushuai Wang <wangfushuai@baidu.com>
>> 
>> When two PnP devices map to the same physical port, the serial8250 driver
>> removes and re-registers the console structure for the same port.
>> 
>> During re-registration, the console structure still has CON_PRINTBUFFER set
>> from the initial registration, which causes console_init_seq() to set
>> console->seq to syslog_seq. This results in re-printing the entire
>> system log buffer, which may lead to RCU stall on slow serial consoles.
>> 
>> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
>> log printing.
>> 
>> Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>> ---
>> V1->V2: Add Fixes tag
>> previous discussion: https://lore.kernel.org/all/20260416092917.27301-1-fushuai.wang@linux.dev/T/#u
>> 
>> Please ignore previous email if you received it before. There is something wrong with my email client.
>> 
>>  drivers/tty/serial/8250/8250_core.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index a428e88938eb..01b14392d9f7 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -694,6 +694,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>>  {
>>  	struct uart_8250_port *uart;
>>  	int ret;
>> +	bool was_removed = false;
>>  
>>  	if (up->port.uartclk == 0)
>>  		return -EINVAL;
>> @@ -716,8 +717,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>>  	if (uart->port.type == PORT_8250_CIR)
>>  		return -ENODEV;
>>  
>> -	if (uart->port.dev)
>> +	if (uart->port.dev) {
>>  		uart_remove_one_port(&serial8250_reg, &uart->port);
>> +		was_removed = true;
>> +	}
>>  
>>  	uart->port.ctrl_id	= up->port.ctrl_id;
>>  	uart->port.port_id	= up->port.port_id;
>> @@ -819,6 +822,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>>  					&uart->capabilities);
>>  
>>  		serial8250_apply_quirks(uart);
>> +
>> +		if (was_removed && uart_console(&uart->port))
>> +			uart->port.cons->flags &= ~CON_PRINTBUFFER;
> 
> Why not set the flag up above when you remove the port?  Why down here?
> 
> thanks,
> 
> greg k-h

Hi, Greg

I just felt it's cleaner to clear it only when re-registration happens.
Do you think there is any problem with doing it right after the removal?

-- 
Regards,
WANG
