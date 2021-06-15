Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEFCC48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718B861444
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFOQXA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhFOQXA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 12:23:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DF9361444;
        Tue, 15 Jun 2021 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623774055;
        bh=A//FjPnGORFN1egULK4FZVmE0QZM3H3vbfVdYalLmUc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ek5PoI3owNGFiVWfrlGzFsEjl1OXF8eMSZ+XnTlXa38ATH+k0MpBoDeJEtVTmoDVw
         f+U1pAJrJmD6FnwIlw8aLpiB4gHpus0Bs22Kryciz+ZNnzlPMRSrYkcHbhBoOYIRQt
         XSV8kTfkd/pQJh055pq/uVe6klnKmElVuyEg0jDpvH8sGApcEo/6J2D4cXz5mCLXSR
         tYKtjO3uuRc32MYCToKKPESeIC0jy0F8XR3oBWU6R4bP76U48C2Slng0tV0SrPNfBV
         CoO/xMgyXKoeZGe/V1R2cs4HNoJqY1oIiDS28dpnib9twl5obhiChJweu9De62vCfV
         epbXJ1KHRBqJQ==
Received: by mail-ed1-f52.google.com with SMTP id s6so51898363edu.10;
        Tue, 15 Jun 2021 09:20:55 -0700 (PDT)
X-Gm-Message-State: AOAM532KEg/WOQlsJTaOvFZJ1LmTm9XPJ4yIeketLdpQTxJV6VEZ3Slp
        RdUsxQcsOYwaqjbKhRHTZq/3aRk+c7UiurcdcQ==
X-Google-Smtp-Source: ABdhPJyBoxVJH3xF/WxVEUjQE0taHKPI2RIQWJ9pzI7pv0ojHASmCzM2k5cttEz8Fq9s6n+PeW9P9ZdJDmC15Fiqz5k=
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr347145edz.62.1623774054092;
 Tue, 15 Jun 2021 09:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com> <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com> <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
 <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com> <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com>
In-Reply-To: <9937DB34-7757-4A54-BCC6-AF5514FD7F1D@cortina-access.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 10:20:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>
Message-ID: <CAL_JsqLHdi29Du1F=e1N471tnsziWpH7TPO_caDF3SrjvHS-iw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 15, 2021 at 10:06 AM Alex Nemirovsky
<Alex.Nemirovsky@cortina-access.com> wrote:
>
>
>
> > On Jun 15, 2021, at 8:44 AM, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Jun 15, 2021 at 8:39 AM Alex Nemirovsky
> > <Alex.Nemirovsky@cortina-access.com> wrote:
> >>
> >>
> >>
> >>> On Jun 15, 2021, at 7:13 AM, Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
> >>>
> >>> On Tue, Jun 15, 2021 at 01:36:39PM +0000, Alex Nemirovsky wrote:
> >>>> MAINTAINERS modification was made in the initial version 1.  We made=
 no changes to it since then,
> >>>> thus not sure what we could at to  Changelog which would add value o=
r clarity for others
> >>>> from the v1.
> >>>>
> >>>>> On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
> >>>>>
> >>>>> On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> >>>>>> From: Jason Li <jason.li@cortina-access.com>
> >>>>>>
> >>>>>> Convert the Cortina-Access UART binding to DT schema format.
> >>>>>>
> >>>>>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> >>>>>> ---
> >>>>>> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++=
++++
> >>>>>> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >>>>>> MAINTAINERS                                   |  6 +++
> >>>>>
> >>>>> You are also adding a MAINTAINERS entry here, which is not listed i=
n the
> >>>>> changelog text, so I couldn't take it anyway :(
> >>>
> >>> Add the maintainers entry in the first patch, with the driver please.
> >>
> >> The change to MAINTAINERS here add a new file into the DT documentatio=
n.
> >> Should it not be grouped into the dt-binding portion and reviewed by t=
he DT time for which this patch
> >> is CC=E2=80=99ed to? Why would moving the DT documentation file that i=
s introduced be into the first patch, which is the
> >> serial driver itself be the correct approach?
> >
> > The binding doesn't actually need a MAINTAINERS entry (though having
> > one is fine). get_maintainers.pl will also pull emails from the
> > binding schema.
> >
> > Rob
>
> Hi Rob,
> It sounds like you are find with patch 2/3 from a DT point of view.  Coul=
d we review the rest from the DT point of view
> to get either feedback for changes or ACK these, so we can unblock this s=
eries?

Can't say I've seen it as I only see replies in my mail. Did this
originally go to the DT list? If not, it's never in my queue[1].

Rob

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/
