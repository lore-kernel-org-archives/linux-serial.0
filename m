From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is >=0
Date: Fri, 30 Jan 2015 15:23:16 -0800
Message-ID: <20150130232316.GA20971@kroah.com>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com>
 <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 15, 2015 at 03:55:08PM +0100, Michal Simek wrote:
> This patch should be the part of:
> "tty: serial: 8250_core: use the ->line argument as a hint in
> serial8250_find_match_or_unused()"
> (sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)
> 

How can I go back in time and add a patch to another one?

confused,

greg k-h
