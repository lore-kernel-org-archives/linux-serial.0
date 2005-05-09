From: Christer Weinigel <christer@weinigel.se>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: 09 May 2005 11:15:43 +0200
Message-ID: <m3br7klpz4.fsf@zoo.weinigel.se>
References: <200505051650.38471.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:53673 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261174AbVEIJPp
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 05:15:45 -0400
In-Reply-To: <200505051650.38471.andyparkins@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
Cc: linux-serial@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I wonder if anyone can help me with this as a problem?  I'm trying to send 
> commands to a device along a two wire RS485 connection.  I'm using an RS232 
> to RS485 converter that changes the buffer direction based on RTS.  With that 
> in mind I therefore do things like (error detection left out for brevity)
> 
>       ______________________________________
> RTS __|                                    |_____
>        _____ ___ ___ ___
> TXD ___|   |_| |_| |_| |_________________________
>         S 1 0 1 0 1 0 1 0 s
>                            <-----delay---->
> 
> There is a small delay between RTS going high and the data starting - no 
> problem there, however, when the transmission finishes there is a 2 byte 
> delay before RTS goes low.  The device I'm talking to has (apparently) a 
> response time of 200us; I'm seeing a delay before restoration of RTS of 2ms. 
> write() returns immediately - the delay is coming from tcdrain() - but I 
> cannot see from where.

As others have told you, the granularity of HZ in the stock Linux
kernel isn't good enough to give you a 200us RTS shutoff.  What you
should be able to do is something like this:

    usigned int lsr;

    bit = TIOCM_RTS;
    ioctl( fd, TIOCMBIS, &bit );

    do {
        ioctl(fd, TIOCSERGETLSR, &lsr);
    } while (lsr & TIOCSER_TEMT);

    ioctl( fd, TIOCMBIC, &bit );

This will busy wait until the transmitter is empty.  It's wasteful,
but it'll probably work.  Remember to add error checking to the above
code, and you may want to run it with a realtime priority when you've
seen that it works.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
