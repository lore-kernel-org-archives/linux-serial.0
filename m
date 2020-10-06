Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA08EC41604
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B9E2065C
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601995827;
	bh=gt7znWk4kRGq0ubOIfjjTwl0/JotDFfpt2HL+E0HmcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sjiu7nHPTyDDvE9U608KbnX8YjGKsFo5udq9pTVUOyYKU9enmfd6IqYG4A5xbQWvr
	 CH9hntz/lROR/BQyO4nB1gZXJMgiRB5qIauij3gQtMRBJcudTcWXbJq2IePKBI9QYB
	 0Jk9KfWFinLot+tug6ZVZFV5IhZo31EutzrQY85Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFOu1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:50:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42645 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFOu1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 10:50:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so12525586otl.9;
        Tue, 06 Oct 2020 07:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wI0lpf6tpLc/36rDHzk9b+tgbd0mnF0Ci8BszJIYvg=;
        b=A+956ErXZ5n/HbpqmV4npJcvImH9S/xy51kDJcuffAq44zQ1gr2rxq17aiHPCDFjOE
         uSyW3C/cO4I4CTMvQ3jLONFNXpQLAM36SdwxFKoJOEkyEFFZ9nl4pp1idlJI24qefb0M
         h8bbDl54rOEovHt9kX3o8bGO7/DJTBFRm8Mbfyy3h9CcQ6oBSGWKkuaotY5KuPzWjNi0
         yGkVQwGdjBmkzfIhH+1oS8biZX9G+r/LFGz5ofy9PsQIftgler5IDyp41ywwX0lZ2Ndm
         MfWTmUkEIgiACcxteD+Cw0/rqzqASaMRRV4kXaUv8TAIB+YrikiRNfDIiuPRQCPhw6Cr
         0ehw==
X-Gm-Message-State: AOAM533TQUmArwrKov69O6AWwsAhcxtagZMGjtOdjY5WtnGM0GqX1pal
        dL6o0qV5Cq4LqjfCnl1cig==
X-Google-Smtp-Source: ABdhPJxcw2nLLs5ypquYDblUvpVVnJ4HrlQJGDhk2VMGKyp1w7Ml/Oms/3ZGuw+j5tH9Dd+Mi1JZrw==
X-Received: by 2002:a9d:7853:: with SMTP id c19mr1542339otm.253.1601995826057;
        Tue, 06 Oct 2020 07:50:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k3sm916299oof.6.2020.10.06.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 07:50:25 -0700 (PDT)
Received: (nullmailer pid 2195766 invoked by uid 1000);
        Tue, 06 Oct 2020 14:50:24 -0000
Date:   Tue, 6 Oct 2020 09:50:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: serial: fsl-imx-uart: fix i.MX 53 and 6
 compatible matching
Message-ID: <20201006145024.GA2195158@bogus>
References: <20200925212649.23183-1-krzk@kernel.org>
 <20201002124126.GA3348316@kroah.com>
 <CAJKOXPcec1nUmV+y_BtXHw8Jv970Ec_SVCCnLKFy0Lq08KpCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcec1nUmV+y_BtXHw8Jv970Ec_SVCCnLKFy0Lq08KpCuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 02, 2020 at 02:45:51PM +0200, Krzysztof Kozlowski wrote:
> On Fri, 2 Oct 2020 at 14:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 11:26:49PM +0200, Krzysztof Kozlowski wrote:
> > > The i.MX 53 and i.MX6Q DTS use two compatibles, i.MX 6SL/6SLL/SX three
> > > so update the binding to fix dtbs_check warnings like:
> > >
> > >   serial@21ec000: compatible: ['fsl,imx6q-uart', 'fsl,imx21-uart'] is not valid under any of the given schemas
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../devicetree/bindings/serial/fsl-imx-uart.yaml          | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > This doesn't apply to my tty tree :(
> 
> It is rebased on my previous fsl-imx-uart dt-bindings patch which was
> picked up by Rob. Otherwise there would be conflicts.
> 
> Rob,
> Could you pick this up as well?

Applied.

Rob
