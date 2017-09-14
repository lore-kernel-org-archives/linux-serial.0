From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 03/10] clk: at91: pmc: Support backup for programmable
 clocks
Date: Thu, 14 Sep 2017 11:38:45 +0200
Message-ID: <dc318434-cf3e-6cb9-2072-7b8ec45aed97@microchip.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
 <20170908153604.28383-4-romain.izard.pro@gmail.com>
 <b0c7e816-4a7c-609d-2bc7-281fc6ca751d@microchip.com>
 <20170913170310.grfv7j5xvh7chjdo@piout.net>
 <CAGkQfmOZBi4tzUSEAD7J+w_v+pZ_yFgPRBaYaLnW-ptFZO0rvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAGkQfmOZBi4tzUSEAD7J+w_v+pZ_yFgPRBaYaLnW-ptFZO0rvg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: romain izard <romain.izard@mobile-devices.fr>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-iio@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-clk@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Josh Wu <rainyfeeling@outlook.com>, Marek Vasut <marek.vasut@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Alan Stern <stern@rowland.harvard.edu>, linux-serial@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Jon
List-Id: linux-serial@vger.kernel.org

On 14/09/2017 at 09:41, romain izard wrote:
> 2017-09-13 19:03 GMT+02:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
>> On 13/09/2017 at 14:29:35 +0200, Nicolas Ferre wrote:
>>> On 08/09/2017 at 17:35, Romain Izard wrote:
>>>> From: Romain Izard <romain.izard@mobile-devices.fr>
>>>>
>>>> Save and restore the System Clock and Programmable Clock register for
>>>> the backup use case.
>>>
>>> "System Clock" seems to be handled in another patch.
>>>
>>>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>>>> ---
>>>>  drivers/clk/at91/pmc.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
>>>> index 07dc2861ad3f..5421b03553ec 100644
>>>> --- a/drivers/clk/at91/pmc.c
>>>> +++ b/drivers/clk/at91/pmc.c
>>>> @@ -66,6 +66,7 @@ static struct
>>>>     u32 pcr[PMC_MAX_IDS];
>>>>     u32 audio_pll0;
>>>>     u32 audio_pll1;
>>>> +   u32 pckr[3];
>>>
>>> Some products have different numbers of PCK (only 2 on at91sam9x5 for
>>> instance)...
>>>
>>
>> My opinion is that it will be time to change that when multiple SoCs will
>> need to save their registers.
>>
> For the next version, I'll add a #define. But as this code requires a
> device tree node with the compatible string "atmel,sama5d2-pmc", I believe
> that we can ignore other chips for now.

Fair enough, let's go for this.

Bye,
-- 
Nicolas Ferre

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
