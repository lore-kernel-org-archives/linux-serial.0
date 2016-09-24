From: zhichang <zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Sat, 24 Sep 2016 16:00:37 +0800
Message-ID: <378cda2d-e8fb-af10-01ff-c555def3d639@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <9178320.n4yHmfyPA3@wuerfel> <57E40665.8080005@gmail.com>
 <1760643.vMTR5o5E9g@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1760643.vMTR5o5E9g@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "liviu.dudau-5wv7dgnIgG8@public.gmane.org" <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi, Arnd,


On 2016年09月23日 17:51, Arnd Bergmann wrote:
> On Friday, September 23, 2016 12:27:17 AM CEST zhichang.yuan wrote:
>> For this patch sketch, I have a question.
>> Do we call pci_address_to_pio in arch_of_address_to_pio to get the 
>> corresponding logical IO port
>> for LPC??
> 
> 
> No, of course not, that would be silly:
> 
> The argument to pci_address_to_pio() is a phys_addr_t, and we we don't
> have one because there is no address associated with your PIO, that
> is the entire point of your driver!
> 
ok. I think I know you points. The physical addresses of LPC are only the LPC
domain addresses, not the really CPU physical addresses. That is just why you
don't support the ranges property usage in patch V3. Consequently, It is not so
reasonable to call pci_address_to_pio() with LPC address because that function
is only suitable for cpu physical address.

But just as you said in the next email reply to Gabriele, "Any IORESOURCE_IO
address always refers to the logical I/O port range in Linux, not the physical
address that is used on a bus.", Any devices which support IO accesses should
have their own unique logical IO range to drive the corresponding hardware. It
means that the drivers should know the mapping between physical port/memory
address and logical IO depend on the device specific I/O mode. At this moment,
only PCI host bridge setup a logical IO range allocation mechanism to manipulate
this logical IO range, and this way applies cpu physical address(memory) as the
input. Now, our LPC also need subrange from this common logical IO range, but
with legacy I/O port rather than CPU memory address. Ok, it break the
precondition of pci_register_io_range/pci_pio_to_address, we should not use them
directly for LPC although the calling of pci_pio_to_address is simple and less
change on the relevant code. We had done like that in V3...

So, the key issue is how to get a logical IO subrange which is not conflicted
with others, such as pci host bridges??

I list several ideas for discussion:

1. reserve a specific logical IO subrange for LPC

I describe this in "Note 1" below. Please check it.
This way seems simple without much changes, but it is not generic.

2. setup a separate logical IO subrange allocation mechanism specific for LPC/ISA

Just as your suggestion before, add the arch_of_address_to_pio() for the devices
which operate I/O with legacy I/O port address rather than memory address in
MMIO mode. That arch_of_address_to_pio() will return non-conflict logical IO
with PCI host bridge at last. But the logical IO range is global, those
functions for LPC/ISA specific logical IO subrange allocation must be
synchronized with pci_register_io_range/pci_pio_to_address to know what logical
ranges had been populated. It is not good for the implement dispersion on same
issue.

3. setup a new underlying method to control the logical IO range management

Based on the existing resource management, add a simplified logical IO range
management support which only request the logical IO ranges according the IO
range size ( similar to IORESOURCE_SIZEALIGN mode ), no matter what type the
physical address is. Then revise the current pci_register_io_range to adopt this
new method. Of-course, LPC/ISA request the logical IO with this new method too.

This is just a proposition. It is more workload compared with other solutions.

What do you think about these? Any more ideas?


> Also, we already know the mapping because this is what the inb/outb
> workaround is looking at, so there is absolutely no reason to call it
> either.
> 
>> If we don't, it seems the LPC specific IO address will conflict with PCI 
>> host bridges' logical IO.
>>
>> Supposed our LPC populated the IO range from 0x100 to 0x3FF( this is 
>> normal for ISA similar
>> devices), after arch_of_address_to_pio(), the r->start will be set as 
>> 0x100, r->end will be set as
>> 0x3FF.  And if there is one PCI host bridge who request a IO window size 
>> over 0x400 at the same
>> time, the  corresponding r->start and r->end will be set as 0x0, 0x3FF 
>> after of_address_to_resource
>> for this host bridge.  Then the IO conflict happens.
> 
> You would still need to reserve some space in the io_range_list
> to avoid possible conflicts, which is a bit ugly with the current
> definition of pci_register_io_range, but I'm sure can be done.
> 

Note 1) Do you remember patch V2? There, I modified the pci.c like that to
reserve 0 - PCIBIOS_MIN_IO (it is 0x1000) :

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..ac2e569 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3221,7 +3221,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resourc

 #ifdef PCI_IOBASE
        struct io_range *range;
-       resource_size_t allocated_size = 0;
+       resource_size_t allocated_size = PCIBIOS_MIN_IO;

        /* check if the range hasn't been previously recorded */
        spin_lock(&io_range_lock);
@@ -3270,7 +3270,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)

 #ifdef PCI_IOBASE
        struct io_range *range;
-       resource_size_t allocated_size = 0;
+       resource_size_t allocated_size = PCIBIOS_MIN_IO;

        if (pio > IO_SPACE_LIMIT)
                return address;
@@ -3293,7 +3293,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t addres
 {
 #ifdef PCI_IOBASE
        struct io_range *res;
-       resource_size_t offset = 0;
+       resource_size_t offset = PCIBIOS_MIN_IO;
        unsigned long addr = -1;

        spin_lock(&io_range_lock);

Based on this, a exclusive logical IO subrange is for LPC now. Then we certainly
can add some special handling in __of_address_to_resource or
__of_translate_address --> of_translate_one to return the untranslated LPC/ISA
IO address. But to be honest, I think we don't need this special handling in
address.c anymore. We had known the LPC/ISA IO is 1:1 to logical IO, just think
any logical IO port among 0 - 0x1000 should call the LPC registered I/O hooks in
the new in/out().

Furthermore, we can make the reservation is not fixed as PCIBIOS_MIN_IO. If the
LPC/ISA probing is run before PCI host bridge probing, we can reserve a
non-fixed logcial IO subrange what LPC/ISA ask for.

This solution is based on an assumption that no any other devices have to
request the specific logical IO subrange for LPC/ISA. Probably this assumption
is ok on arm64, you known, there is no real IO space as X86. But anyway, this
reservation is not so generic, depended on some special handling.

Does this idea match your comments??


> One way I can think of would be to change pci_register_io_range()
> to just return the logical port number directly (it already
> knows it!), and pass an invalid physical address (e.g. 
> #define ISA_WORKAROUND_IO_PORT_WINDOW -0x10000) into it for
> invalid translations.
> 

I am not so clear know your idea here.  Do you want to select an unpopulated CPU
address as the parent address in range property?? or anything else???


> Another alternative that just occurred to me would be to move
> the pci_address_to_pio() call from __of_address_to_resource()
> into of_bus_pci_translate() and then do the special handling
> for the ISA/LPC bus in of_bus_isa_translate().

As for this idea, do you mean that of_translate_address will directly return the
final logical IO start address?? It seems to extend the definition of
of_translate_address.


Thanks,
Zhichang

> 
> 	Arnd
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
