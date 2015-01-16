From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is
 >=0
Date: Fri, 16 Jan 2015 12:02:02 +0100
Message-ID: <3ecb2012312c4af5bbd395391aa82921@BY2FFO11FD005.protection.gbl>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com>
 <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
 <54B8D32E.5000805@linutronix.de>
 <df5d7450de9f4382b1cb43791f69e25c@BL2FFO11FD013.protection.gbl>
 <54B8ED20.60308@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54B8ED20.60308@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

On 01/16/2015 11:51 AM, Sebastian Andrzej Siewior wrote:
> - Yoshihiro YUNOMAE
> (reason: 550 5.1.1 <yoshihiro.yunomae.ez@hitachi.com>: Recipient
> address rejected: User Unknown)
> 
> On 01/16/2015 11:37 AM, Michal Simek wrote:
>> Hi,
> 
> Hi,
> 
>> Origin patch looks good to me but this checking will be good to add.
>> Are you using of_serial.c because I didn't find any of_alias_get_id call
>> for 8250?
> 
> I'm using of_alias_get_id() in 8250_omap.c which made it into
> v3.19-rc1. I think the change you mention made it one release earlier.

I see
serial: of-serial: fetch line number from DT
commit 1bd8324535ec1ff44aef55c0e40b9e7d56b310fb

but it was reverted

Revert "serial: of-serial: fetch line number from DT"
commit e4c787dac21e50ac9ef53fac91b9182d4fede465

Olof: what was the reason for that breakage?
Is it missing alias list on Tegra?
which caused that port->line number is bogus.

Thanks,
Michal
