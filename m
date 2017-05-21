From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 1/6] gpio: exar: Fix passing in of parent PCI device
Date: Sun, 21 May 2017 13:44:17 +0200
Message-ID: <7d5b0099-b4d9-881d-fc63-0c7f8229e096@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
 <62280d24a7cf7c0be849c1186c909c850f4d2cc6.1495119548.git.jan.kiszka@siemens.com>
 <CAHp75VcRRxgzoPio2zWrR5rE_ac9uQjcphcXTQF6TrM13qxe+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcRRxgzoPio2zWrR5rE_ac9uQjcphcXTQF6TrM13qxe+A@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-18 19:14, Andy Shevchenko wrote:
> On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> This fixes reloading of the GPIO driver for the same platform device
>> instance as created by the exar UART driver: First of all, the driver
>> sets drvdata to its own value during probing and does not restore the
>> original value on exit. But this won't help anyway as the core clears
>> drvdata after the driver left.
>>
>> Use stable platform_data instead.
> 
> Okay, basically what we are trying to do here is to reinvent part of
> MFD framework.
> 
> I'd like to hear Linus' and others opinions if it worth to use it instead.
> 

I've looked into MFD modeling, but it would only make sense if we break
up the exar driver, change its xr17v35x part into a platform device and
create a dual-cell MFD for the PCI device. I don't think that would be
beneficial here. There are also dependencies between the UART part and
the MPIOs, specifically during init. All that would create a lot of
churn to the existing exar code.

I'm now passing the parent reference via device.parent instead of using
platform data.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
