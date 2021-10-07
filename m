Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C6C433F5
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 12:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A16561251
	for <linux-serial@archiver.kernel.org>; Thu,  7 Oct 2021 12:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbhJGMFd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Oct 2021 08:05:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57447 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhJGMFd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Oct 2021 08:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633608220; x=1665144220;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KfmQwXwjpkUqzPCW9Vy8rMSdY83umdm3xb0l1zYj0nw=;
  b=YZVlhv2pW2mJHnciZ2vVYwG4bIhtRMJHBr03Z8ieU5nMMelrRFX9cA4A
   oshxxR78pNKpimdwuGtTAQ4kOlytFh4f7W9NrUTS2z5zVMUmCNROecpQr
   WS5EDXAK0oKldfX1KuPFck8OOxY3vStpWnR8GnzAPl3zenWcSzG1y0Dbm
   HzvF60GT1gtf+EOG+uQjOww2RZJ+XQjLuMquAcidm4bTrRYQWtU4zGooS
   Ydxl+xffuN4us2coq4/xUZm7qKiVt+VDz44tyIjzMEtHPkfhFbOSaBPsz
   KOIYUc9GAqlY4n3uXAOjXf/MhA1thcJ6ZjlGXX8BmgZOh63Q2wQ29kxS2
   g==;
IronPort-SDR: sr4jnZM+FJXVKAHXkdEmopkV7mfeWrF/Zy72PBxUBULmyt8Ycn01hSZ4g8SZQMHXuvoIn7oQ0j
 vVoxKUZz7jx4OwaT25md21ZKYO4zORIzQ0j67knVZmyERH6sf2J4LZ+FuSYax3cxc+c/+JcHrH
 Z+XFnXpd0Gbame39i9wKftNf1q0QcF9Maz2K1BmMSza1AAZqHlwR2bt/vUkwfQ5cDoAG/N3mMV
 BqeLrTql0HR//pRz+PvTTjohYBThBRAR7d7Pzj0mXnu3C2/H5pZ66djoTPRniQzn1wh0GYS+qv
 a5kXWeqsevX3iI57bv9AAE+p
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="134584212"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 05:03:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 05:03:39 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 7 Oct 2021 05:03:36 -0700
Subject: Re: [PATCH] tty: serial: atmel: use macros instead of hardcoded
 values
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211007112014.2332019-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <336df8ff-72fa-90af-607b-eeb683de4a37@microchip.com>
Date:   Thu, 7 Oct 2021 14:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007112014.2332019-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07/10/2021 at 13:20, Claudiu Beznea wrote:
> Use UART_PM_STATE_ON, UART_PM_STATE_OFF instead of hardcoded values.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu, best regards,
   Nicolas

> ---
>   drivers/tty/serial/atmel_serial.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 249ea35088d2..2c99a47a2535 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2084,7 +2084,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>   	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>   
>   	switch (state) {
> -	case 0:
> +	case UART_PM_STATE_ON:
>   		/*
>   		 * Enable the peripheral clock for this serial port.
>   		 * This is called on uart_open() or a resume event.
> @@ -2094,7 +2094,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>   		/* re-enable interrupts if we disabled some on suspend */
>   		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->backup_imr);
>   		break;
> -	case 3:
> +	case UART_PM_STATE_OFF:
>   		/* Back up the interrupt mask and disable all interrupts */
>   		atmel_port->backup_imr = atmel_uart_readl(port, ATMEL_US_IMR);
>   		atmel_uart_writel(port, ATMEL_US_IDR, -1);
> 


-- 
Nicolas Ferre
