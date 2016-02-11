From: Martin Sperl <martin@sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in
 console
Date: Thu, 11 Feb 2016 14:15:10 +0100
Message-ID: <56BC895E.2010108@sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>
Cc: Eric Anholt <eric@anholt.net>
List-Id: linux-serial@vger.kernel.org


On 10.02.2016 16:12, Martin Sperl wrote:
> Hi!
>
> I got a strange effect when using the auxiliar UART as the logging co=
nsole:
>
> The kernel is configured for drivers/tty/serial/8250/8250_bcm2835aux.=
c to
> get linked into the main kernel (requires also 8250.c to be linked in=
).
>
> As long as I boot using the main UART (PL011) in the kernel parameter=
s:
>    earlyprintk consoleblank=3D0 console=3DttyAMA0 root=3D/dev/mmcblk0=
p2 rootwait
>
> Everything works fine - early_printk works and normal logging works a=
s well.
> Both configured ttys (/dev/ttyAMA0 and /dev/ttyS0) in /etc/initttab
> work fine.
>
> Now when I switch the console to use the auxiliar UART
> (which right now does not support early_printk) like this:
>    earlyprintk consoleblank=3D0 console=3DttyS0,115200n1 root=3D/dev/=
mmcblk0p2 rootwait
>
> I get the situation where:
> * u-boot starts and writes to the main UART
> * Kernel boots using early_printk logging to the main UART until we g=
et to:
>    [    2.657090] bootconsole [earlycon0] disabled
> * then we see the earlyprintk buffer dumped on the aux-uart
> * then booting continues and logging happens on the aux-uart:
>    [    2.657090] bootconsole [earlycon0] disabled
>    [    2.662673] 20201000.serial: ttyAMA0 at MMIO 0x20201000 (irq =3D=
 81, base_baud =3D 0) is a PL011 rev2
>    [    2.663793] console [ttyS0] disabled
>    [    2.663899] 20215040.serial: ttyS0 at MMIO 0x0 (irq =3D 53, bas=
e_baud =3D 31224999) is a 16550
>    [    3.384166] console [ttyS0] enabled
> * everything works fine and I get networking and everything up
>    [....] Starting NTP server: ntpd. ok
>    [....] Starting OpenBSD Secure Shell server: sshd. ok
>    My IP address is 10.10.10.41 ::127.0.0.1
>
>    Raspbian GNU/Linux 7 raspcm.intern.sperl.org ttyS0
> * I can even log in via SSH and networking works.
>    Note that I have the getty for ttyAMA0 disabled in inittab
> * when I then enable the tty on the main UART like this:
>    root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
> * I get the following:
>    [   72.962845] uart-pl011 20201000.serial: no DMA platform data
> * the system freezes=E2=80=A6
> * sometimes I still get the following on the auxiliar UART before the=
 system =E2=80=9Ccrashes":
