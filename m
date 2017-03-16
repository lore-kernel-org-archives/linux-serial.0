From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
Date: Thu, 16 Mar 2017 11:13:01 +0100
Message-ID: <CAK8P3a2QZ_j9RQ0U=4MoAAcRcZyu0L5AiYM22QZkiRxh7Ca-iA@mail.gmail.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan> <58C9F6C6.4090700@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58C9F6C6.4090700@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Rafael Wysocki <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxarm@huawei.com, devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>, linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>, liviu.dudau@arm.com, Zou Rongrong <zourongrong@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 16, 2017 at 3:21 AM, zhichang.yuan
<yuanzhichang@hisilicon.com> wrote:
> Hi, Rafael,
>
> Thanks for your review!
>
> On 2017/3/14 5:24, Rafael J. Wysocki wrote:
>> On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
>>> In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on Asus
>>> T100TA), the '_DEP' was supported to solve the dependency of Asus battery. But
>>> this patch is specific to Asus battery device.
>>> In the real world, there are other devices which need the dependency to play the
>>> role on the enumeration order. For example, all the Hip06 LPC
>>> periperals(IPMI-BT, uart, etc) must be scanned after the LPC host driver
>>> finished the probing. So, it makes sense to add a checking whether the ACPI
>>> device meet all the dependencies during its enumeration slot, if not, the
>>> enumeration will be delayed till all dependency master finish their work.
>>>
>>> This patch adds the dependency checking in ACPI enumeration, also the
>>> corresponding handling to retrigger the Hip06 LPC peripherals' scanning.
>>
>> AFAICS, _DEP is generally abused in the wild and cannot be made generic.  Sorry.
>>
>
> From the ACPI specification, _DEP is for operation region accesses.
> You are right...
>
> How about we add a ACPI handler for our LPC bus?? Just like amba.
> In this way, we also can solve the issue about LPC enumeration order.

As far as I can tell, PCI and LPC have exactly the same requirement here,
so whatever you end up doing for one should be used for the other as well.

      Arnd
