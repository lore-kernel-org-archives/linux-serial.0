Return-Path: <SRS0=IZPE=C4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639AAC43464
	for <linux-serial@archiver.kernel.org>; Sat, 19 Sep 2020 02:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BD120789
	for <linux-serial@archiver.kernel.org>; Sat, 19 Sep 2020 02:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISC0q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Sep 2020 22:26:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgISC0q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Sep 2020 22:26:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90745AFC71EE37155C7E;
        Sat, 19 Sep 2020 10:26:43 +0800 (CST)
Received: from [10.174.176.211] (10.174.176.211) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:26:39 +0800
Subject: Re: [PATCH -next] tty: serial: imx: fix link error with
 CONFIG_SERIAL_CORE_CONSOLE=n
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200918091305.3822598-1-yangyingliang@huawei.com>
 <20200918111658.GB2242974@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <d39572f9-2f18-384e-ebc2-21a046c5986f@huawei.com>
Date:   Sat, 19 Sep 2020 10:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200918111658.GB2242974@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 2020/9/18 19:16, Greg KH wrote:
> On Fri, Sep 18, 2020 at 05:13:05PM +0800, Yang Yingliang wrote:
>> Fix the link error by selecting SERIAL_CORE_CONSOLE.
>>
>> aarch64-linux-gnu-ld: drivers/tty/serial/imx_earlycon.o: in function `imx_uart_console_early_write':
>> imx_earlycon.c:(.text+0x84): undefined reference to `uart_console_write'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/tty/serial/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 9631ccf43378..1044fc387691 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -521,6 +521,7 @@ config SERIAL_IMX_EARLYCON
>>   	depends on ARCH_MXC || COMPILE_TEST
>>   	depends on OF
>>   	select SERIAL_EARLYCON
>> +	select SERIAL_CORE_CONSOLE
>>   	help
>>   	  If you have enabled the earlycon on the Freescale IMX
>>   	  CPU you can make it the earlycon by answering Y to this option.
>> -- 
>> 2.25.1
>>
> What caused this build error to start happening?  Any pointers to the
> specific commit?

It's start from 699cc4dfd140 ("tty: serial: imx: add imx earlycon 
driver"), the driver

uses the uart_console_write(), but SERIAL_CORE_CONSOLE is not selected, 
so uart_console_write

is not defined, then we get the error.

>
> thanks,
>
> greg k-h
> .
