From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Thu, 18 May 2017 20:41:57 +0300
Message-ID: <CAHp75VcAiGFzfhd-609zsuscU19STQOme3Y91d1amaDToO8=oA@mail.gmail.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com> <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
 <CAHp75VewiaiYq6esGTiTV8kG30krhuXLQgLFGn10jmjkooXGPA@mail.gmail.com> <65189e05-e300-bbe3-660d-4fdd6d4ec8c1@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <65189e05-e300-bbe3-660d-4fdd6d4ec8c1@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 18, 2017 at 7:39 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-18 18:33, Andy Shevchenko wrote:
>> On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>>> +static bool is_iot2040;
>>
>> No, please, use driver data of DMI and hide this in corresponding structure.
>> Or even assign  port->port.rs485_config in the callback function.
>>
>> Moreover, can't you use port->port.rs485_config != NULL instead?
>
> There are two cases to be handled on IOT2040: the setting of the
> rs485_config and the different setup of the GPIOs, but the latter at a
> specific point in the initialization only. So I don't see yet how
> driver_data could come into play and help.

struct exar_iot2040_setup {
...rs485_config();
...setup_gpio();
};

struct exar_iot2040_setup iot2040_setup = {
...
};

DMI:

.driver_data = (void *)&iot2040_setup;

Above is just unfinished proposal, since I have noticed your new mail.
So, it seems we are on the same page.

One thing, I still would consider to use device properties instead of
platform data (with consideration of MFD framework usage).

-- 
With Best Regards,
Andy Shevchenko
