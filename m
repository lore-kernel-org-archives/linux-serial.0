From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: earlycon: no match?
Date: Mon, 04 May 2015 18:31:44 -0400
Message-ID: <5547F350.7030405@hurleysoftware.com>
References: <20150503211054.GR15254@pengutronix.de> <55477BC1.6000805@hurleysoftware.com> <20150504194229.GR15254@pengutronix.de> <5547D4DB.8060300@hurleysoftware.com> <20150504205241.GT15254@pengutronix.de> <5547E447.9020604@hurleysoftware.com> <20150504215832.GW15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150504215832.GW15254@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 05/04/2015 05:58 PM, Robert Schwebel wrote:
> On Mon, May 04, 2015 at 05:27:35PM -0400, Peter Hurley wrote:
>> As I understand you,
>>
>> 1. you have CONFIG_SERIAL_EARLYCON=y
>> 2. but you don't specify an earlycon
>> 3. so no earlycon starts.
>> 4. your command line includes "console=ttyAMA0,115200n8"
>> 5. and a console starts on that port (yes?)
>>
>> I don't see a regression here from any previous kernel; this is exactly
>> the same behavior as before, so what is broken?
> 
> It outputs a warning message "no match" because it assumes that
> "ttyAMA0" (specified in the console= entry on the kernel commandline)
> matches with "pl011", coming from OF_EARLYCON_DECLARE for the serial
> driver.
> 
> I don't understand how this is supposed to work: it will *never* match,
> right?
> 
> You say it is a diagnostics message that indicates a misspelling.
> I fail to see what is misspelled, so what does it diagnose?

Ok, so this is only about the diagnostic message, and not about some
other failure.

I don't typically describe harmless diagnostics that didn't appear before
as "broken", so I was having trouble believing what I was reading.

Now that I understand that this is _only_ about a diagnostic message that
didn't appear in previous kernels, I will direct to what I have written
previously multiple times.

Further, I would ask how _you_ would programmatically distinguish
misspellings amongst the following console strings?

	console=pl012,...
	console=_pl011,...
	console=pl,...
	console=ttyAMA0,...
	
Regards,
Peter Hurley

>>> In order to let you better understand the setup here: My AM335x device
>>> (same CPU as on BeagleBone) is a headless embedded system, the only
>>> input/output device it has is a serial port. No display, no touch. For
>>> development, a pretty similar system is simulated in QEMU, with
>>> vexpress.
>>>
>>> Until recently, specifying "console=ttyAMA0" was the correct way to get
>>> the kernel + userspace output out of that serial line. On ARM, there was
>>> no "early" mechanism, only early_printk.
>>>
>>> I wouldn't mind if your citation from kernel-parameters above was true
>>> and I could get an (early and non-early) serial console with a unified
>>> "console=ttyAMA0".
>>>
>>> However, it doesn't work, as "ttyAMA0" doesn't match "pl011".
>>
>> The AM335x does not have a AMBA pl011 port, so "console=ttyAMA0,..." has no
>> effect on that hardware, and never has. Something else is providing console
>> on that setup. Please attach your entire dmesg log for that setup.
> 
> Hardware 1: AM335x
>             drivers/serial/tty/omap-serial.c
>             console=ttyO2,115200n8
> 
> Hardware 2: QEMU/vexpress
>             drivers/serial/tty/amba-pl011.c
>             console=ttyAMA0,38400
> 
> The same kernel runs on both platforms.
> 
> Let's just discuss the 2nd case for now, with ttyAMA0 (which is pl011),
> which has earlycon support and registers here:
> 
> http://lxr.free-electrons.com/source/drivers/tty/serial/amba-pl011.c#L2129
> 
>>> So I'm doing the right thing here, and it doesn't work.
>>
>> I'm not sure what you mean by "it doesn't work".
>> Are you saying that the serial console is not starting?
> 
> The serial console is starting.
> 
> It claims that earlycon has "no match", while the correct serial device
> is specified.
> 
> How do you suggest this is supposed to be used in the pl011 case,
> without the "diagnostic message" triggering that says "no match"?
> 
> Here is the full serial console log (directed to qemu's stdout):
> 
> ----------8<----------8<----------8<----------8<----------8<----------
> rsc@callisto:OSELAS.BSP-GF$ configs/platform-gf/run
> [    0.000000] Linux version 4.1.0-rc1+ (rsc@callisto) (gcc version 4.8.3 20131111 (prerelease) (OSELAS.Toolchain-2013.12.2 linaro-4.8-2013.11) ) #10 PREEMPT Mon May 4 23:03:27 CEST 2015
> [    0.000000] earlycon: no match for ttyAMA0,38400n8
> [    0.000000] Kernel command line: root=/dev/mmcblk0p2 rootfs=ext2 rw mem=1024M console=ttyAMA0,38400n8 loglevel=6 rootwait rootfstype=ext4

PS - If the message really bothers you that much, please feel free to submit a
patch to Greg that lowers that message level to pr_info() instead, so it
doesn't appear in your logs.

I've include an _unsigned_ patch below which does just that. Feel free to
modify and submit it to Greg with your Signed-off-by.


> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0674ed4   (6580 kB)
> [    0.000000]       .init : 0xc0675000 - 0xc06b2000   ( 244 kB)
> [    0.000000]       .data : 0xc06b2000 - 0xc06fd3e8   ( 301 kB)
> [    0.000000]        .bss : 0xc0700000 - 0xc073a5d8   ( 234 kB)
> [    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
> [    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
> [    0.425170] platform 10000000.sysreg: Error -2 creating of_node link
> [    0.429607] platform basic-mmio-gpio.1.auto: Error -2 creating of_node link
> [    0.429959] platform basic-mmio-gpio.2.auto: Error -2 creating of_node link
> [    0.430561] platform basic-mmio-gpio.3.auto: Error -2 creating of_node link
> [    0.604531] of_amba_device_create(): amba_device_add() failed (-19) for /memory-controller@100e0000
> [    0.605709] of_amba_device_create(): amba_device_add() failed (-19) for /memory-controller@100e1000
> [    0.606411] of_amba_device_create(): amba_device_add() failed (-19) for /watchdog@100e5000
> [    0.620892] of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga@7,00000000/sysctl@01000
> [    0.633512] of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga@7,00000000/wdt@0f000
> [    0.725997] SCSI subsystem initialized
> [    0.796591] NFS: Registering the id_resolver key type
> [    0.797533] Key type id_resolver registered
> [    0.797758] Key type id_legacy registered
> [    0.998780] Key type dns_resolver registered
> [    1.403497] random: nonblocking pool is initialized
> 
> Welcome to PTXdist / af inventions-GF!
> 
> [  OK  ] Created slice Root Slice.
> [  OK  ] Listening on Journal Socket (/dev/log).
> [  OK  ] Listening on udev Kernel Socket.
> 
> <...>
> 
> ----------8<----------8<----------8<----------8<----------8<----------
> 
> rsc
> 

--- >% ---
Subject: [PATCH] earlycon: Reduce log message level of "earlycon: no match for
 ..."

---
 drivers/tty/serial/earlycon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5fdc9f3..a7725f6 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -188,7 +188,7 @@ static int __init param_setup_earlycon(char *buf)
 
 	err = setup_earlycon(buf);
 	if (err == -ENOENT) {
-		pr_warn("no match for %s\n", buf);
+		pr_info("no match for %s\n", buf);
 		err = 0;
 	} else if (err == -EALREADY) {
 		pr_warn("already registered\n");
-- 
2.4.0
