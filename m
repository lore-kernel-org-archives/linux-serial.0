Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA3EB64DD
	for <linux-serial@archiver.kernel.org>; Mon,  7 Aug 2023 08:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHGIlr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Aug 2023 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjHGIlk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Aug 2023 04:41:40 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360511733;
        Mon,  7 Aug 2023 01:41:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VpCmB9e_1691397688;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpCmB9e_1691397688)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 16:41:29 +0800
Message-ID: <3554a99d-339f-39f9-111d-040025096f97@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 16:41:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: sprd: Support 12 uart ports
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230807080726.7190-1-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230807080726.7190-1-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 8/7/2023 4:07 PM, Wenhua Lin wrote:
> From: Wenhua Lin <wenhua.lin@unisoc.com>
> 
> Support 12 uart ports, which can solve the problem
> of insufficient uart ports.

This sounds incorrect to me.
If this is a software bug, please add a Fixes tag to backport for stable 
kernels. If the change of the max ports is only avaliable on the new 
SPRD serial hardware, you should ensure the change is 
backward-compatibility with old hardware.

> Signed-off-by: Wenhua Lin <wenhua.lin@unisoc.com>
> ---
>   drivers/tty/serial/sprd_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index b58f51296ace..2774df490899 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -22,7 +22,7 @@
>   #include <linux/tty_flip.h>
>   
>   /* device name */
> -#define UART_NR_MAX		8
> +#define UART_NR_MAX		12
>   #define SPRD_TTY_NAME		"ttyS"
>   #define SPRD_FIFO_SIZE		128
>   #define SPRD_DEF_RATE		26000000
