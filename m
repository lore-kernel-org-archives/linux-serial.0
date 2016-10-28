From: Nathan <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Fri, 28 Oct 2016 14:55:16 -0500
Message-ID: <d0895cd3-2552-60ce-ab24-2d6d100740bf@sgi.com>
References: <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------2A93167AA221705292FAF6A5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027201916.GA7718@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org

--------------2A93167AA221705292FAF6A5
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Unfortunately the quirk crashed...

[    3.985834] pnp 00:01: parse allocated resources
[    3.986342] pnp 00:01: PNP0c02: calling 
quirk_system_pci_resources+0x0/0x180
[    3.987055] pnp 00:01: PNP0c02: calling quirk_intel_mch+0x0/0x1a0
[    3.987613] pnp 00:01: PNP0c02: calling quirk_serial_port+0x0/0x140
[    3.988246] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000001
[    3.989044] IP: [<ffffffff813b52af>] quirk_serial_port+0xdf/0x140
[    3.989600] PGD 0
[    3.989798] Oops: 0002 [#1] SMP
[    3.990089] Modules linked in:
[    3.990476] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 
4.8.0-00001-ge41e11b #37
[    3.991176] Hardware name: SGI.COM ICE-XIP119/S0751-Medina, BIOS 
ma2e2054 02/05/2014
[    3.994913] task: ffff88086c2b4040 task.stack: ffff88086c2b8000
[    3.995461] RIP: 0010:[<ffffffff813b52af>] [<ffffffff813b52af>] 
quirk_serial_port+0xdf/0x140
[    3.996352] RSP: 0000:ffff88086c2bb998  EFLAGS: 00010282
[    3.996909] RAX: 0000000000000037 RBX: ffff88106f108360 RCX: 
0000000000000001
[    3.997596] RDX: 0000000000000001 RSI: 0000000000000292 RDI: 
ffff88106f108000
[    3.998240] RBP: ffff88086c2bb9e8 R08: 0000000000000000 R09: 
0000000000000000
[    3.998852] R10: 000000000000000a R11: 0000000000000000 R12: 
ffff88106f108000
[    3.999506] R13: ffff88106f108360 R14: 00000000ffffffea R15: 
ffff88084f2d3f40
[    4.000181] FS:  0000000000000000(0000) GS:ffff88086fb40000(0000) 
knlGS:0000000000000000
[    4.000880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.001363] CR2: 0000000000000001 CR3: 0000000001a06000 CR4: 
00000000001406e0
[    4.005050] Stack:
[    4.005249]  ffff88086c2bb9b8 0000000000000000 ffffffff81810846 
ffff88086c2bb988
[    4.006061]  00000000fbe1ffff ffffffff81aaf740 ffff88106f108000 
ffff88106f108000
[    4.006838]  00000000ffffffea ffff88084f2d3f40 ffff88086c2bba08 
ffffffff813b48f2
[    4.007586] Call Trace:
[    4.007821]  [<ffffffff813b48f2>] pnp_fixup_device+0x22/0x70
[    4.008272]  [<ffffffff813b0073>] __pnp_add_device+0x13/0xf0
[    4.008758]  [<ffffffff813a1c9d>] ? acpi_walk_resources+0xe3/0x114
[    4.009272]  [<ffffffff813b6550>] ? 
pnpacpi_parse_allocated_resource+0xa0/0xa0
[    4.009920]  [<ffffffff813b01a0>] pnp_add_device+0x50/0xf0
[    4.010481]  [<ffffffff813a1bab>] ? acpi_walk_resource_buffer+0x10d/0x11c
[    4.011127]  [<ffffffff813b6550>] ? 
pnpacpi_parse_allocated_resource+0xa0/0xa0
[    4.011823]  [<ffffffff813a1cbd>] ? acpi_walk_resources+0x103/0x114
[    4.015512]  [<ffffffff81b687ff>] pnpacpi_add_device+0x1ce/0x254
[    4.016040]  [<ffffffff81b688bb>] pnpacpi_add_device_handler+0x36/0x3a
[    4.016678]  [<ffffffff8139b2c5>] acpi_ns_get_device_callback+0x134/0x156
[    4.017356]  [<ffffffff8139ad78>] acpi_ns_walk_namespace+0x10a/0x251
[    4.017977]  [<ffffffff8139b191>] ? acpi_get_devices+0x10b/0x10b
[    4.018556]  [<ffffffff81b685bb>] ? ispnpidacpi+0x7b/0x7b
[    4.019089]  [<ffffffff8139b156>] acpi_get_devices+0xd0/0x10b
[    4.019649]  [<ffffffff81b68885>] ? pnpacpi_add_device+0x254/0x254
[    4.020236]  [<ffffffff81b68611>] pnpacpi_init+0x56/0x76
[    4.020753]  [<ffffffff81000380>] do_one_initcall+0xc0/0x1d0
[    4.021299]  [<ffffffff812e7444>] ? ida_pre_get+0x54/0xe0
[    4.024877]  [<ffffffff812398da>] ? proc_alloc_inum+0x4a/0xd0
[    4.025453]  [<ffffffff81b25d25>] ? repair_env_string+0x17/0x58
[    4.026030]  [<ffffffff810849e7>] ? parse_one+0xd7/0x180
[    4.026557]  [<ffffffff81084b7c>] ? parse_args+0xec/0x300
[    4.027094]  [<ffffffff81b25d0e>] ? kernel_init_freeable+0x2a3/0x2a3
[    4.027703]  [<ffffffff810a6c3e>] ? __wake_up+0x4e/0x70
[    4.028222]  [<ffffffff81b25a45>] do_basic_setup+0xb2/0xd8
[    4.028765]  [<ffffffff81b25d0e>] ? kernel_init_freeable+0x2a3/0x2a3
[    4.029370]  [<ffffffff81b25c85>] kernel_init_freeable+0x21a/0x2a3
[    4.029945]  [<ffffffff8157a939>] kernel_init+0x9/0x100
[    4.030443]  [<ffffffff81586ecf>] ret_from_fork+0x1f/0x40
[    4.030961]  [<ffffffff8157a930>] ? rest_init+0x80/0x80
[    4.031476] Code: 01 00 00 4c 89 e7 4c 89 f6 e8 5e 08 f4 ff 85 c0 74 
3c 48 8b 1b 4c 89 f2 4c 39 eb 0f 85 65 ff ff ff 48 85 d2 74 28 4d 85 ff 
74 23 <48> c7 02 00 00 00 00 48 c7 42 08 00 00 00 00 48 c7 42 10 00 00
[    4.036680] RIP  [<ffffffff813b52af>] quirk_serial_port+0xdf/0x140
[    4.037267]  RSP <ffff88086c2bb998>
[    4.037615] CR2: 0000000000000001
[    4.037938] ---[ end trace 5bc20b620cbcf8e2 ]---
[    4.038360] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x00000009
[    4.038360]
[    4.039210] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x00000009
[    4.039210]

The other thing I did as a diagnostic exercise was to look at the commit 
I bisected too.

After some experimentation I found only I could revert a small part to 
"fix" the issue.

This probably doesn't illuminate much but...

On 10/27/2016 03:19 PM, Sean Young wrote:
> On Wed, Oct 26, 2016 at 01:16:16PM -0500, Nathan Zimmer wrote:
>> On 10/25/2016 03:41 PM, Sean Young wrote:
>>> On Mon, Oct 24, 2016 at 04:49:25PM -0500, Nathan Zimmer wrote:
>>>> [    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>> The isa probe driver find the serial port.
>>>
>>>> [    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
>>>> [    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)
>>> But then decides that the port is already in use (the existing serial driver).
>>>> [    1.568366] serial 00:04: pnp_assign_resources failed (-16)
>>>> [    1.569188] serial 00:04: unable to assign resources
>>>> [    1.569924] serial: probe of 00:04 failed with error -16
>>> Please try and boot 3.7.0 with "8250.share_irqs=1", maybe it will pick
>>> irq 3 and it will be happy again, but that is just a guess.
>>>
>>> I think I have not fully understood what the failure is. Does the serial
>>> port not work or does the boot hang? What are the symptoms?
>> With console=ttyS1 the boot will "hang", sometimes it makes it all the way
>> through but may take 30 minutes, instead of the 2-4 minutes this box
> Where does it hang? Any error messages?
>
>>> We might be able to fix the problem with a pnp quirk but 3.7 is has not had
>>> any releases for a long time. We will need a reproduction on a concurrent
>>> kernel so a patch can be written for that.
>> Yes it still happens with 4.8+
>> I had only started dwelling on 3.6/3.7 since that is where it first appears
>> and don't have any attachment to those.
> Ok. Please try to following patch. I'm not sure it is good enough to be
> merged as-is, but should provide a start for testing. Output with
> CONFIG_PNP_DEBUG_MESSAGES should show only irq 3 is available for the
> serial port now.
>
> Sean
>
>  From 3a1705a2e28f4385b778ad96d7c517b82ea860e2 Mon Sep 17 00:00:00 2001
> From: Sean Young <sean@mess.org>
> Date: Thu, 27 Oct 2016 20:13:50 +0100
> Subject: [PATCH] PNP: Add quirk for BIOS advertising wrong irqs for serial
>   port
>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/pnp/quirks.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index d28e3ab..8712161 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -66,6 +66,48 @@ static void quirk_awe32_resources(struct pnp_dev *dev)
>   	}
>   }
>   
> +static void quirk_serial_port(struct pnp_dev *dev)
> +{
> +	struct pnp_option *option;
> +	struct pnp_irq *irq;
> +	struct pnp_port *port;
> +
> +	list_for_each_entry(option, &dev->options, list) {
> +		if (!pnp_option_is_dependent(option))
> +			continue;
> +
> +		if (option->type == IORESOURCE_IO) {
> +			port = &option->u.port;
> +
> +			if (port->min != 0x2f8 || port->max != 0x2f8 ||
> +				port->size != 8 || port->align != 1)
> +				return;
> +		} else if (option->type == IORESOURCE_IRQ) {
> +			pnp_irq_mask_t map;
> +
> +			irq = &option->u.irq;
> +
> +			bitmap_zero(map.bits, PNP_IRQ_NR);
> +			__set_bit(3, map.bits);
> +			__set_bit(4, map.bits);
> +			__set_bit(5, map.bits);
> +			__set_bit(6, map.bits);
> +			__set_bit(7, map.bits);
> +			__set_bit(10, map.bits);
> +			__set_bit(11, map.bits);
> +			__set_bit(12, map.bits);
> +
> +			if (!bitmap_equal(map.bits, irq->map.bits, PNP_IRQ_NR))
> +				return;
> +		}
> +	}
> +
> +	if (irq && port) {
> +		bitmap_zero(irq->map.bits, PNP_IRQ_NR);
> +		__set_bit(3, irq->map.bits);
> +	}
> +}
> +
>   static void quirk_cmi8330_resources(struct pnp_dev *dev)
>   {
>   	struct pnp_option *option;
> @@ -448,6 +490,7 @@ static struct pnp_fixup pnp_fixups[] = {
>   #ifdef CONFIG_PCI
>   	{"PNP0c02", quirk_intel_mch},
>   #endif
> +	{"PNP0c02", quirk_serial_port},
>   	{""}
>   };
>   


--------------2A93167AA221705292FAF6A5
Content-Type: text/x-patch; name="hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hack.patch"

---
 drivers/tty/serial/8250/8250_core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index dcf43f6..aef2d2a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1123,15 +1123,11 @@ static int __init serial8250_init(void)
        if (ret)
                goto out;
 
-       ret = serial8250_pnp_init();
-       if (ret)
-               goto unreg_uart_drv;
-
        serial8250_isa_devs = platform_device_alloc("serial8250",
                                                    PLAT8250_DEV_LEGACY);
        if (!serial8250_isa_devs) {
                ret = -ENOMEM;
-               goto unreg_pnp;
+               goto unreg_uart_drv;
        }
 
        ret = platform_device_add(serial8250_isa_devs);
@@ -1147,8 +1143,6 @@ static int __init serial8250_init(void)
        platform_device_del(serial8250_isa_devs);
 put_dev:
        platform_device_put(serial8250_isa_devs);
-unreg_pnp:
-       serial8250_pnp_exit();
 unreg_uart_drv:
 #ifdef CONFIG_SPARC
        sunserial_unregister_minors(&serial8250_reg, UART_NR);
@@ -1173,8 +1167,6 @@ static void __exit serial8250_exit(void)
        platform_driver_unregister(&serial8250_isa_driver);
        platform_device_unregister(isa_dev);
 
-       serial8250_pnp_exit();
-
 #ifdef CONFIG_SPARC
        sunserial_unregister_minors(&serial8250_reg, UART_NR);
 #else
-- 
1.7.12.4


--------------2A93167AA221705292FAF6A5--
