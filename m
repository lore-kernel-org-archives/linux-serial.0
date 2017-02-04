From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V6 2/5] PCI: Adapt pci_register_io_range() for indirect-IO
 and PCI I/O translation
Date: Sat, 4 Feb 2017 12:59:57 +0000
Message-ID: <af413460-35bb-30ee-05f2-4fc4293b0f31@huawei.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-3-git-send-email-yuanzhichang@hisilicon.com>
 <20170131001551.GC20550@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170131001551.GC20550@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>, "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: mark.rutland@arm.com, benh@kernel.crashing.org, gabriele.paoloni@huawei.com, rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com, linuxarm@huawei.com, frowand.list@gmail.com, lorenzo.pieralisi@arm.com, arnd@arndb.de, xuwei5@hisilicon.com, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org, liviu.dudau@arm.com, zhichang.yuan02@gmail.com, zourongrong@gmail.com, robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olof@lixom.net, brian.starkey@arm.com
List-Id: linux-serial@vger.kernel.org

On 31/01/2017 00:15, Bjorn Helgaas wrote:
> On Tue, Jan 24, 2017 at 03:05:22PM +0800, zhichang.yuan wrote:
>> After indirect-IO is introduced, system must can assigned indirect-IO devices
>> with logical I/O ranges which are different from those for PCI I/O devices.
>> Otherwise, I/O accessors can't identify whether the I/O port is for memory
>> mapped I/O or indirect-IO.
>> As current helper, pci_register_io_range(), is used for PCI I/O ranges
>> registration and translation, indirect-IO devices should also apply these
>> helpers to manage the I/O ranges. It will be easy to ensure the assigned
>> logical I/O ranges unique.
>> But for indirect-IO devices, there is no cpu address. The current
>> pci_register_io_range() can not work for this case.
>>
>> This patch makes some changes on the pci_register_io_range() to support the
>> I/O range registration with device's fwnode also. After this, the indirect-IO
>> devices can register the device-local I/O range to system logical I/O and
>> easily perform the translation between device-local I/O range and sytem
>> logical I/O range.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I had a couple trivial comments, but you can include my:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci parts
>
> in your next revision.  I don't know who you have in mind to merge this;
> it doesn't really touch much of PCI.  But let me know if you need anything
> else from me.

Thanks Bjorn.

The current status is that we plan to send a new patchset early next 
week with the suggested change to combine PCI+extio IO framework. The IO 
space range stuff (pci_register_io_range() et al) will move from 
drivers/pci/pci.c to new lib/libio.c (renamed from extio.c).

We still need someone to merge (we are praying to make 4.11), and also 
Arnd to kindly check the update from his sketch and also more reviews of 
the ACPI part of what was extio.c 
(http://www.spinics.net/lists/devicetree/msg160611.html, 5/5)

Much appreciated,
John

>
>> ---
>>  drivers/acpi/pci_root.c | 12 +++++-------
>>  drivers/of/address.c    |  8 ++------
>>  drivers/pci/pci.c       | 44 ++++++++++++++++++++++++++++++++++++++++----
>>  include/linux/pci.h     |  7 +++++--
>>  4 files changed, 52 insertions(+), 19 deletions(-)
>>
