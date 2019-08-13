From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial
 boards
Date: Tue, 13 Aug 2019 12:36:40 +0800
Message-ID: <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
 <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Morris Ku <morris_ku@sunix.com>, Debbie Liu <debbie_liu@sunix.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

at 21:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Add support to Sunix serial boards with up to 16 ports.
>>
>> Sunix board need its own setup callback instead of using Timedia's, to
>> properly support more than 4 ports.
>
> Can you, please, split out the Sunix quirk driver to a separate module
> (see examples like: 8250_exar, 8250_lpss, 8250_mid)?
> And then with a fewer LOCs add a new boards.

Greg asked Sunix to use existing 8250_pci.c instead of its own module.
It only needs a special setup function, other parts are just 8250_pci.

Why does split them a better idea? I even think of squashing 8250_moxa into  
8250_pci.

Kai-Heng

>
>> Cc: Morris Ku <morris_ku@sunix.com>
>> Cc: Debbie Liu <debbie_liu@sunix.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>>  use div64_s64() instead of do_div()
>>
>>  drivers/tty/serial/8250/8250_pci.c  | 93 +++++++++++++++++++++++------
>>  drivers/tty/serial/8250/8250_port.c |  8 +++
>>  include/uapi/linux/serial_core.h    |  3 +
>>  3 files changed, 87 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_pci.c  
>> b/drivers/tty/serial/8250/8250_pci.c
>> index 7f740b37700b..b2a5c2228858 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -1692,6 +1692,30 @@ pci_wch_ch38x_setup(struct serial_private *priv,
>>         return pci_default_setup(priv, board, port, idx);
>>  }
>>
>> +static int
>> +pci_sunix_setup(struct serial_private *priv,
>> +               const struct pciserial_board *board,
>> +               struct uart_8250_port *port, int idx)
>> +{
>> +       int bar;
>> +       int offset;
>> +
>> +       port->port.flags |= UPF_FIXED_TYPE;
>> +       port->port.type = PORT_SUNIX;
>> +
>> +       if (idx < 4) {
>> +               bar = 0;
>> +               offset = idx * board->uart_offset;
>> +       } else {
>> +               bar = 1;
>> +               idx -= 4;
>> +               idx = div_s64_rem(idx, 4, &offset);
>> +               offset = idx * 64 + offset * board->uart_offset;
>> +       }
>> +
>> +       return setup_port(priv, port, bar, offset, 0);
>> +}
>> +
>>  #define PCI_VENDOR_ID_SBSMODULARIO     0x124B
>>  #define PCI_SUBVENDOR_ID_SBSMODULARIO  0x124B
>>  #define PCI_DEVICE_ID_OCTPRO           0x0001
>> @@ -2289,21 +2313,14 @@ static struct pci_serial_quirk  
>> pci_serial_quirks[] __refdata = {
>>                 .setup          = pci_timedia_setup,
>>         },
>>         /*
>> -        * SUNIX (Timedia) cards
>> -        * Do not "probe" for these cards as there is at least one  
>> combination
>> -        * card that should be handled by parport_pc that doesn't match  
>> the
>> -        * rule in pci_timedia_probe.
>> -        * It is part number is MIO5079A but its subdevice ID is 0x0102.
>> -        * There are some boards with part number SER5037AL that report
>> -        * subdevice ID 0x0002.
>> +        * Sunix PCI serial boards
>>          */
>>         {
>>                 .vendor         = PCI_VENDOR_ID_SUNIX,
>>                 .device         = PCI_DEVICE_ID_SUNIX_1999,
>>                 .subvendor      = PCI_VENDOR_ID_SUNIX,
>>                 .subdevice      = PCI_ANY_ID,
>> -               .init           = pci_timedia_init,
>> -               .setup          = pci_timedia_setup,
>> +               .setup          = pci_sunix_setup,
>>         },
>>         /*
>>          * Xircom cards
>> @@ -2757,6 +2774,11 @@ enum pci_board_num_t {
>>         pbn_pericom_PI7C9X7952,
>>         pbn_pericom_PI7C9X7954,
>>         pbn_pericom_PI7C9X7958,
>> +       pbn_sunix_pci_1s,
>> +       pbn_sunix_pci_2s,
>> +       pbn_sunix_pci_4s,
>> +       pbn_sunix_pci_8s,
>> +       pbn_sunix_pci_16s,
>>  };
>>
>>  /*
>> @@ -3494,6 +3516,31 @@ static struct pciserial_board pci_boards[] = {
>>                 .base_baud      = 921600,
>>                 .uart_offset    = 0x8,
>>         },
>> +       [pbn_sunix_pci_1s] = {
>> +               .num_ports      = 1,
>> +               .base_baud      = 921600,
>> +               .uart_offset    = 0x8,
>> +       },
>> +       [pbn_sunix_pci_2s] = {
>> +               .num_ports      = 2,
>> +               .base_baud      = 921600,
>> +               .uart_offset    = 0x8,
>> +       },
>> +       [pbn_sunix_pci_4s] = {
>> +               .num_ports      = 4,
>> +               .base_baud      = 921600,
>> +               .uart_offset    = 0x8,
>> +       },
>> +       [pbn_sunix_pci_8s] = {
>> +               .num_ports      = 8,
>> +               .base_baud      = 921600,
>> +               .uart_offset    = 0x8,
>> +       },
>> +       [pbn_sunix_pci_16s] = {
>> +               .num_ports      = 16,
>> +               .base_baud      = 921600,
>> +               .uart_offset    = 0x8,
>> +       },
>>  };
>>
>>  static const struct pci_device_id blacklist[] = {
>> @@ -4532,17 +4579,29 @@ static const struct pci_device_id  
>> serial_pci_tbl[] = {
>>                 pbn_b0_bt_1_921600 },
>>
>>         /*
>> -        * SUNIX (TIMEDIA)
>> +        * Sunix PCI serial boards
>>          */
>>         {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> -               PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
>> -               PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00,
>> -               pbn_b0_bt_1_921600 },
>> -
>> +               PCI_VENDOR_ID_SUNIX, 0x0001, 0, 0,
>> +               pbn_sunix_pci_1s },
>>         {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> -               PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
>> -               PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
>> -               pbn_b0_bt_1_921600 },
>> +               PCI_VENDOR_ID_SUNIX, 0x0002, 0, 0,
>> +               pbn_sunix_pci_2s },
>> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> +               PCI_VENDOR_ID_SUNIX, 0x0004, 0, 0,
>> +               pbn_sunix_pci_4s },
>> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> +               PCI_VENDOR_ID_SUNIX, 0x0084, 0, 0,
>> +               pbn_sunix_pci_4s },
>> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> +               PCI_VENDOR_ID_SUNIX, 0x0008, 0, 0,
>> +               pbn_sunix_pci_8s },
>> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> +               PCI_VENDOR_ID_SUNIX, 0x0088, 0, 0,
>> +               pbn_sunix_pci_8s },
>> +       {       PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
>> +               PCI_VENDOR_ID_SUNIX, 0x0010, 0, 0,
>> +               pbn_sunix_pci_16s },
>>
>>         /*
>>          * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
>> diff --git a/drivers/tty/serial/8250/8250_port.c  
>> b/drivers/tty/serial/8250/8250_port.c
>> index c1cec808571b..8900112ed232 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -308,6 +308,14 @@ static const struct serial8250_config uart_config[]  
>> = {
>>                 .rxtrig_bytes   = {1, 4, 8, 14},
>>                 .flags          = UART_CAP_FIFO,
>>         },
>> +       [PORT_SUNIX] = {
>> +               .name           = "Sunix",
>> +               .fifo_size      = 128,
>> +               .tx_loadsz      = 128,
>> +               .fcr            = UART_FCR_ENABLE_FIFO |  
>> UART_FCR_R_TRIG_10,
>> +               .rxtrig_bytes   = {1, 32, 64, 112},
>> +               .flags          = UART_CAP_FIFO | UART_CAP_SLEEP,
>> +       },
>>  };
>>
>>  /* Uart divisor latch read */
>> diff --git a/include/uapi/linux/serial_core.h  
>> b/include/uapi/linux/serial_core.h
>> index 3cc3af1c2ee1..055626ca0a40 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -290,4 +290,7 @@
>>  /* SiFive UART */
>>  #define PORT_SIFIVE_V0 120
>>
>> +/* Sunix UART */
>> +#define PORT_SUNIX     121
>> +
>>  #endif /* _UAPILINUX_SERIAL_CORE_H */
>> --
>> 2.17.1
>
>
> -- 
> With Best Regards,
> Andy Shevchenko
