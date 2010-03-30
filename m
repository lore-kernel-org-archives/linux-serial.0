From: christian pellegrin <chripell@fsfe.org>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Tue, 30 Mar 2010 14:03:20 +0200
Message-ID: <cabda6421003300503t4fc7d3c4tc51167611180fef9@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	 <1269340170-6558-1-git-send-email-chripell@fsfe.org>
	 <20100329104838.49c18075@feng-i7>
	 <cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	 <20100329150642.4a94e78a@feng-i7>
	 <cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	 <20100330101445.5c64dedb@feng-i7>
	 <cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
	 <20100330094637.325d3fb9@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41234 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460Ab0C3MDV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Mar 2010 08:03:21 -0400
Received: by gyg13 with SMTP id 13so2104562gyg.19
        for <linux-serial@vger.kernel.org>; Tue, 30 Mar 2010 05:03:20 -0700 (PDT)
In-Reply-To: <20100330094637.325d3fb9@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Feng Tang <feng.tang@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Mar 30, 2010 at 10:46 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> There I would partly disagree. Fixing the spi driver clearly makes sense
> but the serial driver should be batching better. Is there a reason the
> driver couldn't adjust the size based upon the tty speed when getting a
> termios request ?

Just a small note for those who don't know max31x0. There are just 2
instructions to tx/rx data: simple data rx (in which we read one data
from the fifo (the data is valid if R status bit is set), control
lines (CTS) and status bits) and a combined tx/rx (like before but we
also send one byte (if the T status bit the char will be accepted) and
set control lines (RTS)). Every of these instructions is 2 bytes long.
It's a full SPI message (so you have to assert CS before and de-assert
it afterwards to make it work). TX buffer is just 1 byte deep, RX one
is 8 bytes.

Unfortunately we cannot batch TX if SPI speed (in chars going in /
time unit) is higher than the baud rate of serial communication. We
need to check that T bis is asserted before sending a char, otherwise
it is lost. For low baud rates doing this means monopolizing the bus.
And there is a subtle problem if we reduce SPI speed to the UART baud
rate: we can ask only for a maximum speed on the SPI. In case this is
lower the one we asked (maybe because of SPI clock divisors) and we do
a TX batch big enough we could not be emptying the RX FIFO fast enough
and so we risk to loose chars in a full duplex operation (*).

We could do batch RX operation but perhaps we are just transferring
bytes for nothing because we don't know in advance if the R bit is
set. And we cannot interleave TX and RX like current drivers do
because we are forced to use the simple rx operation and not the
combined rx/tx.

There's another point about batching: single instructions are complete
SPI messages. Many SPI master drivers I worked with (S3C24xx, AT91
because of a bug in the hardware) manage CS as a normal gpio. Another
problem here is that many devices require a configurable delay on CS
change (see delay_usecs field of spi_transfer) which is not handle by
hardware and so the drivers must somehow break a SPI messages in
single transfers and do something at the end of every one of these. So
even we batch 10 tx/rx instructions I really don't think many SPI
master controllers will be able to do a DMA of 20 bytes. Anyway I
agree that if we find a way of doing batching it's a good thing
because better controllers can benefit.

>
>> 2) even worse is that we can do flow control decision only on such boundary.
>
> For serial flow control it doesn't matter, its implicitly asynchronous
> and if you only turn the fifo on at high speed you response time will be
> reasonably bounded.
>

if we somehow manage to batch a TX of n bytes and after the first one
CTS changes we are going to send n-1 chars anyway. OK, maybe our peer
de-asserted CTS when still having n-1 byes of buffer free and somehow
higher layer protocols will recover. So I agree this could be not so
worrisome. But we should keep n small enough.

>> 3) this is not reliable: think of what happens if the actual SPI
>> transfer speed we get will be slower that the one we requested. We
>> won't be emptying the RX buffer fastly enough even if could.
>
> Consoles are not usually balanced for I/O. I grant you probably don't
> want to be using full fifo sized blocks but I'm not sure I understand why
> there is a problem below that ?
>

My concern is expressed above (*). Perhaps it's me missing some point.
To make it clear: I'm more than happy to test a driver that takes
another approach and switch to it if it's better (but it has to have
support of multiple instances and a fair usage of SPI bandwidth at
least). But I really don't see a reliable way of adding batching of
tx/rx. And I think it will be better to provide a patch to the current
driver than to rewrite it completely.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
