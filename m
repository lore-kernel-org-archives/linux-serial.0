Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C689A15A8;
	Sun,  1 Dec 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733011487; cv=none; b=gV7m6TqHhrTx1+fK7zfNaneIHMMxpCehyPViamnKlhHjKnF5LiJoJ+8BbjFVH+C7CpKRaqFxCTA6lXrRo4XDXMr7nDQsEWJLEozjATr3unbceGxmvenQP6WmW1DE4mL0/H2bS9UPzv1In0W6WDDqEdcxnHT4v5Ecqifha/aXv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733011487; c=relaxed/simple;
	bh=MLnJgorJwh+hbxtr/zQo6L4PQuQDTv95fqiNd+XnGIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PZ8I+cipW4uVvpSpR8mo2gcVJSS9PqeIukBZuxZSOqjMJnaue5V925J887DXS0nVlMaIm5n5XpFbN84XCqOfSrUjRfRgzJ7Md2189+G1ALmvQWWYJx1kPur10FhUYtkRB1sf70JTc/6VlY0lPLIzdnToEpH7lt/50PmHKlX4+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B841992009C; Sun,  1 Dec 2024 01:04:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B1B9692009B;
	Sun,  1 Dec 2024 00:04:36 +0000 (GMT)
Date: Sun, 1 Dec 2024 00:04:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiri Slaby <jirislaby@kernel.org>
cc: John Ogness <john.ogness@linutronix.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Petr Mladek <pmladek@suse.com>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Rengarajan S <rengarajan.s@microchip.com>, 
    Jeff Johnson <quic_jjohnson@quicinc.com>, 
    Serge Semin <fancer.lancer@gmail.com>, 
    Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
    Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH tty-next v3 1/6] serial: 8250: Adjust the timeout for
 FIFO mode
In-Reply-To: <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
Message-ID: <alpine.DEB.2.21.2411080343040.9262@angie.orcam.me.uk>
References: <20241025105728.602310-1-john.ogness@linutronix.de> <20241025105728.602310-2-john.ogness@linutronix.de> <837a7ecd-be29-4865-9543-cb6f7e7e46e7@kernel.org> <alpine.DEB.2.21.2410310349450.40463@angie.orcam.me.uk>
 <2fab2ef8-d0d6-4b94-90b6-7c16641a2f68@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 Nov 2024, Jiri Slaby wrote:

> > > THRE only signals there is a space for one character.
> > 
> >   Nope[1]:
> > 
> > "In the FIFO mode, THRE is set when the transmit FIFO is empty; it is
> > cleared when at least one byte is written to the transmit FIFO."
> 
> Hmm, I was confused by NXP's 16c650b [1] datasheet then (or I cannot parse):
> ===
> The THR empty flag in the LSR register will be set to a logic 1 when the
> transmitter is empty or when data is transferred to the TSR. Note that a write
> operation can be performed when the THR empty flag is set
> (logic 0 = FIFO full; logic 1 = at least one FIFO location available).
> ===

 This description seems broken indeed and I find your interpretation of it
correct.  I do hope this is just an editorial mistake with the NXP device.

> But indeed in the LSR[5] bit description, they state:
> ===
> In the FIFO mode, this bit is set when the transmit FIFO is
> empty; it is cleared when at least 1 byte is written to the transmit FIFO.
> ===

 FWIW I chased documentation for the original 16550A device and it uses 
analogous wording[1]:

"Bit 5: This bit is the Transmitter Holding Register Empty (THRE)
indicator. Bit 5 indicates that the UART is ready to
accept a new character for transmission. In addition, this bit
causes the UART to issue an interrupt to the CPU when the
Transmit Holding Register Empty Interrupt enable is set
high. The THRE bit is set to a logic 1 when a character is
transferred from the Transmitter Holding Register into the
Transmitter Shift Register. The bit is reset to logic 0 concur-
rently with the loading of the Transmitter Holding Register
by the CPU. In the FIFO mode this bit is set when the XMIT
FIFO is empty; it is cleared when at least 1 byte is written to
the XMIT FIFO."

It further documents polled operation for THRE[2]:

"LSR5 will indicate when the XMIT FIFO is empty."

and provides further details as to the transmit FIFO[3]:

"The NS16550A transmitter optimizes the CPU/UART data
transaction via the following features:

"1. The depth of the Transmitter (Tx) FIFO ensures that as
    many as 16 characters can be transferred when the
    CPU services the Tx interrupt. Once again, this effec-
    tively buffers the CPU transfer rate from the serial data
    rate.

"2. The Transmitter (Tx) FIFO is similar in structure to
    FIFOs the user may have previously set up in RAM. The
    Tx depth allows the CPU to load 16 characters each
    time it switches context to the service routine. This re-
    duces the impact of the CPU time lost in context switch-
    ing.

"3. Since a time lag in servicing an asynchronous transmit-
    ter usually has no penalty, CPU latency time is of no
    concern to transmitter operation."

This design choice may result in "choppy" transmission due to the transmit 
handler invocation latency, but as noted above it is intentional.  DMA can 
be used with the NS16550A if it is required to avoid this issue, and later 
compatible UART designs such as the 650 give more flexibility as to the Tx 
FIFO fill level trigger threshold.

References:

[1] National Semiconductor Corporation, "Microcommunication Elements 
    Databook, 1987 Edition", "NS16550A Universal Asynchronous 
    Receiver/Transmitter with FIFOs", Section 8.4 "LINE STATUS REGISTER", 
    p. 2-73

[2] same, Section 8.12 "FIFO POLLED MODE OPERATION", p. 2-75

[3] same, Martin S. Michael, Daniel G. Durich, Application Note 491, "The 
    NS 16550A: UART Design and Application Considerations", Section 1.0 
    "Design Considerations and Operation of the New UART Features", p. 5-4

Available from: 
<http://bitsavers.org/components/national/_dataBooks/1987_National_Microcommunications_Elements_Data_Book.pdf>.

 HTH,

  Maciej
