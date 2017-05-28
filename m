From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v3 09/10] gpio-exar/8250-exar: Make set of exported GPIOs
 configurable
Date: Sun, 28 May 2017 18:30:13 +0200
Message-ID: <678c7b34-211e-a3a3-29ef-5c4b6a0cf400@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
 <1f047bc2a36a3808170cb32e18f272109e675d0c.1495814557.git.jan.kiszka@siemens.com>
 <CAHp75Vdory-NsFRo5OFv7+G5dF315Yr10kEoVsgzod5mwMgqhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdory-NsFRo5OFv7+G5dF315Yr10kEoVsgzod5mwMgqhA@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-27 15:48, Andy Shevchenko wrote:
> On Fri, May 26, 2017 at 7:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
>> rest is required to operate the UART. To allow modeling this case,
>> expand the platform device data structure to specify a (consecutive) pin
>> subset for exporting by the gpio-exar driver.
> 
>> +       unsigned int first_pin;
> 
>> +       if (device_property_read_u32(&pdev->dev, "first_pin", &first_pin) < 0 ||
> 
> And again, we need to follow the rules of the device property
> bindings. (No underscores - use dashes; name should be registered).
> 
> Without Rafael's / Mika's and Rob's opinions I would not go with a
> such name even for internal property.
> 
> DWC3 (USB) for example is still using "linux," prefix. I dunno if it's
> the case here, I mean can or can't we use similar approach.
> 
>> +           device_property_read_u32(&pdev->dev, "npins", &npins) < 0)
> 
> "ngpios"
> 

Yeah, forgot to change all this before reposting. Will make the names
DT-alike.

But there is nothing to register: DT shall stay away from this device.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
