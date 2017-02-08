From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 4/7] serial: exar: Move Commtech adapters to 8250_exar as
 well
Date: Wed, 8 Feb 2017 07:32:16 +0100
Message-ID: <bda321fe-cddf-7b3a-89c6-150a733f07cb@siemens.com>
References: <cover.1486483803.git.jan.kiszka@siemens.com>
 <ccf49a203b0aa1861cbb8a6cfafdc22ba5ea120e.1486483804.git.jan.kiszka@siemens.com>
 <CAHp75Vf0vx5YXczvnUkkyp8=C397pYMvsf32sRAx0jU+Cgxb6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf0vx5YXczvnUkkyp8=C397pYMvsf32sRAx0jU+Cgxb6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On 2017-02-08 00:23, Andy Shevchenko wrote:
> On Tue, Feb 7, 2017 at 6:10 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Those are exar-based, too.
> 
> Exar-based
> 
>> With the required refactoring of the code to fit into 8250_exar, we
>> automatically fix the same issue pci_xr17v35x_setup had before: 8XMODE,
>> FCTL, TXTRG and RXTRG were always only set for port 0. Now they are
>> initialized for the correct target port by using port.membase.
> 
> My comments below.
> 
>> --- a/drivers/tty/serial/8250/8250_exar.c
>> +++ b/drivers/tty/serial/8250/8250_exar.c
>> @@ -24,11 +24,15 @@
>>
>>  #include "8250.h"
>>
>> -#define PCI_DEVICE_ID_COMMTECH_4224PCIE        0x0020
>> -#define PCI_DEVICE_ID_COMMTECH_4228PCIE        0x0021
>> -#define PCI_DEVICE_ID_COMMTECH_4222PCIE        0x0022
>> -#define PCI_DEVICE_ID_EXAR_XR17V4358   0x4358
>> -#define PCI_DEVICE_ID_EXAR_XR17V8358   0x8358
> 
>> +#define PCI_DEVICE_ID_COMMTECH_4222PCI335      0x0004
>> +#define PCI_DEVICE_ID_COMMTECH_4224PCI335      0x0002
> 
> I think you assumed ID ordered list?

Yeah, will reorder at this chance.

> 
>> +#define PCI_DEVICE_ID_COMMTECH_2324PCI335      0x000a
>> +#define PCI_DEVICE_ID_COMMTECH_2328PCI335      0x000b
>> +#define PCI_DEVICE_ID_COMMTECH_4224PCIE                0x0020
>> +#define PCI_DEVICE_ID_COMMTECH_4228PCIE                0x0021
>> +#define PCI_DEVICE_ID_COMMTECH_4222PCIE                0x0022
>> +#define PCI_DEVICE_ID_EXAR_XR17V4358           0x4358
>> +#define PCI_DEVICE_ID_EXAR_XR17V8358           0x8358
> 
>> @@ -292,6 +345,21 @@ static int __maybe_unused exar_resume(struct device *dev)
> 
>> +static const struct exar8250_board pbn_fastcom335_2 = {
>> +       .num_ports      = 2,
>> +       .setup          = pci_fastcom335_setup,
>> +};
>> +
>> +static const struct exar8250_board pbn_fastcom335_4 = {
>> +       .num_ports      = 4,
>> +       .setup          = pci_fastcom335_setup,
>> +};
>> +
>> +static const struct exar8250_board pbn_fastcom335_8 = {
>> +       .num_ports      = 8,
>> +       .setup          = pci_fastcom335_setup,
>> +};
> 
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -1622,54 +1622,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
>>  #define UART_EXAR_MPIOINV_15_8 0x98    /* MPIOINV[15:8] */
>>  #define UART_EXAR_MPIOSEL_15_8 0x99    /* MPIOSEL[15:8] */
>>  #define UART_EXAR_MPIOOD_15_8  0x9a    /* MPIOOD[15:8] */
> 
> And why not to remove above constants?

Forgotten, will remove.

> 
>> -       /*
>> -        * Commtech, Inc. Fastcom adapters
>> -        */
>> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCI335,
>> -               PCI_ANY_ID, PCI_ANY_ID,
>> -               0,
>> -               0, pbn_b0_2_1152000_200 },
>> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCI335,
>> -               PCI_ANY_ID, PCI_ANY_ID,
>> -               0,
>> -               0, pbn_b0_4_1152000_200 },
>> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_2324PCI335,
>> -               PCI_ANY_ID, PCI_ANY_ID,
>> -               0,
>> -               0, pbn_b0_4_1152000_200 },
>> -       {       PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_2328PCI335,
>> -               PCI_ANY_ID, PCI_ANY_ID,
>> -               0,
>> -               0, pbn_b0_8_1152000_200 },
>> -
> 
> Check black list as well. I suppose now there is a bug and it's left
> even after this patch.
> 

Yeah, it lacks PCI_VENDOR_ID_COMMTECH... will send an update.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
