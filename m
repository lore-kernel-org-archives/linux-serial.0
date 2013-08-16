From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Fri, 16 Aug 2013 05:27:53 -0700
Message-ID: <20130816122753.GA24550@kroah.com>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50636 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab3HPM0R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 08:26:17 -0400
Content-Disposition: inline
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: jslaby@suse.cz, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On Fri, Aug 16, 2013 at 05:13:01PM +0530, Viresh Kumar wrote:
> The -rt patch triggers a lockdep warning for serial drivers if
> tty_flip_buffer_push() is called with uart_port->lock locked. This never shows
> up on UP kernels.

What about SMP kernels?  linux-next?

> Release the port lock before calling tty_flip_buffer_push() and reacquire it
> after the call.
> 
> Similar stuff was already done for few other drivers in the past, like:
> 
> commit 2389b272168ceec056ca1d8a870a97fa9c26e11a
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue May 29 21:53:50 2007 +0100
> 
>     [ARM] 4417/1: Serial: Fix AMBA drivers locking
> 
> This is neither tested nor compiled.

So I'm guessing you don't want it to be applied, if you can't take the
time to at least test-build it, why should we?

{sigh}

> I was working on Samsung's Arndale board
> and so was required to samsung serial driver. Then thought why not others :)
> 
> Rebased over: v3.11-rc5

Lots of tty and serial changes have happened since -rc5 in linux-next,
can you please rebase, and test, these against that tree and resend them
if they are still needed?

thanks,

greg k-h
