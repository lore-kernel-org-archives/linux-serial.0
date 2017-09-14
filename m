From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v1 01/10] clk: at91: pmc: Wait for clocks when resuming
Date: Thu, 14 Sep 2017 18:15:56 +0200
Message-ID: <CAGkQfmPB8b38=hJrtuKJ-Hiqdfx9dt5SQ5R7EBL9cJV5_eRmXQ@mail.gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-2-romain.izard.pro@gmail.com> <14fb5261-bb03-a6bd-6653-2a2c655b04ee@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14fb5261-bb03-a6bd-6653-2a2c655b04ee@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Jonathan Cameron <jic23@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org, linux-mtd <linux-mtd@lists.in>
List-Id: linux-serial@vger.kernel.org

2017-09-13 14:15 GMT+02:00 Nicolas Ferre <nicolas.ferre@microchip.com>:
> On 08/09/2017 at 17:35, Romain Izard wrote:
>> Wait for the syncronization of all clocks when resuming, not only the
>> UPLL clock. Do not use regmap_read_poll_timeout, as it will call BUG()
>> when interrupts are masked, which is the case in here.
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>>  drivers/clk/at91/pmc.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
>> index 775af473fe11..5c2b26de303e 100644
>> --- a/drivers/clk/at91/pmc.c
>> +++ b/drivers/clk/at91/pmc.c
>> @@ -107,10 +107,20 @@ static int pmc_suspend(void)
>>       return 0;
>>  }
>>
>> +static bool pmc_ready(unsigned int mask)
>> +{
>> +     unsigned int status;
>> +
>> +     regmap_read(pmcreg, AT91_PMC_SR, &status);
>> +
>> +     return ((status & mask) == mask) ? 1 : 0;
>> +}
>> +
>>  static void pmc_resume(void)
>>  {
>> -     int i, ret = 0;
>> +     int i;
>>       u32 tmp;
>> +     u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
>>
>>       regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
>>       if (pmc_cache.mckr != tmp)
>> @@ -134,13 +144,11 @@ static void pmc_resume(void)
>>                            AT91_PMC_PCR_CMD);
>>       }
>>
>> -     if (pmc_cache.uckr & AT91_PMC_UPLLEN) {
>> -             ret = regmap_read_poll_timeout(pmcreg, AT91_PMC_SR, tmp,
>> -                                            !(tmp & AT91_PMC_LOCKU),
>> -                                            10, 5000);
>> -             if (ret)
>> -                     pr_crit("USB PLL didn't lock when resuming\n");
>> -     }
>> +     if (pmc_cache.uckr & AT91_PMC_UPLLEN)
>> +             mask |= AT91_PMC_LOCKU;
>> +
>> +     while (!pmc_ready(mask))
>> +             cpu_relax();
>
> Okay, but I would prefer to keep the timeout property in it. So we may
> need to re-implement a timeout way-out here.
>

We need to have a reference clock to measure the timeout delay. If we use
the kernel's timekeeping, it relies on the clocks that we are configuring in
this code. Moreover, my experience with the mainline code is that when
something goes wrong, nothing will work. No oops or panic will be reported,
the device will just stop working.

In my case, I had obvious failures (it just stopped working unless I removed
USB wakeup or activated the console during suspend) but also very rare
failures, that occurred in the bootloader. Those issues were detected when
testing repeated suspend cycles for a night: the memory controller would
never enter the self-refresh mode during the resume sequence.

This led me to question the bootloader's code first, and I set up 4 boards
with the backup prototype code on v4.9 to verify that it was stable on
suspend. I've reached 1.5 million sleep cycles over 3 weeks without
failure, so this hinted towards the difference between the prototype and the
backup code provided for v4.12 (which contained the patch that got in
v4.13). Once I integrated this patch, I've run the v4.12 code for 2 weeks
without issue as well.

In the end, I don't want to touch this code if I do not have to, as checking
that it does not regress is really cumbersome.

-- 
Romain Izard
