Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFC9C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Sep 2021 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8424C611ED
	for <linux-serial@archiver.kernel.org>; Mon, 20 Sep 2021 22:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhITWgG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Sep 2021 18:36:06 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42574 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbhITWeF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Sep 2021 18:34:05 -0400
Received: by mail-oi1-f175.google.com with SMTP id x124so3323558oix.9;
        Mon, 20 Sep 2021 15:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aj7IEXY3KZYixFl0VaXRIMHcEUWgkmZRuZiRokVIEv0=;
        b=7+qkLJL1mKBhcTjFX29w44K1c2x0WLnq1uLQNtBwQdk7/d6xmnoo8Kv/fl6r6nokGW
         iUSxeR48xdYfR+9lKetgaKxHjS1QbM2XteaCbm19/IfCzjKn5Zjm9vwDXdasWkRtIkG0
         4+UhKWTVGS2gusIGhllobO9yVWmg9wxgOLO9K6lPPXNPr4vSH9EZafkfiaeCTOW/idxO
         g6dy3C9EwDNfoaIfgdod/v57oSwyc1JyfDihMAOsmU3bEgJZBvSqTP/EzT7avOz59b2O
         2+rLNjnXQ8WtVO0T7Q/GJQ3KuyVqM6E1RjyanUum8W2UwTSO2r+2qaYxmIpr6VwR6aLB
         ZUSQ==
X-Gm-Message-State: AOAM5317Yq0VAVoqdwUGltE1lY3ExcD3EAxECO/47DhLOqSmsTxh10Xp
        3PRuonWfyguMSS4H3ukl9A==
X-Google-Smtp-Source: ABdhPJwrfppYZB0GQM8jcRCSjXe+t8LovZKnzVd8y2jcbLrgQDJQGHMNuoRi1dlp6VCPmUrd6YGd9w==
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr1134012oiu.79.1632177158021;
        Mon, 20 Sep 2021 15:32:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o18sm484552ote.69.2021.09.20.15.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:32:37 -0700 (PDT)
Received: (nullmailer pid 920809 invoked by uid 1000);
        Mon, 20 Sep 2021 22:32:36 -0000
Date:   Mon, 20 Sep 2021 17:32:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     catalin-dan.udma@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        ghennadi.procopciuc@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, ciprianmarian.costea@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bogdan.hamciuc@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, s32@nxp.com,
        Matthias Brugger <mbrugger@suse.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, bogdan.folea@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/8] dt-bindings: serial: fsl-linflexuart: add
 compatible for S32G2
Message-ID: <YUkMBPhnXXDbqW4Z@robh.at.kernel.org>
References: <20210908064528.922-1-clin@suse.com>
 <20210908064528.922-4-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908064528.922-4-clin@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 08 Sep 2021 14:45:23 +0800, Chester Lin wrote:
> Add a compatible string for the uart binding of NXP S32G2 platforms. Here
> we use "s32v234-linflexuart" as fallback since the current linflexuart
> driver can still work on S32G2.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> Changes in v2:
> - Remove redundant minItems/maxItems from compatible properties.
> - Remove the redundant example.
> - Rename the vendor string to "nxp," for s32g2.
> 
>  .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
