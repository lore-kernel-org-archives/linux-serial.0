From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Date: Thu, 16 Aug 2012 16:35:55 +0200
Message-ID: <502D054B.3010606@c-s.fr>
References: <201208141426.q7EEQSPc003956@localhost.localdomain> <20120814155227.018988da@pyramind.ukuu.org.uk> <502CF2A0.8080109@c-s.fr> <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:34457 "EHLO mailhub1.si.c-s.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab2HPOgA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 10:36:00 -0400
In-Reply-To: <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Le 16/08/2012 16:29, Alan Cox a =E9crit :
>> The PowerPC CPM is working differently. It doesn't use a fifo but
>> buffers. Buffers are handed to the microprocessor only when they are
>> full or after a timeout period which is adjustable. In the driver, t=
he
> Which is different how - remembering we empty the FIFO on an IRQ
>
>> buffers are configured with a size of 32 bytes. And the timeout is s=
et
>> to the size of the buffer. That is this timeout that I'm reducing to=
 1
>> byte in my proposed patch. I can't see what it would break for high
>> speed I/O.
> How can a timeout be measured in "bytes". Can we have a bit more clar=
ity
> on how the hardware works and take it from there ?
>
> Alan
>
The reference manual of MPC885 says the following about the MAX_IDL=20
parameter:

MAX_IDL: Maximum idle characters. When a character is received, the=20
receiver begins counting idle characters. If MAX_IDL idle characters ar=
e=20
received before the next data character, an idle timeout occurs and the=
=20
buffer is closed,
generating a maskable interrupt request to the core to receive the data=
=20
from the buffer. Thus, MAX_IDL offers a way to demarcate frames. To=20
disable the feature, clear MAX_IDL. The bit length of an idle character=
=20
is calculated as follows: 1 + data length (5=969) + 1 (if parity is use=
d)=20
+ number of stop bits (1=962). For 8 data bits, no parity, and 1 stop b=
it,=20
the character length is 10 bits

If the UART is receiving data and gets an idle character (all ones), th=
e=20
channel begins counting consecutive idle characters received. If MAX_ID=
L=20
is reached, the buffer is closed and an RX interrupt is generated if no=
t=20
masked. If no buffer is open, this event does not generate an interrupt=
=20
or any status information. The internal idle counter (IDLC) is reset=20
every time a character is received. To disable the idle sequence=20
function, clear MAX_IDL


The datasheet of the 16550 UART says:

Besides, for FIFO mode operation a time out mechanism is implemented.=20
Independently of the trigger level of the FIFO, an interrupt will be=20
generated if there is at least one word in the FIFO and for a time=20
equivalent to the transmission of four characters
- no new character has been received and
- the microprocessor has not read the RHR
To compute the time out, the current total number of bits (start, data,=
=20
parity and stop(s)) is used, together with the current baud rate (i.e.,=
=20
it depends on the contents of the LCR, DLL, DLM and PSD registers).


Christophe
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
