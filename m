From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Date: Thu, 16 Aug 2012 15:16:16 +0200
Message-ID: <502CF2A0.8080109@c-s.fr>
References: <201208141426.q7EEQSPc003956@localhost.localdomain> <20120814155227.018988da@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120814155227.018988da@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org


Le 14/08/2012 16:52, Alan Cox a =E9crit :
> On Tue, 14 Aug 2012 16:26:28 +0200
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
>> Hello,
>>
>> I'm not sure who to address this Patch to either
>>
>> It fixes a delay issue with CPM UART driver on Powerpc MPC8xx.
>> The problem is that with the actual code, the driver waits 32 IDLE p=
atterns before returning the received data to the upper level. It means=
 for instance about 1 second at 300 bauds.
>> This fix limits to one byte the waiting period.
> Take a look how the 8250 does it - I think you want to set the value
> based upon the data rate. Your patch will break it for everyone doing
> high seed I/O.
>
> Alan
>
I'm not sure I understand what you mean. As far as I can see 8250/16550=
=20
is working a bit different, as it is based on a fifo and triggers an=20
interrupt as soon as a given number of bytes is received. I also see=20
that in case this amount is not reached, there is a receive-timeout=20
which goes on after no byte is received for a duration of more than 4 b=
ytes.

The PowerPC CPM is working differently. It doesn't use a fifo but=20
buffers. Buffers are handed to the microprocessor only when they are=20
full or after a timeout period which is adjustable. In the driver, the=20
buffers are configured with a size of 32 bytes. And the timeout is set=20
to the size of the buffer. That is this timeout that I'm reducing to 1=20
byte in my proposed patch. I can't see what it would break for high=20
speed I/O.

Christophe
