Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBDEC433C1
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 05:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6171561A1B
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 05:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYFlG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 01:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCYFkx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 01:40:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34819C06174A;
        Wed, 24 Mar 2021 22:40:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v26so715423iox.11;
        Wed, 24 Mar 2021 22:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ZJuZyG5EyUyV+P4POHr63Z6WBq4xJYiTvaFchgclQI=;
        b=enGvwYzYJhFRdA5LENa9xHVplo2yJzy2G+NKOkmYljnWTZntst8oqdA1nmv1c7wIv0
         P9WtFcTcloxZ61Ag8dkqBZR1jNFAzT8ox3S26lbBFBBHUJwfPsAnHEh6tvS8dbO3ehW0
         LIjNgg5RG9mYg+mowcyU3juDB9eqzD1LuMI4bSzdRdU51xFcA+uU2QXhQcZRu/biGqbv
         UWBlnyI9uvZNfFz5ENaAuBoTtKycJaJkb8C84ODshJ3F6yaRtyKCFKqhE083ecPfrGgX
         ArGaadbQU1q0oPc2VY2JhAZ7A00J6tjfkd3ltsiZ6CNPrtnudsk8zMZuRhW+y3pKJPDJ
         f5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ZJuZyG5EyUyV+P4POHr63Z6WBq4xJYiTvaFchgclQI=;
        b=fOwWxav8PEGYcHXeTUi2WfkqmJ02qfqeDrEzJEjNc33Z8CMKGIEuEwbDQAn/nJaxhE
         8g5KIjMbbWuiYBnKeTLjkViUy8b3Ot8zxpAUzLIfAOTUcMOSGh6Ccn9pn7Eg4F32wXf4
         rYZhU2rleO8v0pkLD4xLLd4oZg1pjc4sAYKKCNLfW2RkuhR+V1NRKcxsR54bUfv7Wq9X
         OCCjSHOalDEpqFiK6Lzmut/fTGI5/pIiS8t3MO0/Ku9smYlX+j9JMb0dluaHoaB2FLXM
         2Al98YGnUHzY197lIrx5vBv2ycNlC2cFbYtssW1F5gmrLaxev/02Oy2vdj+le3w9JKiJ
         Ya6w==
X-Gm-Message-State: AOAM5334uqZZOu+ps+2j7LFAd4Fe9U3H7wPzuzu1o6sAaIvE/q0Uhuos
        8b+ofHZ4xMWBv+hbRsZBPRs+s8T+7pswWZ3R7AI=
X-Google-Smtp-Source: ABdhPJxkLmUszGSoe7SOp77M3RTyBJYMqnmTo2KjwjsX9TQbTc9REpxEGUAdxAS9JWBtNdJjwNljleAbH0UU9cea6UU=
X-Received: by 2002:a05:6638:d47:: with SMTP id d7mr6042430jak.2.1616650852714;
 Wed, 24 Mar 2021 22:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
 <CAL9mu0Lfj+n4uk2rT8QnDtRveHn2gLx4ut6fLCByt0w9e08vwQ@mail.gmail.com>
 <01c9f635-7b2b-fc9c-3cf9-6d7f425d683e@foss.st.com> <CAL9mu0LaWyhb0=CdJgrfq8v08P2cgKSx8g=u3MJU=dRQc8bThw@mail.gmail.com>
 <20210324174525.GA3309477@robh.at.kernel.org>
In-Reply-To: <20210324174525.GA3309477@robh.at.kernel.org>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 25 Mar 2021 13:40:16 +0800
Message-ID: <CAL9mu0+g0fRGNzZp7Mbxd0to6B1gSGvgFFtNcSzB=-h3Y6G92Q@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] dt-bindings: serial: stm32: add phandle
 'bluetooth' to fix dtbs_check warrning
To:     Rob Herring <robh@kernel.org>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        Alexandre TORGUE <Alexandre.torgue@foss.st.com>
Cc:     rong.a.chen@intel.com, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob,

Thanks for the suggestion.


On Thu, Mar 25, 2021 at 1:45 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Mar 19, 2021 at 07:13:27PM +0800, dillon min wrote:
> > Hi Alexandre,
> >
> > Thanks for the reply.
> >
> > On Fri, Mar 19, 2021 at 4:38 PM Alexandre TORGUE
> > <alexandre.torgue@foss.st.com> wrote:
> > >
> > > Hi Dillon
> > >
> > > On 3/19/21 5:28 AM, dillon min wrote:
> > > > No changes, Just loop lkp in.
> > > >
> > > >
> > > > Hi lkp,
> > > >
> > > > Sorry for the late reply, thanks for your report.
> > > > This patch is to fix the build warning message.
> > > >
> > > > Thanks.
> > > > Regards
> > > >
> > > > On Mon, Mar 15, 2021 at 5:45 PM <dillon.minfei@gmail.com> wrote:
> > > >>
> > > >> From: dillon min <dillon.minfei@gmail.com>
> > > >>
> > > >> when run make dtbs_check with 'bluetoothi brcm,bcm43438-bt'
> > > >> dts enabled on stm32h7, there is a warrning popup:
> > > >>
> > > >>>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'b=
luetooth'
> > > >>     does not match any of the regexes: 'pinctrl-[0-9]+'
> > > >>
> > > >> to make dtbs_check happy, so add a phandle bluetooth
> > > >>
> > > >> Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32=
H743i-EVAL board")
> > > >> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > > >> Reported-by: kernel test robot <lkp@intel.com>
> > > >> ---
> > > >>   Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 5 =
+++++
> > > >>   1 file changed, 5 insertions(+)
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uar=
t.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > > >> index 8631678283f9..5e674840e62d 100644
> > > >> --- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > > >> +++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
> > > >> @@ -50,6 +50,11 @@ properties:
> > > >>       minItems: 1
> > > >>       maxItems: 2
> > > >>
> > > >> +  bluetooth:
> > > >> +    type: object
> > > >> +    description: |
> > > >> +      phandles to the usart controller and bluetooth
> > > >> +
> > >
> > > Do we really need to add this "generic" property here ? You could tes=
t
> > > without the "AditionalProperties:False".
> > Yes, indeed. we have no reason to add a generic 'bluetooth' property
> > into specific soc's interface yaml.
> > I can't just remove "AditionalProperties:False", else make
> > O=3D../kernel-art/ dtbs dtbs_check will run into
> >
> > /home/fmin/linux/Documentation/devicetree/bindings/serial/st,stm32-uart=
.yaml:
> > 'oneOf' conditional failed, one must be fixed:
> > 'unevaluatedProperties' is a required property
> > 'additionalProperties' is a required property
> > ...
> >
> > So , i will replace "AditionalProperties:False". with
> > unevaluatedProperties: false, do you agree with this?
>
> This is okay as long as 'serial.yaml' is referenced, but will eventually
> fail if not (unevaluatedProperties isn't actually implemented yet).
>
> > If so, i will send patch v4 later.
>
> Or you can do this:
>
> addtionalProperties:
>   type: object
>
> Which means any other property has to be a node.
>
Okay, I just test your patch, it's fixed dtbs_check warrning as well.
I will merge it to next submit, thanks.

Hi, Valentin CARON=EF=BC=8C
Could you help to double check it, after my v5 submit ? thanks so much.

Regards.

Valent
> Rob
