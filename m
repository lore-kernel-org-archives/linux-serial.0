From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v8 2/3] serial: exar: split out the exar code from 8250_pci
Date: Tue, 10 Jan 2017 08:03:17 +0000
Message-ID: <58749545.2040106@gmail.com>
References: <1483914727-6076-1-git-send-email-sudipm.mukherjee@gmail.com> <1483914727-6076-2-git-send-email-sudipm.mukherjee@gmail.com> <CAHp75VficfU+BTgW_Mm_UTC8oDKJA0yxrUz_PBY=w4jT2LFbMA@mail.gmail.com> <58740DD7.9070009@gmail.com> <CAHp75VfKvpzX2s6f-kz_XYwKE5L48WiyaDq3Vc24VZ=ZSEy7jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfKvpzX2s6f-kz_XYwKE5L48WiyaDq3Vc24VZ=ZSEy7jQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Monday 09 January 2017 11:13 PM, Andy Shevchenko wrote:
> On Tue, Jan 10, 2017 at 12:25 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> On Monday 09 January 2017 12:14 AM, Andy Shevchenko wrote:
>>>
>>>> +       /*
>>>> +        * Setup Multipurpose Input/Output pins.
>>>> +        */
>>>> +       if (idx == 0)
>>>> +               setup_gpio(p);
>>>
>>>
>>> So, my question is can we do this in GPIO driver?
>>
>>
>> No, I am using the pci card made by RTD, and they use the GPIO pins to
>> configure the hardware. And its based on the default values that is set
>> here.
>
> Can you elaborate a bit.
>
> I case you have GPIO:
> 1. map registers
> 2. do some GPIO configuration
> 3. do some other configuration
> 4. umap registers
> 5. register GPIO
> 6. register serial
>
> Correct?
>
> My question is, would it work if
>
> 1. register GPIO

then the platform device is created and the gpio driver will start but
the gpio register might not be written yet.

> 2. write GPIO related register (perhaps in GPIO driver)

If we write the GPIO related registers in the GPIO driver and if the
gpio driver is not enabled, then the gpio configuration registers will
not be written and initialized and few boards will break.

> 3. map registers

did you mean pci_ioremap_bar() ?
write to GPIO related register involves writing to the address that we
obtained using pci_ioremap_bar().

> 4. write some other configuration
> 5. unmap registers
> 6. register serial
>
> ?
>
>>
<snip>
>
>>>> +       if (!pcim_iomap(pcidev, bar, 0) && !pcim_iomap_table(pcidev))
>>>> +               return -ENOMEM;
>>>
>>> You ignored my comment, we may never finish the review in such case :-(
>>>
>>> Asking again: do you really need this part? I know why I did so and
>>> put it to 8250_pci, but let's focus on your code.
>
>> I checked your review of v7 and you have not mentioned about this one.
>> :(
>
> I'm sorry, but this is not true. Please, pay attention to all comments.
>
> Below is the cite from here:
> https://www.spinics.net/lists/kernel/msg2416487.html
> ---vvv
>
>> +       if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
>> +               return -ENOMEM;
>
> Do you need to check this per port? In probe you would know this.
>
> ---^^^

well, and I removed this to the probe so that it is checked only once
and not per port (like you mentioned). I thought that is what you
meant. :)

regards
sudip
