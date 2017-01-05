From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 3/3] serial: 8250_pci: remove exar code
Date: Thu, 5 Jan 2017 16:37:06 +0200
Message-ID: <CAHp75Vft_6_yM7Khjmnv1WYzSZ0rb_UJP-SVay5e3uK1_3YBRA@mail.gmail.com>
References: <1483611602-5560-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1483611602-5560-4-git-send-email-sudipm.mukherjee@gmail.com> <CAHp75Vdcniuuv3xV_o89i5_MpV_OGfbwE0yyDsRAFYjaxwOUDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdcniuuv3xV_o89i5_MpV_OGfbwE0yyDsRAFYjaxwOUDA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 5, 2017 at 4:35 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jan 5, 2017 at 12:20 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> Remove the exar specific codes from 8250_pci and blacklist those chips
>> so that the exar serial binds to the devices.
>
> exar -> Exar ?
>
>> +#define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
>> +#define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
>> +#define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a
>> +#define PCI_DEVICE_ID_COMMTECH_2328PCI335 0x000b
>
> This is not related to the patch. Create a separate one.
>
>> @@ -3734,6 +3538,8 @@ enum pci_board_num_t {
>>         { PCI_VDEVICE(INTEL, 0x228c), },
>>         { PCI_VDEVICE(INTEL, 0x9ce3), },
>>         { PCI_VDEVICE(INTEL, 0x9ce4), },
>
> + empty line
>
>> +       /* Exar devices */
>> +       { PCI_VDEVICE(EXAR, PCI_ANY_ID), },
>>  };

Ah, one more. Set default for your new driver to be SERIAL_8250.
Otherwise users will lost it, right?

-- 
With Best Regards,
Andy Shevchenko
