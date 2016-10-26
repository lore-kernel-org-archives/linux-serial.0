From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Wed, 26 Oct 2016 13:16:16 -0500
Message-ID: <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
References: <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025204139.GA22268@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org



On 10/25/2016 03:41 PM, Sean Young wrote:
> On Mon, Oct 24, 2016 at 04:49:25PM -0500, Nathan Zimmer wrote:
>> [    0.974874] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
>> [    0.975038] pnp 00:04: parse resource options
>> [    0.975048] pnp 00:04:   dependent set 0 (acceptable) io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
>> [    0.975056] pnp 00:04:   dependent set 0 (acceptable) irq 3 4 5 6 7 10 11 12 flags 0x1
>> [    0.975060] pnp 00:04:   dependent set 0 (acceptable) dma <none> (bitmask 0x0) flags 0x0
> So here the bios claims that the serial port can use any of 3 to 12 irqs.
>
>> [    1.543636] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> Why is this kernel compiled with irq sharing disabled?
Because I first noticed the error on a sles kernel and that is how they 
have it set.
The error also occurs with sharing on.

<snip from a 4.8 dmesg with irq sharing enabled>
[    4.662336] Serial: 8250/16550 driver, 8 ports, IRQ sharing enabled
[    4.663316] serial 00:03: pnp_assign_resources, try dependent set 0
[    4.664249] serial 00:03: [io  0x02f8-0x02ff]
[    4.664913] serial 00:03:   device 0000:00:16.1 using irq 5
[    4.688879] serial 00:03:   device 0000:00:1f.3 using irq 10
[    4.712265] serial 00:03:   device 0000:00:16.0 using irq 11
[    4.735265] serial 00:03: [irq 12]
[    4.757538] serial 00:03:   dma 0 disabled
[    4.780153] serial 00:03: [dma 18446744073709551615 disabled]
[    4.802826] serial 00:03: pnp_assign_resources succeeded: current 
resources:
[    4.825758] serial 00:03: [io  0x02f8-0x02ff flags 0x40000101]
[    4.848625] serial 00:03: [irq 12 flags 0x40000401]
[    4.871224] serial 00:03: [dma 18446744073709551615 flags 0x50000800]
[    4.893988] serial 00:03: pnp_start_dev: current resources:
[    4.916634] serial 00:03: [io  0x02f8-0x02ff flags 0x40000101]
[    4.939280] serial 00:03: [irq 12 flags 0x40000401]
[    4.961646] serial 00:03: [dma 18446744073709551615 flags 0x50000800]
[    4.984180] serial 00:03: set resources
[    5.006654] serial 00:03: encode 3 resources
[    5.028545] serial 00:03:   encode io 0x2f8-0x2ff decode 0x1
[    5.050486] serial 00:03:   encode irq 12 edge high exclusive (2-byte 
descriptor)
[    5.072593] serial 00:03:   encode dma (disabled)
[    5.094644] serial 00:03: activated
[    5.136000] 00:03: ttyS1 at I/O 0x2f8 (irq = 12, base_baud = 115200) 
is a 16550A


>> [    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> The isa probe driver find the serial port.
>
>> [    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
>> [    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)
> But then decides that the port is already in use (the existing serial driver).
>> [    1.568366] serial 00:04: pnp_assign_resources failed (-16)
>> [    1.569188] serial 00:04: unable to assign resources
>> [    1.569924] serial: probe of 00:04 failed with error -16
> Please try and boot 3.7.0 with "8250.share_irqs=1", maybe it will pick
> irq 3 and it will be happy again, but that is just a guess.
>
> I think I have not fully understood what the failure is. Does the serial
> port not work or does the boot hang? What are the symptoms?
With console=ttyS1 the boot will "hang", sometimes it makes it all the 
way through but may take 30 minutes, instead of the 2-4 minutes this box

> We might be able to fix the problem with a pnp quirk but 3.7 is has not had
> any releases for a long time. We will need a reproduction on a concurrent
> kernel so a patch can be written for that.
Yes it still happens with 4.8+
I had only started dwelling on 3.6/3.7 since that is where it first 
appears and don't have any attachment to those.

>
> Sean
