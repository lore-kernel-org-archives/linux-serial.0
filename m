Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97055C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 02:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D7613B5
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 02:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhEFCJ7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 22:09:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17589 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEFCJ7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 22:09:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FbH4d4KqQz1BHys;
        Thu,  6 May 2021 10:06:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Thu, 6 May 2021
 10:08:59 +0800
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Normalize the node name of
 the serial port
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
 <20210422085837.513-2-thunder.leizhen@huawei.com>
 <20210430151825.GA3339934@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f50b1b84-cac1-0f2e-4821-5e1c76af5e31@huawei.com>
Date:   Thu, 6 May 2021 10:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210430151825.GA3339934@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2021/4/30 23:18, Rob Herring wrote:
> On Thu, Apr 22, 2021 at 04:58:35PM +0800, Zhen Lei wrote:
>> Only letters, digits, and commas that describe the base address of the
>> serial port in hexadecimal format are allowed.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
>> index 65e75d040521..71aec7fda07d 100644
>> --- a/Documentation/devicetree/bindings/serial/serial.yaml
>> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
>> @@ -21,7 +21,7 @@ description:
>>  
>>  properties:
>>    $nodename:
>> -    pattern: "^serial(@.*)?$"
>> +    pattern: "^serial(@[0-9a-f,]+)?$"
> 
> The format of unit-addresses is dictated by the bus (parent), so this is 
> the wrong place to enforce this. 

Okay, so I'll leave this place unchanged.

> 
> Rob
> 
> .
> 

