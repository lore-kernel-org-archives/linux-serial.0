Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EBDC48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01C7614A7
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFOPqk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPqj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 11:46:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 237D2614A7;
        Tue, 15 Jun 2021 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623771875;
        bh=pOEn5q/kmABhBFpFTOXEU8WuQroDLJ8T62TFvhJF+zY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SyET8KwSrB+3TuqBoaek+T6uSNLEqJGzUTJz4wXgshRBK9e30481PR1uXFAmn76/f
         KGrUQsWqL4GUvs+waXuNXFJbB0Iywif3sZBPO5Wo9qYwAnJ0FNkmGSBIhl07xYSOb8
         1rZ4D/vqb7I/CqUdiwXDiSaBYeBovNlEq3aQ26FHHn2CocjaYMV3fip/9ZH298g5Ip
         WKazlXH2w6ncV+8SturWj8xIDfInWW9ugmlQ2senL3Rlbqbps9yvVlgYZ2r+8RYru2
         tuHVAQjALvJ9fczw/JA+fqZ6ztS3vLcmo4JAxYXSsdxJqlojuPe9XERJ4HSMVtRJsU
         hQj83zCdI1Dng==
Received: by mail-ed1-f43.google.com with SMTP id w21so51700257edv.3;
        Tue, 15 Jun 2021 08:44:35 -0700 (PDT)
X-Gm-Message-State: AOAM5331M/j3mGQy07WF07oe0IHSjlLy+fFEDjfVTuVUraey5Wf7Pwoo
        Ohz71z7347naG9/u+IXAhPW5KH4bORHzW65yNw==
X-Google-Smtp-Source: ABdhPJyEHiHgZO7dCJ9YlVLUpCzRaubqbjF3N5ZTb8jhLJ1MP8MnsylXBdgxPESwHZF+8ttuDoaCdKcOj64tKfKGh7I=
X-Received: by 2002:aa7:cac9:: with SMTP id l9mr21226edt.373.1623771873757;
 Tue, 15 Jun 2021 08:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com> <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
 <YMi1jOL6y+eUK3Df@kroah.com> <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
In-Reply-To: <B71C5D02-EDBE-4AAD-AF1B-2FD467BE075A@cortina-access.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 09:44:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
Message-ID: <CAL_JsqKDf9W-1KHUoFFCoLareLKf0CAVMU6CXR22xW3hWM_8yg@mail.gmail.com>
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

On Tue, Jun 15, 2021 at 8:39 AM Alex Nemirovsky
<Alex.Nemirovsky@cortina-access.com> wrote:
>
>
>
> > On Jun 15, 2021, at 7:13 AM, Greg Kroah-Hartman <gregkh@linuxfoundation=
.org> wrote:
> >
> > On Tue, Jun 15, 2021 at 01:36:39PM +0000, Alex Nemirovsky wrote:
> >> MAINTAINERS modification was made in the initial version 1.  We made n=
o changes to it since then,
> >> thus not sure what we could at to  Changelog which would add value or =
clarity for others
> >> from the v1.
> >>
> >>> On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfoundati=
on.org> wrote:
> >>>
> >>> On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> >>>> From: Jason Li <jason.li@cortina-access.com>
> >>>>
> >>>> Convert the Cortina-Access UART binding to DT schema format.
> >>>>
> >>>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> >>>> ---
> >>>> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++=
++
> >>>> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >>>> MAINTAINERS                                   |  6 +++
> >>>
> >>> You are also adding a MAINTAINERS entry here, which is not listed in =
the
> >>> changelog text, so I couldn't take it anyway :(
> >
> > Add the maintainers entry in the first patch, with the driver please.
>
> The change to MAINTAINERS here add a new file into the DT documentation.
> Should it not be grouped into the dt-binding portion and reviewed by the =
DT time for which this patch
> is CC=E2=80=99ed to? Why would moving the DT documentation file that is i=
ntroduced be into the first patch, which is the
> serial driver itself be the correct approach?

The binding doesn't actually need a MAINTAINERS entry (though having
one is fine). get_maintainers.pl will also pull emails from the
binding schema.

Rob
