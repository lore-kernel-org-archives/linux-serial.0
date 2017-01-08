From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Sun, 8 Jan 2017 02:24:59 -0800
Message-ID: <20170108102459.GA3644@infradead.org>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
 <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 05, 2017 at 12:19:56AM +0200, Andy Shevchenko wrote:
> NAK, check the PCI devres code, please.

Releasing something through devres that wasn't allocated using a devm_* or
pcim_* function isn't expected, and we should fix that instead.
pci_free_irq_vectors is _currently_ implemented by calling
pci_disable_msi and pci_disable_msix, but there is no guarantee for that
in the API.

Your code works by accident, not by design.  If you want the resources
to be auto-released you need to add a proper pcim_alloc_irq_vectors
API.
