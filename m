Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED362C7EE31
	for <linux-serial@archiver.kernel.org>; Sun, 21 May 2023 11:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEULrK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 May 2023 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjEUKoE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 May 2023 06:44:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53601700
        for <linux-serial@vger.kernel.org>; Sun, 21 May 2023 03:39:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-309382efe13so2976873f8f.2
        for <linux-serial@vger.kernel.org>; Sun, 21 May 2023 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684665547; x=1687257547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPQaVPnWETci3ODKFpU9MT3SCdp6porwObhlEoOFKyY=;
        b=YiCT8q466S1xB70l8moLIDT3NUV0PrJ0KqcaD7zm7nlKOwd8v0TJCRCgYbp8lrV9Kb
         9fQgJIzAcO2BNvL7dEm0Uf3eahMF7+5LjqZaeoWrpkYxDr1kvb5pdwIhWwWcbJfl8MOJ
         lBDXNr8skCr7IjZCIJDJ34HBT7ulb5ncfPTJH/w+mdxV8AoS1EEeEo0z44vyoH3cR6c8
         lkNkG+XJEHwShHQmMponPvLhJmpTpd5dCtZDDigoFFw6F5UsiMACotefBLIkwLW/Wcjv
         LSpzq/imIU/9V7pzWZEQ9TSjMvX7bDEKGdvzeKGY5I51zTYm4CxyFpxhQosYjwyDGd+7
         xN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684665547; x=1687257547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPQaVPnWETci3ODKFpU9MT3SCdp6porwObhlEoOFKyY=;
        b=jVPzkogFTNw6MKIRVZaBzgSwgJuKHwxwcHMGrkdb+p0kaXPxEZDH/YiujYjOHJSImm
         Y0CPxRBFrhrFslOuO92OQHGlPMkBbDnte+mCGyFf4kmBaQr3+RV1A8gK4d9a57N2mxky
         fAnZIIjfG38Z+sv6xDCUp1vR0SSusC7i+VjB4ArordW+0yLox4x9D6EkUON3PwosjENo
         F2xt0g0SV2gM/0QR7nmXOABNMzXWJhGDJ3eZV8iZbFc4aKObSKc+WXX003qWImX4bhOZ
         oV+c04qIBxwGhPTOu0lBQNtMKwyMZe8OnCwkaqOwvg1xqy61LdKqueA9XsyaKgOhqJ2I
         yizw==
X-Gm-Message-State: AC+VfDwBAVrZTN6fz0zj9N0DKAqFAyaYF3WoWhJNP0yK1pvOxV1Vyh1W
        NGO7QQ1jTihk5X6JHW/DPDI=
X-Google-Smtp-Source: ACHHUZ4ep294voIhGhRsP2EdJo3Ewlf+f2YbQn7e1IXgnzJmGc/k4lenSrniEJQA4NVBHsn5GCsK+Q==
X-Received: by 2002:a5d:55cf:0:b0:309:33c4:52e1 with SMTP id i15-20020a5d55cf000000b0030933c452e1mr4905207wrw.64.1684665546494;
        Sun, 21 May 2023 03:39:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b? ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d5450000000b00306415ac69asm4366644wrv.15.2023.05.21.03.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 03:39:05 -0700 (PDT)
Message-ID: <03081b26-067a-89d2-0b2d-5f4e681ad243@gmail.com>
Date:   Sun, 21 May 2023 12:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] serial: Make uart_remove_one_port() return void
Content-Language: fr-FR
To:     Claudiu.Beznea@microchip.com, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        shc_work@mail.ru, shawnguo@kernel.org, s.hauer@pengutronix.de,
        patrice.chotard@foss.st.com, jacmet@sunsite.dk,
        michal.simek@amd.com, ilpo.jarvinen@linux.intel.com,
        andy.shevchenko@gmail.com, christophe.leroy@csgroup.eu,
        yuehaibing@huawei.com
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
 <20230512173810.131447-3-u.kleine-koenig@pengutronix.de>
 <c55af31a-6cfb-21e3-26a8-41d0428adf51@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <c55af31a-6cfb-21e3-26a8-41d0428adf51@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Le 15/05/2023 à 11:57, Claudiu.Beznea@microchip.com a écrit :
> On 12.05.2023 20:38, Uwe Kleine-König wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> The return value is only ever used as a return value for remove callbacks
>> of platform drivers. This return value is ignored by the driver core.
>> (The only effect is an error message, but uart_remove_one_port() already
>> emitted one in this case.)
>>
>> So the return value isn't used at all and uart_remove_one_port() can be
>> changed to return void without any loss. Also this better matches the
>> Linux device model as remove functions are not supposed to fail.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com> # atmel_serial.c
Acked-by: Richard Genodu <richard.genoud@gmail.com> # atmel_serial.c