>    (at least when starting the tty from inittab)
>    [   73.072985] bcm2835-clk 20101000.cprman: plld: couldn't lock PL=
L
>    [   73.079132] ------------[ cut here ]------------
>    [   73.083848] WARNING: CPU: 0 PID: 2329 at drivers/clk/clk.c:680 =
clk_core_disable+0x34/0xf0()
>    [   73.093067] ---[ end trace 416e78cea88f5fb5 ]---
>    [   73.097848] ------------[ cut here ]------------
>    [   73.102616] WARNING: CPU: 0 PID: 2329 at drivers/clk/clk.c:575 =
clk_core_unprepare+0x34/0x110()
>    [   73.112219] ---[ end trace 416e78cea88f5fb6 ]---
>
> A similar effect I get when using stty:
>    root@raspcm:~# stty -F /dev/ttyAMA0
>    [  128.878127] uart-pl011 20201000.serial: no DMA platform data
>    speed 9600 baud; line =3D 0;
>    -brkint -imaxbel
> Then the system freezes.
>
> As if the plld does not lock - even if it (probably) is already locke=
d.
>
> Or the message actually comes from bcm2835_clock_wait_busy which also
> produces this message - so maybe we should better identify the messag=
e.
>
> Note that the same also applies if I remove earlyprintk with
> the only difference being that I do not get the initial boot
> messages on the main UART.
> (at that time only: "Uncompressing Linux... done, booting the kernel.=
=E2=80=9D
> shows on the main uart after u-boot start..)
>
> Unfortunately it is only possible to really test this on a
> rpi-Compute module, as only there we can expose both uarts
> on distinct GPIOs at the same time:
>    GPIO 14: level=3D1 fsel=3D4 alt=3D0 func=3DTXD0
>    GPIO 15: level=3D1 fsel=3D4 alt=3D0 func=3DRXD0
>    GPIO 32: level=3D1 fsel=3D2 alt=3D5 func=3DTXD1
>    GPIO 33: level=3D1 fsel=3D2 alt=3D5 func=3DRXD1
>
> Here the commits I have used based on spi/for-next (based on 4.4.0)
> with the patches (* prefix) for the driver for aux-uart
> added separately as they are not in the tree I have used:
> * a96f6c7 serial: bcm2835: add driver for bcm2835-aux-uart
> * 464e876 clk: bcm2835: Add bindings for the auxiliary peripheral clo=
ck gates.
> * 1af1b28 clk: bcm2835: Add a driver for the auxiliary peripheral clo=
ck gates.
> ece19b8 Merge remote-tracking branch 'spi/fix/loopback' into spi-linu=
s
> 887e6a3 Merge tag 'spi-v4.5' into spi-linus
> ebea7c0 spi: fix counting in spi-loopback-test code
> cabeea9 Merge remote-tracking branches 'spi/topic/sun4i', 'spi/topic/=
topcliff-pc
> 4f95307 Merge remote-tracking branches 'spi/topic/overlay', 'spi/topi=
c/pxa2xx',
> 41d5a70 Merge remote-tracking branches 'spi/topic/lm70llp', 'spi/topi=
c/loopback'
> 635b9b2 Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/dw-=
mid', 'spi/
> 3c27892 Merge remote-tracking branches 'spi/topic/bcm63xx', 'spi/topi=
c/butterfly
> 9b17e80 Merge remote-tracking branch 'spi/topic/sunxi' into spi-next
> 174c211 Merge remote-tracking branch 'spi/topic/core' into spi-next
> f30f072 Merge remote-tracking branch 'spi/fix/mtk' into spi-linus
> afd2ff9 Linux 4.4
>
> Maybe someone has gotten any idea?
>
> In the meantime I will try to reproduce on a 4.5-rc3 based branch.
Same issue with 4.5-rc3 - here the commits:
* bec2300c serial: bcm2835: add driver for bcm2835-aux-uart
388f7b1 Linux 4.5-rc3

Here the clock calls I have instrumented for the console=3DttyAMA0 case=
:
[    1.884107] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - plla
[    1.890723] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllb
[    1.897308] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllc
[    1.903849] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - plld
[    1.910429] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllh
[    1.917184] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
timer
[    1.924143] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ti=
mer
[    1.931237] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
otp
[    1.938081] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ot=
p
[    1.944757] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
tsens
[    1.951714] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ts=
ens
[    1.958605] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
vpu
[    1.965429] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - vp=
u
[    1.972088] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
v3d
[    1.978909] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - v3=
d
[    1.985622] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
isp
[    1.992405] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - is=
p
[    1.999101] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
h264
[    2.006011] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - h2=
64
[    2.012774] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
sdram
[    2.019772] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - sd=
ram
[    2.026848] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
uart
[    2.033725] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ua=
rt
[    2.040521] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
vec
[    2.047366] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ve=
c
[    2.054207] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.061065] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - hs=
m
[    2.067720] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.074699] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
emmc
[    2.081574] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - em=
mc
[    2.088316] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.095253] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.102112] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.108951] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - pw=
m
[    2.115594] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.122374] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.129667] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.136523] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.143329] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.150148] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.157157] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.163942] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.230330] bcm2835-clk 20101000.cprman: bcm2835_pll_on - pllc
[    2.245552] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[    2.251559] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[    2.284246] bcm2835-clk 20101000.cprman: bcm2835_clock_on - emmc

