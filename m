From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 5/6] gpio-exar/8250-exar: Make set of exported GPIOs
 configurable
Date: Sun, 21 May 2017 13:43:13 +0200
Message-ID: <83279eaf-69aa-333c-58b8-202d221375d3@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
 <357209721396d57cb871ae69d72308b1a7c9cbd7.1495119548.git.jan.kiszka@siemens.com>
 <CAHp75VcOHq05ZHc=arV9URQ9C6_guLiERB=FQ7FQgBTBYNrvPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcOHq05ZHc=arV9URQ9C6_guLiERB=FQ7FQgBTBYNrvPQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-18 19:43, Andy Shevchenko wrote:
> On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
>> rest is required to operate the UART. To allow modeling this case,
>> expand the platform device data structure to specify a (consecutive) pin
>> subset for exporting by the gpio-exar driver.
> 
>> +       unsigned int first_gpio;
> 
> Perhaps pin?
> Or shift?
> 
> Because first_gpio a bit confusing with Linux side of GPIO.

Ack, going for "pin".

> 
>> -       unsigned int bank = offset / 8;
>> -       unsigned int addr;
>> +       struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
>> +       unsigned int bank, addr;
>>
>> +       offset += exar_gpio->first_gpio;
>> +       bank = offset / 8;
> 
> Can't we instead do something like the following:
> 
> struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
> unsigned int bank = (offset + exar_gpio->pin) / 8;
> unsigned int line = (offset + exar_gpio->pin) % 8;
> 

OK, I'm using this pattern now:

	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;

> 
>> +       pdata.first_gpio = first_gpio;
>> +       pdata.ngpio = ngpio;
> 
> Still thinking about device properties ("ngpios" and something like
> "exar8250,gpio-start").

Changed back to properties, removing all platform data.

But what's the purpose of prefixing the name here? This does not have
anything to do with device trees. It's a private parameter channel
between the creating device driver and the gpio driver, and there will
be no other bindings.

> 
>> +       unsigned int first_gpio;
>> +       unsigned int ngpio;
> 
> u16 ?
> 

If we do that, then we would rather have to choose u8. But this is
pointless restriction. I prefer to stay with the native type.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
