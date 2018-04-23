From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC. PATCH] earlycon: Remove hardcoded port->uartclk
 initialization in of_setup_earlycon
Date: Mon, 23 Apr 2018 15:22:51 +0200
Message-ID: <18997e5d-dcbf-3a99-e1db-994ba97b1e24@xilinx.com>
References: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
 <6626f66e-e1a6-9e54-0011-95ab4949bd3b@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6626f66e-e1a6-9e54-0011-95ab4949bd3b@mips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Redfearn <matt.redfearn@mips.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, devicetree@vger.kernel.org, Rob Herring <robherring2@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On 23.4.2018 15:16, Matt Redfearn wrote:
> 
> 
> On 23/04/18 10:27, Michal Simek wrote:
>> There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
>> systems.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> It looks like from history that portclk = BASE_BAUD * 16 was setup to
>> get on calculation on x86 (divisor = 1) but it shouldn't be needed on
>> DT based
>> system. That's why I think that there is no DT based system which really
>> requires this line.
> 
> Hi Michal,
> 
> This is fine for the MIPS generic platform (tested on Boston board)
> which was broken by some earlycon changes a few versions ago. Also
> tested on a MIPS pistachio board. As long as the bootloader has
> configured the uart divisor, earlycon should work as long as my patch
> "serial: 8250_early: Only set divisor if valid clk & baud" is applied to
> avoid a bad divisor getting calculated.

I have sent one patch to fix your patch because you don't need to check
device->baud twice.
[PATCH] serial: 8250_early: Setup divider when uartclk is passed
 > Tested-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Michal
