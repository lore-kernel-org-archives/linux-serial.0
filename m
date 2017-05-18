From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 8/8] serial: exar: Add support for IOT2040 device
Date: Thu, 18 May 2017 07:06:58 +0200
Message-ID: <9c3fa989-b137-2935-23cd-d9c3a91c6ce6@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
 <1d8ba1dea24da541389e8175097aa4f67eddc298.1494660546.git.jan.kiszka@siemens.com>
 <CAHp75VcG4rZiWoym9U4qaoEzUT_AY0m62oL+a8Zb-=3yBFV5Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcG4rZiWoym9U4qaoEzUT_AY0m62oL+a8Zb-=3yBFV5Og@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-13 15:54, Andy Shevchenko wrote:
> On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> This implements the setup of RS232 and the switch-over to RS485 or RS422
>> for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
>> to switch between the different modes. The external logic is controlled
>> via MPIO pins of the EXAR controller.
>>
>> Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
>> an LED.
>>
>> As the XR17V352 used on the IOT2040 is not equipped with an external
>> EEPROM, it cannot present itself as IOT2040-variant via subvendor/
>> subdevice IDs. Thus, we have to check via DMI for the target platform.
>>
>> Co-developed with Sascha Weisenberger.
>>
> 
> Please, refactor that using properly formed DMI structrure and use its
> callback and driver data facilities/

Could you point to a specific example? The callback of the dmi_system_id
structure is not designed to handle device initializations like this one
- not to speak of having those two different initialization points here.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
