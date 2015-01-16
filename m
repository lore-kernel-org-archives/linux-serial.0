From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is
 >=0
Date: Fri, 16 Jan 2015 12:33:09 +0100
Message-ID: <54B8F6F5.1030204@linutronix.de>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com> <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com> <54B8D32E.5000805@linutronix.de> <df5d7450de9f4382b1cb43791f69e25c@BL2FFO11FD013.protection.gbl> <54B8ED20.60308@linutronix.de> <3ecb2012312c4af5bbd395391aa82921@BY2FFO11FD005.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ecb2012312c4af5bbd395391aa82921@BY2FFO11FD005.protection.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

On 01/16/2015 12:02 PM, Michal Simek wrote:
>>> Origin patch looks good to me but this checking will be good to add.
>>> Are you using of_serial.c because I didn't find any of_alias_get_id call
>>> for 8250?
>>
>> I'm using of_alias_get_id() in 8250_omap.c which made it into
>> v3.19-rc1. I think the change you mention made it one release earlier.
> 
> I see
> serial: of-serial: fetch line number from DT
> commit 1bd8324535ec1ff44aef55c0e40b9e7d56b310fb
> 
> but it was reverted
> 
> Revert "serial: of-serial: fetch line number from DT"
> commit e4c787dac21e50ac9ef53fac91b9182d4fede465
> 
> Olof: what was the reason for that breakage?
> Is it missing alias list on Tegra?
> which caused that port->line number is bogus.

I doubt it, because a missing alias would return -1 and would not be
considered for port->line.

I think it is more what happens if you use the second UART and the
primary is unused (as in not probed). With this change the console will
be on ttyS1 - without it it remains on ttyS0. The former is what we
wanted.

And it seems they use for "nvidia,tegra[23]0-hsuart" the serial-tegra.c
driver which makes use of of_alias_get_id() but the of_serial() one
which is used by nvidia,tegra20-uart() does not. And since this change
does not notify anyone during upgrade but removes the console everyone
gets a little grumpy*.

* and I've been looking for a smooth solution for the ttyOx -> ttySx
  change in OMAP just to avoid people complaining and risking a revert
  :)

> Thanks,
> Michal

Sebastian
