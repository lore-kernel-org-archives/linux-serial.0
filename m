From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v8 2/3] serial: exar: split out the exar code from 8250_pci
Date: Mon, 09 Jan 2017 22:25:27 +0000
Message-ID: <58740DD7.9070009@gmail.com>
References: <1483914727-6076-1-git-send-email-sudipm.mukherjee@gmail.com> <1483914727-6076-2-git-send-email-sudipm.mukherjee@gmail.com> <CAHp75VficfU+BTgW_Mm_UTC8oDKJA0yxrUz_PBY=w4jT2LFbMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VficfU+BTgW_Mm_UTC8oDKJA0yxrUz_PBY=w4jT2LFbMA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Monday 09 January 2017 12:14 AM, Andy Shevchenko wrote:
> On Mon, Jan 9, 2017 at 12:32 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>
>> Add the serial driver for the Exar chips. And also register the
>> platform device for the gpio provided by the Exar chips.
>
> GPIO ?
>
<snip>
>
>> +       /*
>> +        * Setup Multipurpose Input/Output pins.
>> +        */
>> +       if (idx == 0)
>> +               setup_gpio(p);
>
> So, my question is can we do this in GPIO driver?

No, I am using the pci card made by RTD, and they use the GPIO pins to
configure the hardware. And its based on the default values that is set
here.

>
> Can we register it beforehand if needed?


The GPIO are only present in these chips and is only needed if this
particular setup executes. I am not sure what you mean by 'beforehand'.

>
>> +
<snip>
>> +
>> +static int
>> +exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>> +{
>
>> +       int rc;
>
> Make it last in the definition block. I think I mentioned this earlier.

I made it alphabetical based on the first character. I thought thats
what you meant.

>
>> +       struct exar8250_board *board;
>> +       struct uart_8250_port uart;
>> +       struct exar8250 *priv;
>> +       unsigned int nr_ports, i, bar = 0, maxnr;
>> +
>> +       board = (struct exar8250_board *)ent->driver_data;
>> +
>> +       rc = pcim_enable_device(pcidev);
>> +       if (rc)
>> +               return rc;
>> +
>
>> +       if (!pcim_iomap(pcidev, bar, 0) && !pcim_iomap_table(pcidev))
>> +               return -ENOMEM;
>
> You ignored my comment, we may never finish the review in such case :-(
>
> Asking again: do you really need this part? I know why I did so and
> put it to 8250_pci, but let's focus on your code.

I checked your review of v7 and you have not mentioned about this one.
:(

It was kept from 8250_pci.c. will remove.

>
>> +
>> +       maxnr = (pci_resource_len(pcidev, bar) - board->first_offset) >>
>> +               (board->reg_shift + 3);
<snip>
>> +static const struct exar8250_board pbn_exar_XR17C158 = {
>> +       .num_ports      = 8,
>> +       .base_baud      = 921600,
>> +       .uart_offset    = 0x200,
>> +       .setup          = pci_xr17c154_setup,
>> +};
>> +
>
> Port number is easily to get from device ID, I already said this.
> nr = subvendor == PCI_VENDOR_ID_IBM ? 1 : device & 0x0f;
>
> Yes, it means ->setup() hook will allocate memory for lines (declare
> them as int *line and use devm_kcalloc).

Sorry, I don't understand here. why in ->setup() hook?
I can just change in the probe() as:
nr_ports = board->num_ports ? board->num_ports : device & 0x0f;
and then devm_kzalloc() will work the same way in probe.

But is it worth to reduce few lines at the cost of readability? The way
the boards are defined now, anyone can see and understand which device
is having what configuration.

regards
sudip
