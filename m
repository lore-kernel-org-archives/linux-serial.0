Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64562C43331
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261AE2076A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="AoUPJH25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYXyy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:54:54 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:54632 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCYXyy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:54:54 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 19:54:54 EDT
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id D6616B02EB7
        for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2020 00:47:39 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1585180059; x=1586044060; bh=hwawGVLeEGKlOEKyGcHOaP4x1GO8hx2CZJL
        TZm7JUXI=; b=AoUPJH25pI4oMJqKYEpNS7bT5Iwr/HC3crlHMgK2xgWu4/t1rDO
        1/FGfmEXI2fafrGY+GasxHnEgvkEefwXwB4ziqtbXdv2iFqUrIjYQOozjGv4lvgZ
        0mCrDXpA3WPtqyZYi8BiqWhXbkC/DkhKz2sjZcp+v6nHiePNpZOqV3ik=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R9ou3chOmirW for <linux-serial@vger.kernel.org>;
        Thu, 26 Mar 2020 00:47:39 +0100 (CET)
Received: from [10.212.134.200] (unknown [192.168.123.254])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 42F53B02E4E;
        Thu, 26 Mar 2020 00:47:38 +0100 (CET)
Subject: Re: [PATCH v2 4/7] serial: 8250: Handle implementations not having
 TEMT interrupt using em485
To:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
References: <20200325231422.1502366-1-heiko@sntech.de>
 <20200325231422.1502366-5-heiko@sntech.de>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <3a5df648-b054-3338-f7a4-4c01783eabf6@micronovasrl.com>
Date:   Thu, 26 Mar 2020 00:47:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325231422.1502366-5-heiko@sntech.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Heiko,

very cleaner way to handle TEMT as a capability!
And I've found one thing...

Il 26/03/2020 00:14, Heiko Stuebner ha scritto:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Some 8250 ports have a TEMT interrupt but it's not a part of the 8250
> standard, instead only available on some implementations.
> 
> The current em485 implementation does not work on ports without it.
> The only chance to make it work is to loop-read on LSR register.
> 
> So add UART_CAP_TEMT to mark 8250 uarts having this interrupt,
> update all current em485 users with that capability and make
> the stop_tx function loop-read on uarts not having it.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> [moved to use added UART_CAP_TEMT, use readx_poll_timeout]
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>   drivers/tty/serial/8250/8250.h            |  1 +
>   drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
>   drivers/tty/serial/8250/8250_of.c         |  2 ++
>   drivers/tty/serial/8250/8250_omap.c       |  2 +-
>   drivers/tty/serial/8250/8250_port.c       | 25 +++++++++++++++++++----
>   5 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 52bb21205bb6..770eb00db497 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -82,6 +82,7 @@ struct serial8250_config {
>   #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
>   					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>   					 */
> +#define UART_CAP_TEMT	(1 << 18)	/* UART has TEMT interrupt */
>   
>   #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
>   #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 12d03e678295..3881242424ca 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	/* initialize data */
> -	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
> +	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
>   	up.port.dev = &pdev->dev;
>   	up.port.regshift = 2;
>   	up.port.type = PORT_16550;
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 65e9045dafe6..841f6fcb2878 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -225,6 +225,8 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>   			&port8250.overrun_backoff_time_ms) != 0)
>   		port8250.overrun_backoff_time_ms = 0;
>   
> +	port8250.capabilities |= UART_CAP_TEMT;
> +

Shouldn't this be NOT UART_CAP_TEMT set by default? On all other
vendor specific files you enable it, I think here you shouldn't enable
it too by default. Right?

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

>   	ret = serial8250_register_8250_port(&port8250);
>   	if (ret < 0)
>   		goto err_dispose;
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index dd69226ce918..d29d5b0cf8c1 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1140,7 +1140,7 @@ static int omap8250_probe(struct platform_device *pdev)
>   	up.port.regshift = 2;
>   	up.port.fifosize = 64;
>   	up.tx_loadsz = 64;
> -	up.capabilities = UART_CAP_FIFO;
> +	up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
>   #ifdef CONFIG_PM
>   	/*
>   	 * Runtime PM is mostly transparent. However to do it right we need to a
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 47c059987538..41ad7db6a31e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -15,6 +15,7 @@
>   #include <linux/moduleparam.h>
>   #include <linux/ioport.h>
>   #include <linux/init.h>
> +#include <linux/iopoll.h>
>   #include <linux/console.h>
>   #include <linux/sysrq.h>
>   #include <linux/delay.h>
> @@ -1520,6 +1521,11 @@ static inline void __do_stop_tx(struct uart_8250_port *p)
>   		serial8250_rpm_put_tx(p);
>   }
>   
> +static inline int __get_lsr(struct uart_8250_port *p)
> +{
> +	return serial_in(p, UART_LSR);
> +}
> +
>   static inline void __stop_tx(struct uart_8250_port *p)
>   {
>   	struct uart_8250_em485 *em485 = p->em485;
> @@ -1529,11 +1535,22 @@ static inline void __stop_tx(struct uart_8250_port *p)
>   		/*
>   		 * To provide required timeing and allow FIFO transfer,
>   		 * __stop_tx_rs485() must be called only when both FIFO and
> -		 * shift register are empty. It is for device driver to enable
> -		 * interrupt on TEMT.
> +		 * shift register are empty. If 8250 port supports it,
> +		 * it is for device driver to enable interrupt on TEMT.
> +		 * Otherwise must loop-read until TEMT and THRE flags are set.
>   		 */
> -		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> -			return;
> +		if (p->capabilities & UART_CAP_TEMT) {
> +			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +				return;
> +		} else {
> +			int lsr;
> +
> +			if (readx_poll_timeout(__get_lsr, p, lsr,
> +					(lsr & BOTH_EMPTY) == BOTH_EMPTY,
> +					0, 10000) < 0)
> +				pr_warn("%s: timeout waiting for fifos to empty\n",
> +					p->port.name);
> +		}
>   
>   		__stop_tx_rs485(p);
>   	}
> 

