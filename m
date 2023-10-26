Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794ABC25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 12:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbjJZMaS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJZMaR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 08:30:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E27C0
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 05:30:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c9305727so2517e87.1
        for <linux-serial@vger.kernel.org>; Thu, 26 Oct 2023 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698323413; x=1698928213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qhWD/wKolF9uKVlzI4nYGJUgFmTHF3AiqIVIus6VkI=;
        b=bTgPD/Oky+VIhlbStwAtXE7KjxqEkhbMZN77jFSHaiK/OypjmyBKXF0ciRlRCqrogF
         OBTFuR4mJxyurpAYilmf8ulciK9I3SPEcHC+QGxUqltKJOgXayGBsmh3FxBIH80cUKAV
         eSgWCm9tEmBfRQGL7TerMB1bup9dtPqe/XXFQWj+ug42CWYJWXLpj4i5rqeUa65Swjym
         Hw07JeR/ooI1YiU8cNctKjbc8L/AzNJEktoa9o+58+O59UoCKP42LgS4q4Szb0cy2A6o
         bSX/mw1Pxr0zlmHpODKkgs6fTIkXEHIUnN9Qfv9Gj0qJAMUbS9ts1B73Xy1fDn0mkoN/
         cDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323413; x=1698928213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qhWD/wKolF9uKVlzI4nYGJUgFmTHF3AiqIVIus6VkI=;
        b=inPKnsEnMI9ZAm8x2Hm9GwExOQja6Hsbi3KfHjlOHPtmDCXdj+RxMHAelat77kp8aa
         Bt02Y9aVVmd1wtrmxA0Cqh6VZCH2KUtNxPxSOrQuuIGOewGl6rOMhUIiWIZysVZ4Xhmi
         Zd+KRAWfhzh0lVZz9fGceoz+o/LfZ+iyln1eGBZTrfc1RCN2mr/qitXaCxREYg+p3X2H
         WtnNOyVcdaMAYi7DQATtNGe9aib2oM4IFo1g3zo6xCxRWaSrJL+7JLJfUI/9EQVHr/tY
         1NREOM82DNlYzfIjXTHNDnKvj4n/UHCAXa9/B5HQsR17atqdnsHjFFqBNoXdcGyjLohT
         rcCw==
X-Gm-Message-State: AOJu0Yz31aMLDtKG8A5aY7p2IiqAK+t2FOsPifrZXTBWRokgPYGZ0dt8
        xHebHDN2GBVnT+A2r0CINBTNH6cUWCQjxJzUNXZCXA==
X-Google-Smtp-Source: AGHT+IE6QM/eApLj1AsHNxFOYu2uDQvZytkXOnMiEtLdFb8n5Du8D+PFTiiqmsRDdm6maD8J7henO7mIi4vqnWhGmMI=
X-Received: by 2002:ac2:4e90:0:b0:504:7b50:ec9a with SMTP id
 o16-20020ac24e90000000b005047b50ec9amr156584lfr.1.1698323413398; Thu, 26 Oct
 2023 05:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231025142609.2869769-1-vamshigajjela@google.com>
 <7e7eb495-8e54-49f3-bab7-0de72b2cf7b6@kernel.org> <b86df0e0-ba54-232-1854-bf3d1cbbe479@linux.intel.com>
 <3bd3d362-94c5-4d50-9404-0e4f6a3dec21@kernel.org>
In-Reply-To: <3bd3d362-94c5-4d50-9404-0e4f6a3dec21@kernel.org>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Thu, 26 Oct 2023 18:00:01 +0530
Message-ID: <CAMTSyjoE+3B=ACLW4=Pz-otu4q7fMU1OXE-fmTdvVu569906Tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 26, 2023 at 3:19=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 26. 10. 23, 11:24, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 26 Oct 2023, Jiri Slaby wrote:
> >
> >> On 25. 10. 23, 16:26, Vamshi Gajjela wrote:
> >>> From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >>>
> >>> The function uart_fifo_timeout() returns an unsigned long value, whic=
h is
> >>> the number of jiffies. Therefore, the function uart_poll_timeout() ha=
s been
> >>> modified to use an unsigned long type for timeout values instead of a=
n int
> >>> and to avoid truncation.
> >>
> >> Hi,
> >>
> >> there is no truncation possible, right?
> >
> > That's very likely true (I didn't run the calculations), thus it's corr=
ect
> > to not have Fixes tag.
>
> Good. I would remove that "and to avoid truncation" completely from the
> commit log. I would only say that we are getting things consistent.
>
> "avoid truncation" can lead to -> we should backport it to stable. And
> neither is true.
I will drop "and to avoid truncation".
>
> > It's more about having consistent typing since
> > we're talking about jiffies, so unsigned long as usual.
>
> Yeah and that's of course fine by me.
>
> thanks,
> --
> js
> suse labs
>
