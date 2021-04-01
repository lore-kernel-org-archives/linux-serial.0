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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC27C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453C96108B
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 08:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDAIBC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 04:01:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18740 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229459AbhDAIAd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 04:00:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1317wSqH018320;
        Thu, 1 Apr 2021 10:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dQQnehMvfeIOz8ToW7gRQOcCaUxuauDw8fWY91KRE5w=;
 b=rc1H6xJM1rGiAC/BHBzMsQwt+ou0S+D//o7AuRm0P4C/7cVAu1dd56gnHrUrqsNrsewp
 LtnHvHORx+JG1byuqwX4RhYHUuTslv4SiDvWCjWUvr9fb6PCjiyZfvOx1hjAJq6YF7Oo
 wJFEqYIWDNfrvrBLDyHvo1YDghz8Jh6pDV+BxVB1CupWyA/VyybYYsFOXloQJ5puaKRt
 Mq/NxfIGuxpchHoRa2CQnRvLqa5gyAWCNWM1zu82OMbUDfLJwXoOw1CajIDQmCKafEVC
 NXtsBYDpAUtEneT/8wFNWnIWt1SVjFbjJGxrsmS7mEiIqV8kjs7ivDkqmhuDyE+BV3Bo yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37n296tbht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 10:00:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3534A100034;
        Thu,  1 Apr 2021 09:59:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E586F21B399;
        Thu,  1 Apr 2021 09:59:58 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Apr
 2021 09:59:57 +0200
Subject: Re: [PATCH v9 0/6] ARM: STM32: add art-pi(stm32h750xbh6) board
 support
To:     <dillon.minfei@gmail.com>, <robh@kernel.org>,
        <valentin.caron@foss.st.com>, <rong.a.chen@intel.com>,
        <a.fatoum@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <afzal.mohd.ma@gmail.com>, <gregkh@linuxfoundation.org>,
        <erwan.leray@foss.st.com>, <erwan.leray@st.com>,
        <linux-serial@vger.kernel.org>, <lkp@intel.com>,
        <patrice.chotard@foss.st.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <pali@kernel.org>,
        <mchehab+huawei@kernel.org>, <andrew@lunn.ch>
References: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <50cee64f-a264-4073-bafa-1e6775608169@foss.st.com>
Date:   Thu, 1 Apr 2021 09:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_03:2021-03-31,2021-04-01 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dillon

