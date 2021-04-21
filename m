Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D997C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C2C61448
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbhDUJiv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:38:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16487 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbhDUJiv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:38:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQFmB2XhhztWfr;
        Wed, 21 Apr 2021 17:35:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 21 Apr 2021
 17:38:12 +0800
Subject: Re: [PATCH 1/1] dt-bindings: serial: Add label property for pl011
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210415073105.3687-1-thunder.leizhen@huawei.com>
 <20210420200246.GA3717650@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fa6c6079-8061-5774-8252-31956ac84ae2@huawei.com>
Date:   Wed, 21 Apr 2021 17:38:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210420200246.GA3717650@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2021/4/21 4:02, Rob Herring wrote:
> On Thu, Apr 15, 2021 at 03:31:05PM +0800, Zhen Lei wrote:
>> When there is more than one pl011 serial port present, the label property
>> allows a custom name to be used for briefly describe the usage or position
>> of each serial port.
>>
>> Without this "label" property, many dtbs_check warnings similar to the
>> following are reported:
>> arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dt.yaml: \
>> serial@ffd74000: Additional properties are not allowed ('label' was unexpected)
>>         From schema: Documentation/devicetree/bindings/serial/pl011.yaml
> 
> I think this should go into serial.yaml instead.

Yes，But if I add "label: true" into serial.yaml, it doesn't work. I haven't figured out why.

By the way, should "$ref: /schemas/serial.yaml#" be replaced with "$ref: /schemas/serial/serial.yaml#"?

> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/serial/pl011.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
>> index 1f8e9f2644b6b80..303c7746423f503 100644
>> --- a/Documentation/devicetree/bindings/serial/pl011.yaml
>> +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
>> @@ -34,6 +34,9 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  label:
>> +    maxItems: 1
> 
> label is always a single string and so 'maxItems' is always 1. Just 
> need:
> 
> label: true

OK

> 
>> +
>>    interrupts:
>>      maxItems: 1
>>  
>> -- 
>> 2.26.0.106.g9fadedd
>>
>>
> 
> .
> 

