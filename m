Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FDDC6FD1F
	for <linux-serial@archiver.kernel.org>; Sat, 25 Mar 2023 11:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjCYLbd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Mar 2023 07:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYLbc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Mar 2023 07:31:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30672B2
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 04:31:30 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.35]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mj7yt-1q9r5A1H9h-00f8gs; Sat, 25 Mar 2023 12:31:05 +0100
Message-ID: <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
Date:   Sat, 25 Mar 2023 12:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
Content-Language: en-US
In-Reply-To: <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f6vhEdpmHc0R7w1v4sCdl1E0iSA3s582EpuXDp5ypVBJde+8C3R
 U0flL0VdRfg0+mwK6TyOcIza8zalDUNBr1FV9YP58GNPy0JqgW9+65PSdSWCLglwYa/046E
 QME9bfWTktZESmfWKxwTpAx4XE7+68homVK4s6OOAS3FdrTCDLBLxxS7csptoe/pEResTQM
 sJkDmTdq8Fz5aLFTqd1dQ==
UI-OutboundReport: notjunk:1;M01:P0:0lxNjQMlRf0=;yP0Zv4/A6hm03NuqM2EgA0JycAW
 pk4NQyKk+xkqGYpm5S4TvDMRbABgL67kR2ZSIU5br7pTCkB/XF2fy7JGHa+pKfuYIZr1OYKpA
 FqQm9yqsWmSibaU9ST7EJlqTCxEwEVE6C6urRVZrydNJ3C0jjQ1a/DaTX6wrtQ+aksLfZ0yjN
 hQuGEGmDrqM+gCM7hN9e0SMSkInM4N7wjHMCIJ7qTcDuCnNMJDo7F8RxY41YIKiyqKdePae/9
 8E3raTnyZsVEn2EoGW/rXNZpjs/uIYA0V7GsyljVDpA2gGL0FomWUH0LMHQFfxGy7G83vUUAP
 jXBJRq5MQSVRspHjS0+jBrxKqrmCMvRoS1UYX0OxKlrpXRKAx+IUDrBhUQYN9aG/KtUC2MB1a
 wdmiKXVfJuVW8SP9SVKLTw3wIBx1k5UqwvWv9DBJ6Svb8tdCUslMzKspm1D153ssbDKmx13C0
 bbQoq7nBIgGvUJkMI6+BYR9NtNojv1sKvZjBpe7bmq6jZFWt5c85GQIAEUouw1DhtP44OIXYL
 Y0C0GoHFRkF+x3xIfX0MM+fXJK7cY0STO2S2YLY/uwmULwRXsiSYKg5ilazd0VWQbIiGI+u/r
 jui/tBxWvOupFOalAh4GC7PZ2AVcxCLZ8MnhMaS4FRyc2umm8qCbCV6XOO8yD9zxGGuEJkCwI
 9g+0Bhc3X/eURW07CB8XTpzWNchvp+WyeD68SXJjrg==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Fabio,

Am 24.03.23 um 16:00 schrieb Stefan Wahren:
> Hi Fabio,
> 
> Am 24.03.23 um 13:57 schrieb Fabio Estevam:
>> Hi Stefan,
>>
>> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
>> <ilpo.jarvinen@linux.intel.com> wrote:
>>
>>> This has come up earlier, see e.g.:
>>>
>>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>>
>>> My somewhat uninformed suggestion: if the overrun problems mostly 
>>> show up
>>> with console ports, maybe the trigger level could depend on the port
>>> being a console or not?
>> Does the change below help? Taking Ilpo's suggestion into account:
> this breaks the boot / debug console completely, but i got the idea.
>>

based on your patch, i successfully tested this:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f07c4f9ff13c..1aacaa637ede 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1277,6 +1277,7 @@ static void imx_uart_clear_rx_errors(struct 
imx_port *sport)
  }

  #define TXTL_DEFAULT 2 /* reset default */
+#define RXTL_DEFAULT_CONSOLE 1 /* reset default */
  #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
  #define TXTL_DMA 8 /* DMA burst setting */
  #define RXTL_DMA 9 /* DMA burst setting */
@@ -1286,6 +1287,9 @@ static void imx_uart_setup_ufcr(struct imx_port 
*sport,
  {
  	unsigned int val;

+	if (uart_console(&sport->port))
+		rxwl = RXTL_DEFAULT_CONSOLE; // fallback
+
  	/* set receiver / transmitter trigger level */
  	val = imx_uart_readl(sport, UFCR) & (UFCR_RFDIV | UFCR_DCEDTE);
  	val |= txwl << UFCR_TXTL_SHF | rxwl;
