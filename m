Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD780C6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 14:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCXOUM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXOUL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 10:20:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B503CAF34
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 07:20:09 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.35]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbRXj-1qCJ010Yzx-00bspE; Fri, 24 Mar 2023 15:19:48 +0100
Message-ID: <547ab600-3630-4645-75c4-ff29610c9437@i2se.com>
Date:   Fri, 24 Mar 2023 15:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <20230324133739.rwo6yr75vrwatbhb@pengutronix.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230324133739.rwo6yr75vrwatbhb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p1DlTSg/zO4MjNzaedZao++hc1HstgGQPYfFwZ3r56XeOyNklNb
 /JPb7l7VasYv5PCfhZCndhmh8uusUG8pjOIskUlwIlu2xNKM67JpekeLLcWX8lUeJDryM1h
 VfTu8LNRJW6Pl+IG4V91vazjFyWQw4bGe3WW2rBow2VQJhUXSe77u/voUbvy/fPc0nwHGOo
 Wy0spF+ePoei3eb8Jg6Pg==
UI-OutboundReport: notjunk:1;M01:P0:yCUrYLqnr0w=;P3L10Cv/oEroj1kFJ3wLXPucOsH
 gtMZdcK6Nk3ngbYqIeTelCr4My8Z92/gD4U7dSXuAHN9HDFQGPOhAkWdlz+mmocxzkll5svJw
 YByw9Vbq49rJwLyDjBmfctl9ntWmlxl7YeZ8kDLx9eh61IH/nvgrqqepcQvJhF/ciuM1tfvee
 9woVd+D0nyr78TmenB1zGucZcGN30D4KC1StC+WDfejWmrrLcR9HcVHkQXrN7ca8dRMmDyEEk
 Vie4VhoLzCMSRPlc6JJTGIgrnv7+d4pUwxsoSVFULg5TwZW3aR3b0B1Qg3CKh2NPpLjqKB1RI
 D0PlqcVoNjxlSO5YvjIBZ3noM4Ijjxn/CarRmVJEMt0izPXfGMS7jXUNhuBLEnszkN6O0Ywqy
 Aif0ks0E9d2gNrINI1/9o8TUhSlkbgMcT4rY8n0aIDZZG/EdHJ2MU8N+zRGPwLI7Pi22grl73
 KDXcpGAi73cL/lvYjYiON3jzXpImfRwIEv+nRnhBntGo9NX/yFrOTrzqacISI09va1Bl2LyIr
 T1nJ/xb3LZSddWZG4GqESZUI9nEBFBUoGab7cNQm/IGevevuvMJmeJwGeGyvbb5pwdIS8YgoL
 Vtia4/W2MhXrXbzVceJe21iO0aXP+l15Ya5NKi2F1d16xYBiFdL6e6V6+CU3mmuq2FgRtrQZy
 8T1KBJK0E+puI2aiKFglJ9FCb1cDNYsiDaFfvawWmg==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Am 24.03.23 um 14:37 schrieb Uwe Kleine-König:
> On Fri, Mar 24, 2023 at 09:57:39AM -0300, Fabio Estevam wrote:
>> Hi Stefan,
>>
>> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
>> <ilpo.jarvinen@linux.intel.com> wrote:
>>
>>> This has come up earlier, see e.g.:
>>>
>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>>
>>> My somewhat uninformed suggestion: if the overrun problems mostly show up
>>> with console ports, maybe the trigger level could depend on the port
>>> being a console or not?
>> Does the change below help? Taking Ilpo's suggestion into account:
> I wonder if it's a red herring that having the console on that port
> makes a difference. If I understand correctly the problem is pasting
> bigger amounts of data on a ttymxc after having logged in via a getty?
>
> @Stefan: Can you try to reproduce with the port being also a console?

Sorry, for the confusion. Maybe i should have mentioned that the debug 
UART was configured as a console. Here is the output to be more specific 
(ttymxc0 and 4 are RS485, ttymxc3 is the debug console):

# cat /proc/tty/driver/IMX-uart

serinfo:1.0 driver revision:
0: uart:IMX mmio:0x02020000 irq:192 tx:285207 rx:2633621 fe:2 DSR|CD
3: uart:IMX mmio:0x021F0000 irq:193 tx:70502 rx:69 RTS|DTR|DSR
4: uart:IMX mmio:0x021F4000 irq:194 tx:300988 rx:677223 DSR|CD
5: uart:IMX mmio:0x021FC000 irq:195 tx:0 rx:0 DSR|CD
6: uart:IMX mmio:0x02018000 irq:191 tx:0 rx:0 DSR|CD

Just for clarification the Tarragon board is build in a charging 
station. So hardware access is limited.

@Uwe which port should be configured as a console?

>
> Best regards
> Uwe
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
