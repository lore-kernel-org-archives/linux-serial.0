From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BUG] NULL pointer dereference in uart_write_room().
Date: Tue, 6 May 2008 22:23:28 +0100
Message-ID: <20080506212328.GA17929@flint.arm.linux.org.uk>
References: <261636618@web.de> <200805022300.GIB30385.FJOVHQSMFtOOFL@I-love.SAKURA.ne.jp> <200805041716.DDG43279.JOSMHVFOFFQLOt@I-love.SAKURA.ne.jp> <20080505113055.5284052e@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40878 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933592AbYEFVXt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 May 2008 17:23:49 -0400
Content-Disposition: inline
In-Reply-To: <20080505113055.5284052e@core>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 05, 2008 at 11:30:55AM +0100, Alan Cox wrote:
> > (5) uart_remove_one_port() is called by serial8250_register_port()
> >     since ttyS0 is already in use but it is requested to be once removed.
> 
> That means 8250_pnp is taking over and then trying to delete the console,
> so its breakage in the serial layer glue. Perhaps Russell has some ideas
> as its hard to tell what he intended to happen originally.

Is the rest of the report available somewhere?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
