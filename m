Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D3C6FD1D
	for <linux-serial@archiver.kernel.org>; Mon, 27 Mar 2023 14:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjC0OnN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Mar 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjC0OnL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Mar 2023 10:43:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7A10CA
        for <linux-serial@vger.kernel.org>; Mon, 27 Mar 2023 07:42:57 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1u2b-1qQcFk1ZYf-012GBe; Mon, 27 Mar 2023 16:42:25 +0200
Message-ID: <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com>
Date:   Mon, 27 Mar 2023 16:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2x7dH306ege1cKmimn0+FtCBHNAmA+ZiUttxg/tsd+xVtyCHQqT
 iTKgGpMeNEuRtXpemvVLfOQk/vftDs1fIeyQSg+D1pBdYWsIrQbVpz0S7YiYrgBIsIgAlvS
 MeuyHUWnK7rnGk21e++me2cYjb5LcPBniF5NpR8rEfl7yCbyGmoaGsAtVTxPjv5Z3zP2NRS
 7ikPfezjkYht1uf+hzoaA==
UI-OutboundReport: notjunk:1;M01:P0:muF48CanQD8=;rxsc259Y/NZ/v0y+xS1ETgJndZT
 +DE5x0CGSCOhzv7uJ7G6NVRLBwU3i44RFZqqEZyaV76ULzDGeJvVf1cEE46dx10jd39h5OYDa
 0qetQAIYRPENgJeun/4NHGt93KGHV69fk3qG7eCDz8G/FXTJl4TQf59N2ZpwlNLS9d7UrLiGf
 dBWaurh19z0R6G3x8c842I/lad817nMJF/62sqfdcBpb916hGW/emMvC/Bcm5ZS/rUKbaF1cp
 VsQ7uhCCSrijib0X7fGUbixC6ABlcGsMmCkKJDI/SnWPfvH7uk0vgvVIoWMlREkH3/2Lrg+zk
 RdjmTE1CqrN52/QsWuzz+MxIWF4wMLIRwKrg2DasFyy2ftcae1ppbcEH8Ku91/+yk5HU5cdpB
 61SwHTxSNgsxdm72Rw0Xd2d+BitTbdCzVG4DxINNO6/4JtVjr6XF2bA1Q3yUXPPTPcuMage/e
 P96TXR2hm9+csAHsxUQlEwD+0NuRnDeU9w+s8RE8hAhMzRpKe2qKdIMlQ7IsRbxI/Wljkpelz
 OyoPurewXO8abqIv2lCgNLXG9Wm39S78tEwivZMNps4NdEK7XhMUyz0Nvxem4mZrSBp1IPQcy
 qys5+tHDWzd9hyjPjkGWk/nBDCthiZYqHAIfLz/24PDa94TH0m3q3FR3AYIJ+9RoMAD3QphJH
 5VFTxxCDTWlriWfFKROIi7SvUirzPDCPuF8DDXyNZg==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Am 25.03.23 um 16:11 schrieb Uwe Kleine-König:
> Hello,
> 
> On Sat, Mar 25, 2023 at 12:31:01PM +0100, Stefan Wahren wrote:
>> Am 24.03.23 um 16:00 schrieb Stefan Wahren:
>>> Am 24.03.23 um 13:57 schrieb Fabio Estevam:
>>>> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>
>>>>> This has come up earlier, see e.g.:
>>>>>
>>>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>>>>
>>>>> My somewhat uninformed suggestion: if the overrun problems
>>>>> mostly show up
>>>>> with console ports, maybe the trigger level could depend on the port
>>>>> being a console or not?
>>>> Does the change below help? Taking Ilpo's suggestion into account:
>>> this breaks the boot / debug console completely, but i got the idea.
>>>>
>>
>> based on your patch, i successfully tested this:
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index f07c4f9ff13c..1aacaa637ede 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1277,6 +1277,7 @@ static void imx_uart_clear_rx_errors(struct imx_port
>> *sport)
>>   }
>>
>>   #define TXTL_DEFAULT 2 /* reset default */
>> +#define RXTL_DEFAULT_CONSOLE 1 /* reset default */
>>   #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
>>   #define TXTL_DMA 8 /* DMA burst setting */
>>   #define RXTL_DMA 9 /* DMA burst setting */
>> @@ -1286,6 +1287,9 @@ static void imx_uart_setup_ufcr(struct imx_port
>> *sport,
>>   {
>>   	unsigned int val;
>>
>> +	if (uart_console(&sport->port))
>> +		rxwl = RXTL_DEFAULT_CONSOLE; // fallback
>> +
>>   	/* set receiver / transmitter trigger level */
>>   	val = imx_uart_readl(sport, UFCR) & (UFCR_RFDIV | UFCR_DCEDTE);
>>   	val |= txwl << UFCR_TXTL_SHF | rxwl;
> 
> So the current theory that the issue occurs because of a combination of:
> 
>   - With a higher watermark value the irq triggers later and so there is
>     less time the until the ISR must run before an overflow happens; and
> 
>   - serial console activity disables irqs for a (relative) long time
> 
> right?
> 
> So on an UP system the problem should occur also on a non-console port?
> Local irqs are only disabled if some printk is about to be emitted,
> isn't it? Does this match the error you're seeing?
> 
> That makes me wonder if the error doesn't relate to the UART being a
> console port, but the UART being used without DMA?! (So the patch above
> fixes the problem for you because on the console port no DMA is used?)

today i had time to do some testing. At first i tested with different 
RXTL_DEFAULT values.

1 No overrun
2 No overrun
4 No overrun
8 Overruns

After that i look at the # echo 0 > /proc/sys/kernel/printk approach, 
but this didn't change anything. The kernel is usually silent about log 
message after boot and the console works still with echo. Enforcing some 
driver to call printk periodically would make the console unusuable.

Finally i tried to disabled the spin_lock in imx_uart_console_write:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f07c4f9ff13c..c342559ff1a2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2007,14 +2007,12 @@ imx_uart_console_write(struct console *co, const 
char *s, unsigned int count)
  	struct imx_port_ucrs old_ucr;
  	unsigned long flags;
  	unsigned int ucr1;
-	int locked = 1;
+	int locked = 0;

  	if (sport->port.sysrq)
  		locked = 0;
  	else if (oops_in_progress)
  		locked = spin_trylock_irqsave(&sport->port.lock, flags);
-	else
-		spin_lock_irqsave(&sport->port.lock, flags);

  	/*
  	 *	First, save UCR1/2/3 and then disable interrupts

But the overruns still occured. Is this because the serial core already 
helds a lock?

> 
> Best regards
> Uwe
> 
