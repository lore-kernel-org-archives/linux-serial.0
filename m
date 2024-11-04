Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25F38F97;
	Mon,  4 Nov 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702072; cv=none; b=l7XwTYsObwyUZJ87PZ9qfPlo61znEhFsDSSc6CTQTNfIoLy8djqjrwcG3yvnHiTGAOjqKbDUPMafGlgQbKiOvVzSyNgCSv23AnYp+U2OrrAze01oAXP9Kfb1eukPVpGgcUafdLJKteiKeyi6HxC5i25i1j2iGZTXRMC9tNvrPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702072; c=relaxed/simple;
	bh=fNO+fhKEjl/2w1YQEqtNRbIXbB1NwkH2rt67rYlzzNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EU+NpVFkdXd3tlAlVDNyU1mnxG7tP5Px4DXigyURUNB5YwBtg9bu6hhMwBgnDCz/S+VQ0K8x8cTgRVWRLWVLy1zF/qZ8OaeZIjxPjJP6KUhQkUTy/IuO9Njz3JG5FazZoyzksd8yM0ZBFwGL/GyAXqGLCqwdj80G45sXqxDatbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFm1x9FG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFm1x9FG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AEEC4CECE;
	Mon,  4 Nov 2024 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702072;
	bh=fNO+fhKEjl/2w1YQEqtNRbIXbB1NwkH2rt67rYlzzNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kFm1x9FGpjsK0ZDJyP3A+RW6eRvo20Atkwy6cruCArFY72sxiZ6qSdJp2M5hGfXPy
	 mXI3ROIvFGypc8w1pM7sLqOi9aoRJh1mPw0NZ+Db9KnBrLaQmZcklDRDx0r4l9jUtK
	 W2mpBnzjspixYHIFZhviNm7QvmE+7loTP8YqDJRYpBrU+md1V4OYIXuH8a2dkEHMhM
	 esV58/c1PRqQGS7xS2IkLSBwLNGWajCje0Q973e6hb3SljJW6dAOA048zzDs7RyvvY
	 ju0w+py/57HiGOQwwuqr1JQJLPrpbZqQmWJqGK+UXAPY74hSGjKEkl1OZQWrw536Fl
	 X/AaJz/kB3PsA==
Message-ID: <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
Date: Mon, 4 Nov 2024 07:34:26 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for FIFO
 mode
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rengarajan S <rengarajan.s@microchip.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>,
 Wander Lairson Costa <wander@redhat.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
 <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31. 10. 24, 5:44, Maciej W. Rozycki wrote:
> On Wed, 30 Oct 2024, Jiri Slaby wrote:
> 
>>> @@ -3306,13 +3310,18 @@ static void serial8250_console_restore(struct
>>> uart_8250_port *up)
>>>    static void serial8250_console_fifo_write(struct uart_8250_port *up,
>>>    					  const char *s, unsigned int count)
>>>    {
>>> -	int i;
>>>    	const char *end = s + count;
>>>    	unsigned int fifosize = up->tx_loadsz;
>>> +	unsigned int tx_count = 0;
>>>    	bool cr_sent = false;
>>> +	unsigned int i;
>>>      	while (s != end) {
>>> -		wait_for_lsr(up, UART_LSR_THRE);
>>> +		/* Allow timeout for each byte of a possibly full FIFO. */
>>> +		for (i = 0; i < fifosize; i++) {
>>> +			if (wait_for_lsr(up, UART_LSR_THRE))
>>> +				break;
>>> +		}
>>
>> THRE only signals there is a space for one character.
> 
>   Nope[1]:
> 
> "In the FIFO mode, THRE is set when the transmit FIFO is empty; it is
> cleared when at least one byte is written to the transmit FIFO."

Hmm, I was confused by NXP's 16c650b [1] datasheet then (or I cannot parse):
===
The THR empty flag in the LSR register will be set to a logic 1 when the 
transmitter is empty or when data is transferred to the TSR. Note that a 
write operation can be performed when the THR empty flag is set
(logic 0 = FIFO full; logic 1 = at least one FIFO location available).
===

But indeed in the LSR[5] bit description, they state:
===
In the FIFO mode, this bit is set when the transmit FIFO is
empty; it is cleared when at least 1 byte is written to the transmit FIFO.
===

Anyway, it still does not answer the original question: Instead of 
looping fifosize multiplied by random timeout, can we re-use 
port->frame_time?

[1] SC16C650B -- 5 V, 3.3 V and 2.5 V UART with 32-byte FIFOs and 
infrared (IrDA) encoder/decoder; Rev. 04 — 14 September 2009; Product 
data sheet

>>> +	/* Allow timeout for each byte written. */
>>> +	for (i = 0; i < tx_count; i++) {
>>> +		if (wait_for_lsr(up, UART_LSR_THRE))
>>
>> This ensures you sent one character from the FIFO. The FIFO still can contain
>> plenty of them. Did you want UART_LSR_TEMT?
> 
>   The difference between THRE and TEMT is the state of the shift register
> only[2]:
> 
> "In the FIFO mode, TEMT is set when the transmitter FIFO and shift
> register are both empty."

Sure. The question still holds:

 > But what's the purpose of spinning _here_? The kernel can run and 
FIFO too. Without the kernel waiting for the FIFO.

If we want to wait for fifo to empty, why not *also* the TSR. Meaning:

 > Did you want UART_LSR_TEMT?

thanks,
-- 
js
suse labs
