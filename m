Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015017E;
	Mon,  2 Dec 2024 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733119937; cv=none; b=AhNoHxy7IbcYxtCNXuBqkFSGy/YdfyfiNDWzzwtcfumtYnEUFRST/URztocRCPOlwPgdAMLzVz8/5H4nAYBr1/6ePL8RLUvrbcRF1jXNfroUqQ8KHcp2yIhPf09HGRPzsl0hr48E9sTKxg0jsWdNPa22UWwtWKIsWY46837DtI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733119937; c=relaxed/simple;
	bh=av2/qGxfETVVpYWjdPwqPFx/7HMHwabf8lIR+vBntXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enAPSygDprLujgAFEqW6whZUfhMdl7f9rjs5S8A5M93WuTCjqWiZpaS6jutvnt4xYVjeJOQ7F2HFbp92xoTdIpOPM8rSW7bPW9kS5g6ZbEDhycHyzd249TIj3QyOtRVr4K2cBmYzathTapElvL1cZKJsK31hYUDMsaG9q34gzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QniMDvTA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QniMDvTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999D2C4CED2;
	Mon,  2 Dec 2024 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733119936;
	bh=av2/qGxfETVVpYWjdPwqPFx/7HMHwabf8lIR+vBntXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QniMDvTA6GB3amtZcVS0cBYMdgTa/XN3jumFMLpoYRgh2uIPL5UR38shdNEQrKHt6
	 BLKq8Fh1/vfSSzDoHHDe+GpQqECknIG3CcWcCGCSF4ckdl2TzXJovcZkDb+TCsjwMm
	 XzyquP6Ywr56hEw5d5NrksmBFNbQiWYnwFKS3rplZGVaR/yuVnH881KhniICq4T5Kz
	 WdVvLyPBNf4xBnQTmR8Z9rFDamGVWmBlrL4OgGKfNl4zxQNIJHWFqm7RvuuUfEcR/r
	 ruKKELR3s82iqpEORLx5XZ7YLgJGHdal7NXbWPfCwpSfqSGaiE8nBUZtALaqdzRlro
	 q8UXWaP4A9bkQ==
Message-ID: <848cbe1c-d84d-4377-8709-bb98d1d83146@kernel.org>
Date: Mon, 2 Dec 2024 07:12:11 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for FIFO
 mode
To: John Ogness <john.ogness@linutronix.de>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
 <84ldxzccjl.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <84ldxzccjl.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 11. 24, 15:13, John Ogness wrote:
> On 2024-11-04, Jiri Slaby <jirislaby@kernel.org> wrote:
>> Instead of looping fifosize multiplied by random timeout, can we
>> re-use port->frame_time?
> 
> Rather than 10k loops, we could loop
> 
> 	(port->frame_time * some_scaled_padding) / 1000
> 
> times. The padding is important because we should not timeout in the
> normal scenario. Perhaps using ~2 as @some_padding. Something like:
> 
> 	port->frame_time >> 9
> 
> ?

No, spell it out as you did above:
   port->frame_time * 2 / NSEC_PER_USEC

>>>    The difference between THRE and TEMT is the state of the shift register
>>> only[2]:
>>>
>>> "In the FIFO mode, TEMT is set when the transmitter FIFO and shift
>>> register are both empty."
>>
>> But what's the purpose of spinning _here_? The kernel can run and
>> FIFO too. Without the kernel waiting for the FIFO.
>>
>> If we want to wait for fifo to empty, why not *also* the TSR. Meaning:
>>
>> Did you want UART_LSR_TEMT?
> 
> Let us assume we have a line with 640 characters and a FIFO of 64
> bytes. For this line, we must wait for the FIFO to empty 10 times. It is
> enough to wait for THRE for each of the 64-byte blocks because we are
> only interested in refilling the FIFO at this point. Only at the very
> end (in the caller...  serial8250_console_write()) do we need to wait
> for everything to flush to the wire (TEMT).
> 
> By waiting on TEMT for each of the 64-byte blocks, we are waiting longer
> than necessary. This creates a small window where the FIFO is empty and
> there is nothing being transmitted.
> 
> I did a simple test on my beaglebone-black hardware, sending 100 lines
> of 924 bytes at 9600 bps. Since my hardware uses a 64-byte FIFO, each
> line would have 14 such windows.
> 
> And indeed, waiting for TEMT rather than only THRE for the 64-byte
> blocks resulted in an extra 30ms total transfer for all 92400
> bytes. That is about 20us lost in each window by unnecessarily waiting
> for TEMT.

Sure -- you still misunderstand me. I am still asking why do you want to 
wait for the TX machinery at the *end* (for the last 64 B of the 640 B 
line) of transmission at all? It occurs to me as wasted cycles.

thanks,
-- 
js
suse labs
