Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438C69959;
	Mon,  4 Nov 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729602; cv=none; b=Zrzh13M/H8I5WpHT/eLvCtkLFjEzAbUYs78EP34SAx71fx6zij+RnAvA3uHv8L4IotF9AbTyO/cybPiEzmoOrN3u1anapcW5LLGxtjSqB/7MS4486PXD5Pc+ofqsOSbrdikhhyum2UcCb8tq95D/rdwHfi9y4dsGk/bQrwGnZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729602; c=relaxed/simple;
	bh=zHZVpDEghPumhbDxWCNP3qmyYu9XbrEXe58YCAISpz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVAU0ktpfW2FHZX+6KzGMvBbcCZgQ7K4aHpgt4A6Rodkrmd7mBVoz5Pb/0v4er+ifdAHZgEKERyi+NVjfMBBWEEBMC+EpdoxoudD7MM7Lhr/cIohE4GKKaKRdpJmBE1R+7sLTELQOEvfQ9FG8zYS8dUFiF3qvf4oFbT61tLxWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrZCVPbx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eg2tRJUF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrZCVPbx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eg2tRJUF"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730729598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqMpvBzTXhahVtCTdWYroVOEmQxKU/0HvPqDIkQqPYg=;
	b=YrZCVPbxwyd7YMzXWCMHJRIWA9gNIsiyQakRirV3nUDuvwGm0no4RpZO0zJ5teat4Fox9Y
	wpgJ1T8zZBWOdTcCIyU0WlgYUeDV/jLOEbGMd0h3QBfeL06NJo+iDI9myExtU1cpE1eiqR
	RU65G3BX+2JalZySA7SYWtai2x+C9DLuo/2pX7JsINGsFmO8bpCKjPiqcj1RYY6UIkqAZF
	AiT4epWC+giaTMkg2g7ObFbgse8v6C3oE/l+IgsMVi2LIKs+cwr9kiuSwq6gzcfE/Q1xQX
	aTqLiiJOWLN1xdEpmr7i9/Coi8qaCMqDN+/5dtlnPUQ7QzxW95987nTT/Kd9Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730729598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqMpvBzTXhahVtCTdWYroVOEmQxKU/0HvPqDIkQqPYg=;
	b=Eg2tRJUFLV5qxkREtuvMrNqi402ioDqX/dNJC+8Qct3UVeWZ1a8LrRSAqKpZuFiMCRDBdD
	VRZ5ndWFZC10YcBA==
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
In-Reply-To: <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-2-john.ogness@linutronix.de>
 <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org>
 <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
 <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
Date: Mon, 04 Nov 2024 15:19:18 +0106
Message-ID: <84ldxzccjl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-04, Jiri Slaby <jirislaby@kernel.org> wrote:
> Instead of looping fifosize multiplied by random timeout, can we
> re-use port->frame_time?

Rather than 10k loops, we could loop

	(port->frame_time * some_scaled_padding) / 1000

times. The padding is important because we should not timeout in the
normal scenario. Perhaps using ~2 as @some_padding. Something like:

	port->frame_time >> 9

?

>>   The difference between THRE and TEMT is the state of the shift register
>> only[2]:
>> 
>> "In the FIFO mode, TEMT is set when the transmitter FIFO and shift
>> register are both empty."
>
> But what's the purpose of spinning _here_? The kernel can run and
> FIFO too. Without the kernel waiting for the FIFO.
>
> If we want to wait for fifo to empty, why not *also* the TSR. Meaning:
>
> Did you want UART_LSR_TEMT?

Let us assume we have a line with 640 characters and a FIFO of 64
bytes. For this line, we must wait for the FIFO to empty 10 times. It is
enough to wait for THRE for each of the 64-byte blocks because we are
only interested in refilling the FIFO at this point. Only at the very
end (in the caller...  serial8250_console_write()) do we need to wait
for everything to flush to the wire (TEMT).

By waiting on TEMT for each of the 64-byte blocks, we are waiting longer
than necessary. This creates a small window where the FIFO is empty and
there is nothing being transmitted.

I did a simple test on my beaglebone-black hardware, sending 100 lines
of 924 bytes at 9600 bps. Since my hardware uses a 64-byte FIFO, each
line would have 14 such windows.

And indeed, waiting for TEMT rather than only THRE for the 64-byte
blocks resulted in an extra 30ms total transfer for all 92400
bytes. That is about 20us lost in each window by unnecessarily waiting
for TEMT.

Of course, we are only talking about console output, which is horribly
inefficient on system resources. But I would argue, if we do not care
about unnecessary waiting, then why even have the FIFO optimization in
the first place?

John