On 3/31/21 10:28 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patchset intend to add art-pi board support, this board developed
> by rt-thread(https://www.rt-thread.org/).
> 
> Board resources:
> 8MiB QSPI flash
> 16MiB SPI flash
> 32MiB SDRAM
> AP6212 wifi,bt,fm comb
> 
> sw context:
> - as stm32h750 just has 128k bytes internal flash, so running a fw on
>    internal flash to download u-boot/kernel to qspi flash, boot
>    u-boot/kernel from qspi flash. this fw is based on rt-thread.
> - kernel can be xip on qspi flash or load to sdram
> - root filesystem is jffs2(created by buildroot), stored on spi flash
> 
> to support the boad, add following changes.
> - fix r0-r3, r12 register restore failed after svc call,
> - add dts binding
> - update yaml doc
> 

Thanks for adding this new STM32 MCU board. Series applied on 
stm32-next. As discussed I made some changes applying the series.

Regards
Alex



> ---
> changes in v9:
> - move gpio{a..k} entries from stm32h7-pinctrl.dtsi to stm32h743.dtsi
> v8 link:
> https://lore.kernel.org/lkml/1617094704-10040-1-git-send-email-dillon.minfei@gmail.com/
> 
> changes in v8:
> - drop '[PATCH v7 3/6] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
>    support stm32h750' - stm32h743-pinctrl.dtsi file
> - move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
>    to stm32h743.dtsi
> - update stm32h743i-{dico/eval}.dtsi to include stm32h7-pinctrl.dtsi
> - move file stm32h743.dtsi submit position to [PATCH V8 3/6]
> v7 link:
> https://lore.kernel.org/lkml/1617071338-9436-1-git-send-email-dillon.minfei@gmail.com/
> 
> changes in v7:
> - remove changes in
>    Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
>    Hi Rob Herring
>    as you has already ack this patch, please ignore it. thanks
>    history link:
>    https://lore.kernel.org/lkml/1614758717-18223-4-git-send-email-dillon.minfei@gmail.com/
>    https://lore.kernel.org/lkml/20210308195033.GA2855292@robh.at.kernel.org/
> - remove "[PATCH v6 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support"
>    remove "[PATCH v6 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi"
> - reference to stm32h743-pinctrl.dtsi in stm32h750i-art-pi.dts
> v6 link:
> https://lore.kernel.org/lkml/1616757302-7889-1-git-send-email-dillon.minfei@gmail.com/
> 
> changes in v6:
> - add gpiox{gpio-ranges, ngpios} in stm32h7-pinctrl.dtsi
> - add status="disabled" in stm32h743.dtsi
> 
> changes in v5:
> - accroding to rob's suggestion, replace false with 'type: object'
>    of 'additionalProperties'.
> - add Tested-by: Valentin Caron <valentin.caron@foss.st.com>
> 
> changes in v4:
> - use unevaluatedProperties: false to fix dtbs_check warrnings instead of
>    add 'bluetooth' in st,stm32-uart.yaml
> 
> changes in v3:
> - fix dtbs_check warrning: (8002cbd78fd5 and 4bc21d3dd678)
>    >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller:
>       {'type': 'object'} is not allowed for {'#address-cells': [[1]], '#size-cells':
>       [[1]], 'ranges': [[0,
> 
>    >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: 'i2c@40005C00',
>       'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$',
>       '^[^@]+$', 'pinctrl-[0-9]+'
>    >> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
>       'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> changes in v2:
> - reorganize the pinctrl device tree about
>    stm32h7-pinctrl/stm32h743/750-pinctrl
>    stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
>                           |                          |-> stm32h743i-eval.dts
>                           |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
>    same to the stm32f7/f4's pinctrl style
> - fix author name/copyright mistake
> - add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
>    have same pin alternate functions, update Kconfig description
> - make item in stm32h750i-art-pi.dts sort by letter
> 
> *** BLURB HERE ***
> 
> dillon min (6):
>    Documentation: arm: stm32: Add stm32h750 value line doc
>    dt-bindings: arm: stm32: Add compatible strings for ART-PI board
>    ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
>    ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
>    ARM: stm32: Add a new SOC - STM32H750
>    dt-bindings: serial: stm32: Use 'type: object' instead of false for
>      'additionalProperties'
> 
>   Documentation/arm/index.rst                        |   1 +
>   Documentation/arm/stm32/stm32h750-overview.rst     |  34 +++
>   .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
>   .../devicetree/bindings/serial/st,stm32-uart.yaml  |   3 +-
>   arch/arm/boot/dts/Makefile                         |   1 +
>   arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 275 ++++++++++++++++++
>   arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 306 ---------------------
>   arch/arm/boot/dts/stm32h743.dtsi                   | 176 +++++++++++-
>   arch/arm/boot/dts/stm32h743i-disco.dts             |   2 +-
>   arch/arm/boot/dts/stm32h743i-eval.dts              |   2 +-
>   arch/arm/boot/dts/stm32h750.dtsi                   |   6 +
>   arch/arm/boot/dts/stm32h750i-art-pi.dts            | 229 +++++++++++++++
>   arch/arm/mach-stm32/board-dt.c                     |   1 +
>   13 files changed, 729 insertions(+), 311 deletions(-)
>   create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
>   create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
>   delete mode 100644 arch/arm/boot/dts/stm32h743-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
>   create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts
> 
