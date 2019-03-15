From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 02/45] drivers: tty: serial: 8250_dw: use
 devm_ioremap_resource()
Date: Fri, 15 Mar 2019 10:37:09 +0100
Message-ID: <d4e60f4b-6a3f-8af1-0ddb-e7a69e0c15d4@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-3-git-send-email-info@metux.net>
 <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tobias Klauser <tklauser@distanz.ch>, Richard Genoud <richard.genoud@gmail.com>, macro@linux-mips.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com
List-Id: linux-serial@vger.kernel.org

On 15.03.19 10:04, Andy Shevchenko wrote:
> On Fri, Mar 15, 2019 at 12:41 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> Instead of fetching out data from a struct resource for passing
>> it to devm_ioremap(), directly use devm_ioremap_resource()
> 
> I don't see any advantage of this change.
> See also below.

I see that the whole story wasn't clear. Please see my reply to Greg,
hope that clears it up a little bit.

>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
>>         p->set_ldisc    = dw8250_set_ldisc;
>>         p->set_termios  = dw8250_set_termios;
>>
>> -       p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
>> +       p->membase = devm_ioremap_resource(dev, regs);
>>         if (!p->membase)
> 
> And how did you test this? devm_ioremap_resource() returns error
> pointer in case of error.

hmm, devm_ioremap_resource() does so, but devm_ioremap() does not ?
I really didn't expect that. Thanks for pointing that out.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
