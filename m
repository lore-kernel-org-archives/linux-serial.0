From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v7 2/3] serial: exar: split out the exar code from 8250_pci
Date: Sun, 08 Jan 2017 11:11:29 +0000
Message-ID: <58721E61.6050200@gmail.com>
References: <1483833469-11422-1-git-send-email-sudipm.mukherjee@gmail.com> <1483833469-11422-3-git-send-email-sudipm.mukherjee@gmail.com> <CAHp75Vdirfo6ioAa_mZ+gXRHRjFUqy13-naBJYn8+O2FxPMDYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdirfo6ioAa_mZ+gXRHRjFUqy13-naBJYn8+O2FxPMDYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sunday 08 January 2017 01:02 AM, Andy Shevchenko wrote:
> On Sun, Jan 8, 2017 at 1:57 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> Add the serial driver for the exar chips. And also register the
>> platform device for the exar gpio.
>
> Did you ignore some comments?
>
> IIRC I recommended to use proper vendor name like Exar (or how is it spelled?).

oops, sorry. I missed that.

>
>> Headers, if arranged in alphabetical order, will give a build warning.
>
> I think I know how to make it better.
>
>> And thanks for revewing that v6. I think those were the worst patch I
>> have ever posted.
>
> You may do even more better. See below.
>
>> +#undef DEBUG
>
>> +#include <asm/byteorder.h>
>
> (1)
>
>> +#include <linux/pci.h>
>
> Squeez this to the rest
>
>> +#include <linux/8250_pci.h>
>
> (2)
>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/tty.h>
>
> You perhaps need something like this here:
>
> + empty line
> (1) +#include <asm/byteorder.h>
>
>> +
>
> (2) +#include <linux/8250_pci.h>
>
>> +#include "8250.h"

not sure if I have understood this header thing properly. But let me 
play with it and see,

>
>> +
>> +#define PCI_NUM_BAR_RESOURCES  6
<snip>
>> +static struct pci_device_id exar_pci_tbl[] = {
>> +       {       PCI_DEVICE_SUB(PCI_VENDOR_ID_EXAR,
>> +               PCI_DEVICE_ID_EXAR_XR17C152,
>> +               PCI_SUBVENDOR_ID_CONNECT_TECH,
>> +               PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232), 0, 0,
>> +               (kernel_ulong_t)&pbn_b0_2_1843200_200 },
>
> You ignored my comment regarding to make a macro(s).

I used PCI_DEVICE_SUB() and PCI_VDEVICE(), but yes, custom macro might 
be better here. I was trying to have one custom macro, but with two 
different macros it should be ok.

>
> Moreover, some of data, like number of ports, can be easily calculated
> from device ID.

yes, but since the baudrate is different i will need to have different 
board id for it.
Like: 'PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232' has a device id 
'PCI_DEVICE_ID_EXAR_XR17C154' is having a baudrate of 1843200 but the 
other devices with the same deviceid will have a baudrate of 921600.

unless, in the probe I compare the subvendor with 
PCI_SUBVENDOR_ID_CONNECT_TECH and modify the baud. Let me try.

Thanks for reviewing.

Regards
Sudip
