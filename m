From: Stas Sergeev <stsp@list.ru>
Subject: Re: Q: how to control the TTY output queue in real time?
Date: Fri, 10 Aug 2012 23:54:19 +0400
Message-ID: <502566EB.3070304@list.ru>
References: <50255E31.8060904@list.ru> <20120810203355.224622cc@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120810203355.224622cc@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Alan, thanks, clear enough now. :)

10.08.2012 23:33, Alan Cox wrote:
> 	if (bytes_left < constant)
> 		write_wakeup
>
>
> and I suspect if you made that adjustable and turned off the fifo and any
> other funnies you'd at least make it work for a sufficiently rigged demo.
You suggest to turn off the fifo, sounds worrysome,
does this mean that tcdrain() and TIOCOUTQ do not
account the fifo too?
If they do quite fine with the fifo, then maybe the new
function will do too? Its basically a tcdrain(), just with
the controllable watermark I guess.
