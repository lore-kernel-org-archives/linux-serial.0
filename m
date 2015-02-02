From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is >=0
Date: Mon, 02 Feb 2015 12:49:32 +0200
Message-ID: <1422874172.31903.355.camel@linux.intel.com>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com>
	 <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
	 <20150130232316.GA20971@kroah.com>
	 <10fc6603c5af4dfab13cb36a1f7b95be@BN1AFFO11FD050.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10fc6603c5af4dfab13cb36a1f7b95be@BN1AFFO11FD050.protection.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, monstr@monstr.eu, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-02-02 at 09:09 +0100, Michal Simek wrote:
> On 01/31/2015 12:23 AM, Greg Kroah-Hartman wrote:
> > On Thu, Jan 15, 2015 at 03:55:08PM +0100, Michal Simek wrote:
> >> This patch should be the part of:
> >> "tty: serial: 8250_core: use the ->line argument as a hint in
> >> serial8250_find_match_or_unused()"
> >> (sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)
> >>
> > 
> > How can I go back in time and add a patch to another one?
> 
> ok. Let me rewrite it to make more sense. Definitely not asking
> you to squash that to the patch. It is just pointer to origin
> patch which added this code and which should be extended with this one.

I guess you can use Fixes tag for that, though it doesn't sound like a
fix.

> 
> Thanks,
> Michal
> 


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
