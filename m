From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Wed, 8 Jan 2014 13:54:50 +0100
Message-ID: <52CD4A9A.4010205@atmel.com>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org> <CACRpkdb2GvHAa9kF5KXWMiTDnyepziGmjqrCcgB1B7e0iHVKXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb2GvHAa9kF5KXWMiTDnyepziGmjqrCcgB1B7e0iHVKXA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jakub Pavelek <jakub.pavelek@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 08/01/2014 13:42, Linus Walleij :
> On Thu, Nov 7, 2013 at 10:25 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> This passes the errata fix using a GPIO to control the RTS pin
>> on one of the AT91 chips to use gpiolib instead of the
>> AT91-specific interfaces. Also remove the reliance on
>> compile-time #defines and the cpu_* check and rely on the
>> platform passing down the proper GPIO pin through platform
>> data.
>>
>> This is a prerequisite for getting rid of the local GPIO
>> implementation in the AT91 platform and move toward
>> multiplatform.
>>
>> The patch also adds device tree support for getting the
>> RTS GPIO pin from the device tree on DT boot paths.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v3->v4:
> 
> Hi Nicolas, I don't see this patch in linux-next, where did it
> get stuck? Something I can help with? Greg has ACKed it
> and all I think ...

Yes, everything seemed ready. It is actually stuck in Uwe's pull-request
which I asked for an update yesterday...
(Re: [GIT PULL] get rid of <mach/timex.h>). Maybe we should synchronize
each other on IRC?

I would have liked to see it merged in linux-next soon.

Bye,
-- 
Nicolas Ferre
