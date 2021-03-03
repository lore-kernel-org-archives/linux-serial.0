Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A1C432C3
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6015B64EEE
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbhCDAAC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42740 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233449AbhCCRZl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 12:25:41 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123HI5r2010143;
        Wed, 3 Mar 2021 18:23:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VZlYydjoa19ZfjiGy/7lae6d4RmJH4yQmK8Bw6psmbI=;
 b=Wg3ENRICMBCFHPNUtQPnFZC83FWwJbdPyPaY5UsoYMtvOIvB23fu7ukniD+S77ZcpysY
 8tDhE1lAqGIq+/Djb1ml0SkXuXtaeYRLyGGAkErLEcxnmfeUEshPbey1k3/DXzQiOAhL
 6VMJZrytZ85knSx6Gr6BgtBz6kT4NSGAuYPPLFuurg5Vpe2CbEVGokG53gMlplcj+Jwk
 JWA6akb4QX3MdTencFg/WWxjXSw5q5dpDF3NVAVHfLsvghFPl0VUkN7iYxQwdD+Jxsex
 mlqW6RwVUroKM3S4+pv3thNPyUeXMR0UlPQI+BlioeMq2T6FjbQQhyQS1J/M7v6odhsx FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yf9qaac5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 18:23:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43B82100034;
        Wed,  3 Mar 2021 18:23:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2412520CE3A;
        Wed,  3 Mar 2021 18:23:27 +0100 (CET)
Received: from [10.211.2.167] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Mar
 2021 18:23:25 +0100
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
To:     Martin Devera <devik@eaxlabs.cz>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <aeefa74e-fa19-6c31-5240-0f14fca89298@foss.st.com>
 <20210302190303.28630-1-devik@eaxlabs.cz>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <86ae0975-0f6b-f121-09c4-d909f081a635@foss.st.com>
Date:   Wed, 3 Mar 2021 18:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302190303.28630-1-devik@eaxlabs.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_05:2021-03-03,2021-03-03 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/2/21 8:03 PM, Martin Devera wrote:
> Add new rx-tx-swap property to allow for RX & TX pin swapping.
> 
> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 32 +++++++++++++++-------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 

Hi Martin,

I'm only wondering on moving the allOf and the st,hw-flow-ctrl prop. But
others may comment on this.

Feel free to add my:
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks!
Fabrice

> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> index 8631678283f9..6eab2debebb5 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> @@ -9,9 +9,6 @@ maintainers:
>  
>  title: STMicroelectronics STM32 USART bindings
>  
> -allOf:
> -  - $ref: rs485.yaml
> -
>  properties:
>    compatible:
>      enum:
> @@ -40,6 +37,10 @@ properties:
>  
>    uart-has-rtscts: true
>  
> +  rx-tx-swap:
> +    type: boolean
> +    maxItems: 1
> +
>    dmas:
>      minItems: 1
>      maxItems: 2
> @@ -66,13 +67,24 @@ properties:
>    linux,rs485-enabled-at-boot-time: true
>    rs485-rx-during-tx: true
>  
> -if:
> -  required:
> -    - st,hw-flow-ctrl
> -then:
> -  properties:
> -    cts-gpios: false
> -    rts-gpios: false
> +allOf:
> +  - $ref: rs485.yaml
> +  - if:
> +      required:
> +        - st,hw-flow-ctrl
> +    then:
> +      properties:
> +        cts-gpios: false
> +        rts-gpios: false
> +  - if:
> +      required:
> +        - rx-tx-swap
> +    then:
> +      properties:
> +        compatible:
> +          enum:
> +            - st,stm32f7-uart
> +            - st,stm32h7-uart
>  
>  required:
>    - compatible
> 
