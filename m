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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEB3C433FE
	for <linux-serial@archiver.kernel.org>; Thu,  9 Sep 2021 11:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9A860698
	for <linux-serial@archiver.kernel.org>; Thu,  9 Sep 2021 11:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbhIILwy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:52:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39382 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240943AbhIILuv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Sep 2021 07:50:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC097200EF;
        Mon,  6 Sep 2021 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630956946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Myxi+rNyKHYVeMxsZEIiSjP23vQUMmsIvDtzesxP3qg=;
        b=ugKP2+XRMgyLHw31scY7psFVAofUuJdQ0wYthgcIqdO1wcAgczM7lgWU29SjDbGu7dTiZs
        aVD8IdJBjscUBRYbHtbhokcjw939BaJBNMOle1VmfAxazChHq9By+omAonWuWBpgpJmFev
        XehwO2YWmbjutW6950aFcw7W83QDTxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630956946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Myxi+rNyKHYVeMxsZEIiSjP23vQUMmsIvDtzesxP3qg=;
        b=FoU8I4jEvkIDSm+wRdop7ggSULrkAgMIPo3na5SGl37ix+img2g0cFLU5wXL716PXVEl6O
        XJkn34qEPE6GioAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 60A0E12FF9;
        Mon,  6 Sep 2021 19:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id f1yAFpJtNmETGQAAGKfGzw
        (envelope-from <afaerber@suse.de>); Mon, 06 Sep 2021 19:35:46 +0000
Message-ID: <41b2ff7b-2dee-62e8-abb6-df90d7156313@suse.de>
Date:   Mon, 6 Sep 2021 21:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Chester Lin <clin@suse.com>
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
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-2-clin@suse.com> <YRaxt1LCF+hWaMJU@robh.at.kernel.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <YRaxt1LCF+hWaMJU@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13.08.21 19:53, Rob Herring wrote:
> On Thu, Aug 05, 2021 at 02:54:22PM +0800, Chester Lin wrote:
>> Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
>> design 2 board ( S32G-VNP-RDB2).
>>
>> Signed-off-by: Chester Lin <clin@suse.com>
>> ---
>>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index e2097011c4b0..3914aa09e503 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -983,6 +983,13 @@ properties:
>>            - const: solidrun,lx2160a-cex7
>>            - const: fsl,lx2160a
>>  
>> +      - description: S32G2 based Boards
>> +        items:
>> +          - enum:
>> +              - fsl,s32g274a-evb
>> +              - fsl,s32g274a-rdb2
>> +          - const: fsl,s32g2
> 
> Given this is an entirely different family from i.MX and new?, shouldn't 
> it use 'nxp' instead of 'fsl'?

S32V also still used fsl prefix, despite the company name long being NXP
(same for several Layerscape and i.MX models).

If, as Radu indicated on 3/8, NXP wants to make that switch now for S32G
then I see no reason against nxp. I verified that it's already defined:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/vendor-prefixes.yaml

However, should the matching .dts[i] files using nxp prefix (4-6/8) then
still go under dts/freescale/, or should they go to a new dts/nxp/ then?
That would separate it from S32V. Intel did do a switch from dts/altera/
to dts/intel/ at some point, so there's precedence for either, I guess.
No idea whether anything might break if we moved S32V alongside S32G.

Similarly, the easiest and most merge-friendly would be to leave
arm/fsl.yaml and add the nxp-prefixed S32G2 there, as done here. If NXP
want to rename fsl.yaml to nxp.yaml in a general housekeeping effort,
that could be done independently, outside Chester's patchset.

> Either way,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
