Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7EFC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  9 Sep 2021 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819796124D
	for <linux-serial@archiver.kernel.org>; Thu,  9 Sep 2021 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhIIMrj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:47:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351358AbhIIMk5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Sep 2021 08:40:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B57B2214F;
        Mon,  6 Sep 2021 20:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630960699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qtuu4/ZPScsVk6rGAAsM4l/yhJ6XWgzmUIpitKEkZE=;
        b=bwx6AwVxePnGeA6sHWnTWHmHziRJ7BLWg+YFvI43c+9oIARjqF2O0sdzks5278D3uRNkfg
        1HuKMeucmzCYtRxdLhx4Xp7IFJRicVs5xWrHRu/WNlGPAZgs8paH+BAZ1cf/VvTgeoTwn0
        PPOtI3GCs+KtyHDZE2ND9WN5p+QWavM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630960699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qtuu4/ZPScsVk6rGAAsM4l/yhJ6XWgzmUIpitKEkZE=;
        b=KS0j4zjdKNgfJDJQBZd5xPEIT3ALT8vriz2BhZFM1uLDD+j3XcneLhcPFc7nA0mXk+le66
        WEu5tg/L+FwByNDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7ADCE13313;
        Mon,  6 Sep 2021 20:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LbxWHDp8NmHHIwAAGKfGzw
        (envelope-from <afaerber@suse.de>); Mon, 06 Sep 2021 20:38:18 +0000
Message-ID: <11f8b913-1057-7d30-e936-f27483f9a6e2@suse.de>
Date:   Mon, 6 Sep 2021 22:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Content-Language: en-US
To:     Chester Lin <clin@suse.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Rob Herring <robh@kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-2-clin@suse.com> <YRaxt1LCF+hWaMJU@robh.at.kernel.org>
 <YR0akXYPYthDuvCh@linux-8mug>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <YR0akXYPYthDuvCh@linux-8mug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chester,

On 18.08.21 16:34, Chester Lin wrote:
> On Fri, Aug 13, 2021 at 12:53:59PM -0500, Rob Herring wrote:
>> On Thu, Aug 05, 2021 at 02:54:22PM +0800, Chester Lin wrote:
>>> Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
>>> design 2 board ( S32G-VNP-RDB2).
>>>
>>> Signed-off-by: Chester Lin <clin@suse.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index e2097011c4b0..3914aa09e503 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -983,6 +983,13 @@ properties:
>>>            - const: solidrun,lx2160a-cex7
>>>            - const: fsl,lx2160a
>>>  
>>> +      - description: S32G2 based Boards
>>> +        items:
>>> +          - enum:
>>> +              - fsl,s32g274a-evb
>>> +              - fsl,s32g274a-rdb2
>>> +          - const: fsl,s32g2
>>
>> Given this is an entirely different family from i.MX and new?, shouldn't 
>> it use 'nxp' instead of 'fsl'? Either way,
> 
> It sounds good and Radu from NXP has mentioned a similar idea for the
> compatible string of linflexuart. To keep the naming consistency, should we
> change all 'fsl' to 'nxp' as well?

I assume that question was just unclearly phrased, so for the record:

ABI stability rules forbid us from changing "all 'fsl'" in compatible
strings or property names.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/ABI.rst

Deployed firmware providing mainline-merged platforms with DTBs using
fsl prefix (e.g., the quoted LX2160A) needs to continue working with
newer drivers, and deployed mainline Linux should continue working after
firmware updates that modify the DTB provided to Linux.

So, if NXP wants to use nxp prefix for new S32G bindings, you can do
that for your additions only, but for LINFlexD UART (3/8) you will still
need to use fsl for the "historical" S32V binding used as fallback.

Please keep S32G consistent with itself - so if we decide on nxp here,
we should apply it to SoC, boards, LINFlexD and any future peripherals.

> For example, we could rename the fsl.yaml
> to nxp.yaml.

Since other people might be contributing i.MX boards etc. to that file,
better not make your patch series conflict with other people's patches,
so that it can get merged and we can move on to the next patchsets.

The schema filename is not ABI, so it can be renamed later.

The .dtb path may become ABI (e.g., U-Boot $fdtfile), thus my comment
about consciously deciding between freescale/ vs. nxp/ subdirectory.

> However, changing all of them would cause some impacts, which will
> need more verifications on new strings. Otherwise we would have to tolerate the
> naming differences only used by s32g2.

I fear tolerating the mess one way or another is the only viable way.
Otherwise both bindings and drivers would need duplication for backwards
compatibility, for no good reason - Freescale was acquired back in 2015.

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
