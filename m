Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDCC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D41613E4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 09:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhDWJzE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:55:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17397 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJzE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 05:55:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FRV2M4S8VzlYNC;
        Fri, 23 Apr 2021 17:52:27 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 23 Apr 2021
 17:54:17 +0800
Subject: Re: [PATCH] tty: serial: samsung_tty: remove set but not used
 variables
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <jirislaby@kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
References: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
 <YIKXs7WCF2zI3uvI@kroah.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <660e8905-6c5c-e076-5211-a87a62ea5c87@huawei.com>
Date:   Fri, 23 Apr 2021 17:54:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YIKXs7WCF2zI3uvI@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


在 2021/4/23 17:47, Greg KH 写道:
> On Fri, Apr 23, 2021 at 05:39:00PM +0800, Tian Tao wrote:
>> The value of 'ret' is not used, so just delete it.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/tty/serial/samsung_tty.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index d9e4b67..d269d75 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>>   			default:
>>   				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
>>   						prop);
>> -				ret = -EINVAL;
> That looks odd, shouldn't you do something with this instead of ignoring
> it???

How about this ？

diff --git a/drivers/tty/serial/samsung_tty.c 
b/drivers/tty/serial/samsung_tty.c
index d9e4b67..9fbc611 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2220,8 +2220,7 @@ static int s3c24xx_serial_probe(struct 
platform_device *pdev)
                         default:
                                 dev_warn(&pdev->dev, "unsupported 
reg-io-width (%d)\n",
                                                 prop);
-                               ret = -EINVAL;
-                               break;
+                               return -EINVAL;

> .
>

