Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5027B35A
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518407; cv=none; b=nAqeGRSNcV1cM9qdUMpq2IFwLLc1+H4T/WD5+YA7MbrTdO18zMRIDPQ9xvzaTtQttYv6Ng8YA3wl4hmJBs3W81FEcyDI8bVKRkxZj733qIPxxdVqkX76/RJqP8NVG5xKisRzbjwoMv87fOMPy0ZjQ9RFKIKYU/m0LrBHORJ+2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518407; c=relaxed/simple;
	bh=wFTlt6LZ6LOuEVQtmzvUIX6acd6pW9U+t2WnW2mdIGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO3xfo5TdsOKNbwJdthOjFvgKpLw6VQReKEY93/HU5F/PsO0S9wFKAtAIkaftLIIjDwqJvKN02aHyz4RbY4yC0U3XLKoEXOdQMCr14zClhbSkpdlL4olI82ZSuZkiCMLiK449jNDMT2wDwXoge+RLeFWRcjNd/xsHWoNe1fCxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ul5zDfWT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6yHgsd5z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ul5zDfWT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6yHgsd5z"
Message-ID: <7a33100a-24bd-4bed-b9b2-539fc5a15c2c@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755518403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdVhT07Q6bI/tGFe9Za1FLvpnXGorhiEzQlVqTMCT/0=;
	b=ul5zDfWTmiZd3KzGh285zJA+9KG2uYcrZV9mRzWyvxkP3+8ZCxcULples9ECefsbqfaCw+
	c3DzQRTnKeEXLQTy5mif0UW8YnTxm/KEko7NQY6jO7XpGtX0u9sseMwbFeJLXFrMQk4ilJ
	OPQwT7YWSeCwXrw0EQGCN/I3qX5vpEstJIuTUiLEGT9wObAYjpaq1HZd/7P8eWxN6c+W1o
	lVS/1YMK8d+0oqt/bnHcPjMnrxYDZTlJgyYHD8emvi0yjy6WnKWfqOHlsLMaB3xcuZBL5T
	sW8P/Bq5z//uxRBg0FOPhixsYVSI/xPEA5HAxOPfbkLnK29FK0CgSdX8D4vlVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755518403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdVhT07Q6bI/tGFe9Za1FLvpnXGorhiEzQlVqTMCT/0=;
	b=6yHgsd5zoQqTMfB8DlpGvLGYgJGsALP83uiCjvlApizJaY0NFRrLDvJNnC7QfrbhywZ/Vh
	qxeVGs4j1Q9xdwBg==
Date: Mon, 18 Aug 2025 14:00:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@amd.com>, linux-serial@vger.kernel.org,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
References: <20250818095216.795550-1-martin.kaistra@linutronix.de>
 <2025081804-bruising-garage-a57b@gregkh>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <2025081804-bruising-garage-a57b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 18.08.25 um 12:02 schrieb Greg Kroah-Hartman:
> On Mon, Aug 18, 2025 at 11:52:16AM +0200, Martin Kaistra wrote:
>> After all bytes to be transmitted have been written to the FIFO
>> register, the hardware might still be busy actually sending them.
>>
>> Thus, wait for the TX FIFO to be empty before starting the timer for the
>> RTS after send delay.
>>
>> Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>> I tried using the TX empty interrupt instead of polling the register,
>> but it doesn't seem to be firing reliably, which is why I chose this
>> implementation instead.
>>
>>   drivers/tty/serial/xilinx_uartps.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>> index fe457bf1e15bb..38d2b33d0b6c8 100644
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -454,6 +454,10 @@ static void cdns_uart_handle_tx(void *dev_id)
>>   
>>   	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
>>   	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
>> +		/* Wait for the tx fifo to be actually empty */
>> +		while (cdns_uart_tx_empty(port) != TIOCSER_TEMT)
>> +			udelay(1);
> 
> Having a while look that could potentially never exit?  What could go
> wrong...
> 
> Seriously, what happens if the port never empties due to flow control
> stuff?

I will add a timeout..

Before sending a v2, however, can I ask: will a solution with udelay() even be 
accepted?

martin

> 
> thanks,
> 
> greg k-h

-- 
