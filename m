Return-Path: <SRS0=JhiI=CM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9BC433E2
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 04:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6020758
	for <linux-serial@archiver.kernel.org>; Thu,  3 Sep 2020 04:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgICEuU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Sep 2020 00:50:20 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:52498 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgICEuU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Sep 2020 00:50:20 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 00:50:19 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 60F8822A1E3A;
        Thu,  3 Sep 2020 12:44:33 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GVpgzeMHLz0u; Thu,  3 Sep 2020 12:44:33 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 4081F205523F;
        Thu,  3 Sep 2020 12:44:33 +0800 (HKT)
Received: from [10.128.3.2] (061244237146.static.ctinets.com [61.244.237.146])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 2CBC9C01B69;
        Thu,  3 Sep 2020 12:44:33 +0800 (HKT)
Subject: Re: [PATCH] serial: imx: Delete duplicated argument to | in
 imx_uart_probe
To:     Ye Bin <yebin10@huawei.com>, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org
References: <20200903021922.316760-1-yebin10@huawei.com>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <68d1c081-806a-99e9-7954-04814b84ce7b@gtsys.com.hk>
Date:   Thu, 3 Sep 2020 12:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903021922.316760-1-yebin10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 3/9/2020 10:19 am, Ye Bin wrote:
> When calculate ucr1 UCR1_TRDYEN is duplicate.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   drivers/tty/serial/imx.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index ce8c472cf385..4e6ead1f650e 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2389,8 +2389,7 @@ static int imx_uart_probe(struct platform_device *pdev)
>   
>   	/* Disable interrupts before requesting them */
>   	ucr1 = imx_uart_readl(sport, UCR1);
> -	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN |
> -		 UCR1_TRDYEN | UCR1_RTSDEN);
> +	ucr1 &= ~(UCR1_ADEN | UCR1_TRDYEN | UCR1_IDEN | UCR1_RRDYEN | UCR1_RTSDEN);
>   	imx_uart_writel(sport, ucr1, UCR1);
>   
>   	if (!imx_uart_is_imx1(sport) && sport->dte_mode) {
> 
Fixes: c514a6f848b5b ("serial: imx: use Tx ready rather than Tx empty irq")

-Chris
