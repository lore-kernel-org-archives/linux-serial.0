From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] tty: serial: 8250_core: Check that port->line is
 >=0
Date: Fri, 16 Jan 2015 11:37:01 +0100
Message-ID: <df5d7450de9f4382b1cb43791f69e25c@BL2FFO11FD013.protection.gbl>
References: <3293c93689f5d8c684133a9d9952411a201609dc.1421333585.git.michal.simek@xilinx.com>
 <d3a26f5ecd44e1415f213e6ee7f33005c1b23f4a.1421333585.git.michal.simek@xilinx.com>
 <54B8D32E.5000805@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54B8D32E.5000805@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

Hi,

On 01/16/2015 10:00 AM, Sebastian Andrzej Siewior wrote:
> On 01/15/2015 03:55 PM, Michal Simek wrote:
>> This patch should be the part of:
>> "tty: serial: 8250_core: use the ->line argument as a hint in
>> serial8250_find_match_or_unused()"
>> (sha1: 59b3e898ddfc81a65975043b5eb44103cc29ff6e)
>>
>> port->line can be setup by DT driver to -1 which needs to
>> be also checked.
> 
> This is what I have in 8250_omap to make sure it does not get < 0:
> 
>          if (pdev->dev.of_node) {
>                  ret = of_alias_get_id(pdev->dev.of_node, "serial");
> 
>                  of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>                                       &up.port.uartclk);
>                  priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
>          } else {
>                  ret = pdev->id;
>          }
>          if (ret < 0) {
>                  dev_err(&pdev->dev, "failed to get alias/pdev id\n");
>                  return ret;
>          }
>          up.port.line = ret;
> 
> but I didn't think of that others might pass < 0 since it wasn't used
> before.
> Does the original patch (you noted) break anything as of now? Because
> then this patch should go stable.

Origin patch looks good to me but this checking will be good to add.
Are you using of_serial.c because I didn't find any of_alias_get_id call
for 8250?

Your logic here is a little bit different than I have in my tree.
(Some sort of pl011 solution). You don't need to failed if you port.line is
below 0 but if you are not able to read aliases port enumeration
may be unpredictable.

Thanks,
Michal
