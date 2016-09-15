From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: RE: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 15 Sep 2016 12:05:51 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F871F72@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5869118.UilSPY9Sai@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F871B01@lhreml507-mbx>
 <8360154.kzsE8V8pTW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8360154.kzsE8V8pTW@wuerfel>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "minyard@acm.org" <minyard@acm.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, John Garry <john.garry@huawei.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuanzhichang <yuanzhichang@hisilicon.com>, Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "liviu.dudau@arm.com" <liviu.dudau@arm.com>, "kantyzc@163.com" <kantyzc@163.com>, "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-ar>
List-Id: linux-serial@vger.kernel.org

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 15 September 2016 09:22
> To: Gabriele Paoloni
> Cc: linux-arm-kernel@lists.infradead.org; Yuanzhichang;
> devicetree@vger.kernel.org; lorenzo.pieralisi@arm.com; minyard@acm.org;
> gregkh@linuxfoundation.org; benh@kernel.crashing.org; John Garry;
> will.deacon@arm.com; linux-kernel@vger.kernel.org; xuwei (O); Linuxarm;
> linux-serial@vger.kernel.org; linux-pci@vger.kernel.org;
> zourongrong@gmail.com; liviu.dudau@arm.com; kantyzc@163.com;
> zhichang.yuan02@gmail.com
> Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Thursday, September 15, 2016 8:02:27 AM CEST Gabriele Paoloni wrote:
> >
> > From <<3.1.1. Open Firmware Properties for Bus Nodes>> in
> > http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
> >
> > I quote:
> > "There shall be an entry in the "ranges" property for each
> > of the Memory and/or I/O spaces if that address space is
> > mapped through the bridge."
> >
> > It seems to me that it is ok to have 1:1 address mapping and that
> > therefore of_translate_address() should fail if "ranges" is not
> > present.
> 
> The key here is the definition of "mapped through the bridge".
> I can only understand this as "directly mapped", i.e. an I/O
> port of the child bus corresponds directly to a memory address
> on the parent bus, but this is not the case here.
> 
> The problem with adding the mapping here is that it looks
> like it should be valid to create a page table entry for
> the address returned from the translation and access it through
> a pointer dereference, but that is clearly not possible.

I understand that somehow we are abusing of the ranges property
here however the point is that with the current implementation ranges
is needed because otherwise the ipmi driver probe will fail here:

of_ipmi_probe -> of_address_to_resource -> __of_address_to_resource
-> of_translate_address -> __of_translate_address

Now we had a bit of discussion internally and to avoid
having ranges we came up with two possible solutions:

1) Using bit 3 of phys.hi cell in 2.2.1 of
http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
This would mean reworking of_bus_isa_get_flags in 
http://lxr.free-electrons.com/source/drivers/of/address.c#L398
and setting a new flag to be checked in __of_address_to_resource

2) Adding a property in the bindings of each device that is
a child of our LPC bus and modify __of_address_to_resource
to check if the property is in the DT and eventually bypass
of_translate_address

However in both 1) and 2) there are some issues:
in 1) we are not complying with the isa binding doc (we use
a bit that should be zero); in 2) we need to modify the
bindings documentation of the devices that are connected
to our LPC controller (therefore modifying other devices
bindings to fit our special case).

I think that maybe having the 1:1 range mapping doesn't
reflect well the reality but it is the less painful
solution...

What's your view?
 
Many Thanks

Gab

> 
> > This is also explained quite well in
> > http://lxr.free-electrons.com/source/drivers/of/address.c#L490
> >
> > what do you think?
> 
> This is a separate issue, and only relevant for Apple Macintosh
> machines as well as the PA-Semi sdc.
> 
> 	Arnd
