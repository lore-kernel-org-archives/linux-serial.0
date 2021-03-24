Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18008C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E391261A01
	for <linux-serial@archiver.kernel.org>; Wed, 24 Mar 2021 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhCXRpz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:45:55 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45686 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhCXRpa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Mar 2021 13:45:30 -0400
Received: by mail-io1-f53.google.com with SMTP id k8so22392558iop.12;
        Wed, 24 Mar 2021 10:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQOKKI3NBhlafu15L4AYHTsh8eoYcv2NYX3pxh4cbeY=;
        b=fLcPi0nCP9Nb7SG8qkTXoUMNre4sg5jXl6cwa/jxpJPIiXed8Okr3gJXcls+Nx5SXm
         bNq1KB1RL7QwgwVeQl2kQrojYjZUNxRVdtg0wvtRmNGllkQRvAYEJb2PfMp4JM7DFs5Z
         1ZBuS1ycDYJkGlnKHHjI4OLHNbKdZKjK0boAR4NEkeaQZgL4cvNJwm9NKYeKCqOuoqxD
         Xxc0/JyT55dGDnCvKkbDryXISxnaiGa7tRD2+ap+mydZ7DsSt+yp1yXRotYT03A4jsdo
         nYP0wBZjGCmBMJjtsQQ+/8ClSWMhEck6emFVs89pgr1ZRyXVoRtQu0w4gOgC2piaVoI0
         lGIw==
X-Gm-Message-State: AOAM532ot5Ffod2oVEjIgMcNEA41KdkIXuid8JVkY/Jy2sgxre131Mk2
        bHHqMEuMrcaQruQxGq/GcQaMX6eI16eK
X-Google-Smtp-Source: ABdhPJykeeWlxXXZ603awX5WAKK6E91QipPknYAhmUz/+Kj3s31Ka3rSq1o62TNB0Nhkf4AldSTLRQ==
X-Received: by 2002:a02:8801:: with SMTP id r1mr4013533jai.51.1616607929547;
        Wed, 24 Mar 2021 10:45:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 14sm1439848ilt.54.2021.03.24.10.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:45:28 -0700 (PDT)
Received: (nullmailer pid 3316165 invoked by uid 1000);
        Wed, 24 Mar 2021 17:45:25 -0000
Date:   Wed, 24 Mar 2021 11:45:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        rong.a.chen@intel.com, Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
Subject: Re: [PATCH v3 9/9] dt-bindings: serial: stm32: add phandle
 'bluetooth' to fix dtbs_check warrning
Message-ID: <20210324174525.GA3309477@robh.at.kernel.org>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
 <CAL9mu0Lfj+n4uk2rT8QnDtRveHn2gLx4ut6fLCByt0w9e08vwQ@mail.gmail.com>
 <01c9f635-7b2b-fc9c-3cf9-6d7f425d683e@foss.st.com>
 <CAL9mu0LaWyhb0=CdJgrfq8v08P2cgKSx8g=u3MJU=dRQc8bThw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL9mu0LaWyhb0=CdJgrfq8v08P2cgKSx8g=u3MJU=dRQc8bThw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 19, 2021 at 07:13:27PM +0800, dillon min wrote:
> Hi Alexandre,
> 
> Thanks for the reply.
> 
> On Fri, Mar 19, 2021 at 4:38 PM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
> >
> > Hi Dillon
> >
> > On 3/19/21 5:28 AM, dillon min wrote:
> > > No changes, Just loop lkp in.
> > >
> > >
> > > Hi lkp,
> > >
> > > Sorry for the late reply, thanks for your report.
> > > This patch is to fix the build warning message.
> > >
> > > Thanks.
> > > Regards
> > >
> > > On Mon, Mar 15, 2021 at 5:45 PM <dillon.minfei@gmail.com> wrote:
> > >>
> > >> From: dillon min <dillon.minfei@gmail.com>
> > >>
> > >> when run make dtbs_check with 'bluetoothi brcm,bcm43438-bt'
> > >> dts enabled on stm32h7, there is a warrning popup:
> > >>
> > >>>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
> > >>     does not match any of the regexes: 'pinctrl-[0-9]+'
> > >>
> > >> to make dtbs_check happy, so add a phandle bluetooth
> > >>
> > >> Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
> > >> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >> ---
> > >>   Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 5 +++++
> > >>   1 file changed, 5 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > >> index 8631678283f9..5e674840e62d 100644
> > >> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > >> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > >> @@ -50,6 +50,11 @@ properties:
> > >>       minItems: 1
> > >>       maxItems: 2
> > >>
> > >> +  bluetooth:
> > >> +    type: object
> > >> +    description: |
> > >> +      phandles to the usart controller and bluetooth
> > >> +
> >
> > Do we really need to add this "generic" property here ? You could test
> > without the "AditionalProperties:False".
> Yes, indeed. we have no reason to add a generic 'bluetooth' property
> into specific soc's interface yaml.
> I can't just remove "AditionalProperties:False", else make
> O=../kernel-art/ dtbs dtbs_check will run into
> 
> /home/fmin/linux/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml:
> 'oneOf' conditional failed, one must be fixed:
> 'unevaluatedProperties' is a required property
> 'additionalProperties' is a required property
> ...
> 
> So , i will replace "AditionalProperties:False". with
> unevaluatedProperties: false, do you agree with this?

This is okay as long as 'serial.yaml' is referenced, but will eventually 
fail if not (unevaluatedProperties isn't actually implemented yet).

> If so, i will send patch v4 later.

Or you can do this:

addtionalProperties:
  type: object

Which means any other property has to be a node.

Rob
