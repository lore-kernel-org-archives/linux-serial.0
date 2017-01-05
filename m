From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Thu, 5 Jan 2017 08:03:13 +0100
Message-ID: <bec9b233-5069-c54a-4c11-9e6c33e7ef9a@siemens.com>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
 <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
 <daaa7a86-9987-911b-24ee-21d5107f0d7a@siemens.com>
 <20170105052546.GA10503@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105052546.GA10503@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-01-05 06:25, Christoph Hellwig wrote:
> On Wed, Jan 04, 2017 at 11:46:58PM +0100, Jan Kiszka wrote:
>>> I NAKed already third patch related to PCI managed resources (couple
>>> of those regarding to pci_irq_* API)/
>>>
>>
>> Ah, there are resources that are managed without being allocated
>> explicitly that way. Hmm, not very intuitive. Are MSI / MSI-X vectors
>> the only such cases?
> 
> MSI/MSI-X resources are not managed that way and an explicit call to
> pci_free_irq_vectors is required from the API standpoint.  It might not
> actually free memory in many cases, but it still is a symmetric API.
> 

Andy is referring to the following:
- pcim_enable_device registers pci_devres with the devres subsystem
- on device release, devres_release_all is invoked, and that calls
  pcim_release
- the latter will invoke pci_disable_msi and pci_disable_msix if any of
  them is enabled

The user will still call the same pci_msi_enable, pci_alloc_irq_vectors
etc., but they are now "magically" managed with pcim_enable_device being
used. Same for pci_request_region.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
