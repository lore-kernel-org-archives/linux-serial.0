From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell gateway
 shim for cdc-acm
Date: Sat, 5 Jan 2019 00:43:48 +0100
Message-ID: <9d97fec5-31b0-8717-cd10-de4f36d1cf05@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-6-afaerber@suse.de>
 <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-lpwan@lists.infradead.org, linux-serial <linux-serial@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev <netdev@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

Am 04.01.19 um 18:07 schrieb Rob Herring:
> On Fri, Jan 4, 2019 at 5:21 AM Andreas Färber <afaerber@suse.de> wrote:
>>
>> Ignore our device in cdc-acm probing and add a new driver for it,
>> dispatching to cdc-acm for the actual implementation.
>>
>> WARNING: It is likely that this VID/PID is in use for unrelated devices.
>> Only the Product string hints what this really is in current v0.2.1.
>> Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
>> with such firmware is known to me.
>>
>> While this may seem unorthodox, no internals of the driver are accessed,
>> just the set of driver callbacks is duplicated as shim.
>>
>> Use this shim construct to fake DT nodes for serdev on probe.
>> For testing purposes these nodes do not have a parent yet.
>> This results in two "Error -2 creating of_node link" warnings on probe.
> 
> It looks like the DT is pretty static. Rather than creating the nodes
> at run-time, can't you create a dts file and build that into your
> module.

Heh, if that were the only issue with this patch... ;)

I had read about that possibility here [1], but it just appeared to give
me a binary blob with no handy documentation on how to parse the
__dtb_XXX_begin..__dtb_XXX_end blob afterwards for assignment to
interface->dev.of_node. Two nodes and one compatible property were
enough to get me started, so that was quickest, given lack of knowledge.

I intentionally left it static to keep error handling and cleanup
manageable for now... Otherwise I'd need to kstrdup()/kzalloc() all
properties so that I can consistently kfree() them again on release.

Note that this was just a PoC, so there are properties missing here:

At least currently Ben's patch [2] (wrongly?) relies on the optional
clock-output-names property if #clock-cells property is specified -
which I did not in this patch. (Thus it'll disable clk_out, which would
break opening the netdev if we wouldn't run into other errors first.)

Any comments on how to best deal with clk names on the driver side would
be appreciated, so that we can just leave the property away here and get
a sane default name. Otherwise we'd need to generate a unique name here.

If #clock-cells were present, the driver would also rely on obtaining a
parent clock, which may be easiest for me to fix in the driver; but
assuming we need it, we'd need a clocks property pointing to phandles.
Wouldn't phandles need to be unique globally in the kernel for lookup?
phandles from a separate .dtb fragment wouldn't seem to tick that box.

(For reference there's also a clk locking issue under discussion at [3],
as well as multiple unresolved Kbuild reports about clk_hw not being
applicable on sparc64 allyesconfigs and m68k allmodconfig that I'm
unsure how to best resolve while keeping the driver broadly usable. Not
using clk would solve above DT worries but would leave us with ugly
driver dependencies across spi and a custom sx130x_radio bus.)

Kconfig may also be a topic to consider for this USB driver - my x86_64
host for instance doesn't have CONFIG_OF, so it might work to manually
allocate such nodes, whereas using API or &of_fwnode_ops (needed?) may
be a problem - although without CONFIG_OF the serdev code probably is
unable to enumerate the nodes in the first place?

And I assume on ACPI platforms hot-pluggable USB devices shouldn't need
a user-overridden ACPI table either - have you thought about some
serdev-specific lookup as fallback when OF and ACPI come up empty?

Your drivers/tty/serdev/core.c:serdev_controller_add() has access to
ctrl->dev->parent, so it could maintain a list of callbacks that drivers
(e.g., cdc-acm) could register callbacks with and cast the device here
to usb_interface; my module here would then only need to register such a
callback against cdc-acm in its module init to allow cdc-acm to provide
it with the usb_interface, where it could then check for the iProduct to
determine whether that device should be serdev-controlled or not - say
by returning 0 to bind, negative error to ignore - and loading/creating
an internal of_node or whatever necessary. Just a rough idea for now...

Even easier, serdev_device_driver could just get an optional callback!
Then my driver in 3/5 could just determine itself which device it wants
to bind against and still use the module_serdev_device_driver() macro.
(serdev is built-in, so not as easy to tweak on random boards here...)

Any comments on serdev in 4/5? I wonder whether that was an oversight
(in which case it should get a Fixes line) or an intentional choice due
to issues? You mentioned hangup and open/close mismatches before...

Thanks,
Andreas

[1] https://elinux.org/Device_Tree_Linux#FDT_built_into_kernel_as_data
[2] https://patchwork.ozlabs.org/patch/983173/
[3]
https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000069.html

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
