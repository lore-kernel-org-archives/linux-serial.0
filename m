Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3CC001DB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Aug 2023 05:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjHNF5Q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Aug 2023 01:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjHNF4n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Aug 2023 01:56:43 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E691991
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 22:56:12 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64723cf8264so1565776d6.2
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691992569; x=1692597369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nWy8K+A3gmg43bAetQ9sAtJN4YzGBCb2rJvrClCSx0=;
        b=B9xjF4jRfzv6Uau+Zp2OrPOPajuCt2sdF7e21IJsiZmXYG3mj3LlkGeyI371r+eo+U
         n02Hykxlhmg5GlD4wm20LUTAZU7yQ08B+f/2dPItAvKMI7IoddMWuf6WNFLCgBjWjRFq
         Bdur9Hzo7lWkX7h50IiS2uY7Mim7i4qyEe1sTRUEsKkx09cN69n5u2HhgbJiqQAnP7Sh
         9hUyc/axoPGTZUSxMidzpMyxY6BcdxZ1qX47vImGp9qUMFU4VrmHJ42/QzCY9MFawiYo
         41+pEebMtoM9NV2gvx+YeibkIahpZz83no+MXRPITHAkZ7OmHBgd4bDymB3aNtEFvNR5
         4sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691992569; x=1692597369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nWy8K+A3gmg43bAetQ9sAtJN4YzGBCb2rJvrClCSx0=;
        b=Ty6T6U4UGkzYOCb+qlh5uvCTgwR+mdEnnFb3+nCvlSPhrX+gy7cSEg39pXb85a/f4x
         vv0p3vgtVggl0uqBglojpGdtDs6FBRtxlvXaLhdCJjdoujSHcBsJ9WN3l8wMisVKA04z
         pph87RTWxLUUSnYebomzZNnSp6+CjCnrqZpeP8R9aMWCe3+QnFjjGCdkcqWSwYUmxzFH
         7HRwKaaXiKIsh+m0JNhk75k4/L5L81KJl02+NP3OTGRj+/CoccorEzhUh26uBZp6R37K
         a5ItTliMI93uZdFdLcOS/MTIPFJDD4cqvZmYzBMZFftfM2Mh6bSoMlBiR/+6Y3HMtMqi
         Xo4w==
X-Gm-Message-State: AOJu0Yxwb6cMSryBhN6N2pJBdUdjKf/o1UkIAl3W9h0dRNZ4dhIW6fm4
        ibeX9nx0sb/vWX757kBFVZWmohZIF4HcRCdGQozbDA==
X-Google-Smtp-Source: AGHT+IHW7Xb+gaFCMb0r8VD3gHfQkPvEtJSU0q7Z911XKy/EpJw4llUFP7xsE+ImxMVfHm7iSsO25GA4euVpqbYuA3o=
X-Received: by 2002:a0c:e1d3:0:b0:641:8cb7:b089 with SMTP id
 v19-20020a0ce1d3000000b006418cb7b089mr9611951qvl.27.1691992569765; Sun, 13
 Aug 2023 22:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230809135042.2443350-1-nick.hu@sifive.com> <2023081143-flannels-verbally-9d0f@gregkh>
In-Reply-To: <2023081143-flannels-verbally-9d0f@gregkh>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Mon, 14 Aug 2023 13:55:58 +0800
Message-ID: <CAKddAkA9TZs2vVCzBWtfgo3gYJsrMMmsDMtA22iEMM3ok9TgPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Add Sifive uart suspend and resume
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zong.li@sifive.com, jirislaby@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg

On Sat, Aug 12, 2023 at 3:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 09, 2023 at 09:50:41PM +0800, Nick Hu wrote:
> > Add Sifive uart suspend and resume functions for system suspend.
> >
> > Changes in v2:
> > - Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
> > - Remove the unnecessary check
> >
> > Nick Hu (1):
> >   serial: sifive: Add suspend and resume operations
> >
> >  drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > --
> > 2.34.1
> >
>
> Does not apply to my tree :(
Is there any reason that it doesn't apply to your tree?
Which tree should I go?
