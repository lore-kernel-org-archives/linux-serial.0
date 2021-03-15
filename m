Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C091C43381
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1C664F67
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhCOXMI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhCOXLl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 19:11:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3986C06174A;
        Mon, 15 Mar 2021 16:11:40 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e7so10976659ile.7;
        Mon, 15 Mar 2021 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWwHR8Ne423+zbtI1q+8mLttBfXbDb6VslhtXcXanQg=;
        b=tDmV3Clxxrt5CYW6RR5YvvuFRnN750yidjGLYegOB42Ae9zwMhBjB8qjfA173QHAlG
         oAWC+SYJO1hS9ifiZSDX1U/sGOQyigND3hHv1grdytMkoojG5raNQxL+9HUwT8RXSxG5
         asX49ilTHb6G06bDtHYtIwSjlpYCbnTABKe5yHIEm0h6g3ojlhxqhL/N/XeIsyXy0zPW
         dWpvNMJRikRoHV1IjjcsOPy404NrmT5eMpPXTQ24R2ibgtXXbLBzX2E7xLn4hSne7pu9
         K3Rr8c7Ky8R3vo28DEHiwdx5ppLMUJ61kCV1q/KGy1Ek/yPqrxVJh2vOtr0Ou014TA9B
         AwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWwHR8Ne423+zbtI1q+8mLttBfXbDb6VslhtXcXanQg=;
        b=CAo4GWTOQIoI92jFrY/bFM1Rj1ABsUdH88c5lojR8Ot8QsFYJCESpkwfzKYV/wjAMj
         4qqFEubQZ9FDVfn+0S3yW/gnQsZWxEliHYBBbAzN2oIeaJaaVnpO6tlrAyl7UCc51Z9J
         /nY4kFOZVAJzWk2c6mXGNztY5Todyinx0qeaXO6k+KAfQ5CnYULSXDw56gSBuTqmtm15
         JiYJLHUp+y0/ZYuz5QrqTFyZal5KXsJRRoAlYGhi82PVxhrRLW7dhWyZS34iXXY4QTAC
         jLUSU8osD//zSTO0RnrP298Eg3FKcfmJE+L8ipXFBRjkAiMPdlG1p9crh4XZyccEUxdm
         yENg==
X-Gm-Message-State: AOAM531TYHrnQ0qBmsTF74STQ6JKY6sjwD8IfzIWND9sQQtaUajP+6ob
        a+JR/Rn1+kuTLNP4ymc/IJEf7SpPj+aDMeSXwFY=
X-Google-Smtp-Source: ABdhPJyIMGxVLSY13hI+sOxMMBbHkVYSuVizx6fGRZmxlv5OglFxTSdwX1GBMv9JMdlw2kMfPpdh3pViASu367w3Gpc=
X-Received: by 2002:a05:6e02:dcd:: with SMTP id l13mr1430957ilj.271.1615849900503;
 Mon, 15 Mar 2021 16:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-4-git-send-email-dillon.minfei@gmail.com> <20210315162648.GB981570@robh.at.kernel.org>
In-Reply-To: <20210315162648.GB981570@robh.at.kernel.org>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 15 Mar 2021 23:11:04 +0800
Message-ID: <CAL9mu0+T++RotJt_ayPDFmbxjLL6G20FzR0aQ2FMjn6Dz0qaFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        gregkh@linuxfoundation.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-serial@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk,
        erwan.leray@st.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        erwan.leray@foss.st.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, afzal.mohd.ma@gmail.com,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 16, 2021 at 12:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 15 Mar 2021 17:43:50 +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patch intend to add pinctrl configuration support for
> > stm32h750 value line
> >
> > The datasheet of stm32h750 value line can be found at:
> > https://www.st.com/resource/en/datasheet/stm32h750ib.pdf
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>
Sorry for that, i forgot to remove patch 3 from v2/v3 theris, there are no
changes in v2/v3. please just ignore it , thanks.

Dillon,
Best Regards.
