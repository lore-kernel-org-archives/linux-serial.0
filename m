Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A7CC25B50
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAUQMg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Jan 2023 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUQMg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Jan 2023 11:12:36 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC281E9D4
        for <linux-serial@vger.kernel.org>; Sat, 21 Jan 2023 08:12:34 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPrXf-1p6yVu2Go7-00Muru; Sat, 21 Jan 2023 17:12:09 +0100
Message-ID: <6dc81996-6ffc-c1bc-6c3f-ca65055c94a2@i2se.com>
Date:   Sat, 21 Jan 2023 17:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/7] serial: imx: do not sysrq broken chars
Content-Language: en-US
To:     Sergey Organov <sorganov@gmail.com>, linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <87bko4e65y.fsf@osv.gnss.ru>
 <20230121153639.15402-1-sorganov@gmail.com>
 <20230121153639.15402-4-sorganov@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230121153639.15402-4-sorganov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2YADwGzkJ2977gcN2dZbwsjc/4ttSWw7nzInE6yna05u6rGzVgz
 t6iOnkoNzAUelkDVjAgwpIDfzPH2v9u56AWQjNDpCRKwNJEJ7iYFj3q1OOunwRiogZGPxRQ
 hczz0Cn1u37yZTAX5YebVzYVhv/UEDM91teZ/fK/wJ4+WaOUpNMvQmZwfXRplu8D6OrBvTg
 NDJMq4RRfGlWAGn7iSL8A==
UI-OutboundReport: notjunk:1;M01:P0:Xj/MohnC4sw=;PGjFhCpmLQamjWN9SrdDJzNi9mI
 sUF4zS+PBJhwPHtOlziiDad1rGPYd32MN5TDv6SbIJh5SSr9HB/Qz/IyD0kMBoFr1arwvT49P
 KgUaalF2V39VLcMFkYO6qNXAbuenZGWQc3xrXCbzYqKjdl/BlUd1gCvN1UuHl9YBbCQ+L0mPr
 +6weGI0UGuD6QmXTOkwl2Fu7esaeemRN2MPDauwsdHqZr9wyiomg2iQYHWY2fUpLdgD7/SHQD
 qv9iDL7CPJytKAb4agnbQcqx4qdtyAVBF4j5WI2zG+AsuCsrmPj2/ziYUbjeDi+QAHbrLu4ik
 KdAS1w7XpMu+Ic9OJY77DP51NqztE1JGrMwlccnDuWnDSpcBTnyzgBKgD6DhU0PHimQFWWjRj
 vPr2oPIv1bEryVzwARAqr7A72dlc/09Cmj7JmUv+vhR3hKZVY0l0ZDMBxI0a5npIQjwaj0XS4
 ZR/DSRtW/LnWzAGPwf2XgsHnu7yd234b34EJTRjjxXQ7jsjJHgwxCpGby+EPgiuDWYSt7DWtR
 ZvQzkizcAdajEgCtsooPqsNNzlvgTStDmONQWyjdusvy0UKxcOJQYJtf42nge2JZtwBkGmwpV
 7263XTkPqrrtKTk5HKPrEKbNhhgpluFza0NPIjVwheyiZXtotKVpa8+CoefQjH2zh1TiRbxNK
 KkXKMHnkRcpUBhWmdeW4vpLB0/W3Qjdw+2aF1BA1Iw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sergey,

Am 21.01.23 um 16:36 schrieb Sergey Organov:
> Do not call uart_handle_sysrq_char() if we got any receive error along with
> the character, as we don't want random junk to be considered a sysrq.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>

this looks like a bugfix to me. Since the relevant code is pretty old, 
i'm not sure about the fixes tag here:

Fixes: 279a9acc9b72 ("2.6.11 import") ?

> ---
>   drivers/tty/serial/imx.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e7fce31e460d..e709118fe85c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -911,9 +911,6 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>   				continue;
>   		}
>   
> -		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
> -			continue;
> -
>   		if (unlikely(rx & URXD_ERR)) {
>   			if (rx & URXD_BRK)
>   				sport->port.icount.brk++;
> @@ -942,6 +939,8 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
>   				flg = TTY_OVERRUN;
>   
>   			sport->port.sysrq = 0;
> +		} else if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx)) {
> +			continue;
>   		}
>   
>   		if (sport->port.ignore_status_mask & URXD_DUMMY_READ)
