From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is
 >=0
Date: Mon, 2 Feb 2015 09:09:52 +0100
Message-ID: <10fc6603c5af4dfab13cb36a1f7b95be@BN1AFFO11FD050.protection.gbl>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com>
 <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
 <20150130232316.GA20971@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130232316.GA20971@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

On 01/31/2015 12:23 AM, Greg Kroah-Hartman wrote:
> On Thu, Jan 15, 2015 at 03:55:08PM +0100, Michal Simek wrote:
>> This patch should be the part of:
>> "tty: serial: 8250_core: use the ->line argument as a hint in
>> serial8250_find_match_or_unused()"
>> (sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)
>>
> 
> How can I go back in time and add a patch to another one?

ok. Let me rewrite it to make more sense. Definitely not asking
you to squash that to the patch. It is just pointer to origin
patch which added this code and which should be extended with this one.

Thanks,
Michal
