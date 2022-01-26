Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC2C28CF5
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jan 2022 13:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiAZNYM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238940AbiAZNYL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jan 2022 08:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643203451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANJWRqaJOsHeBahCZP1aUBPvVHukSwmTjnJxwO3XFi8=;
        b=PI/U1at3D9yLh1M4kiJLHma8Zf9uTX0AiBX2ZdBytOPtvzSfoIHE4n/Pqpe0qU2ntqIIGy
        enBQndMRPAnAOzNFUmFJXZUxErwBQDFkwOBnAss7DpLFY6r2E2G2vhDQUv3Ng+bH2DZ+pp
        tUSr8L5iuNoIK9TH7LV3HnuqCM6ZYXo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-stDAFt3iNV63_LdWAIWztw-1; Wed, 26 Jan 2022 08:24:10 -0500
X-MC-Unique: stDAFt3iNV63_LdWAIWztw-1
Received: by mail-ej1-f70.google.com with SMTP id v2-20020a1709062f0200b006a5f725efc1so4880421eji.23
        for <linux-serial@vger.kernel.org>; Wed, 26 Jan 2022 05:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANJWRqaJOsHeBahCZP1aUBPvVHukSwmTjnJxwO3XFi8=;
        b=2naEWcc6TdxR8lvAzxscSmT76xKjX9xr2HGLbWzYzmzzBjEpTOTWXOFYos/HGPQRRn
         RfxyR0QQ00ymbBQ7LGKt1NKyIsaSU06uPTyzWoSRBRldWcpXQ3wjYNNlmXqFm9hNbP8B
         gemTk+scD6b1iZw+p++8+9ncCzpA4PC05Es1Zlf4BeddPny3zAYAVNZJytbQckiJ4szq
         6OG9KtfR0X4W60yI/9XnwZMhnBmCMlwRbwNYeeqNumXyOvrRSYAv6EPgFiWw2nzZ8u9p
         H8HI2Qsq6KQQCg/6bnri8aDLte3kYfbeEbBOq0hqAKZ5/W2Er+2WOHatCKAGzUByq8zi
         HGiA==
X-Gm-Message-State: AOAM5303S4drz+d7kqTZLm7omoDtzCowRtLmkyunMVHRyzYxCxHTihLU
        5vOw1HAJ7q6UCDhXUOVoT0ob97aKg6vB3QwImGtbDFjbOqPJvQ92uuxS+mYdzk8tgU+ezC6CDPe
        /co6INymGdE4i6KStlKQGU8IYiA5qHXwZRLRg8tY/
X-Received: by 2002:aa7:d916:: with SMTP id a22mr25322804edr.316.1643203448928;
        Wed, 26 Jan 2022 05:24:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWwMrft4WxUun1ndbSR3lYX4QMq5cL7NVmEXsJv8NqcvjuTwDeS2EsnamlOpKPh8HCYWa/s4tUCv06avVPlVA=
X-Received: by 2002:aa7:d916:: with SMTP id a22mr25322789edr.316.1643203448749;
 Wed, 26 Jan 2022 05:24:08 -0800 (PST)
MIME-Version: 1.0
References: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org> <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com> <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com> <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com> <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
 <YfELyq5AmxiZxjme@kroah.com> <YfE6AiIgXrd+5qvk@smile.fi.intel.com>
In-Reply-To: <YfE6AiIgXrd+5qvk@smile.fi.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 26 Jan 2022 10:23:57 -0300
Message-ID: <CAAq0SU=ivwiGPZoD=BsD67A4A4pvuh0S02L2Udhg8vmjnmCAAw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wcosta@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 26, 2022 at 9:10 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 26, 2022 at 09:52:26AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 25, 2022 at 03:40:36PM -0300, Wander Costa wrote:
> > > On Tue, Jan 25, 2022 at 1:56 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Jan 25, 2022 at 06:53:48PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> > > > > > On 25/01/2022 10:29, Wander Costa wrote:
> > > >
> > > > ...
> > > >
> > > > > > Andy, does this work for X86?
> > > > >
> > > > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >
> > > > > No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
> > > > > (means the 8250_pnp is in use). And I believe the same will be the case on LPSS
> > > > > ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
> > > > > all of them.
> > > >
> > > > Shall I send a revert and we can continue with a new approach later on?
> > > >
> > >
> > > Tomorrow (or maybe after tomorrow) I am going to post the fixes I
> > > already have, and an additional patch adding a build option
> > > (disabled to default) so people maybe if they want to use the FIFO on
> > > console write. But I understand if people decide to go
> > > ahead and revert the patch.
> >
> > Let me revert this for now.  And no new config options please, this
> > should "just work".
>
> Thanks!
>
> Wander, if you need a test for something new, I may help to perform on
> our (sub)set of x86 machines.
>

Thanks, Andy. I will let you know when I have new patches.

