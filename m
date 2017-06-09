From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v5 03/11] gpio-exar/8250-exar: Fix passing in of parent
 PCI device
Date: Fri, 9 Jun 2017 09:44:28 +0200
Message-ID: <b52e2c46-05db-63fa-f0a5-b59ca73e6e3e@siemens.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com>
 <63100617e55d78ab881baaa6baf44e8d74d0e816.1496388533.git.jan.kiszka@siemens.com>
 <CACRpkdah8Bgo2Ga5RK8+9=dqr0pizSYd50wqQk++TyycW6=xnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdah8Bgo2Ga5RK8+9=dqr0pizSYd50wqQk++TyycW6=xnQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-06-09 09:21, Linus Walleij wrote:
> On Fri, Jun 2, 2017 at 9:28 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> This fixes reloading of the GPIO driver for the same platform device
>> instance as created by the exar UART driver: First of all, the driver
>> sets drvdata to its own value during probing and does not restore the
>> original value on exit. But this won't help anyway as the core clears
>> drvdata after the driver left.
>>
>> Set the platform device parent instead.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If I get Gregs ACK on this I can merge patches 2-11 through the
> GPIO tree.
> 

Patch 10 needs an update, Andy had remarks. I need to resync and send it
- there will be v6 soon.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
