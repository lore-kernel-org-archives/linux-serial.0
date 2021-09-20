Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBE7C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 20 Sep 2021 22:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9045C6121D
	for <linux-serial@archiver.kernel.org>; Mon, 20 Sep 2021 22:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhITWfe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Sep 2021 18:35:34 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39719 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbhITWdd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Sep 2021 18:33:33 -0400
Received: by mail-ot1-f43.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so9261088ota.6;
        Mon, 20 Sep 2021 15:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lv5vCVTK+7a76eimxd7MmcrL6XcLV1HKDiYmE/lrs8A=;
        b=kCuAClWgjXVCWMW40vKOqyJNn7svRxQBQxxkPkNHhjD0wLC1DH9Qbp3dY3hI79Qe9+
         0zwpqgCrBFox+FsU4sm9kAlANqz/69tw5OP5wjJ7zpxGuEOQjhxQsXHc3r/zJ4tupy4c
         atqJpCuQ2p/Rwac9MsYyiY5CQeKufZnRvMgmO5T4T5g6NrYi9vkvSkAdW9AlZhtW6PEE
         cCCsy7Jlld72BmwrsTsAnEmvTLcbgx0PJCCp/gEQhHIpjtE6i9iEIFP6KbBdS81IkHUd
         mrVfv/Qad29Cbl7ZYV7ltTPN3aFzHCtiOFNcBibMH9lxyZEpjj5g+ZUpA3Z8v7V4lBit
         vZfA==
X-Gm-Message-State: AOAM530NPssY6/qzTrOaMDIXowgBML4uTCOzLI+d/c1078B/CIKI7pU7
        ncYELalFZkkIuaUasFqGRg==
X-Google-Smtp-Source: ABdhPJyHo02hXm0YTIK08iLCQV4BEts76YSKzirf6elJYiGSX459iEgxxFQ6lHRpFJJZiRwGlhlXPg==
X-Received: by 2002:a05:6830:349c:: with SMTP id c28mr23307583otu.35.1632177125682;
        Mon, 20 Sep 2021 15:32:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y9sm2549850ote.39.2021.09.20.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:32:04 -0700 (PDT)
Received: (nullmailer pid 919767 invoked by uid 1000);
        Mon, 20 Sep 2021 22:32:03 -0000
Date:   Mon, 20 Sep 2021 17:32:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     devicetree@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        ciprianmarian.costea@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        Rob Herring <robh+dt@kernel.org>, catalin-dan.udma@nxp.com,
        bogdan.folea@nxp.com, linux-arm-kernel@lists.infradead.org,
        ghennadi.procopciuc@nxp.com, linux-kernel@vger.kernel.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org,
        bogdan.hamciuc@nxp.com
Subject: Re: [PATCH v2 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <YUkL4w+FOWOus6FA@robh.at.kernel.org>
References: <20210908064528.922-1-clin@suse.com>
 <20210908064528.922-3-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908064528.922-3-clin@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 08 Sep 2021 14:45:22 +0800, Chester Lin wrote:
> Convert the FSL LINFlexD UART binding to json-schema.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> ---
> Changes in v2:
> - Drop the specific description "S32V234 SoC".
> - Fill my name in the maintainer field. I tried to contact the authors
>   of fsl,s32-linflexuart.txt but got no response.
> 
>  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
>  .../bindings/serial/fsl,s32-linflexuart.yaml  | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
