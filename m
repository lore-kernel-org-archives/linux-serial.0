From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Wed, 4 Jan 2017 23:46:58 +0100
Message-ID: <daaa7a86-9987-911b-24ee-21d5107f0d7a@siemens.com>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
 <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-01-04 23:19, Andy Shevchenko wrote:
> On Wed, Jan 4, 2017 at 9:36 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> No one seems to do this magically in the background, so we have to do
>> the job in the exit handler that corresponds to the board setup handler.
>>
>> Fixes: 60a9244a5d14 ("serial: 8250_lpss: enable MSI for Intel Quark")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> NAK, check the PCI devres code, please.
> 
> Christoph, can you amend documentation to make this clear?
> 
> I NAKed already third patch related to PCI managed resources (couple
> of those regarding to pci_irq_* API)/
> 

Ah, there are resources that are managed without being allocated
explicitly that way. Hmm, not very intuitive. Are MSI / MSI-X vectors
the only such cases?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
