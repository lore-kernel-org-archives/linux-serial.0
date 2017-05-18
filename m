From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 5/8] gpio: exar: Fix reading of directions and values
Date: Thu, 18 May 2017 12:16:15 +0200
Message-ID: <160112c1-c80b-5b1b-6e54-4b3c22f554b6@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
 <1891081c09747965173fb03a7305e1c73033dac0.1494660546.git.jan.kiszka@siemens.com>
 <CAHp75Vdxoro-FoJY-t+FVk_9J6OBZMhJ9P9qjhq5a2bMOJMW9A@mail.gmail.com>
 <88c38a4c-f275-28d3-694e-e3089e56062e@siemens.com>
 <CAHp75Ve3wA6AUTRA7RwFVBS=w5ntdwak+mTJN5tE_n7oW+JQvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve3wA6AUTRA7RwFVBS=w5ntdwak+mTJN5tE_n7oW+JQvw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-18 12:11, Andy Shevchenko wrote:
> On Thu, May 18, 2017 at 8:20 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-05-13 15:36, Andy Shevchenko wrote:
>>> On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>> First, the logic for translating a register bit to the return code of
>>>> exar_get_direction and exar_get_value were wrong. And second, there was
>>>> a flip regarding the register bank in exar_get_direction.
>>>
>>> Again, I wish it was tested in the first place.
>>>
>>> After addressing below:
>>> FWIW:
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>
>>>> @@ -68,7 +68,7 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
>>>>         value = readb(exar_gpio->regs + reg);
>>>>         mutex_unlock(&exar_gpio->lock);
>>>>
>>>> -       return !!value;
>>>> +       return value;
>>>
>>> This one is correct.
> 
>>>
>>>> @@ -80,7 +80,7 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
>>>>         addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
>>>>         val = exar_get(chip, addr) >> (offset % 8);
>>>>
>>>> -       return !!val;
>>>> +       return val & 1;
>>>
>>> It should be rather
>>>
>>>         val = exar_get(chip, addr) & BIT(offset % 8);
>>
>> That won't give us 0 or 1 as return value, thus would be incorrect.
> 
> Full picture:
> 
>  val = exar_get(chip, addr) & BIT(offset % 8);
> 
>  return !!val;
> 
> How it could be non-(1 or 0)?
> 

Right - but what is the point of that other style?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
