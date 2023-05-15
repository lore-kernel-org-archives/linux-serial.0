Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4746C77B75
	for <linux-serial@archiver.kernel.org>; Mon, 15 May 2023 07:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbjEOHMc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 May 2023 03:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjEOHMb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 May 2023 03:12:31 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3002E74
        for <linux-serial@vger.kernel.org>; Mon, 15 May 2023 00:12:29 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F6SYC3032304;
        Mon, 15 May 2023 09:11:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=/7Vozrx9Gl2OmUCpxJALq0Vbp5ECVC3PGd4Snjw1hSw=;
 b=hT2S/fRFJcRyqrsdCRz1nX6TEQ/cVfmz0eMm+x1vLf7wYDBRfUGtRrwoqjO/GaDSOJeb
 emMLoJWdI0y1+5P8SvwagCCMQrUJXs2ZCBTH+k77Y4wu5X5Rv6Pw+59sjmf+b7Ae/fUf
 +JyIqeCKx1ggv5WFM46TCUfpBVjRh8fMKIk3f+L/A4AB2g7FYPTDTdFSJaok6nTF4Dv7
 J1omChL8d+x3u10NE5jJw+36HqEIVNRJWf9IRx8ScAUNKon55VRwQXXXyqNmUuMVGdWV
 caeFmbNzBGMT5Wk6x7Pjrq5DiBuhr14gOmzrAntL2pxnX5ylm0ibW3KtWjpSZpZwgT3O Ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qhyp7spns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 09:11:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88F6F10002A;
        Mon, 15 May 2023 09:11:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6DA702122E7;
        Mon, 15 May 2023 09:11:37 +0200 (CEST)
Received: from [10.201.21.26] (10.201.21.26) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 15 May
 2023 09:11:36 +0200
Message-ID: <0dffd5df-e5bf-1665-8c00-56e78fa7d785@foss.st.com>
Date:   Mon, 15 May 2023 09:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] serial: Make uart_remove_one_port() return void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        YueHaibing <yuehaibing@huawei.com>
CC:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-serial@vger.kernel.org>,
        "moderated list:ARM/Microchip" <linux-arm-kernel@lists.infradead.org>,
        <kernel@pengutronix.de>
References: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
 <20230512173810.131447-3-u.kleine-koenig@pengutronix.de>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230512173810.131447-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.26]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_04,2023-05-05_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi

On 5/12/23 19:38, Uwe Kleine-König wrote:
> The return value is only ever used as a return value for remove callbacks
> of platform drivers. This return value is ignored by the driver core.
> (The only effect is an error message, but uart_remove_one_port() already
> emitted one in this case.)
> 
> So the return value isn't used at all and uart_remove_one_port() can be
> changed to return void without any loss. Also this better matches the
> Linux device model as remove functions are not supposed to fail.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/atmel_serial.c           |  5 ++---
>  drivers/tty/serial/clps711x.c               |  4 +++-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  5 ++++-
>  drivers/tty/serial/imx.c                    |  4 +++-
>  drivers/tty/serial/lantiq.c                 |  4 +++-
>  drivers/tty/serial/serial_core.c            |  6 +-----
>  drivers/tty/serial/st-asc.c                 |  4 +++-
>  drivers/tty/serial/uartlite.c               | 12 ++++--------
>  drivers/tty/serial/xilinx_uartps.c          |  5 ++---
>  include/linux/serial_core.h                 |  2 +-
>  10 files changed, 26 insertions(+), 25 deletions(-)

> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 5215e6910f68..dc2f2051435c 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -796,7 +796,9 @@ static int asc_serial_remove(struct platform_device *pdev)
>  {
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  
> -	return uart_remove_one_port(&asc_uart_driver, port);
> +	uart_remove_one_port(&asc_uart_driver, port);
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP

For st-asc:  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
