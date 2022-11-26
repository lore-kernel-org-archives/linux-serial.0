Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342AAC4167B
	for <linux-serial@archiver.kernel.org>; Sat, 26 Nov 2022 02:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKZCYj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Nov 2022 21:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKZCYh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Nov 2022 21:24:37 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A91CFD9;
        Fri, 25 Nov 2022 18:24:36 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJwXG5FSDzmW93;
        Sat, 26 Nov 2022 10:23:58 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 10:24:33 +0800
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 10:24:33 +0800
Subject: Re: [PATCH] serial: tegra: Add missing clk_disable_unprepare() in
 tegra_uart_hw_init()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <thierry.reding@gmail.com>
References: <20221125101109.175394-1-yiyang13@huawei.com>
 <43480917-dbe8-2b0c-3806-00f142d417d4@wanadoo.fr>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <61a1607c-78df-db03-0df5-34f108c6f554@huawei.com>
Date:   Sat, 26 Nov 2022 10:24:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <43480917-dbe8-2b0c-3806-00f142d417d4@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2022/11/25 19:19, Christophe JAILLET wrote:
> Le 25/11/2022 à 11:11, Yi Yang a écrit :
>> Add the missing clk_disable_unprepare() before return from
>> tegra_uart_hw_init() in the error handling path.
>>
>> Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message 
>> when an error occurs")
>> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
>> Signed-off-by: Yi Yang <yiyang13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/tty/serial/serial-tegra.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> 
> Hi,
> 
> I think that it is also missing in tegra_uart_startup() if an error 
> occurs after a successful tegra_uart_hw_init() call.
> 
> Or maybe (based on function mane) tegra_uart_hw_deinit() should called 
> there.
> 
> Just my 2c.
> 
> CJ
> 

Thanks! I will fix it in v2 patch.

> 
>> diff --git a/drivers/tty/serial/serial-tegra.c 
>> b/drivers/tty/serial/serial-tegra.c
>> index e5b9773db5e3..abc5039eb273 100644
>> --- a/drivers/tty/serial/serial-tegra.c
>> +++ b/drivers/tty/serial/serial-tegra.c
>> @@ -1046,6 +1046,7 @@ static int tegra_uart_hw_init(struct 
>> tegra_uart_port *tup)
>>       if (tup->cdata->fifo_mode_enable_status) {
>>           ret = tegra_uart_wait_fifo_mode_enabled(tup);
>>           if (ret < 0) {
>> +            clk_disable_unprepare(tup->uart_clk);
>>               dev_err(tup->uport.dev,
>>                   "Failed to enable FIFO mode: %d\n", ret);
>>               return ret;
>> @@ -1067,6 +1068,7 @@ static int tegra_uart_hw_init(struct 
>> tegra_uart_port *tup)
>>        */
>>       ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
>>       if (ret < 0) {
>> +        clk_disable_unprepare(tup->uart_clk);
>>           dev_err(tup->uport.dev, "Failed to set baud rate\n");
>>           return ret;
>>       }
> 
> .