And for the console=3DttyS0,115200 case:
[    1.884106] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - plla
[    1.890721] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllb
[    1.897307] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllc
[    1.903849] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - plld
[    1.910429] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllh
[    1.917183] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
timer
[    1.924143] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ti=
mer
[    1.931234] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
otp
[    1.938077] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ot=
p
[    1.944759] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
tsens
[    1.951717] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ts=
ens
[    1.958607] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
vpu
[    1.965429] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - vp=
u
[    1.972089] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
v3d
[    1.978908] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - v3=
d
[    1.985620] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
isp
[    1.992406] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - is=
p
[    1.999102] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
h264
[    2.006010] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - h2=
64
[    2.012772] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
sdram
[    2.019769] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - sd=
ram
[    2.026842] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
uart
[    2.033719] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ua=
rt
[    2.040518] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
vec
[    2.047362] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ve=
c
[    2.054199] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.061052] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - hs=
m
[    2.067706] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.074688] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
emmc
[    2.081561] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - em=
mc
[    2.088303] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.095241] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.102100] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.108938] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - pw=
m
[    2.115582] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.122362] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.129648] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.136509] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.143315] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.150135] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.157145] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.163929] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.230333] bcm2835-clk 20101000.cprman: bcm2835_pll_on - pllc
[    2.275803] bcm2835-clk 20101000.cprman: bcm2835_clock_on - emmc

The only real difference is this diff:
@@ -41,6 +41,4 @@
   20101000.cprman: bcm2835_clock_get_parent - pwm
   20101000.cprman: bcm2835_clock_get_parent - hsm
   20101000.cprman: bcm2835_pll_on - pllc
- 20101000.cprman: bcm2835_pll_on - plld
- 20101000.cprman: bcm2835_clock_on - uart
   20101000.cprman: bcm2835_clock_on - emmc

so plld and uart are not started for the console=3DttyS0 case.

After I instrumented clk-bcm2835.c to see what happens in the driver
and running: /sbin/getty -a root -L ttyAMA0 115200 vt100

I get the following:
[  146.342341] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[  146.348426] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[  146.354639] uart-pl011 20201000.uart: no DMA platform data
[  146.375535] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
[  146.381776] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - u=
art
[  146.388595] bcm2835-clk 20101000.cprman: bcm2835_pll_off - plld
[  146.396574] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[  146.502551] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
[  146.508726] ------------[ cut here ]------------
[  146.513448] WARNING: CPU: 0 PID: 2349 at drivers/clk/clk.c:680=20
clk_core_disa)
[  146.522673] ---[ end trace 33268753126338e9 ]---
[  146.527478] ------------[ cut here ]------------
[  146.532224] WARNING: CPU: 0 PID: 2349 at drivers/clk/clk.c:575=20
clk_core_unpr)
[  146.541866] ---[ end trace 33268753126338ea ]---

So I wonder why we would disable and reenable the plld and uart clock

Note that just adding a return in bcm2835_pll_off like this:
@@ -900,6 +905,9 @@ static void bcm2835_pll_off(struct clk_hw *hw)
      struct bcm2835_cprman *cprman =3D pll->cprman;
      const struct bcm2835_pll_data *data =3D pll->data;

+    dev_err(cprman->dev, "%s - %s\n", __FUNCTION__, clk_hw_get_name(hw=
));
+    return;
+
      cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
      cprman_write(cprman, data->a2w_ctrl_reg, A2W_PLL_CTRL_PWRDN);
  }

avoids the crash, but the tty is non-functional.

Calling sequence of the clock driver is:
[  145.022546] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[  145.028619] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[  145.034807] uart-pl011 20201000.uart: no DMA platform data
[  145.045089] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
[  145.051418] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - u=
art
[  145.058215] bcm2835-clk 20101000.cprman: bcm2835_pll_off - plld
[  145.065779] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[  145.071761] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart

debugfs shows the following after the above:
root@raspcm:~# head /sys/kernel/debug/clk/uart*/clk_rate
=3D=3D> /sys/kernel/debug/clk/uart0_pclk/clk_rate <=3D=3D
3000000

=3D=3D> /sys/kernel/debug/clk/uart1_pclk/clk_rate <=3D=3D
125000000

=3D=3D> /sys/kernel/debug/clk/uart/clk_rate <=3D=3D
2997598

Is this maybe related to the uart0_pclk, uart1_pclk, apb_pclk
clocks created and registered in bcm2835_init_clocks?

Any Ideas?

Thanks,
                 Martin
