From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Thu, 5 Jan 2017 06:25:46 +0100
Message-ID: <20170105052546.GA10503@lst.de>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com> <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com> <daaa7a86-9987-911b-24ee-21d5107f0d7a@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <daaa7a86-9987-911b-24ee-21d5107f0d7a@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 04, 2017 at 11:46:58PM +0100, Jan Kiszka wrote:
> > I NAKed already third patch related to PCI managed resources (couple
> > of those regarding to pci_irq_* API)/
> > 
> 
> Ah, there are resources that are managed without being allocated
> explicitly that way. Hmm, not very intuitive. Are MSI / MSI-X vectors
> the only such cases?

MSI/MSI-X resources are not managed that way and an explicit call to
pci_free_irq_vectors is required from the API standpoint.  It might not
actually free memory in many cases, but it still is a symmetric API.
