Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB2C47082
	for <linux-serial@archiver.kernel.org>; Mon, 24 May 2021 02:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6457561104
	for <linux-serial@archiver.kernel.org>; Mon, 24 May 2021 02:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhEXCNg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 May 2021 22:13:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhEXCNg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 May 2021 22:13:36 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpLHd6kfhzkY69;
        Mon, 24 May 2021 10:09:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 10:12:07 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 10:12:07 +0800
Subject: Re: [PATCH 2/2] dt-bindings: serial: pl011: Avoid matching device
 tree nodes of variant pl011 drivers
To:     Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210520115440.8259-1-thunder.leizhen@huawei.com>
 <20210520115440.8259-3-thunder.leizhen@huawei.com>
 <CAL_Jsq+XYATKC=y+=wFHtfVB634Mb_Y5xC969UMyDc4Z9W8x4A@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <63a68e34-6778-c543-bb37-1cce94d8e4a0@huawei.com>
Date:   Mon, 24 May 2021 10:12:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+XYATKC=y+=wFHtfVB634Mb_Y5xC969UMyDc4Z9W8x4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 2021/5/22 2:54, Rob Herring wrote:
> On Thu, May 20, 2021 at 6:54 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> There is a variant driver of pl011, which may have a compatible string
>> written as: "arm,sbsa-uart", "arm,pl011". Because it contains "arm,pl011",
>> so the corresponding device tree nodes are also checked by this YAML file.
>> As a result, many flase warnings similar to the following are reported:
>>
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dt.yaml:
>>  serial@21c0000: compatible:0: 'arm,pl011' was expected
>>  serial@21c0000: compatible:1: 'arm,primecell' was expected
> 
> The DT is wrong. The h/w is either a PL011 or it isn't. If it is, then
> the compatible should be '"arm,pl011", "arm,primecell"'. There is no
> point in making it 'arm,sbsa-uart' as the PL011 (and OS support for
> it) predate SBSA (by a lot). If it is not a PL011 and only the SBSA
> subset, then it should be "arm,sbsa-uart".

Yes, I agree. I'll send a patch to fix the freescale's dts.

arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:923:                 compatible = "arm,sbsa-uart","arm,pl011";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:931:                 compatible = "arm,sbsa-uart","arm,pl011";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:939:                 compatible = "arm,sbsa-uart","arm,pl011";
arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:947:                 compatible = "arm,sbsa-uart","arm,pl011";
arch/arm64/boot/dts/hisilicon/hip07.dtsi:1242:                      compatible = "arm,sbsa-uart";


> 
> Rob
> 
> .
> 

