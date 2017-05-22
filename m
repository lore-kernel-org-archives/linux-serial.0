From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Mon, 22 May 2017 18:28:55 +0200
Message-ID: <5aaf3441-2cbb-fc9e-6df3-80b62fc044f8@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
 <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
 <CACRpkdbeXdOWiYpmtQTU1B66mxq1gGpukZWvUepgzNk5LLa1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbeXdOWiYpmtQTU1B66mxq1gGpukZWvUepgzNk5LLa1PQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-22 17:46, Linus Walleij wrote:
> On Thu, May 18, 2017 at 4:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
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
>> Signed-off-by: Sascha Weisenberger <sascha.weisenberger@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Will this thing collide with your fixups so that Greg should take all
> exar patches or can this be applied to the serial tree orthogonally?

This patch has to come last. It depends on patch 5, e.g., and that has
dependencies as well.

FWIW, v3 of this series is coming, just requires another testing round.

Jan


-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
