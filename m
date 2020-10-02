Return-Path: <SRS0=IMut=DJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC0AC4363D
	for <linux-serial@archiver.kernel.org>; Fri,  2 Oct 2020 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75A920719
	for <linux-serial@archiver.kernel.org>; Fri,  2 Oct 2020 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601642765;
	bh=bCtzaRKDFcC6YuUdGkA3fP3iUX5nRLBeb5sdrPRndZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aBzc/nqkyqw6DNbpEC3ecf5nAnAwsz4gs1va2310JwKaFr2wfZ+1tF5QZAYD3cPc8
	 4zrR2RPRdbrOuEfycx/SGnayyC1uboNrIpb4VQVb+RZsy8mi4/4ttdXWXPqW0A64ac
	 qCy6mkS/lOXvgZhyYZrfS2BruvcJSJNsxkn9JZdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBMqF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBMqF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Oct 2020 08:46:05 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ADD20719;
        Fri,  2 Oct 2020 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601642765;
        bh=bCtzaRKDFcC6YuUdGkA3fP3iUX5nRLBeb5sdrPRndZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eg+u5sklGBOfQ+b+hla5PW8rlB32L+9M+s/iioJHKKIIS8uoCCSd4R00KJFTz5Tns
         4jlDnfmeKj/VtkUl9mMbvcH38qxWDB4Of47ffcF1AW96nHKdK8OrYIme89y7taZ2w/
         3NX9asROErfiAICW7baqntIn3PKf2dySkbMO+0iw=
Received: by mail-ej1-f49.google.com with SMTP id p15so1773520ejm.7;
        Fri, 02 Oct 2020 05:46:04 -0700 (PDT)
X-Gm-Message-State: AOAM530be2eb1/e+YdUdV3QOmbBkwepLNpVucP0912tC0q4Hdt3kxZLU
        GoEq4/8wKRgh76xcmmGuHzYNoGeSq3qPyZXvCKU=
X-Google-Smtp-Source: ABdhPJyHdSuJWVuVTaGeJJ4aXGymg46mIdaV8WsXZjI8zh12U1ZrTVPnXFOPuICP+IHWoN/kHliPWlQpH9Oz4o4rrUY=
X-Received: by 2002:a17:906:1a11:: with SMTP id i17mr2036220ejf.381.1601642763320;
 Fri, 02 Oct 2020 05:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212649.23183-1-krzk@kernel.org> <20201002124126.GA3348316@kroah.com>
In-Reply-To: <20201002124126.GA3348316@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 2 Oct 2020 14:45:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcec1nUmV+y_BtXHw8Jv970Ec_SVCCnLKFy0Lq08KpCuw@mail.gmail.com>
Message-ID: <CAJKOXPcec1nUmV+y_BtXHw8Jv970Ec_SVCCnLKFy0Lq08KpCuw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: fsl-imx-uart: fix i.MX 53 and 6
 compatible matching
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 2 Oct 2020 at 14:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 25, 2020 at 11:26:49PM +0200, Krzysztof Kozlowski wrote:
> > The i.MX 53 and i.MX6Q DTS use two compatibles, i.MX 6SL/6SLL/SX three
> > so update the binding to fix dtbs_check warnings like:
> >
> >   serial@21ec000: compatible: ['fsl,imx6q-uart', 'fsl,imx21-uart'] is not valid under any of the given schemas
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/serial/fsl-imx-uart.yaml          | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>
> This doesn't apply to my tty tree :(

It is rebased on my previous fsl-imx-uart dt-bindings patch which was
picked up by Rob. Otherwise there would be conflicts.

Rob,
Could you pick this up as well?

Best regards,
Krzysztof
