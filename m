Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37946C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 08:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14C464F40
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 08:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhCSIje (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:39:34 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:9208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234399AbhCSIjH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 04:39:07 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12J8cEHT002008;
        Fri, 19 Mar 2021 09:38:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=66Y1jOy+i4E+OEpba8S19bATG0w9+cq/uIbqX4l/N6M=;
 b=aeI/wqqazvGmB+C7mNgMlMcVOgnyeDhb+lxlbyEuhoWnV1hHYRT2VwnsJgdPpxARATMZ
 Ip+qHXdUFtFr+HUF7Kw4s+x67amNctvHcmiDJEFqqRm/QLPsETRvxamUv93FlR9IbrLO
 Z8L3bpjYWeNSw6wyvfQ6N3SyWfr/urmB5Q9K9CaM7AJnBSECssJH6WudiKHamSm7nGKb
 ZvKbJFmkTUzm9ICbMk802yEzInHIlQe8qd8dQnbKDOd8HX+swe1BacmWHLr3CGOwJuTX
 li9OKTz9WlT/SNXrCBFOmTJTHv6XhMlyKm5Sg6hLzyT4icc/LgrkfPhbVC7DRTip4mt/ 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378pr6a6u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 09:38:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BD7310002A;
        Fri, 19 Mar 2021 09:38:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 645452257E6;
        Fri, 19 Mar 2021 09:38:40 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Mar
 2021 09:38:39 +0100
Subject: Re: [PATCH v3 9/9] dt-bindings: serial: stm32: add phandle
 'bluetooth' to fix dtbs_check warrning
To:     dillon min <dillon.minfei@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>,
        <afzal.mohd.ma@gmail.com>, <gregkh@linuxfoundation.org>,
        <erwan.leray@st.com>, <erwan.leray@foss.st.com>,
        <linux-serial@vger.kernel.org>, <lkp@intel.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
 <CAL9mu0Lfj+n4uk2rT8QnDtRveHn2gLx4ut6fLCByt0w9e08vwQ@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <01c9f635-7b2b-fc9c-3cf9-6d7f425d683e@foss.st.com>
Date:   Fri, 19 Mar 2021 09:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0Lfj+n4uk2rT8QnDtRveHn2gLx4ut6fLCByt0w9e08vwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_02:2021-03-17,2021-03-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dillon

On 3/19/21 5:28 AM, dillon min wrote:
> No changes, Just loop lkp in.
> 
> 
> Hi lkp,
> 
> Sorry for the late reply, thanks for your report.
> This patch is to fix the build warning message.
> 
> Thanks.
> Regards
> 
> On Mon, Mar 15, 2021 at 5:45 PM <dillon.minfei@gmail.com> wrote:
>>
>> From: dillon min <dillon.minfei@gmail.com>
>>
>> when run make dtbs_check with 'bluetoothi brcm,bcm43438-bt'
>> dts enabled on stm32h7, there is a warrning popup:
>>
>>>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
>>     does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> to make dtbs_check happy, so add a phandle bluetooth
>>
>> Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>   Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
>> index 8631678283f9..5e674840e62d 100644
>> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
>> @@ -50,6 +50,11 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>
>> +  bluetooth:
>> +    type: object
>> +    description: |
>> +      phandles to the usart controller and bluetooth
>> +

Do we really need to add this "generic" property here ? You could test 
without the "AditionalProperties:False".

Regards
Alex


>>   # cts-gpios and rts-gpios properties can be used instead of 'uart-has-rtscts'
>>   # or 'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
>>   # control instead of dedicated pins.
>> --
>> 1.9.1
>>
