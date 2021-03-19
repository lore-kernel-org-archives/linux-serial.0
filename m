Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58851C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA0E64F69
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCSLOJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 07:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSLOE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 07:14:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9AC06174A;
        Fri, 19 Mar 2021 04:14:04 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z3so5638346ioc.8;
        Fri, 19 Mar 2021 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w077GjWQdUN1FmrTEFv40WM5lSLyRxcaw45yoOKr8sg=;
        b=Ah/U9lTHR5vNyN0CEC86//Qc9FeylDRH6wMB4HHVQ+NoL7mGihIWraJuVqNZqgp2Yq
         1g7zDsg9MaotmLKYMdZ8EMAVEitWYaC8wRZp9GKEtDjC4i7p81iJgBP8fyzI93bCWGnD
         Q5KckiSWpbzt0jiNoiV21hFSrzaCxa1E9zqBWDL4By2YePFrMkf22CULcAXOV35inCQs
         9WlSU+dWwREWSpY6Wdccq/ppYw0zn1l4v+m/F9uyboA6feKEsemGi95pGtjja/UMh81E
         nsA4md8IhXXCWxPRYPQNuYe0QbQ32fJr5GZ5XmG9aHczqFDePvJi/0kRRw4fjIRutpkO
         +4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w077GjWQdUN1FmrTEFv40WM5lSLyRxcaw45yoOKr8sg=;
        b=dfmHo+W6BsGEc+twwvtYEXPB8bhi39FAMk7x1waryG4e5tyCBiRKrHeOWORN0Ktpz5
         dgH5UugJnd4jHZQaQbsRAAdFYmlkp7RlSQuWmsrSKb42pydZyieCugIbgxA3yl7hp+iV
         fWhj1UnCeddc4OyRpLjY1BQ0d0Wq2zA3EDCvb8YLBMfptNbCdPcbXEsoX1a2O+/WA/4b
         yTi8gSfFEPqRkYVTg2iyzmqF1AjV3XiNJPV66ZXi7sbC3SVGWNV8KSmvcuyHSSzsdDH3
         PS+Mjq6xR2nkDERtHGjxiEAbiWYwXH06S97VuIRgr9XDiJzWHnCNi2GsHzEHMnuNXqo7
         g13Q==
X-Gm-Message-State: AOAM532P8n6ygdcwc98WQc5hRrCaU/H7HN8QmYPIC5q49ril+97zyihi
        KAQQMet+zq4ChTjpitRLziMD0aEaZvezop6zn8k=
X-Google-Smtp-Source: ABdhPJwBYQjE5C8weELlPH/FS3kqWEEIEOjhv3Lp9BWZAmT9Yc702ijm0oKC/i+eZjjJ5c1BxjTIrer6UF4iaPSlRw8=
X-Received: by 2002:a05:6638:388e:: with SMTP id b14mr831990jav.62.1616152443770;
 Fri, 19 Mar 2021 04:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
 <CAL9mu0Lfj+n4uk2rT8QnDtRveHn2gLx4ut6fLCByt0w9e08vwQ@mail.gmail.com> <01c9f635-7b2b-fc9c-3cf9-6d7f425d683e@foss.st.com>
In-Reply-To: <01c9f635-7b2b-fc9c-3cf9-6d7f425d683e@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Fri, 19 Mar 2021 19:13:27 +0800
Message-ID: <CAL9mu0LaWyhb0=CdJgrfq8v08P2cgKSx8g=u3MJU=dRQc8bThw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] dt-bindings: serial: stm32: add phandle
 'bluetooth' to fix dtbs_check warrning
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        rong.a.chen@intel.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Alexandre,

Thanks for the reply.

On Fri, Mar 19, 2021 at 4:38 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dillon
>
> On 3/19/21 5:28 AM, dillon min wrote:
> > No changes, Just loop lkp in.
> >
> >
> > Hi lkp,
> >
> > Sorry for the late reply, thanks for your report.
> > This patch is to fix the build warning message.
> >
> > Thanks.
> > Regards
> >
> > On Mon, Mar 15, 2021 at 5:45 PM <dillon.minfei@gmail.com> wrote:
> >>
> >> From: dillon min <dillon.minfei@gmail.com>
> >>
> >> when run make dtbs_check with 'bluetoothi brcm,bcm43438-bt'
> >> dts enabled on stm32h7, there is a warrning popup:
> >>
> >>>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
> >>     does not match any of the regexes: 'pinctrl-[0-9]+'
> >>
> >> to make dtbs_check happy, so add a phandle bluetooth
> >>
> >> Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
> >> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> ---
> >>   Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> >> index 8631678283f9..5e674840e62d 100644
> >> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> >> @@ -50,6 +50,11 @@ properties:
> >>       minItems: 1
> >>       maxItems: 2
> >>
> >> +  bluetooth:
> >> +    type: object
> >> +    description: |
> >> +      phandles to the usart controller and bluetooth
> >> +
>
> Do we really need to add this "generic" property here ? You could test
> without the "AditionalProperties:False".
Yes, indeed. we have no reason to add a generic 'bluetooth' property
into specific soc's interface yaml.
I can't just remove "AditionalProperties:False", else make
O=../kernel-art/ dtbs dtbs_check will run into

/home/fmin/linux/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml:
'oneOf' conditional failed, one must be fixed:
'unevaluatedProperties' is a required property
'additionalProperties' is a required property
...

So , i will replace "AditionalProperties:False". with
unevaluatedProperties: false, do you agree with this?
If so, i will send patch v4 later.

Thanks.

Regards
>
> Regards
> Alex
>
>
> >>   # cts-gpios and rts-gpios properties can be used instead of 'uart-has-rtscts'
> >>   # or 'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
> >>   # control instead of dedicated pins.
> >> --
> >> 1.9.1
> >>
