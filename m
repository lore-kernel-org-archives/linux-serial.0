Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CBEC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 01:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C3461353
	for <linux-serial@archiver.kernel.org>; Fri, 21 May 2021 01:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhEUBbW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 21:31:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3452 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbhEUBbW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 21:31:22 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmTVQ3wgbzBvPR;
        Fri, 21 May 2021 09:27:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 09:29:58 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 09:29:57 +0800
Subject: Re: [PATCH 2/2] dt-bindings: serial: pl011: Avoid matching device
 tree nodes of variant pl011 drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210520115440.8259-1-thunder.leizhen@huawei.com>
 <20210520115440.8259-3-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <727009c0-e706-64e7-54be-8c05e8bc4ae7@huawei.com>
Date:   Fri, 21 May 2021 09:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210520115440.8259-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2021/5/20 19:54, Zhen Lei wrote:
> There is a variant driver of pl011, which may have a compatible string
> written as: "arm,sbsa-uart", "arm,pl011". Because it contains "arm,pl011",
> so the corresponding device tree nodes are also checked by this YAML file.
> As a result, many flase warnings similar to the following are reported:
> 
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dt.yaml:
>  serial@21c0000: compatible:0: 'arm,pl011' was expected
>  serial@21c0000: compatible:1: 'arm,primecell' was expected
> 
> Change to only check the device tree nodes that are matched exactly.

Hi, all:
  This morning I rethought, and there's something wrong with this change.
The compatibles that are incorrectly written cannot be identified, for
example, only "arm,pl011". I'll think of something else.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/serial/pl011.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
> index 5ea00f8a283d..3683e4567645 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> @@ -16,9 +16,9 @@ allOf:
>  select:
>    properties:
>      compatible:
> -      contains:
> -        enum:
> -          - arm,pl011
> +      items:
> +        - const: arm,pl011
> +        - const: arm,primecell
>    required:
>      - compatible
>  
> 

