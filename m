From: Helge Deller <deller@gmx.de>
Subject: Re: Have my PA8800 back online... (serial port missing on v4.14)
Date: Tue, 12 Dec 2017 21:11:55 +0100
Message-ID: <43eb21b5-75d9-1142-1307-c2e2d218b362@gmx.de>
References: <20171208190644.GA22228@ls3530.fritz.box>
 <1512980798.25007.581.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1512980798.25007.581.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-parisc-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frank Scheiner <frank.scheiner@web.de>, linux-parisc@vger.kernel.org, John David Anglin <dave.anglin@bell.net>, linux-serial@vger.kernel.org
Cc: debian-hppa@lists.debian.org
List-Id: linux-serial@vger.kernel.org

On 11.12.2017 09:26, Andy Shevchenko wrote:
> On Fri, 2017-12-08 at 20:06 +0100, Helge Deller wrote:
>>>> Anyway, the *only* problem we have right now is, that the Linux
>>>> kernel 4.14 doesn't detect all serial ports which were detected in
>>>> earlier kernels.
> 
>>>> Thus the kernel will talk to the non-existant serial port at
>>>> 0xfffffffff4050010 instead of 0xfffffffff4050000.
> 
> Wait, from this sentence you actually confirm that patch removes *non-
> existant* ports.
> 
> Can you elaborate what you imply here?

The PCI card is a HP "Diva" card, which is basically a server 
remote management board (like HP iLO). 

With "non-existant serial port" I was referring to those few ports
on the Diva card with which one can communicate directly via a proprietary
protocol with the management card.

In older kernels (before your patch) those ports showed up as serial
ports (although they were of no use for the Linux serial driver).
With v4.14 those ports don't show up as ttyS device any longer.  
 
>>>> 4.13:
>>>> [   28.882849] Serial: 8250/16550 driver, 4 ports, IRQ sharing
>>>> enabled
>>>> [   28.898720] 0000:e0:01.0: ttyS0 at MMIO 0xfffffffff4051000 (irq
>>>> = 73, base_baud = 115200) is a 16450
>>>> [   28.934669] 0000:e0:01.1: ttyS1 at MMIO 0xfffffffff4050000 (irq
>>>> = 73, base_baud = 115200) is a 16550A
>>>> [   28.963031] 0000:e0:01.1: ttyS2 at MMIO 0xfffffffff4050010 (irq
>>>> = 73, base_baud = 115200) is a 16550A
>>>> [   28.984946] 0000:e0:01.1: ttyS3 at MMIO 0xfffffffff4050038 (irq
>>>> = 73, base_baud = 115200) is a 16550A
> 
> From here it looks like multi-function PCI device with two functions
> with 1 + 3 serial ports each.
> 
>>>> ...but for v4.14.x only the following serial ports are detected:
>>>> [   28.671984] Serial: 8250/16550 driver, 4 ports, IRQ sharing
>>>> enabled
>>>> [   28.708902] 0000:e0:01.1: ttyS0 at MMIO 0xfffffffff4050000 (irq
>>>> = 73, base_baud = 115200) is a 16550A
>>>> [   28.731145] 0000:e0:01.1: ttyS1 at MMIO 0xfffffffff4050010 (irq
>>>> = 73, base_baud = 115200) is a 16550A
> 
> I'm quite curious how ttyS0 and ttyS3 in previous run (old kernel)
> appear.
> 
>>>>
>>>>
>>>> Maybe reverting this commit brings back the old behavior:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>> /commit/?id=7d8905d064058f4b65057e0101588f362f288bc0
>>>
>>> I'm unsure about this commit, it speaks more of avoiding duplicate
>>> messages
>>> for device enabling.
> 
> No, it's about trying IRQs twice, though it might be not fully clear
> from commit message: the example there shows that IRQs are probed twice
> and on some platforms it may be a problem.
> 
>>
>> Reverting this commit:
>>
>> commit 7d8905d064058f4b65057e0101588f362f288bc0
>> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Date:   Mon Jul 24 20:28:32 2017 +0300
>>
>>     serial: 8250_pci: Enable device after we check black list
>>
>> indeed fixes the problem.
>>
>> After reverting, the serial port from the Diva card shows up as ttyS0
>> (as before).
> 
>> With that patch applied, the serial port from the Diva card gets
>> ignored and the previous ttyS1 port becomes ttyS0 which then breaks
>> booting the parisc machine because the kernel expects the serial port
>> on
>> ttyS1.
> 
>> I'm not sure what the best way forward is.
>> Fact is, that the patch above changes the behaviour and serial ports
>> which were existant before suddenly vanish with kernel 4.14.
> 
> As stated in the commit message there "We can do this since PCI
> specification requires class, device and vendor ID registers to be
> always present in the configuration space."

That's OK.

> So, my understanding that the patch reveals the issue with these ports.

Your patch indirectly changes the behavior.

You check with serial_pci_is_class_communication(dev) if this serial device
is of class SERIAL or MODEM.
If it isn't you exit pciserial_init_one() and don't register the device.

Before your patch this check was inside the function serial_pci_guess_board()
and if (ent->driver_data != pbn_default) the pci serial port got registered 
and initialized *even* if it's *not* of class SERIAL or MODEM.

> (Of course, I agree this is regression and needs to be fixed ASAP)

I don't know if it's easy to fix without reverting your patch.
On the other side, your patch is correct in the sense that it avoids
registering serial ports which shouldn't be registered.
It's just that it now behaves differently and that it breaks booting
Linux on some parisc machines.
 
>> This following patch does work, and adds back the Diva serial port on
>> parisc.
> 
>> Not sure if it's acceptable though.
> 
> For me it looks like the best quick solution right now.
> 
> The proper one sounds like a specific initialization routine for these
> ports.
> 
> Send it as a formal patch and you may add
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the offer to accept this patch, but maybe we are able
to come up with another patch which simply hides those unsupported
devices (serial port and ATI graphics card device on the Diva card).
I posted a proposed patch here:
http://www.spinics.net/lists/linux-parisc/msg08187.html

But I wonder if we are the only platform which notice this different
behavior now. I assume others will notice it soon too.

> P.S. Sorry, we have no parisc hardware around to test.

No problem.

Thanks!
Helge
 
>>
>> Helge
>>
>> diff --git a/drivers/tty/serial/8250/8250_pci.c
>> b/drivers/tty/serial/8250/8250_pci.c
>> index 0c101a7470b0..61319e968e8c 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -3393,6 +3393,10 @@ static int
>> serial_pci_is_class_communication(struct pci_dev *dev)
>>  	 * (Should we try to make guesses for multiport serial
>> devices
>>  	 * later?)
>>  	 */
>> +	if (IS_ENABLED(CONFIG_PARISC) &&
>> +	    (dev->class >> 8) == PCI_CLASS_COMMUNICATION_OTHER)
>> +		return 0;
>> +
>>  	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
>>  	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
>>  	    (dev->class & 0xff) > 6)
> 

