Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0061E51EB;
	Thu, 12 Jun 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718451; cv=none; b=rZWoSY/Xi942DvoB9VKKYnr7FAxxq1XylVmdiEH2rDParIqSRdTdjkYiHsy05Q/w/nRkr2TrePw5UQdMzfX3mR+uzSY/UUvzKt4J3KpBya+ce19IjeUooF3M7IdcpadQpNT/9A6/EFTFs5/5K6X947/Jrt8sBSjX5aUEK0KSMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718451; c=relaxed/simple;
	bh=YNGbyo0dq6GKvxVdgZHgdwE6F5GPysZw4mgBrL+6mdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCw8bRmDr1Egb4ycMvOohp0I+J5yWBAbxibJUGaFGLoAcyVLgQioB8clKDAqMxKSiftR6y+RHDQCwkvWPu1KynlORfqRAGGBXccLfJNmZ9yDm0v9iSt88Amm2N2wW1QEC8hQU8k6YyGEl8o6x41OWgqljxuY0SG/HCFZ6KJUl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyTSH/fn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyTSH/fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96534C4CEEA;
	Thu, 12 Jun 2025 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749718450;
	bh=YNGbyo0dq6GKvxVdgZHgdwE6F5GPysZw4mgBrL+6mdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AyTSH/fn55yUdOl/0zYU74dDAugOw5TWL8bJY+IrXYg5WFoU55uJp7zq+QlSO3MXM
	 AqqI1tXSJu1/O9yXMrVrIop8XihR1VjqHBvyB/7Q6FzSjs064z1pEHly3l5hQPOS9J
	 u+sk9BgH2vUMqKtjDkA/gMq6/cJXLIX3RGRYGfvNji8smUqNB99rvhIdHVRtdtSv93
	 RUukgZDOikZApez542uTaB3nZ9ljsPdVb+Vb92Ry9p3GJA9ZqOcH2g6f0rqCIIBDuz
	 dOSEN55binFeD5In5k6lVulCy7tEc/855Yh3UubTU3zXVReVTRiRxECdsQXFGHsuJ6
	 PgSt/IKA5RnIg==
Message-ID: <b6c85f8e-da53-4268-ae34-421dcf9e373c@kernel.org>
Date: Thu, 12 Jun 2025 10:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] serial: 8250: extract serial8250_THRE_test()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-16-jirislaby@kernel.org>
 <2c7977aa-831d-16be-667f-9f761ea0060f@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2c7977aa-831d-16be-667f-9f761ea0060f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11. 06. 25, 14:03, Ilpo Järvinen wrote:
> On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:
...
>> +	/*
>> +	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
>> +	 * has already been cleared.  Real 16550s should always reassert this interrupt whenever the
>> +	 * transmitter is idle and the interrupt is enabled.  Delays are necessary to allow register
>> +	 * changes to become visible.
> 
> Very long comment lines are hard to read. (This is mostly not related to
> line length limits, but with eye movement required.)
> 
> It may make sense to place some of the descriptive comment text into a
> function comment instead of placing them mid-function.
> 
>> +	 *
>> +	 * Synchronize UART_IER access against the console.
>> +	 */
>> +	uart_port_lock_irqsave(port, &flags);
>> +
>> +	wait_for_xmitr(up, UART_LSR_THRE);
>> +	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
>> +	udelay(1); /* allow THRE to set */
> 
> These comments mix visually into the code making this look a big wall of
> text overall. Maybe consider adding empty lines to the logic as well as
> there are what looks clear steps in this logic.


What about this:
> /*
>  * Test for UARTs that do not reassert THRE when the transmitter is idle and the
>  * interrupt has already been cleared. Real 16550s should always reassert this
>  * interrupt whenever the transmitter is idle and the interrupt is enabled.
>  * Delays are necessary to allow register changes to become visible.
>  */
> static void serial8250_THRE_test(struct uart_port *port)
> {       
>         struct uart_8250_port *up = up_to_u8250p(port);
>         unsigned long flags;
>         bool iir_noint1, iir_noint2;
> 
>         if (!port->irq)
>                 return;
>                         
>         if (up->port.flags & UPF_NO_THRE_TEST)
>                 return;
>         
>         if (port->irqflags & IRQF_SHARED)
>                 disable_irq_nosync(port->irq);
>         
>         /* Synchronize UART_IER access against the console. */
>         uart_port_lock_irqsave(port, &flags);
>         
>         wait_for_xmitr(up, UART_LSR_THRE);
>         serial_port_out_sync(port, UART_IER, UART_IER_THRI);
>         /* allow THRE to set */
>         udelay(1); 
> 
>         iir_noint1 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
>         serial_port_out(port, UART_IER, 0);
>         serial_port_out_sync(port, UART_IER, UART_IER_THRI);
>         /* allow a working UART time to re-assert THRE */
>         udelay(1); 
> 
>         iir_noint2 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
>         serial_port_out(port, UART_IER, 0);
> 
>         uart_port_unlock_irqrestore(port, flags);
> 
>         if (port->irqflags & IRQF_SHARED)
>                 enable_irq(port->irq); 
>                         
>         /*
>          * If the interrupt is not reasserted, or we otherwise don't trust the
>          * iir, setup a timer to kick the UART on a regular basis.
>          */
>         if ((!iir_noint1 && iir_noint2) || up->port.flags & UPF_BUG_THRE)
>                 up->bugs |= UART_BUG_THRE;
> }
> 

?

thanks,
-- 
js
suse labs
