From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Fri, 21 Oct 2016 10:55:40 -0500
Message-ID: <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020201051.GA29324@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

It didn't seem to make a difference as far as output.
Did I miss a config option? or something else?

[    0.000000] Linux version 3.6.0 (root@r1i2n0) (gcc version 4.3.4 
[gcc-4_3-branch revision 152973] (SUSE Linux) ) #3 SMP Mon Oct 17 
20:43:34 EDT 2016
[    0.000000] Command line: 
root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 
resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 
crashkernel=256M-:128M loglevel=8 pnp.debug=1
...
[    2.076084] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    2.097001] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    2.097844] serial 00:04: unable to assign resources
[    2.098303] serial: probe of 00:04 failed with error -16


On 10/20/2016 03:10 PM, Sean Young wrote:
> On Wed, Oct 19, 2016 at 05:13:41PM -0500, Nathan Zimmer wrote:
>> On 10/19/2016 04:07 AM, Sean Young wrote:
>>> So with 3.6.0:
>>>
>>>> [    2.079980] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
>>>> [    2.100887] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
>>>> [    2.101715] serial 00:04: unable to assign resources
>>>> [    2.102174] serial: probe of 00:04 failed with error -16
>>> The pnp probe fails for some reason. I don't understand why.
>>>
>>> With 3.7.0:
>>>
>>>> [    2.062700] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
>>>> [    2.063250] serial 00:04: [io  0x02f8-0x02ff]
>>>> [    2.063875] serial 00:04: [irq 12]
>>>> [    2.064345] serial 00:04: [dma 18446744073709551615 disabled]
>>>> [    2.065540] serial 00:04: activated
>>>> [    2.086442] 00:04: ttyS1 at I/O 0x2f8 (irq = 12) is a 16550A
>>> Now the pnp probe succeeds (with broken irq from pnp).
>>>
>>> Can you please check if there is a wrong irq configured in the bios setup
>>> or if there is a bios update available? I don't know why this worked in
>>> the first place.
>> Apparently this is the latest bios available for these nodes.
>> Also in the bios setup screens I don't see anything for changing irq numbers
>> for serial console.
>> But this is a cluster so sometimes thing get hidden to keep everything
>> uniform as possible.
>>
>> If you want to point me to the pnp probe code you would be suspicious of I
>> can try to debug and see what is going there.
> That would be great, thanks. A good start would be to boot 3.6.0 with
> "loglevel=7 pnp.debug=1" and hopefully that will show why the probe
> used to fail.
>
> Also, does the issue still exist with a more contemporary kernel?
>
>
> Sean