> 
> 
>> ---
>>   drivers/tty/serial/atmel_serial.c           |  5 ++---
>>   drivers/tty/serial/clps711x.c               |  4 +++-
>>   drivers/tty/serial/cpm_uart/cpm_uart_core.c |  5 ++++-
>>   drivers/tty/serial/imx.c                    |  4 +++-
>>   drivers/tty/serial/lantiq.c                 |  4 +++-
>>   drivers/tty/serial/serial_core.c            |  6 +-----
>>   drivers/tty/serial/st-asc.c                 |  4 +++-
>>   drivers/tty/serial/uartlite.c               | 12 ++++--------
>>   drivers/tty/serial/xilinx_uartps.c          |  5 ++---
>>   include/linux/serial_core.h                 |  2 +-
>>   10 files changed, 26 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index 9cd7479b03c0..6e9192f122aa 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -3006,14 +3006,13 @@ static int atmel_serial_remove(struct platform_device *pdev)
>>   {
>>          struct uart_port *port = platform_get_drvdata(pdev);
>>          struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>> -       int ret = 0;
>>
>>          tasklet_kill(&atmel_port->tasklet_rx);
>>          tasklet_kill(&atmel_port->tasklet_tx);
>>
>>          device_init_wakeup(&pdev->dev, 0);
>>
>> -       ret = uart_remove_one_port(&atmel_uart, port);
>> +       uart_remove_one_port(&atmel_uart, port);
>>
>>          kfree(atmel_port->rx_ring.buf);
>>
>> @@ -3023,7 +3022,7 @@ static int atmel_serial_remove(struct platform_device *pdev)
>>
>>          pdev->dev.of_node = NULL;
>>
>> -       return ret;
>> +       return 0;
>>   }
>>
>>   static SIMPLE_DEV_PM_OPS(atmel_serial_pm_ops, atmel_serial_suspend,
>> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
>> index e190dce58f46..e49bc4019b50 100644
>> --- a/drivers/tty/serial/clps711x.c
>> +++ b/drivers/tty/serial/clps711x.c
>> @@ -514,7 +514,9 @@ static int uart_clps711x_remove(struct platform_device *pdev)
>>   {
>>          struct clps711x_port *s = platform_get_drvdata(pdev);
>>
>> -       return uart_remove_one_port(&clps711x_uart, &s->port);
>> +       uart_remove_one_port(&clps711x_uart, &s->port);
>> +
>> +       return 0;
>>   }
>>
>>   static const struct of_device_id __maybe_unused clps711x_uart_dt_ids[] = {
>> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> index 349e7da643f0..66afa9bea6bf 100644
>> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> @@ -1431,7 +1431,10 @@ static int cpm_uart_probe(struct platform_device *ofdev)
>>   static int cpm_uart_remove(struct platform_device *ofdev)
>>   {
>>          struct uart_cpm_port *pinfo = platform_get_drvdata(ofdev);
>> -       return uart_remove_one_port(&cpm_reg, &pinfo->port);
>> +
>> +       uart_remove_one_port(&cpm_reg, &pinfo->port);
>> +
>> +       return 0;
>>   }
>>
>>   static const struct of_device_id cpm_uart_match[] = {
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index c5e17569c3ad..b2bf3cb449f4 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -2467,7 +2467,9 @@ static int imx_uart_remove(struct platform_device *pdev)
>>   {
>>          struct imx_port *sport = platform_get_drvdata(pdev);
>>
>> -       return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
>> +       uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
>> +
>> +       return 0;
>>   }
>>
>>   static void imx_uart_restore_context(struct imx_port *sport)
>> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
>> index a58e9277dfad..d413f97f7190 100644
>> --- a/drivers/tty/serial/lantiq.c
>> +++ b/drivers/tty/serial/lantiq.c
>> @@ -889,7 +889,9 @@ static int lqasc_remove(struct platform_device *pdev)
>>   {
>>          struct uart_port *port = platform_get_drvdata(pdev);
>>
>> -       return uart_remove_one_port(&lqasc_reg, port);
>> +       uart_remove_one_port(&lqasc_reg, port);
>> +
>> +       return 0;
>>   }
>>
>>   static const struct ltq_soc_data soc_data_lantiq = {
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 54e82f476a2c..4b98d13555c0 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3154,13 +3154,12 @@ EXPORT_SYMBOL(uart_add_one_port);
>>    * This unhooks (and hangs up) the specified port structure from the core
>>    * driver. No further calls will be made to the low-level code for this port.
>>    */
>> -int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>> +void uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>>   {
>>          struct uart_state *state = drv->state + uport->line;
>>          struct tty_port *port = &state->port;
>>          struct uart_port *uart_port;
>>          struct tty_struct *tty;
>> -       int ret = 0;
>>
>>          mutex_lock(&port_mutex);
>>
>> @@ -3176,7 +3175,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>>
>>          if (!uart_port) {
>>                  mutex_unlock(&port->mutex);
>> -               ret = -EINVAL;
>>                  goto out;
>>          }
>>          uport->flags |= UPF_DEAD;
>> @@ -3219,8 +3217,6 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>>          mutex_unlock(&port->mutex);
>>   out:
>>          mutex_unlock(&port_mutex);
>> -
>> -       return ret;
>>   }
>>   EXPORT_SYMBOL(uart_remove_one_port);
>>
>> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
>> index 5215e6910f68..dc2f2051435c 100644
>> --- a/drivers/tty/serial/st-asc.c
>> +++ b/drivers/tty/serial/st-asc.c
>> @@ -796,7 +796,9 @@ static int asc_serial_remove(struct platform_device *pdev)
>>   {
>>          struct uart_port *port = platform_get_drvdata(pdev);
>>
>> -       return uart_remove_one_port(&asc_uart_driver, port);
>> +       uart_remove_one_port(&asc_uart_driver, port);
>> +
>> +       return 0;
>>   }
>>
>>   #ifdef CONFIG_PM_SLEEP
>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>> index 94584e54ebbe..679574893ebe 100644
>> --- a/drivers/tty/serial/uartlite.c
>> +++ b/drivers/tty/serial/uartlite.c
>> @@ -685,18 +685,15 @@ static int ulite_assign(struct device *dev, int id, phys_addr_t base, int irq,
>>    *
>>    * @dev: pointer to device structure
>>    */
>> -static int ulite_release(struct device *dev)
>> +static void ulite_release(struct device *dev)
>>   {
>>          struct uart_port *port = dev_get_drvdata(dev);
>> -       int rc = 0;
>>
>>          if (port) {
>> -               rc = uart_remove_one_port(&ulite_uart_driver, port);
>> +               uart_remove_one_port(&ulite_uart_driver, port);
>>                  dev_set_drvdata(dev, NULL);
>>                  port->mapbase = 0;
>>          }
>> -
>> -       return rc;
>>   }
>>
>>   /**
>> @@ -900,14 +897,13 @@ static int ulite_remove(struct platform_device *pdev)
>>   {
>>          struct uart_port *port = dev_get_drvdata(&pdev->dev);
>>          struct uartlite_data *pdata = port->private_data;
>> -       int rc;
>>
>>          clk_disable_unprepare(pdata->clk);
>> -       rc = ulite_release(&pdev->dev);
>> +       ulite_release(&pdev->dev);
>>          pm_runtime_disable(&pdev->dev);
>>          pm_runtime_set_suspended(&pdev->dev);
>>          pm_runtime_dont_use_autosuspend(&pdev->dev);
>> -       return rc;
>> +       return 0;
>>   }
>>
>>   /* work with hotplug and coldplug */
>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>> index 8e521c69a959..20a751663ef9 100644
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -1670,14 +1670,13 @@ static int cdns_uart_remove(struct platform_device *pdev)
>>   {
>>          struct uart_port *port = platform_get_drvdata(pdev);
>>          struct cdns_uart *cdns_uart_data = port->private_data;
>> -       int rc;
>>
>>          /* Remove the cdns_uart port from the serial core */
>>   #ifdef CONFIG_COMMON_CLK
>>          clk_notifier_unregister(cdns_uart_data->uartclk,
>>                          &cdns_uart_data->clk_rate_change_nb);
>>   #endif
>> -       rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
>> +       uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
>>          port->mapbase = 0;
>>          clk_disable_unprepare(cdns_uart_data->uartclk);
>>          clk_disable_unprepare(cdns_uart_data->pclk);
>> @@ -1693,7 +1692,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
>>
>>          if (!--instances)
>>                  uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
>> -       return rc;
>> +       return 0;
>>   }
>>
>>   static struct platform_driver cdns_uart_platform_driver = {
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index 66ecec15a1bf..ddcdb5b8523e 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -853,7 +853,7 @@ void uart_console_write(struct uart_port *port, const char *s,
>>   int uart_register_driver(struct uart_driver *uart);
>>   void uart_unregister_driver(struct uart_driver *uart);
>>   int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
>> -int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
>> +void uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
>>   bool uart_match_port(const struct uart_port *port1,
>>                  const struct uart_port *port2);
>>
>> --
>> 2.39.2
>>
> 

Thanks !
