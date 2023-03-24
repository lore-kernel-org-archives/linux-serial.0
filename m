Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F58C6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 15:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjCXPA3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXPA2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 11:00:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A39619F2E
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 08:00:27 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.35]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9MlG-1qZhcQ0pk4-015IgX; Fri, 24 Mar 2023 16:00:06 +0100
Message-ID: <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
Date:   Fri, 24 Mar 2023 16:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V7vGuHjDvj23wx57HhYybgmdKTlhONAizcFChzLvIGmQKnGFFZv
 F0eix1PIC9DftX/jMI8VtFLtD2rAoaBkwvejZcU0pcgFH3qGKiQGF4NVkeMeiQTteGFAUHf
 VM0u5MnyoXUtqbcWr01jZtDj1HqVDceARAfa4HTr/A6+uOvBMzU6WHO+ivT6sJE6Y0PY3wR
 vd+ay9AOSnutn6ss/slTQ==
UI-OutboundReport: notjunk:1;M01:P0:VUWVSyxpcvQ=;teJUmopskKvOY/vN9yCsl3AwobU
 1h+0dAIozxtuaQzK0rEzwIcmhNE4XFgiC6qlPMp8/+luVzhbrXkMkvLcSYNWc2QRKlOnR27U5
 n4yWTG//Tdo3oe2vNfh5BZUhJcczJDmpes5Cc5IijJxAUIBa7Rde/q6ne//70oqPl6o3mE36O
 TxRaYIaIXnmPI/RgEGuKBMOK8xiTStrC6f0s9q08UDEVTtpPYL4pYi/7sizyGxGJjH1TyU3HL
 L8g6LXlMQW6cBuTE3BAlh1drS1+1nT8yYD86PQr3RYHPghBHjJwL+3Fx3hx+yiMGnsfhWM3pU
 FNXyB+mJxlVmvG2v14e/rU01WIXQWi1FhlgPaoemrtErMV5cgtnSb5KMuWDRBMFoXkA/RC4X+
 p0SDkQFwhehUNIDCzbxhDUpBu5SCoWWc0NmIyXZ95mvL6hM6EULlPdMXBLeW2s90cVEWBCO07
 SPqU8K1HPrCejvisjntyl8lc+y2uTKRIMOWESuw9k3CN7VFVmu4TLybhOtf4QvEmUdwoTlMFF
 xLfSwVJZ0YOCzyfBqOQgtacinVQHGW/ID1VWCrOsdrMDzHTOj1FSvahOrDV0ai7m2LUupxh2p
 fCB9QE5KI3A/Sy+ddwKb5lzDh7gyVATE5YnfQiuakbBVLhp4Rfu3icHXtOGggVmO5X0/tevb3
 wyfQcZ4cmpTc0pOmWogMuYnoOxSGubz76/yfbS8nJw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Fabio,

Am 24.03.23 um 13:57 schrieb Fabio Estevam:
> Hi Stefan,
>
> On Fri, Mar 24, 2023 at 8:48 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
>
>> This has come up earlier, see e.g.:
>>
>> https://lore.kernel.org/linux-serial/20221003110850.GA28338@francesco-nb.int.toradex.com/
>>
>> My somewhat uninformed suggestion: if the overrun problems mostly show up
>> with console ports, maybe the trigger level could depend on the port
>> being a console or not?
> Does the change below help? Taking Ilpo's suggestion into account:
this breaks the boot / debug console completely, but i got the idea.
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 0fa1bd8cdec7..4d0aae38b7a5 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -233,6 +233,7 @@ struct imx_port {
>          enum imx_tx_state       tx_state;
>          struct hrtimer          trigger_start_tx;
>          struct hrtimer          trigger_stop_tx;
> +       unsigned int            rxtl;
>   };
>
>   struct imx_port_ucrs {
> @@ -1309,6 +1310,7 @@ static void imx_uart_clear_rx_errors(struct
> imx_port *sport)
>   }
>
>   #define TXTL_DEFAULT 2 /* reset default */
> +#define RXTL_DEFAULT_CONSOLE 1 /* 1 character or aging timer */
>   #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
>   #define TXTL_DMA 8 /* DMA burst setting */
>   #define RXTL_DMA 9 /* DMA burst setting */
> @@ -1422,7 +1424,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
>          ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
>          imx_uart_writel(sport, ucr1, UCR1);
>
> -       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> +       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
>
>          sport->dma_is_enabled = 0;
>   }
> @@ -1447,7 +1449,7 @@ static int imx_uart_startup(struct uart_port *port)
>                  return retval;
>          }
>
> -       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> +       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
I think at lea this point sport->rxtl is not properly initialized.
>
>          /* disable the DREN bit (Data Ready interrupt enable) before
>           * requesting IRQs
> @@ -1464,6 +1466,11 @@ static int imx_uart_startup(struct uart_port *port)
>          if (!uart_console(port) && imx_uart_dma_init(sport) == 0)
>                  dma_is_inited = 1;
>
> +       if (uart_console(port))
> +               sport->rxtl = RXTL_DEFAULT_CONSOLE;
> +       else
> +               sport->rxtl = RXTL_DEFAULT;
> +
>          spin_lock_irqsave(&sport->port.lock, flags);
>
>          /* Reset fifo's and state machines */
> @@ -1863,7 +1870,7 @@ static int imx_uart_poll_init(struct uart_port *port)
>          if (retval)
>                  clk_disable_unprepare(sport->clk_ipg);
>
> -       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> +       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
>
>          spin_lock_irqsave(&sport->port.lock, flags);
>
> @@ -2139,7 +2146,7 @@ imx_uart_console_setup(struct console *co, char *options)
>          else
>                  imx_uart_console_get_options(sport, &baud, &parity, &bits);
>
> -       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> +       imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
>
>          retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
