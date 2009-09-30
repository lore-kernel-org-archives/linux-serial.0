From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH RESEND] timbuart: Support for beeing probed more than
 once
Date: Wed, 30 Sep 2009 09:56:50 +0200
Message-ID: <4AC30F42.10408@mocean-labs.com>
References: <4AB8C23B.3020309@mocean-labs.com> <20090929162020.e429c826.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:40579 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZI3H4t (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Sep 2009 03:56:49 -0400
In-Reply-To: <20090929162020.e429c826.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Andrew Morton wrote:
> On Tue, 22 Sep 2009 14:25:31 +0200
> Richard R__jfors <richard.rojfors@mocean-labs.com> wrote:
> 
>> There was a problem in the current implementation where a global static
>> uart_driver struct was used. The same struct was reused every time the
>> driver got probed. Since the struct has a state within the serial core
>> it can not be reused.
>>
>> A uart_driver struct is added to the timbuart_port struct which is
>> allocated per platform device.
>>
>> The probe and remove functions are declared __devinit and __devexit.
> 
> Are you sure?  Lots of other serial drivers appears to do it this way
> and I'm ununaware of it causing any problems there.

I suppose it's not common that UART hardware comes and goes, or having several underlying devices
for the same driver.

> Exactly what problem(s) are you observing?  (This should have been
> described in the original changelog btw).

This is what happens on 2.6.32-rc1:

1. The underlaying platform device shows up -> timbuart is probed

2. The underlaying platform device disappears -> timbuart is removed

3. The underlaying platform device shows up:
[  369.722127] ------------[ cut here ]------------
[  369.722135] kernel BUG at drivers/serial/serial_core.c:2347!
[  369.722141] invalid opcode: 0000 [#1] PREEMPT SMP
[  369.722150] last sysfs file: /sys/module/mfd_core/initstate
[  369.722156] Modules linked in: timberdale(+) timbuart max7301 radio_timb joydev ks8842 adv7180
saa7706h tef6862 tsc2007 xilinx_spi_pltfm xilinx_spi i2c_xiic asix timbmlb spi_bitbang most
timblogiw timbdma snd_timbi2s usbnet mfd_core [last unloaded: timberdale]
[  369.722204]
[  369.722212] Pid: 2777, comm: modprobe Not tainted (2.6.32-rc2-ivi #2)
[  369.722219] EIP: 0060:[<c12389e8>] EFLAGS: 00010286 CPU: 0
[  369.722233] EIP is at uart_register_driver+0x12/0x142
[  369.722240] EAX: f8272968 EBX: f75ba080 ECX: ffffffff EDX: 00ca1000
[  369.722246] ESI: fffffff4 EDI: f6e970c0 EBP: f6b6bd70 ESP: f6b6bd5c
[  369.722253]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[  369.722261] Process modprobe (pid: 2777, ti=f6b6a000 task=f6b02ff0 task.ti=f6b6a000)
[  369.722266] Stack:
[  369.722270]  f8272968 f6b6bd70 f75ba080 fffffff4 f6e970c0 f6b6bd8c f8272533 f8272887
[  369.722287] <0> f6e970c8 f6e970c8 ffffffed f8272934 f6b6bd94 c12400e2 f6b6bda8 c123f43c
[  369.722294] <0> f8272934 f6e970c8 c16b9844 f6b6bdb8 c123f54f f6b6bdc4 00000000 f6b6bdd8
[  369.722294] Call Trace:
[  369.722294]  [<f8272533>] ? timbuart_probe+0x12d/0x185 [timbuart]
[  369.722294]  [<c12400e2>] ? platform_drv_probe+0xc/0xe
[  369.722294]  [<c123f43c>] ? driver_probe_device+0x79/0x105
[  369.722294]  [<c123f54f>] ? __device_attach+0x28/0x30
[  369.722294]  [<c123eba1>] ? bus_for_each_drv+0x3d/0x67
[  369.722294]  [<c123f5ba>] ? device_attach+0x44/0x58
[  369.722294]  [<c123f527>] ? __device_attach+0x0/0x30
[  369.722294]  [<c123ea37>] ? bus_probe_device+0x1f/0x34
[  369.722294]  [<c123d8dd>] ? device_add+0x313/0x44e
[  369.722294]  [<c14893b7>] ? _write_unlock+0x8/0x1f
[  369.722294]  [<c1240643>] ? platform_device_add+0xd9/0x11c
[  369.722294]  [<f81fe18d>] ? mfd_add_devices+0x16d/0x1c4 [mfd_core]
[  369.722294]  [<f826e3c6>] ? timb_probe+0x313/0x43c [timberdale]
[  369.722294]  [<c119f6b4>] ? local_pci_probe+0xe/0x10
[  369.722294]  [<c11a00b5>] ? pci_device_probe+0x43/0x66
[  369.722294]  [<c123f43c>] ? driver_probe_device+0x79/0x105
[  369.722294]  [<c123f50b>] ? __driver_attach+0x43/0x5f
[  369.722294]  [<c123eddf>] ? bus_for_each_dev+0x3d/0x67
[  369.722294]  [<c123f313>] ? driver_attach+0x14/0x16
[  369.722294]  [<c123f4c8>] ? __driver_attach+0x0/0x5f
[  369.722294]  [<c123e866>] ? bus_add_driver+0xf9/0x223
[  369.722294]  [<c123f74f>] ? driver_register+0x8b/0xeb
[  369.722294]  [<c11a0279>] ? __pci_register_driver+0x43/0x9c
[  369.722294]  [<c104cbbf>] ? __blocking_notifier_call_chain+0x40/0x4c
[  369.722294]  [<f8275000>] ? timberdale_init+0x0/0x48 [timberdale]
[  369.722294]  [<f8275017>] ? timberdale_init+0x17/0x48 [timberdale]
[  369.722294]  [<c1001139>] ? do_one_initcall+0x4c/0x131
[  369.722294]  [<c105d0c8>] ? sys_init_module+0xa7/0x1db
[  369.722294]  [<c1002aa1>] ? syscall_call+0x7/0xb
[  369.722294] Code: 20 6a 00 e8 fe c6 de ff 5b 8b 45 e8 e8 51 f8 24 00 8d 65 f4 5b 5e 5f 5d c3 55
89 e5 57 56 53 83 ec 08 89 45 ec 83 78 1c 00 74 04 <0f> 0b eb fe 8b 55 ec 31 db 69 42 14 c4 00 00 00
ba d0 80 00 00
[  369.722294] EIP: [<c12389e8>] uart_register_driver+0x12/0x142 SS:ESP 0068:f6b6bd5c
[  369.722758] ---[ end trace ad0b6892a395c249 ]---


The reason is as you see line 2347 of serial_core:
int uart_register_driver(struct uart_driver *drv)
{
	struct tty_driver *normal = NULL;
	int i, retval;

	BUG_ON(drv->state);

The drv->state is not 0, since the "old" struct is reused. The same would happen if the same static
uart_driver struct is used for several devices.

We could set state to NULL, since it was actually deallocated when the driver was unregistered (step
2 above). That would be fine for my case where I only have one platform device which comes and goes.

But the case where we have two platform devices in parallell would break, because the uart_driver
struct is used internally in serial_core. Setting state to NULL when probing the second would make
the state disappear for the first device.

Row 2375 of serial_core:
	normal->driver_state    = drv;

My conclusion is, we need a uart_driver struct per actual hardware device.

--Richard

