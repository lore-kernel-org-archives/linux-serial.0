From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/5] serial: 8250_pci: use DEFINE_PCI_DEVICE_TABLE macro
Date: Wed, 27 Nov 2013 21:40:13 -0800
Message-ID: <1385617213.12210.5.camel@joe-AO722>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
	 <20131128040750.GA29917@kroah.com>
	 <006001ceebfa$c85a1020$590e3060$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <006001ceebfa$c85a1020$590e3060$%han@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-kernel@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Andy Whitcroft' <apw@canonical.com>, linux-serial@vger.kernel.org, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 2013-11-28 at 14:29 +0900, Jingoo Han wrote:
> On Thursday, November 28, 2013 1:08 PM, Greg Kroah-Hartman wrote:
> > On Thu, Nov 28, 2013 at 10:55:35AM +0900, Jingoo Han wrote:
> > > This macro is used to create a struct pci_device_id array.
> > 
> > Yeah, and it's a horrid macro that deserves to be removed, please don't
> > use it in more places.
> > 
> > Actually, if you could just remove it, that would be best, sorry, I'm
> > not going to take these patches.
> 
> (+cc Joe Perches, Andrew Morton, Andy Whitcroft)
> 
> Hi Joe Perches,
> 
> Would you fix checkpatch.pl about DEFINE_PCI_DEVICE_TABLE?
> Currently, checkpatch.pl guides to use DEFINE_PCI_DEVICE_TABLE
> as below.
> 
>   WARNING: Use DEFINE_PCI_DEVICE_TABLE for struct pci_device_id
>   #331: FILE: drivers/usb/host/ehci-pci.c:331:
>   +static const struct pci_device_id pci_ids [] = { {
> 
> However, Greg Kroah-Hartman mentioned that DEFINE_PCI_DEVICE_TABLE
> shouldn't be used anymore.
> 
> So, would you change checkpatch.pl in order to guide to use
> struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE?
> 
> For example,
>   WARNING: Use struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE

The documentation doesn't agree with Greg.

Documentation/PCI/pci.txt:

The ID table is an array of struct pci_device_id entries ending with an
all-zero entry; use of the macro DEFINE_PCI_DEVICE_TABLE is the preferred
method of declaring the table.

Neither does the kernel tree:

$ git grep -w DEFINE_PCI_DEVICE_TABLE | wc -l
410

$ git grep -E "\bstruct\s+pci_device_id\s+\w+\s*\[\s*\]\s*=" | wc -l
376

Most of the 376 should be const and are not.

$ git grep -E "\bconst\s+struct\s+pci_device_id\s+\w+\s*\[\s*\]\s*=" | wc -l
155

Everything that uses DEFINE_PCI_DEVICE_TABLE is const.

$ git grep -A1 -E "define\s+DEFINE_PCI_DEVICE_TABLE"
include/linux/pci.h:#define DEFINE_PCI_DEVICE_TABLE(_table) \
include/linux/pci.h-    const struct pci_device_id _table[]
