From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Thu, 5 Jan 2017 00:52:05 +0200
Message-ID: <CAHp75Ve=rZchgOtKt69V-BTPpT29SY9rFA2cqZUu=HnrhTq_yg@mail.gmail.com>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
 <CAHp75VdyJXGUp0YOX_15wM0Fv+arnQNEcLN6+OMtXGBgG-6jrA@mail.gmail.com> <daaa7a86-9987-911b-24ee-21d5107f0d7a@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <daaa7a86-9987-911b-24ee-21d5107f0d7a@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 5, 2017 at 12:46 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-01-04 23:19, Andy Shevchenko wrote:
>> On Wed, Jan 4, 2017 at 9:36 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> No one seems to do this magically in the background, so we have to do
>>> the job in the exit handler that corresponds to the board setup handler.
>>>
>>> Fixes: 60a9244a5d14 ("serial: 8250_lpss: enable MSI for Intel Quark")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> NAK, check the PCI devres code, please.
>>
>> Christoph, can you amend documentation to make this clear?
>>
>> I NAKed already third patch related to PCI managed resources (couple
>> of those regarding to pci_irq_* API)/
>>
>
> Ah, there are resources that are managed without being allocated
> explicitly that way. Hmm, not very intuitive. Are MSI / MSI-X vectors
> the only such cases?

pci_request_regions(), etc.
Almost all stuff which is usually used in ->probe() of casual PCI driver.


-- 
With Best Regards,
Andy Shevchenko
