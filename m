From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] serial: 8250_lpss: Unconditionally set PCI master for
 Quark
Date: Mon, 9 Jan 2017 18:00:16 +0100
Message-ID: <99156264-8525-f5b6-9a67-735bcdd6f399@siemens.com>
References: <1d0224cc-10ee-df69-b383-c687e08ed44d@siemens.com>
 <CAHp75VdVagWk1P2X7Tp3mgGGeJoU_dbxyTiyZ-Hz=VxjF2VX3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdVagWk1P2X7Tp3mgGGeJoU_dbxyTiyZ-Hz=VxjF2VX3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 2017-01-05 22:54, Andy Shevchenko wrote:
> On Wed, Jan 4, 2017 at 10:48 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> MSI needs it as well.
>>
>> Should have no practical impact, though, as DMA is always available on
>> the Quark. But given the few users of pci_alloc_irq_vectors so far, this
>> incorrect pattern may spread otherwise.
>>
> 
> One question below.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> Fixes: 3f3a46951e02 ("serial: 8250_lpss: set PCI master only for private DMA")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/tty/serial/8250/8250_lpss.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
>> index f09f68a..9315197 100644
>> --- a/drivers/tty/serial/8250/8250_lpss.c
>> +++ b/drivers/tty/serial/8250/8250_lpss.c
>> @@ -183,7 +183,6 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>>         if (ret)
>>                 return;
>>
>> -       pci_set_master(pdev);
>>         pci_try_set_mwi(pdev);
> 
> Does it make sense to move MWI there as well?

TBH, I didn't come across the need to enable this bit so far,
specifically not for doing MSI transactions. Is MWI used at all for MSI
(spec says that MSI is "using a PCI DWORD memory write transaction")?
That question is better answered by someone more familiar with such PCI
details.

Jan

> 
>>
>>         /* Special DMA address for UART */
>> @@ -216,6 +215,8 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
>>         struct pci_dev *pdev = to_pci_dev(port->dev);
>>         int ret;
>>
>> +       pci_set_master(pdev);
>> +
>>         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>>         if (ret < 0)
>>                 return ret;
>> --
>> 2.1.4
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
