From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 2/3] serial: exar: split out the exar code from 8250_pci
Date: Tue, 10 Jan 2017 01:13:18 +0200
Message-ID: <CAHp75VfKvpzX2s6f-kz_XYwKE5L48WiyaDq3Vc24VZ=ZSEy7jQ@mail.gmail.com>
References: <1483914727-6076-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1483914727-6076-2-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VficfU+BTgW_Mm_UTC8oDKJA0yxrUz_PBY=w4jT2LFbMA@mail.gmail.com> <58740DD7.9070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <58740DD7.9070009@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 10, 2017 at 12:25 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Monday 09 January 2017 12:14 AM, Andy Shevchenko wrote:
>>
>>> +       /*
>>> +        * Setup Multipurpose Input/Output pins.
>>> +        */
>>> +       if (idx == 0)
>>> +               setup_gpio(p);
>>
>>
>> So, my question is can we do this in GPIO driver?
>
>
> No, I am using the pci card made by RTD, and they use the GPIO pins to
> configure the hardware. And its based on the default values that is set
> here.

Can you elaborate a bit.

I case you have GPIO:
1. map registers
2. do some GPIO configuration
3. do some other configuration
4. umap registers
5. register GPIO
6. register serial

Correct?

My question is, would it work if

1. register GPIO
2. write GPIO related register (perhaps in GPIO driver)
3. map registers
4. write some other configuration
5. unmap registers
6. register serial

?

>
>>
>> Can we register it beforehand if needed?
>
>
>
> The GPIO are only present in these chips and is only needed if this
> particular setup executes. I am not sure what you mean by 'beforehand'.

See above.

>>> +       int rc;
>>
>> Make it last in the definition block. I think I mentioned this earlier.
>
> I made it alphabetical based on the first character. I thought thats
> what you meant.

Wait, alphabetical order makes sense to the header block. To the
variable definition blocks we apply reverse tree rule

assignments from parameters first
longer lines next
return code variable last

flags for spin lock -> depends.

>>> +       if (!pcim_iomap(pcidev, bar, 0) && !pcim_iomap_table(pcidev))
>>> +               return -ENOMEM;
>>
>> You ignored my comment, we may never finish the review in such case :-(
>>
>> Asking again: do you really need this part? I know why I did so and
>> put it to 8250_pci, but let's focus on your code.

> I checked your review of v7 and you have not mentioned about this one.
> :(

I'm sorry, but this is not true. Please, pay attention to all comments.

Below is the cite from here:
https://www.spinics.net/lists/kernel/msg2416487.html
---vvv

> +       if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> +               return -ENOMEM;

Do you need to check this per port? In probe you would know this.

---^^^

> It was kept from 8250_pci.c. will remove.

Good.

>>> +static const struct exar8250_board pbn_exar_XR17C158 = {
>>> +       .num_ports      = 8,
>>> +       .base_baud      = 921600,
>>> +       .uart_offset    = 0x200,
>>> +       .setup          = pci_xr17c154_setup,
>>> +};
>>> +
>>
>>
>> Port number is easily to get from device ID, I already said this.
>> nr = subvendor == PCI_VENDOR_ID_IBM ? 1 : device & 0x0f;
>>
>> Yes, it means ->setup() hook will allocate memory for lines (declare
>> them as int *line and use devm_kcalloc).
>
>
> Sorry, I don't understand here. why in ->setup() hook?
> I can just change in the probe() as:
> nr_ports = board->num_ports ? board->num_ports : device & 0x0f;
> and then devm_kzalloc() will work the same way in probe.

Yes, after my second comment this is indeed better way to do.

> But is it worth to reduce few lines at the cost of readability?

It's more or less normal practice.
How readability will suffer from that?

> The way
> the boards are defined now, anyone can see and understand which device
> is having what configuration.

You have really limited set of devices where last half-byte *does not*
reflect number of ports.

-- 
With Best Regards,
Andy Shevchenko
