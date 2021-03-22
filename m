Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C3C433C1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A404361994
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhCVLs6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVLso (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:48:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A1C061574;
        Mon, 22 Mar 2021 04:48:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z136so13545220iof.10;
        Mon, 22 Mar 2021 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wyt0l5oKA1RNn55G7F/1OYk1XowasbjdBJAi3unCvdk=;
        b=nQMxbVhwYlbETH/czbc83Qy5xAFLGJLH3Vo6iP+k653Or1hpIct+QeDqnVGR00gR0p
         3lSMNW11Z102gbZhHrmsSEjGALOyZZsKukdK5zdrAhPF0rV+FxIRojTCKInHh8vokZYr
         l5pQovLFDF+03LzkK5NMXQNWeTD/hcfGtDT383MblG9X0gwp+4aDAqbWtdS61/mXsOKV
         nakNVRemI0g3MLPA1kzuoZ1/1dx3VHX/QkHgIsq16s1+es+Ggr5cDbsO7e5WwGJfAIgd
         teBEQSIueRdXSow1IRp/1REehmyRzTO2cjp832Sd/IH++xrhhyvPct/zHnAe7GyZgaZU
         UDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wyt0l5oKA1RNn55G7F/1OYk1XowasbjdBJAi3unCvdk=;
        b=DcdwXbd4ng7Lzk0vVK2MKoniIOCdYLvs1vhMstpZx3DjrkbHzQjlvs4jqxvdVJvDNX
         2/nD8dtpHoDkrP95FSaUJ5aUp17ZdQcyK376SSw1rPk19SgUwF94cH+IEHgE64Dtlby4
         E8XcAIQmcBGfINMoJ/cnsK89A1k3+UcmoytO6B+VtsigLbKPLyZm42nglAn4yhjsQw9Y
         a+E1SRri2kzZoHNbhxTRNfQjBzkmEXDbftdLEQzDDCStfWelrWw6iCfETBlzHu8RFEgd
         KPvPiPnSYFLe8Nq6oqaaKde9/E3I+x2QAJWei8vCa1Dhj9o7RwgohccN3Ncv2Ku5j8qp
         BpCA==
X-Gm-Message-State: AOAM533Dy8R9Nvk1+SYzBggfYCvOVG10DvRYZQHd6E3Gsl6P01iMNH1P
        RxXoboWL+QMx/BbYVvT+LUlBvhON7Myj3pyQd3E=
X-Google-Smtp-Source: ABdhPJzzRxh6vRkud9pux4kVjb8zSKHOU/4RPPGupEarXMhvkeYwfo0hLlTtioZQcjOnyPyDbhKNMkUeAuwejnar8D8=
X-Received: by 2002:a02:3085:: with SMTP id q127mr10661879jaq.137.1616413723386;
 Mon, 22 Mar 2021 04:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
 <1616205383-24114-8-git-send-email-dillon.minfei@gmail.com> <5f95b6ad-ddbe-8394-8599-e78f30c8b62c@foss.st.com>
In-Reply-To: <5f95b6ad-ddbe-8394-8599-e78f30c8b62c@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 22 Mar 2021 19:48:07 +0800
Message-ID: <CAL9mu0LcwRcr+YOuDcLzqxDVCTUajDNnM9SQTkkKCt-J7BX75Q@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH v4 9/9] dt-bindings: serial: stm32: Use
 'unevaluatedProperties' instead of 'additionalProperties'
To:     Valentin CARON - foss <valentin.caron@foss.st.com>,
        Alexandre TORGUE <Alexandre.torgue@foss.st.com>
Cc:     "rong.a.chen@intel.com" <rong.a.chen@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Valentin,
Thanks for feedback.

On Mon, Mar 22, 2021 at 7:05 PM Valentin CARON - foss
<valentin.caron@foss.st.com> wrote:
>
> Hi Dillon,
>
> It works for me.
>
> On 3/20/21 2:56 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > To use additional properties 'bluetooth', need use unevaluatedProperties
> > to fix dtbs_check warnings.
> >
> > 'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
> > does not match any of the regexes: 'pinctrl-[0-9]+'
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
>
> You can add my:
> Tested-by: Valentin Caron <valentin.caron@foss.st.com>
Sure. I will add it to next submit.
>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >
> > v4:
> > - add Reported-by and Fixes tag
> > - use unevaluatedProperties: false to fix dtbs_check warrnings instead of
> >    add 'bluetooth' in st,stm32-uart.yaml
> >
> >   Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > index 8631678283f9..305941b1d5a0 100644
> > --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > @@ -80,7 +80,7 @@ required:
> >     - interrupts
> >     - clocks
> >
> > -additionalProperties: false
> > +unevaluatedProperties: false
> >
> >   examples:
> >     - |
>
> Regards,
> Valentin
