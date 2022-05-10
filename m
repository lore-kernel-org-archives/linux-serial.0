Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898BBC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 10 May 2022 08:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiEJIKV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 May 2022 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiEJIKS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 May 2022 04:10:18 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86DC488A9
        for <linux-serial@vger.kernel.org>; Tue, 10 May 2022 01:06:20 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f7c424c66cso170940177b3.1
        for <linux-serial@vger.kernel.org>; Tue, 10 May 2022 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHvmD3RUYratPZzeW7RFq74TZhAFuN/+YFV/XQLuaIM=;
        b=kEvdUJMTS/1kAQeVQAfzGFEjLuxG4aGpB9eCqNr8CJgwcLLrB8t2T0vDWYVLfsJyNS
         knTQtZLTPrq3iIYk1tn3i/YgEAr8upz//UzjmC/J2lhA+8RJFIwewTuKFUINKj3B3Jvt
         P5EBGE5pStkpL78kvyiVNvBXBOKlD+wcA2Ces=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHvmD3RUYratPZzeW7RFq74TZhAFuN/+YFV/XQLuaIM=;
        b=NuhmquvJHkZvWbu+jOBZSn4PuIR40waCH5v/JZs4LMsrin2ZFDgH14mFZlEU87ayO0
         5oddXIyOg8vpg0dMfQ3bz6BynjLf41QX3kiVpAP9j+AlMkEfRnV5J5q/1Pg6wtc67r78
         VlRtIMvqO5x3BgptJ/sZX3vPPakCGPmIDxjbKvWf3G5HSTSRUjvf8BcRoOksovoYHrBG
         43x11QfxCTUjsyugugsMK72bOQWif7jLeB207oAPubb4ISDKUacVHnYCJ34DxWFcOZLz
         cZ5SavMNX+ylur043oaBu9TM7m3dF+3s4/aX/iaDeOssEB2OAwWScr+TL6IlS5B8226V
         BWNQ==
X-Gm-Message-State: AOAM530T1PltosLREVB/9aCit62QC2XLb/eSh0Xb8ij8+JSRYAfDop67
        9duYGznUr3d0ysf1tld/68EVCmI9b1Lx6zEuLpKZdA==
X-Google-Smtp-Source: ABdhPJxR8UmyAqpm0NDx65RbTGAH+Ic2Inl0X39zKERnNgLItx7XsVM1Qth05XhIcMo2iCuqBDcNOSxhJk4Y3DPsOxI=
X-Received: by 2002:a81:be05:0:b0:2e5:6c26:59fb with SMTP id
 i5-20020a81be05000000b002e56c2659fbmr18802203ywn.94.1652169980102; Tue, 10
 May 2022 01:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <62793d83.1c69fb81.71b96.033e@mx.google.com> <YnlBAoZTJ6WbM394@sirena.org.uk>
 <YnlaZgJfGASYwO8Y@sirena.org.uk> <9a2b8b38-c4c0-b1a3-832b-74a937d66047@collabora.com>
In-Reply-To: <9a2b8b38-c4c0-b1a3-832b-74a937d66047@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 10 May 2022 16:06:09 +0800
Message-ID: <CAGXv+5Hx7cRwNzLWrExcFGy=MMOc3-0EbqCanv2E0G_DKXLCgg@mail.gmail.com>
Subject: Re: next/pending-fixes bisection: baseline.login on mt8173-elm-hana
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 10, 2022 at 4:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 09/05/22 20:16, Mark Brown ha scritto:
> > On Mon, May 09, 2022 at 05:27:51PM +0100, Mark Brown wrote:
> >> On Mon, May 09, 2022 at 09:12:51AM -0700, KernelCI bot wrote:
> >>
> >> The KernelCI bisection bot found a boot regression on mt8173-elm-hana
> >> which bisected to 6f81fdded0d02 ("serial: 8250_mtk: Make sure to select
> >> the right FEATURE_SEL").  With the patch the output terminates at:
> >
> > There was also a similar report on mt8183-kukui-jacuzzi-juniper-sku16.
>
>
> Strange, we tested it on another Kukui device and it didn't produce any issue...
>
> Doubt is if it's just about the FEATURE_SEL register, as that may be protected
> and/or not exist on 8173?
>
> I'm investigating that today.

Confirmed it regressed on MT8183 as well.


ChenYu
