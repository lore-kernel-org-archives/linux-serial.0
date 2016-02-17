From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in
 console
Date: Wed, 17 Feb 2016 11:43:42 +0100
Message-ID: <56C44EDE.9020800@martin.sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
 <56BC895E.2010108@sperl.org>
 <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de>
 <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org>
 <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org>
 <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org>
 <470852136.382408.76a8faee-9235-4ee0-9fd1-e25a1e9f0bb3.open-xchange@email.1und1.de>
 <F7B22AC0-58A7-431D-B203-0C7A9802A040@martin.sperl.org>
 <20160216185737.2278.60129@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160216185737.2278.60129@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


On 16.02.2016 19:57, Michael Turquette wrote:
> Hi Martin & Stefan,
...
> ... how about using the shiny new HAND_OFF clocks feature? See:
>
> http://lkml.kernel.org/r/<1455225554-13267-1-git-send-email-mturquette@baylibre.com>
>
> It seems like you need clocks to remain enabled from the time they are
> registered until a clk consumer driver claims them and Does The Right
> Thing. (e.g. only gates them when it is safe to do so, such as display
> being turned off by user).
>
> Let me know if those patches will help you. The first three patches in
> the series introduce CRITICAL clocks, which never gate. Patches 4-6 are
> a solution that I prefer, allowing the clocks to remain enabled by the
> bootloader, and only gated later on when a consumer driver claims them.
> No changes to clock consumer drivers are required, the framework handles
> the transition of reference counts and the clock provider driver only
> has to set the CLK_ENABLE_HAND_OFF flag for the affected clocks.

I wonder if those patches would really help in this use-case.

HAND_OFF seems to show an issue around the fact that as soon as a
clock is claimed once it is handled "normally".

So when the amba-pl011 driver requests and prepares the uart clock
the "lower" PLLD_per (divider) clock as well as the PLLD (pll) clock
become "prepared" as they are parents.

So fine so good - and that works right now fine.

The problem is that the amba-pl011 driver when loaded as a module
- for some reason - runs clk_unprepare/disable when the tty is closed.

Using stty instead of getty for simplicity (as getty closes and reopens
the tty - or so it seems):
root@raspcm:~# stty -F /dev/ttyAMA0
[ 94.328906] pl011_startup - start
[ 94.332401] pl011_hwinit - prepare-enable
 > HERE PLLD gets prepared/enabled
[ 94.336499] bcm2835_pll_on - plld - start
[ 94.340642] cprman_write - 0x010c = 0x0000020a
[ 94.345170] bcm2835_pll_on - plld - before_wait_pll_lock
[ 94.350637] bcm2835_pll_on - plld - end
 > HERE PLLD_PER gets prepared/enabled
[ 94.354558] cprman_write - 0x1540 = 0x00000004
[ 94.359097] cprman_write - 0x010c = 0x0000020a
 > HERE UART gets prepares/enabled
[ 94.363660] cprman_write - 0x00f0 = 0x000002d6
[ 94.368203] pl011_hwinit - prepare-enable - ret = 0
[ 94.375212] pl011_startup - exit
OUTPUT BY STTY: speed 9600 baud; line = 0;
OUTPUT BY STTY: -brkint -imaxbel
[ 94.381528] pl011_shutdown - start
[ 94.385722] pl011_shutdown - disable_unprepare
 > HERE UART gets disabled/unprepared
[ 94.391024] cprman_write - 0x00f0 = 0x00000286
 > here PLLD_PER gets disabled/unprepared
[ 94.396037] cprman_write - 0x010c = 0x0000028a
[ 94.400616] cprman_write - 0x1540 = 0x00000104
 > HERE PLL gets disabled/unprepared
[ 94.405143] bcm2835_pll_off - plld - start
[ 94.409316] cprman_write - 0x010c = 0x0000038a
[ 94.413906] cprman_write - 0x1140 = 0x00031034
[ 94.418435] bcm2835_pll_off - plld - end
[ 94.422500] pl011_shutdown - exit
root@raspcm:~#

So with the HAND_OFF the PLLD (as it has been prepared) would follow
thru the "release" code as expected, which results in stopping the
PLLD_per clock and subsequently the PLLD clock.

And this disabling of PLLD is what - as far as I can tell - brings
the system to it knees, so this needs to be avoided

And that is what the HAND_OFF flag would not stop, as the clock - at
that time has been claimed - at least when using it directly on PLLD.

Using CLK_IS_CRITICAL instead would solve that issue, as it just does
the prepare/enable inside the framework once and never unprepares it.

I guess it would also help to understand the clock-tree, but
the information on the clock-tree is scarce (or under NDA),
so it is hard to understand why the PLLD impacts the system
in such a way.

Possibly some of the CPU interfaces are sourced from PLLD
(say PLLD_core) and that is why the CPU stops working.

Things that come to mind are:
* SRAM
* AXI bus
* ARM - core (even though that is supposed to be driven of PLLB)
* ARM - L2 cache
* GPU - run by firmware...

And thus disabling the PLLD would impact those interfaces...
(but I could be wrong)

But - as said - documentation on the clock tree details
is unfortunately lacking...

A bit of digging in the source-code shows that the sdram
clock has the clocks in bcm2835_clock_vpu_parents assigned
as parents.

The regdump for the sdram clock shows:
root@raspcm:/build/linux# cat /sys/kernel/debug/clk/sdram/regdump
ctl = 0x00004006
div = 0x00003000

So we use the 6th clock from the list of vpu clocks. (ctl & 0x0f)
and that is the plld_core clock!

This means that obviously disabling PLLD is NOT a good idea, as it
will effectively disable sdram.

Maybe we actually should be forcing the sdram clock to be always
prepared/enabled manually or via CLK_IS_CRITICAL or CLK_HAND_OFF.

Martin

P.s: As far as I understand the reason why the amba_pl011 driver
compiled in is working is because then the driver is used as
the console, so it is always opened and thus the clocks are
always prepared.

Starting getty at a later stage during the boot will thus never
risk getting the prepare_count of the PLLD to 0 - the kernel
console will still hold the prepare reference and thus we
are at 1.
