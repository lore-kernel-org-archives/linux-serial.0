From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: problems with serial driver
Date: Tue, 3 Sep 2002 14:21:43 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <049601c25376$c174d160$294b82ce@connecttech.com>
References: <Pine.LNX.4.44.0209031920570.25130-100000@scil.sinp.msu.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: slack@slackware.ru
Cc: alan@redhat.com, linux-serial@vger.kernel.org

From: <slack@slackware.ru>
> Everything is clear, not a problem. The problem is with overruns.
> I have no idea on how to debug such events. And I cannot detect, what is
> OK and what is not OK (maybe, problems with interrupt, or, port cannot
> detect the start bit etc.), When I put some code between the read()s, it
> brings delays, everything works, more, can sync without any problem with
> start bit (mystic, I see, but... cannot debug). Also, cannot catch the
> overrun.

I don't understand you.

When the receiver port isn't open, but is receiving data, the uart has
the rx circuits turned off. There will be no overruns, because the
hardware is ignoring the input line. When the port is open, but reads
aren't happening fast enough, the driver discards the extra data
silently. Overruns usually indicate a hardware problem.

> it is not a problem, if only few. but I've got a stable garbage (frequency
> is higher, than of normal data - the fact put me in a strange state;
> statistics must say 50/50, but real life 90/10...) or stable normal data.

If you attach to an existing serial data stream, you should get a
mis-sync most of the time. Assuming 8N1 you have a start bit, 8 bits
of character and a stop bit. 10 bits total. Only one is correct, the
start bit, so your random sync attempt should work 1 in 10 times. It
will actually work a little higher, as some of the character bits
don't look like the stop bit and get skipped over, but 90/10 isn't an
unreasonable result.

> and, also, overruns. is it normal, when we like to read data from the port
> with frequency, that is higher, than bus freq.? I think, no. is it
> possible to eliminate such problems? it is hard to control such behaviour
> of the system, it becomes unstable. ordinary user can put such calculator
> in off state. :)

The bus frequency (PCI bus, ISA bus etc) should be mostly irrelevant.
You'd only care if you had a serial port expansion card that was
clocked at a very high base baud rate, and it was an ISA card.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


