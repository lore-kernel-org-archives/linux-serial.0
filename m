From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
Date: Wed, 25 Apr 2018 14:51:37 +0200
Message-ID: <20180425125137.GA30021@kroah.com>
References: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, stable <stable@vger.kernel.org>, Matt Redfearn <matt.redfearn@mips.com>, Jiri Slaby <jslaby@suse.com>, Douglas Anderson <dianders@chromium.org>, linux-serial@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 23, 2018 at 11:18:11AM +0200, Michal Simek wrote:
> device->baud is always non zero value because it is checked already in
> early_serial8250_setup() before init_port is called.
> 
> Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid clk & baud")
> Cc: stable <stable@vger.kernel.org>

This isn't "fixing" anything, as the logic is identical before, or
after, this patch is committed.  So I'll apply this, but will drop these
two tags.

thanks,

greg k-h
