Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2AC43219
	for <linux-serial@archiver.kernel.org>; Tue,  7 Sep 2021 08:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2199610FE
	for <linux-serial@archiver.kernel.org>; Tue,  7 Sep 2021 08:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242828AbhIGJAV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:00:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57262 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbhIGJAS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Sep 2021 05:00:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A95481FE19;
        Tue,  7 Sep 2021 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631005151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67kAHH5xohVl5jt4+A4YLbZP3+bIJFVJRf3g+DvSKqI=;
        b=K933s0Hnyg728XU0LhiQ05M5kWTAbdU+QwfXXgLawP80b2RRouVt48GZafKuvI3OLzAEBw
        AgRBbQKl48zD3xR+x9jmjovdBaIIzsiw/qjOjBTDexked5n8tB/WBlxNOH5KK7jUAIacVO
        KYEVGseDoFxBGNOxr+zi3T97fPQiio0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631005151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67kAHH5xohVl5jt4+A4YLbZP3+bIJFVJRf3g+DvSKqI=;
        b=f+1QheCIte4VpHAXGu0jWwBfn+j7rKhkYaNS78u1bH8ZBUDsqfmrfevjNg1N1VgK3BRbNj
        UaNFOrAB/cQrZwCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 00DF512FF9;
        Tue,  7 Sep 2021 08:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id j0JqOt4pN2ESKQAAGKfGzw
        (envelope-from <afaerber@suse.de>); Tue, 07 Sep 2021 08:59:10 +0000
Message-ID: <9a64b668-8c8a-4ed9-89b7-c5bc1a74ae45@suse.de>
Date:   Tue, 7 Sep 2021 10:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chester Lin <clin@suse.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
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
 <YR0akXYPYthDuvCh@linux-8mug> <11f8b913-1057-7d30-e936-f27483f9a6e2@suse.de>
 <CAJKOXPdZ2iP3-BUk+p5A=UnbGia7s2GAOh84htcEjwB1wNAJrQ@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <CAJKOXPdZ2iP3-BUk+p5A=UnbGia7s2GAOh84htcEjwB1wNAJrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Krzysztof,

On 07.09.21 08:59, Krzysztof Kozlowski wrote:
> On Mon, 6 Sept 2021 at 22:38, Andreas Färber <afaerber@suse.de> wrote:
>> On 18.08.21 16:34, Chester Lin wrote:
>>> On Fri, Aug 13, 2021 at 12:53:59PM -0500, Rob Herring wrote:
>>>> On Thu, Aug 05, 2021 at 02:54:22PM +0800, Chester Lin wrote:
>>>>> Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
>>>>> design 2 board ( S32G-VNP-RDB2).
>>>>>
>>>>> Signed-off-by: Chester Lin <clin@suse.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>>> index e2097011c4b0..3914aa09e503 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>>> @@ -983,6 +983,13 @@ properties:
>>>>>            - const: solidrun,lx2160a-cex7
>>>>>            - const: fsl,lx2160a
>>>>>
>>>>> +      - description: S32G2 based Boards
>>>>> +        items:
>>>>> +          - enum:
>>>>> +              - fsl,s32g274a-evb
>>>>> +              - fsl,s32g274a-rdb2
>>>>> +          - const: fsl,s32g2
>>>>
>>>> Given this is an entirely different family from i.MX and new?, shouldn't
>>>> it use 'nxp' instead of 'fsl'? Either way,
>>>
>>> It sounds good and Radu from NXP has mentioned a similar idea for the
>>> compatible string of linflexuart. To keep the naming consistency, should we
>>> change all 'fsl' to 'nxp' as well?
>>
>> I assume that question was just unclearly phrased, so for the record:
>>
>> ABI stability rules forbid us from changing "all 'fsl'" in compatible
>> strings or property names.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/ABI.rst
>>
>> Deployed firmware providing mainline-merged platforms with DTBs using
>> fsl prefix (e.g., the quoted LX2160A) needs to continue working with
>> newer drivers, and deployed mainline Linux should continue working after
>> firmware updates that modify the DTB provided to Linux.
> 
> This is a new platform/SoC therefore there is no ABI. There is no
> requirement in the kernel that a new ABI (which you define in this
> patchset in the bindings) should be compatible with something
> somewhere. It's some misunderstanding of stable ABI. Therefore all new
> compatibles are allowed to be nxp, not fsl.
> 
> No one here proposed renaming existing compatibles from fsl tro nxp.
> We talk about new ones.

Chester seemingly did: "all 'fsl' ... as well", not "all new 'fsl'"
ones, in the patch context of existing fsl.yaml. Like I said, it may
just have been unluckily worded.

Therefore my saying that it does contain tons of non-new SoC/platform
bindings that he's not allowed to break by changing them.

> Different question of course whether you want to be nice to some
> existing out-of-tree users... but then have in mind that we don't care
> about out of tree. :) Anyway being nice to out-of-tree is not part of
> ABI. It's just being nice and useful.

Nobody is suggesting new S32G ABI be compatible with downstream BSPs.
These patches and changes we're discussing already differ from the BSP.

My point was that as soon as we merge S32G into mainline, it will become
ABI and shouldn't be changed incompatibly anymore once in a release.

These automotive platforms don't run off-the-shelf distros yet and will
need to get their bootloaders upstreamed, too. In particular we'll need
mainline TF-A to merge the SCMI implementation before we can rely on it
here in the kernel for a clk driver; that's holding up MMC and Ethernet.

Best regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
