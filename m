From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/6] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Mon, 22 May 2017 19:33:35 +0300
Message-ID: <CAHp75VeWqxHD7eS5FZGoyYw1B4QGMaWzVUtY-0akC764qjCjng@mail.gmail.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com> <357209721396d57cb871ae69d72308b1a7c9cbd7.1495119548.git.jan.kiszka@siemens.com>
 <CAHp75VcOHq05ZHc=arV9URQ9C6_guLiERB=FQ7FQgBTBYNrvPQ@mail.gmail.com> <83279eaf-69aa-333c-58b8-202d221375d3@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <83279eaf-69aa-333c-58b8-202d221375d3@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sun, May 21, 2017 at 2:43 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-18 19:43, Andy Shevchenko wrote:
>> On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the

>>> +       pdata.first_gpio = first_gpio;
>>> +       pdata.ngpio = ngpio;
>>
>> Still thinking about device properties ("ngpios" and something like
>> "exar8250,gpio-start").
>
> Changed back to properties, removing all platform data.
>
> But what's the purpose of prefixing the name here? This does not have
> anything to do with device trees. It's a private parameter channel
> between the creating device driver and the gpio driver, and there will
> be no other bindings.

To avoid potential collision with registered official property, that's
why better to use prefix.
(I didn't find anything like GPIO start / pin in registered
properties, maybe there is one)

>>> +       unsigned int first_gpio;
>>> +       unsigned int ngpio;
>>
>> u16 ?

> If we do that, then we would rather have to choose u8. But this is
> pointless restriction. I prefer to stay with the native type.

Still for properties it would be u32, wouldn't it?

-- 
With Best Regards,
Andy Shevchenko
