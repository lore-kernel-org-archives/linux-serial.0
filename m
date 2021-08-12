Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC54C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B6D60FC0
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 15:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhHLPyy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 11:54:54 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:35485 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbhHLPyy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 11:54:54 -0400
Received: by mail-ej1-f50.google.com with SMTP id w5so12511546ejq.2;
        Thu, 12 Aug 2021 08:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHqYhReooo30zb8LL9lFKdY9y7F/PVOeVzdjs8SkhdY=;
        b=CEz6cPrNISRWeebn1JShmPOdGdiUUvfWQMNZ6SSI+fhF/Y5MIBtEWeJqxapPNphuC6
         frjAl/pOeIKhwp058MkYgMAksdsW58h4TQ9o4Ku4Je71fzyNLD+FFzB6uMmmjMljjsCC
         RutaBmIwPR10C3kxf2T0uNdz71/A75SQVr3oZGF6nP+/7XQxTxbS/NLR3zR6VfTniC1j
         MGP8bLycxaPsLhTMHIbpmWJL+3srwqnbKnn0s2pkm8Lh3z42fXKU3TybIV0Geg31Vrms
         pU238l7+KNIE9pzs1sJIHtvGVnZoWDDWsB52qnTa1lAH7We12s5vt+0Jox4im6fHHHSX
         53vg==
X-Gm-Message-State: AOAM530xDrgEjsQdulhLdzeoq0W2JOj/RxFoyXfiQSE3yr76g2HL5lQ6
        8JKWgCbSIEtqfIF+uRuPsqo=
X-Google-Smtp-Source: ABdhPJz7ZDXm52HEpswiPiu6k4yJZib8V0zYLDvzytdiDCa4MewFXtlggPHQz+7453yfBwUBysQHZA==
X-Received: by 2002:a17:906:3a46:: with SMTP id a6mr4301854ejf.147.1628783667346;
        Thu, 12 Aug 2021 08:54:27 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.googlemail.com with ESMTPSA id r27sm1299893edb.66.2021.08.12.08.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:54:26 -0700 (PDT)
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <20210805065429.27485-9-clin@suse.com>
 <32310c2a-9800-8b04-b6ac-d8ada044c0f8@kernel.org>
 <20210809080346.GO30984@dragon>
 <3c65f75d-724f-a438-1e22-6baeb745a8e5@suse.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 8/8] MAINTAINERS: Add an entry for NXP S32G2 boards
Message-ID: <fab0d8a6-515a-86a8-daa3-12f37bdf004d@kernel.org>
Date:   Thu, 12 Aug 2021 17:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3c65f75d-724f-a438-1e22-6baeb745a8e5@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/08/2021 17:30, Andreas Färber wrote:
> Hello Shawn and Krzysztof,
> 
> On 09.08.21 10:03, Shawn Guo wrote:
>> On Thu, Aug 05, 2021 at 09:49:51AM +0200, Krzysztof Kozlowski wrote:
>>> On 05/08/2021 08:54, Chester Lin wrote:
>>>> Add a new entry for the maintenance of NXP S32G2 DT files.
>>>>
>>>> Signed-off-by: Chester Lin <clin@suse.com>
>>>> ---
>>>>  MAINTAINERS | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 36aee8517ab0..3c6ba6cefd8f 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2281,6 +2281,12 @@ F:	arch/arm/boot/dts/nuvoton-wpcm450*
>>>>  F:	arch/arm/mach-npcm/wpcm450.c
>>>>  F:	drivers/*/*wpcm*
>>>>  
>>>> +ARM/NXP S32G2 ARCHITECTURE
> 
> Suggestion from NXP is to use the broader S32G name.
> 
>>>> +M:	Chester Lin <clin@suse.com>
>>>> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>>> +S:	Maintained
>>>> +F:	arch/arm64/boot/dts/freescale/s32g2*
>>>
>>> I support the idea of sub-sub-architecture maintainers but I think idea
>>> of in-file addresses was preferred:
>>> https://lore.kernel.org/lkml/20200830122922.3884-1-shawnguo@kernel.org/
> 
> I had specifically asked Chester to add a MAINTAINERS section.
> 
> Is your apparent suggestion of not accepting this MAINTAINERS patch
> based on the assumption that we're dealing with only one email address
> in three files? What do you see as the threshold to warrant a section?
> 
> From my point of view, above MAINTAINERS entry is incomplete, as we
> should CC the full team working on S32G for patch review, not just
> Chester himself.
> So that would in my mind have been additional R: and L: entries in that
> MAINTAINERS section.

I assumed this is a sub-sub-architecture (something coming from
Layerscape or i.MX) but it seems it's not, therefore I don't mind having
separate entry in MAINTAINERS. The idea of in-file maintainers was for
specific boards and SoCs belonging to existing sub-architectures.

I agree with your following reasons.

> 
>> Thanks for reminding that the patch didn't land.  I just resent it with
>> your Reviewed-by tag added.  Thanks!
> 
> Your above patch does not make clear to me what syntax we should use for
> adding email addresses to .dts[i] files now:
> 
> https://lore.kernel.org/lkml/20210809081033.GQ30984@dragon/
> 
> Especially when not dealing with file authors.
> 
> I get the impression it is not a replacement for an F: wildcard used in
> MAINTAINERS, but rather a complement?
> 
> Please understand that this is not about a single .dts file, as your
> patch suggests, but about a complete SoC family consisting of s32g*.dts*
> as well as in the future drivers specific to this platform. It seems way
> easier to specify the list of maintainers/reviewers in MAINTAINERS once
> with suitable wildcard paths, than copying them into each and every
> .dtsi and .dts file and driver .c/.h and later needing to sync multiple
> places. If a bot or user has fixes or cleanups for the S32G code, we
> want to know about it, so that NXP can consider it for their BSP
> branches and SUSE for our SLE branches, and obviously for follow-up
> patch series that are already in the works and waiting on this one.
> 
> Once merged, I would expect Chester or someone from NXP to set up an
> S32G tree on kernel.org that gets integrated into linux-next and sends
> pull requests to the SoC tree maintainers without bothering i.MX and
> Layerscape maintainers. Did you handle that differently for S32V?
> 
> Thanks,
> Andreas
> 
> P.S. Have you checked or considered whether your script change might
> start to CC non-existing email addresses, since we wouldn't be allowed
> to remove them from copyright or authorship statements to prevent that?

The same can happen for DT bindings maintainers.

Best regards,
Krzysztof
