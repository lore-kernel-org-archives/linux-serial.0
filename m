Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDDC678DB
	for <linux-serial@archiver.kernel.org>; Tue,  7 Mar 2023 04:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCGEs5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Mar 2023 23:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCGEsz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Mar 2023 23:48:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB050714
        for <linux-serial@vger.kernel.org>; Mon,  6 Mar 2023 20:48:26 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id fa28so7270306pfb.12
        for <linux-serial@vger.kernel.org>; Mon, 06 Mar 2023 20:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678164506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STW7qruBhVR0gEyrFVepjZKXX6IzFFtUbDhI7bfVrIY=;
        b=PgB6iylFvaSMcAvFUkWc7vMWr2tYd/pzwguNtRHcuCPCitwz8CfEYJz+USeraSUQ2O
         lJ6ULML4JKSR5TwzRPVTsVeNGFUDKKmJ5ZEWExeymkHWkvWFidrAdCMh5dfbU5JbWESp
         cKuHBCoYrhrlX0ictLZuklrW65c+AncCB0qLwo5/BunD2nNCVuq5xoM9+nqGbqMIWuhc
         2H42tC1cemj+Wr1f0LxWn1DaE2PsnQHOvdO6jHMbHg6UDhwL/KbSALxy4nZxXJajxIF0
         6tav5oKHkrF2BDh+9b/46vCifW1kZlSEn5IUGRsrD3C+/Hczzk7hYCBR5d3k3ueJqdOX
         V6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678164506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STW7qruBhVR0gEyrFVepjZKXX6IzFFtUbDhI7bfVrIY=;
        b=rV3bmOnlps8PDFsPSu02q8rV8oktTnPlKveuoV24TvQtQ+SGMIqj/uWyik4TS8rGPQ
         ievABRGNUKcRwjilxsV7PAesDH+GcnIrogErDCFQfQ9NSyPDhXjeAtvDOAeaCJfJD8FA
         Yf+XK3HUoVF9zsZDinyHcfeJPsCelBddc36fJ5TiMQ+aMbwMb1HQzoIqkVdnH4xpsl8W
         11DBLawZcgBbBk2EknMTbYNybuI5lNTsDsjgR/W6THyt10SSulV0SHPxxDbwwlexhk/U
         yya7N/O+BSH3R8PUM19E19fS1biLvxrQXWfvG2o8lbM5XRsKfD5QfZgEaXDNlsRuPv0j
         SJJw==
X-Gm-Message-State: AO0yUKXKvkO9SRTQ59UPsV+kSZYoOMFlAma9RknoEPQHHLyMSj6ST9lu
        Dj4GVV3ZhW+/fFttGxyjElq2VcmAPAhFd9BI/vsO2g==
X-Google-Smtp-Source: AK7set8HvWOKLdo++SGONzexHM/kSOnmjJoguD/k0KVsEHXOSbN45WeBVZ0WOkf9vWu1DFoKUPbcsRqQeMiHcf+SKV4=
X-Received: by 2002:a63:af53:0:b0:507:469a:ca54 with SMTP id
 s19-20020a63af53000000b00507469aca54mr2255004pgo.7.1678164505961; Mon, 06 Mar
 2023 20:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20230302023509.319903-1-saravanak@google.com> <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
 <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com> <CAGETcx_crW9BJmUoVJv1iU-KTr+9WPp_bpfrKoxzQiJGpqDgAA@mail.gmail.com>
In-Reply-To: <CAGETcx_crW9BJmUoVJv1iU-KTr+9WPp_bpfrKoxzQiJGpqDgAA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Mar 2023 20:47:48 -0800
Message-ID: <CAGETcx8e4eUqXPrKTxjJWENs2iwP-d3L_EK4Qp-pit0hrm9FaA@mail.gmail.com>
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 2, 2023 at 10:07=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Thu, Mar 2, 2023 at 9:51=E2=80=AFAM Florian Fainelli <f.fainelli@gmail=
.com> wrote:
> >
> >
> >
> > On 3/2/2023 9:20 AM, Saravana Kannan wrote:
> > > On Thu, Mar 2, 2023 at 9:01=E2=80=AFAM Stefan Wahren <stefan.wahren@i=
2se.com> wrote:
> > >>
> > >> Hi Saravana,
> > >>
> > >> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
> > >>> This allow fw_devlink to do dependency tracking for serdev devices.
> > >>>
> > >>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> > >>> Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f=
17e5@gmail.com/
> > >>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> > >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >>
> > >> since this fixes an issue on Raspberry Pi 4, shouldn't this be menti=
oned
> > >> in the commit message and providing a Fixes tag?
> > >
> > > So RPi 4 was never creating a device links between serdev devices and
> > > their consumers. The error message was just a new one I added and we
> > > are noticing and catching the fact that serdev wasn't setting fwnode
> > > for a device.
> > >
> > > I'm also not sure if I can say this commit "Fixes" an issue in serdev
> > > core because when serdev core was written, fw_devlink wasn't a thing.
> > > Once I add Fixes, people will start pulling this into stable
> > > branches/other trees where I don't think this should be pulled into
> > > older stable branches.
> >
> > That is kind of the point of Fixes: tag, is not it? It is appropriate t=
o
> > list a commit that is not specific to serdev, but maybe a particular
> > point into the fw_devlink history.
>
> I don't want to pick an arbitrary point in fw_devlink as I don't want
> people picking this up with some old version of fw_devlink and having
> to support it there.
>
> > Given this did not appear to have a
> > functional impact, we could go without one.
>
> This is my take too.
>
> Greg/Rob,
>
> If you really want a Fixes here, can you please just add it instead of
> a v2 patch just for that? You can use this commit:
> 3fb16866b51d driver core: fw_devlink: Make cycle detection more robust

Rob/Greg,

Can you pick this up for 6.3-rc2 please?

-Saravana
