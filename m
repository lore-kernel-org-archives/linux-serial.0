Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E95C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 02:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAA5613BC
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 02:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEFCpZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 22:45:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17467 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhEFCpX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 22:45:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FbHsS5X2nzkWph;
        Thu,  6 May 2021 10:41:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 6 May 2021
 10:44:21 +0800
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: pl011: Change to reference
 the kernel-defined serial.yaml
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210422085837.513-1-thunder.leizhen@huawei.com>
 <20210422085837.513-3-thunder.leizhen@huawei.com>
 <20210430152108.GA3344055@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7e25e190-383f-c820-47f5-54894b7e6d8a@huawei.com>
Date:   Thu, 6 May 2021 10:44:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210430152108.GA3344055@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2021/4/30 23:21, Rob Herring wrote:
> On Thu, Apr 22, 2021 at 04:58:36PM +0800, Zhen Lei wrote:
>> The /schemas/serial.yaml from dt-schema only has the property $nodename,
>> whereas the kernel-defined /schemas/serial/serial.yaml contains more
>> useful properties, support for more complex application scenarios.
>>
>> For example:
>> 1) The property "current-speed" in fsl-lx2160a.dtsi
>> 2) The subnode "bluetooth" in hi3660-hikey960.dts
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/serial/pl011.yaml | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> What about all these:

Currently, the extended attributes described in /schemas/serial/serial.yaml are
not referenced in the dts of other serial ports except pl011. So I didn't change
them. At least I run dtbs_check one by one on the ARM64 platform, no warning is
reported. Now, it seems that I was wrong, /schemas/serial/serial.yaml is applicable
to all serial ports. Even if those attributes are not currently referenced, the
reference relationship should be corrected in advance.

> 
> $ git grep 'schemas/serial.yaml'
> Documentation/devicetree/bindings/serial/8250.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/ingenic,uart.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/pl011.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/samsung_uart.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/sifive-serial.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:  - $ref: /schemas/serial.yaml#
> Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml:    $ref: /schemas/serial.yaml#
> 
> .
> 

