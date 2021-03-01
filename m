Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A398C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  1 Mar 2021 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE64C64E38
	for <linux-serial@archiver.kernel.org>; Mon,  1 Mar 2021 10:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhCAKhR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:37:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40515 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234531AbhCAKhP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Mar 2021 05:37:15 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121AVgYH020544;
        Mon, 1 Mar 2021 11:36:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=i63qanHvq06PqbvkfcT0nX7SZDJtNaIWa9wC1GqN/1g=;
 b=UTWhfdYTlpHgopZiO+LUtNP+V5RR/XNoWjs1q7hmvdyeNqAyDzRdYj7JkCZRIoZW811C
 xPWbHraa2tqB+Zen4IeVTL0iGQxHMhwPZE8DBW6I980t4IJjwDfB4I0VaJPh7/54CMWg
 BwxxWaXujlhXGRVENLNRkTDk+xbUdviNH6qVZA1MN5nEcMoLB/vm2/uFTD3qmfdCJp5i
 FWRX49w3xB2WHO84IfQaQ2c7JULqQ/AvpRI9s3d8Rn9va99vY5e1vAXaxogAb3tnmZ/u
 dxuGr9IXIfdGwIQNNMDN8EX3DCh6iDHCZUxzZtuW6D4SmsCH/PWX+tubbvAJ6KEjNP9r Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfc3k9tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 11:36:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1AEB3100034;
        Mon,  1 Mar 2021 11:36:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07CFA227E04;
        Mon,  1 Mar 2021 11:36:16 +0100 (CET)
Received: from [10.211.4.172] (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Mar
 2021 11:36:14 +0100
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
To:     Martin Devera <devik@eaxlabs.cz>, <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Le Ray <erwan.leray@st.com>
References: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
 <20210227164157.30971-1-devik@eaxlabs.cz>
 <20210227164157.30971-2-devik@eaxlabs.cz>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <fecd3c15-7796-7c12-6aaa-d77c7407980d@foss.st.com>
Date:   Mon, 1 Mar 2021 11:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210227164157.30971-2-devik@eaxlabs.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_05:2021-02-26,2021-03-01 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2/27/21 5:41 PM, Martin Devera wrote:
> Add new rx-tx-swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> index 8631678283f9..45f2a19997da 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> @@ -40,6 +40,10 @@ properties:
>  
>    uart-has-rtscts: true
>  
> +  rx-tx-swap:
> +    type: boolean
> +    maxItems: 1
> +

Hi Martin,

This could be restricted to st,stm32f7-uart and st,stm32h7-uart
compatibles. This option isn't available on stm32f4 (e.g. st,stm32-uart
compatible)

Thanks for your patch,
Best Regards,
Fabrice

>    dmas:
>      minItems: 1
>      maxItems: 2
> 
