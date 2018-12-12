From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 11/15] clocksource: Add clock driver for RDA8810PL SoC
Date: Wed, 12 Dec 2018 16:52:58 +0100
Message-ID: <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
 <0b90a179-aa4b-57f7-0874-996d5c535ea9@linaro.org>
 <20181212154748.GA28130@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212154748.GA28130@Mani-XPS-13-9360>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, gregkh@linuxfoundation.org, jslaby@suse.com, linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net
List-Id: linux-serial@vger.kernel.org

On 12/12/2018 16:47, Manivannan Sadhasivam wrote:
> Hi Daniel,
> 
> On Wed, Dec 12, 2018 at 04:07:53PM +0100, Daniel Lezcano wrote:
>> On 10/12/2018 18:35, Manivannan Sadhasivam wrote:
>>> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
>>> and HWTIMER.
>>>
>>> RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER
>>> (64 bit). Each timer provides optional interrupt support. In this
>>> driver, OSTIMER is used for clockevents and HWTIMER is used for
>>> clocksource.
>>>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> The driver looks good to me. Do you want me to pick it up via my tree?
>>
> 
> Yes, please do. Marc is going to pick up the irqchip driver but I'm not
> sure about the serial driver. The rest of the patches can be picked up
> by the ARM maintainers (I need to send another version for dropping
> Andreas from MAINTAINERS).

Ok, applied.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
