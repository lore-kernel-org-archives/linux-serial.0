From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Sun, 08 Jan 2017 18:04:52 +0200
Message-ID: <1483891492.26691.24.camel@linux.intel.com>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
         <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
         <20170108102459.GA3644@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170108102459.GA3644@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Tejun Heo <tj@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, 2017-01-08 at 02:24 -0800, Christoph Hellwig wrote:
> On Thu, Jan 05, 2017 at 12:19:56AM +0200, Andy Shevchenko wrote:
> > NAK, check the PCI devres code, please.

+Cc: Tejun, Bjorn.

> 
> Releasing something through devres that wasn't allocated using a
> devm_* or
> pcim_* function isn't expected, and we should fix that instead.
> pci_free_irq_vectors is _currently_ implemented by calling
> pci_disable_msi and pci_disable_msix, but there is no guarantee for
> that
> in the API.

> Your code works by accident, not by design.  If you want the resources
> to be auto-released you need to add a proper pcim_alloc_irq_vectors
> API.

Though idea sounds sane I disagree this is accidental. The PCI managed
introduction includes among other this one:

+  pcim_enable_device() : after success, all PCI ops become managed

As per commit 9ac7849e35f7 ("devres: device resource management").

Thus, I suppose a new API should follow existing design, or provide a
sane fix. I briefly checked MSI/-X usage and since I'm not so familiar
with the PCI core code, I wouldn't be brave to break it.

Currently I suspect pci_free_irq_vectors() is not friendly with
pcim_release().

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
