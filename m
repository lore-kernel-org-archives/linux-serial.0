Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0893DC433FE
	for <linux-serial@archiver.kernel.org>; Thu,  2 Dec 2021 11:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357114AbhLBLEa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346182AbhLBLE3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Dec 2021 06:04:29 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D6FC061757
        for <linux-serial@vger.kernel.org>; Thu,  2 Dec 2021 03:01:07 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id i6so54909936uae.6
        for <linux-serial@vger.kernel.org>; Thu, 02 Dec 2021 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pk9D0BkgKy2MkHQjOsND26zq44gMYDCnDDc5CGOG3Eo=;
        b=MQzwMbtX3OEq3xFhbvNV9fwEHoed0BB6w8bpPjpAnSKvxey0w7jr842wcnlTfvUu6S
         cPvjz+MuNSnBKEyKITaKbLtK3qhcHMKkOEL3TahZ3cY3Id64C34xaAEtURku7txrqTZP
         TEwzb8URr+IVTqCc78y2Cubsmy4cpXUIop6Si1LFZ8LKATTmVpTz1DqnbTXTm78cmLla
         JFq0oK5fhC4CXugex+FXNY91Oq1Byoi6ik7eWr7Cq0n3Up3qRQqgxz+Menrr/elTmYWh
         3rLbGd7mZmQx/ap6gV64cLo0CenIJ5oz3BJaFmcbCq2rsURgqYh9KLdIOeE8/jE/iO4N
         oD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pk9D0BkgKy2MkHQjOsND26zq44gMYDCnDDc5CGOG3Eo=;
        b=i2btCbCiWhAPWoQAHQ346Mr7ySuLXTHE2RNKXjff6GlIroCV62WCzQWPa2d+kmB86H
         DTuSMZshtN1LNYJxqqv/ZT2uWS5p8NknhFC+EvJKsAyjIIe3keO6/SXlDfw0rA7Vbv8f
         //dEdewdo9WiLO7kHaiGiuLN6daEFLuVESip2mb817PNtUIuC7LmLwu525UeURuCF99Z
         XdzMExRtM37egZ1dGVoBahQLI6tD1JC0YNj0zmCvPy9gH0/w4d1b1zSnOVxd/vVmbNFO
         BJITmOg3vzZk+9AlSTpyQY9hukbz4EarzWSM53erulZfTiPY80z69m+SqFMonXXvhmfw
         F4XA==
X-Gm-Message-State: AOAM5308q6ET9hamKzPm7cmXQLzOrlWom7lnchz5/Lp4YHIKf89cZD3A
        6uXNoa0uBlrl2fs9EJGDt0YD3S2zHHveZfSf+fDpqg==
X-Google-Smtp-Source: ABdhPJxakVPbeV3zYAuA0ClGNGeLE4yam1HSOcyPA7SQE2XyjCmXcnqQqxD6K9GyotZiEP2pJrwvkeSJ6r0RxEK755w=
X-Received: by 2002:a67:be0f:: with SMTP id x15mr13744954vsq.86.1638442866176;
 Thu, 02 Dec 2021 03:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20211130111325.29328-1-semen.protsenko@linaro.org>
 <20211130111325.29328-2-semen.protsenko@linaro.org> <1638294184.179325.2713642.nullmailer@robh.at.kernel.org>
 <4b5bebb0-ed74-8132-1e6b-cb7cbc21439c@canonical.com> <CAL_JsqJb4nMBoGLcf-bKpi5kEE+zXQ=dfo5JSBhrqPFeLnCsHw@mail.gmail.com>
In-Reply-To: <CAL_JsqJb4nMBoGLcf-bKpi5kEE+zXQ=dfo5JSBhrqPFeLnCsHw@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 2 Dec 2021 13:00:54 +0200
Message-ID: <CAPLW+4=Zdvf4HRNUeVMR9URLSdA867hdXVLYy+k47yLH82uTnA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-serial@vger.kernel.org,
        Youngmin Nam <youngmin.nam@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 1 Dec 2021 at 18:20, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 2:04 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> >
> > On 30/11/2021 18:43, Rob Herring wrote:
> > > On Tue, 30 Nov 2021 13:13:21 +0200, Sam Protsenko wrote:
> > >> Add constants for choosing USIv2 configuration mode in device tree.
> > >> Those are further used in USI driver to figure out which value to write
> > >> into SW_CONF register. Also document USIv2 IP-core bindings.
> > >>
> > >> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > >> ---
> > >> Changes in v2:
> > >>   - Combined dt-bindings doc and dt-bindings header patches
> > >>   - Added i2c node to example in bindings doc
> > >>   - Added mentioning of shared internal circuits
> > >>   - Added USI_V2_NONE value to bindings header
> > >>
> > >>  .../bindings/soc/samsung/exynos-usi.yaml      | 135 ++++++++++++++++++
> > >>  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 +++
> > >>  2 files changed, 152 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> > >>  create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> > >>
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/soc/samsung/exynos-usi.example.dts:35.39-42.15: Warning (unique_unit_address): /example-0/usi@138200c0/serial@13820000: duplicate unit-address (also used in node /example-0/usi@138200c0/i2c@13820000)
> >
> > Rob,
> >
> > The checker complains about two nodes with same unit-address, even
> > though the node name is different. Does it mean that our idea of
> > embedding two children in USI and having enabled only one (used one) is
> > wrong?
>
> IIRC, we allow for this exact scenario, and there was a change in dtc
> for it. So I'm not sure why this triggered.
>

It's triggered from WARNING(unique_unit_address, ...), because it
calls static void check_unique_unit_address_common() function with
disable_check=false. I guess we should interpret that this way: the
warning makes sense in regular case, when having the same unit address
for two nodes is wrong. So the warning is reasonable, it's just not
relevant in this particular case. What can be done:

  1. We can introduce some specific property to mark nodes with
duplicated address as intentional. check_unique_unit_address_common()
can be extended then to omit checking the nodes if that property is
present.
  2. We can just ignore that warning in this particular case (and
similar cases).
  3. We can add some disambiguation note to that warning message, like
"if it's intentional -- please ignore this message"

I'm all for option (3), as it's the easiest one, and still reasonable.
Rob, what do you think? Can we just ignore that warning in further
versions of this patch series?

> Rob
