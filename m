From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Expected behavior of set_termios() w.r.t. TX FIFO?
Date: Sat, 18 Mar 2017 18:57:54 +0800
Message-ID: <20170318105754.GA19937@kroah.com>
References: <CAMuHMdWVOFVxb4bfexg5ZPOdC6Yig4g5Rd+5rRAOfrhH3W83GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWVOFVxb4bfexg5ZPOdC6Yig4g5Rd+5rRAOfrhH3W83GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 17, 2017 at 01:28:39PM +0100, Geert Uytterhoeven wrote:
> Hi Greg, Jiri, Peter,
> 
> I'm wondering what is the expected behavior of calling
> uart_ops.set_termios() w.r.t. characters that are already queued in the
> UART's TX FIFO.
> 
>   - Should it wait (block) until all queued characters have been
>     transmitted, before changing the UART's settings?
>   - Should it apply the new settings immediately, affecting the already
>     queued characters?
>   - Should it apply the new settings, dropping the already queued
>     characters?
>   - Is calling uart_ops.set_termios() while the TX FIFO isn't empty
>     allowed (this can be triggered easily from userspace)?
> 
> uart_ops.set_termios() returns void, so there's no way to return an error.
> 
> Currently the sh-sci driver blocks until the TX FIFO has been emptied,
> which may never happen if hardware flow control is enabled, and the remote
> side never asserts CTS, leading to:
> 
>         NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
> 
> See also "[PATCH 2/2] serial: sh-sci: Fix hang in sci_reset()",
> https://lkml.org/lkml/2016/12/2/225).
> 
> Thanks for your answer!

I think this has come up in the past, and due to the problem you have
found (could be waiting forever due to flow control), the answer was
just to set the new settings and not wait for anything to be flushed out
of the uart.

If a user sends a bunch of data, and then changes settings, without
first waiting for the data to be sent, then I feel they deserve the
uncertainty they will get :)

Hope this helps,

greg k-h
