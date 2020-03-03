Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC199C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 07:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C09215A4
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 07:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgCCHmg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:42:36 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:21020 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHmg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 02:42:36 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: O7nPWFUYAo46OKeqpq4DP6IKOpF+nVYiAdwnUMbQ8fSaiNzmXHwXqFm94BkNP5ugsipUD0DoDB
 LqKZRMZ0WwJeNfufsgA3sOkhn2nDpkYsSsS5Fjr46YgYGxAMBh/WOZ6dcdEjIrHZ47XC/xKoLv
 rczO22iCfEKatiVpHo7y3G3M0FG/KJfASDlRxjmC7G3+jPaS/fp8WwNqYmde2MzeZRbUf//txw
 TUWDd+HQsbES/zYXYhtyg9DqS4FJdGqB8TTk6QlReVJzHVyVb+ivmPDxyBhaNIk4KCwBSmElEw
 k8I=
X-IronPort-AV: E=Sophos;i="5.70,510,1574146800"; 
   d="scan'208";a="67426639"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2020 00:42:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Mar 2020 00:42:35 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 3 Mar 2020 00:42:48 -0700
Date:   Tue, 3 Mar 2020 08:41:52 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: Re: [PATCH] tty: serial: atmel_serial: Drop GPIO includes
Message-ID: <20200303074152.eis2vtryfewujdbx@M43218.corp.atmel.com>
References: <20200229220941.205599-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200229220941.205599-1-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Feb 29, 2020 at 11:09:41PM +0100, Linus Walleij wrote:
> 
> Nothing in this driver uses the symbols from these GPIO
> includes so drop them. These are probably just historical
> artifacts from befor mctrl_gpio was used.
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Razvan Stefanescu <razvan.stefanescu@microchip.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks.

> ---
>  drivers/tty/serial/atmel_serial.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c15c398c88a9..801b998c87e7 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -20,15 +20,12 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/atmel_pdc.h>
>  #include <linux/uaccess.h>
>  #include <linux/platform_data/atmel.h>
>  #include <linux/timer.h>
> -#include <linux/gpio.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/err.h>
>  #include <linux/irq.h>
>  #include <linux/suspend.h>
> --
> 2.24.1
> 
