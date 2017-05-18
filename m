From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Thu, 18 May 2017 18:58:02 +0200
Message-ID: <f3959f33-b82a-e64a-c04d-bfa7ab486402@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
 <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
 <CAHp75VewiaiYq6esGTiTV8kG30krhuXLQgLFGn10jmjkooXGPA@mail.gmail.com>
 <65189e05-e300-bbe3-660d-4fdd6d4ec8c1@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65189e05-e300-bbe3-660d-4fdd6d4ec8c1@siemens.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-18 18:39, Jan Kiszka wrote:
> On 2017-05-18 18:33, Andy Shevchenko wrote:
>> On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> This implements the setup of RS232 and the switch-over to RS485 or RS422
>>> for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
>>> to switch between the different modes. The external logic is controlled
>>> via MPIO pins of the EXAR controller.
>>>
>>> Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
>>> an LED.
>>>
>>> As the XR17V352 used on the IOT2040 is not equipped with an external
>>> EEPROM, it cannot present itself as IOT2040-variant via subvendor/
>>> subdevice IDs. Thus, we have to check via DMI for the target platform.
>>>
>>> Co-developed with Sascha Weisenberger.
>>
>> Few nits below and one comment that should be addressed.
>>
>>> +#define UART_EXAR_RS485_DLY(x) (x << 4)
>>
>> ((x) << 4)
> 
> Yep.
> 
>>
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
> 

OK, got - hacking...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
