From: slack@slackware.ru
Subject: Re: problems with serial driver
Date: Wed, 4 Sep 2002 09:39:37 +0400 (MSD)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0209040919280.25638-100000@scil.sinp.msu.ru>
References: <049601c25376$c174d160$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <049601c25376$c174d160$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-serial@vger.kernel.org

On Tue, 3 Sep 2002, Stuart MacDonald wrote:

> > brings delays, everything works, more, can sync without any problem with
> > start bit (mystic, I see, but... cannot debug). Also, cannot catch the
> > overrun.
> I don't understand you.
> When the receiver port isn't open, but is receiving data, the uart has
> the rx circuits turned off. There will be no overruns, because the
> hardware is ignoring the input line. When the port is open, but reads
> aren't happening fast enough, the driver discards the extra data
> silently. Overruns usually indicate a hardware problem.
Hm... Hardware problem on different chipsets, different processors,
different kernels(only chip is 16550A). I understand, that this can
indicate hardware problems.
But..

> of character and a stop bit. 10 bits total. Only one is correct, the
> start bit, so your random sync attempt should work 1 in 10 times. It
> will actually work a little higher, as some of the character bits
> don't look like the stop bit and get skipped over, but 90/10 isn't an
> unreasonable result.
OK, I know that. It is clear. Can You tell me, why usleep(100) totally
eliminates the problem with garbage?

> The bus frequency (PCI bus, ISA bus etc) should be mostly irrelevant.
> You'd only care if you had a serial port expansion card that was
> clocked at a very high base baud rate, and it was an ISA card.
:) Ok, Ok. Have You ever got in touch with 2xP4 Xeon Mother with ISA slots
from Supermicro? The problem is in fact, that I ve get total kernel halts
when often open/close/startprog with serial ports. For example, running
script, that launches the prog and killing it, can kill the comp in a
short period of time with overruns.
Sorry, I'm short in deep HW knowledge, and, also, I have no much time
to debug such problem(but like to do that). :( Also, I don't know, how to
debug it in a better way in the kernel.


