Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D0C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 11:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED04860FBF
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 11:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbhHML3U (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 07:29:20 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:35393 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbhHML3M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 07:29:12 -0400
Received: by mail-ej1-f42.google.com with SMTP id w5so17695335ejq.2;
        Fri, 13 Aug 2021 04:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IBXCYPUTTAcQyneOGCdcbZVJIuyUOiqeKb7yjSzy5ro=;
        b=H1xeqy4Arf0Dhg0qzfQD1tqndkr0ESP+MGQdZCf4FFEZdPakxrXMeD+5MSr6QcR/L2
         UHm6RS8h+H1FSMxuk41wI/CwFks0yK41CREAi6cp2JHRhK1rDpShnfKD80Bgf8qk3BU2
         4VrSvafR8SCilYICNRWSSkvpK/qaEqemitBDdqAiKMQot1nZ1xvhtJHCIclSFanEwJzs
         wtVcVv3fWFFCvMpYs3yMoeq+upSYOKJuknFObN3LcthKj2yy9nvY1+FRT1+gkfN8al5w
         O+tjJn2WXgfysJ5esWLTlBW48PHu2BoM7cPdZhi0wRbMKNud+0u9DZZ8oRruTOpj9qKr
         F72w==
X-Gm-Message-State: AOAM531sw2I2m0iIEdrtowvfFcxzBx77NWu+zJR5ltp/sV6FKMEKqjRZ
        qDneB8/nIDlwug24Kgx2yUA=
X-Google-Smtp-Source: ABdhPJzRlKknfKMJ9vBxYJA90SRDKtySk+QkGHwljDv8+3DU07AmJnnsBAgDcecQHnDPe1G86t1KAQ==
X-Received: by 2002:a17:907:7609:: with SMTP id jx9mr1988040ejc.432.1628854124552;
        Fri, 13 Aug 2021 04:28:44 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.googlemail.com with ESMTPSA id o23sm769708eds.75.2021.08.13.04.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 04:28:43 -0700 (PDT)
To:     Chester Lin <clin@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-3-clin@suse.com>
 <1ff13837-e6ca-c476-376d-b4f80450a259@suse.de> <YRZTSJPFLFFIR+gx@linux-8mug>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <0b42dc7e-a7c1-fe41-e39a-89627d44cbe4@kernel.org>
Date:   Fri, 13 Aug 2021 13:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRZTSJPFLFFIR+gx@linux-8mug>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/08/2021 13:11, Chester Lin wrote:
> Hi Andreas,
> 
> On Thu, Aug 12, 2021 at 06:04:44PM +0200, Andreas Färber wrote:
>> On 05.08.21 08:54, Chester Lin wrote:
>>> Convert the FSL LINFlexD UART binding to json-schema.
>>>
>>> Signed-off-by: Chester Lin <clin@suse.com>
>>> ---
>>>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
>>>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++++
>>>  2 files changed, 48 insertions(+), 22 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>>>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>
>> Thanks for your effort, Chester.
>>
>>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>>> deleted file mode 100644
>>> index f1bbe0826be5..000000000000
>>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>>> +++ /dev/null
>>> @@ -1,22 +0,0 @@
>>> -* Freescale LINFlexD UART
>>> -
>>> -The LINFlexD controller implements several LIN protocol versions, as well as
>>> -support for full-duplex UART communication through 8-bit and 9-bit frames.
>>> -
>>> -See chapter 47 ("LINFlexD") in the reference manual[1].
>>> -
>>> -Required properties:
>>> -- compatible :
>>> -  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, which
>>> -    is compatible with the one integrated on S32V234 SoC
>>> -- reg : Address and length of the register set for the device
>>> -- interrupts : Should contain uart interrupt
>>> -
>>> -Example:
>>> -uart0: serial@40053000 {
>>> -	compatible = "fsl,s32v234-linflexuart";
>>> -	reg = <0x0 0x40053000 0x0 0x1000>;
>>> -	interrupts = <0 59 4>;
>>> -};
>>> -
>>> -[1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
>>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>> new file mode 100644
>>> index 000000000000..acfe34706ccb
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>>> @@ -0,0 +1,48 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>
>> Since this is dual-licensed and BSD-2-Clause would seem compatible with
>> GPLv3, this could probably be s/GPL-2.0-only/GPL-2.0-or-later/ ? Not a
>> blocker.
> 
> There's no license identifier in the original file so it's not a problem to
> choose "GPL-2.0-or-later".

That is not entirely correct. If there is no explicit license in the
file, it's kernel's default so GPL-2.0-only. You cannot relicense
derivative work without getting permission from authors and copyright
holders.

However if you did not copy the text/description from original bindings,
your work won't be derivative so you can relicense it.

Best regards,
Krzysztof
