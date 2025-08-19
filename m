Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0C28BABA
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619179; cv=none; b=I5DahZWSBheJAq5XxK9C8vTYZe0ucBlky6XqJ/Xmx49XseUfRAqLZLsLOaTZvQmvcCHeZwV7qP2GoMsJ6rpvonuALqVh5RcCMzLTlsqFdeNQQw30d0Ix67IQvWLnAbzavFe422/ZrQGIqsJ2t99rPOOqcjnSihYsEHETuZFQliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619179; c=relaxed/simple;
	bh=sYZI50tt5w0MCYkGl/AkitKiLCrAEgEonAfhaGy/LG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olK5JHWitF3rJ6Cgi3Wm5wtZF58oXgd9a8EAYPjydafpS/VkjIkeiUR0M6CCiThSTWoDk24mMNsHGUmfVaOcE680buhzdyDCvfZsHUegkVw72MEb32W7cQLXUxypXtG+zxUslq8f6gSkNss0T1D+ln/Vh7eUPHVfT9pLyPwsJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ub7qQuG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=baLpMugZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ub7qQuG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="baLpMugZ"
Message-ID: <2784dfee-a010-426f-a09e-aadc7abe3148@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755619174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYHZtcne7/up7Tits1zClLt1DcfsgOXEfNJKwIj0Ntg=;
	b=4ub7qQuGpCAAHwbppVsKC/AFE9PI06J9X6d0t5UgukUl+8oaXovGhptbF5/YS5NP7x3eFe
	BP/yjtz/+6psK+cHFpTA4/A3Y5UbV8E5W9fKxG+REhd4dA4xUA9jLOj6aMDGuB5Bje9v5R
	JlSaMQLko5cQ1U7TZb3bIz9VWWl6LfKd0hgJOC8enBY+b7aXMcoLa6PcEWr1thq63j9QnL
	yOOi+n9TjHD2XfoFe0X9pFLm6h8SZd4IsQtwI5+Gt0DW8QaaK/crQtyR+h7UFLtcrCbZdV
	jQxB7YGXgfwauXHiznkMWcZY9zri0Q6TBtuYfu0D+KDpMfe7cAbiCGhZ8WA7Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755619174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYHZtcne7/up7Tits1zClLt1DcfsgOXEfNJKwIj0Ntg=;
	b=baLpMugZWaVdkxX9fFJBH+H9uv6f23uQ70JFtz9D6zD41IJfQuHFA5I5CKpdVC8UXtx2oR
	UgZYzk9o2p4V3dCg==
Date: Tue, 19 Aug 2025 17:59:34 +0200
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
 <7a33100a-24bd-4bed-b9b2-539fc5a15c2c@linutronix.de>
 <2025081955-debatable-registrar-3c23@gregkh>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <2025081955-debatable-registrar-3c23@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 19.08.25 um 12:49 schrieb Greg Kroah-Hartman:
> On Mon, Aug 18, 2025 at 02:00:02PM +0200, Martin Kaistra wrote:
>> Am 18.08.25 um 12:02 schrieb Greg Kroah-Hartman:
>>> On Mon, Aug 18, 2025 at 11:52:16AM +0200, Martin Kaistra wrote:
>>>> After all bytes to be transmitted have been written to the FIFO
>>>> register, the hardware might still be busy actually sending them.
>>>>
>>>> Thus, wait for the TX FIFO to be empty before starting the timer for the
>>>> RTS after send delay.
>>>>
>>>> Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
>>>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>>>> ---
>>>> I tried using the TX empty interrupt instead of polling the register,
>>>> but it doesn't seem to be firing reliably, which is why I chose this
>>>> implementation instead.
>>>>
>>>>    drivers/tty/serial/xilinx_uartps.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>>>> index fe457bf1e15bb..38d2b33d0b6c8 100644
>>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>>> @@ -454,6 +454,10 @@ static void cdns_uart_handle_tx(void *dev_id)
>>>>    	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
>>>>    	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
>>>> +		/* Wait for the tx fifo to be actually empty */
>>>> +		while (cdns_uart_tx_empty(port) != TIOCSER_TEMT)
>>>> +			udelay(1);
>>>
>>> Having a while look that could potentially never exit?  What could go
>>> wrong...
>>>
>>> Seriously, what happens if the port never empties due to flow control
>>> stuff?
>>
>> I will add a timeout..
>>
>> Before sending a v2, however, can I ask: will a solution with udelay() even
>> be accepted?
> 
> Probably not, would you want that called when waiting like this?

It would look like this:
+               /* Wait for the TX FIFO to be empty */
+               for (tmout = 1000000; tmout; tmout--) {
+                       if (cdns_uart_tx_empty(port) == TIOCSER_TEMT)
+                               break;
+                       udelay(1);
+               }

