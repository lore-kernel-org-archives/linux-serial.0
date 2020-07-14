Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0090DC433ED
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FAB217BA
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 00:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DsVuBHOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGNAxg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGNAxf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Jul 2020 20:53:35 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C7C08C5DB
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2020 17:53:34 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id m6so3499330vsl.12
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2020 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBmPGkwb8F27DgB7ghpu4ldmH1wyapHT/SdG1wNVoGM=;
        b=DsVuBHOSfihKaNkABXRm4ftNILFS5xlzW6RCsluK4T11o2qaXfRJa5N0UNwsp+0kCJ
         53tVV/PwX28dzQ54HAuuCIN7gy+nUOCPu2EunQOHMCfOVUG950g7F3158McC+Q3pXBLw
         KdViqNVDKlGvtHk3ZRRKIfsi3+Ub9nFkvXgaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBmPGkwb8F27DgB7ghpu4ldmH1wyapHT/SdG1wNVoGM=;
        b=rmvbV2DoCgknthX6yOXVN9m8MsGTq2yz3SOK7NsYoa9/LTPFX/spv0QIIT/TMECadS
         385P9oEgiM5Ahq6w2Bg95jH59WRyiZgCh66L4/1DBTIW6wII/R+NsPewZJUhUGSJQcO1
         ClWE3m7R8/NW3PEEFKcrMclLmlJOkwibFe72yG0n5Uqkg/mp4fpGj6WIbAczKLUg4vzF
         AplFSe0DEXRZakDIiILM/Mph+Bv6BSAmfmoJohNZ+ears5fDCowjTGgLk4oDih3edCpd
         TUCnrxz1hgsNCCk2JeeuO405mAQA5aDd6lfzoDV3KNBcpXzsViupvNygN6vCx5khQrCL
         yVyQ==
X-Gm-Message-State: AOAM530o0pfVECUSh0MClwXnw8kq3tYcGL3LI9LeCaYBC2/bmbMXBznK
        h7IEnuadVY0T0dJ/A6bqkgtIIBneQsw=
X-Google-Smtp-Source: ABdhPJw84B7/TEl6kvDyqWQnOoXmSSl0r2jFKcdnY7ehITrMKobwTsZqZjTOhLK7XEmb+BROHYYBlQ==
X-Received: by 2002:a67:d90c:: with SMTP id t12mr1548276vsj.88.1594688013442;
        Mon, 13 Jul 2020 17:53:33 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id x25sm2069295vsg.21.2020.07.13.17.53.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 17:53:32 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id o25so4954672uar.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Jul 2020 17:53:31 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr1932767uav.0.1594688011224;
 Mon, 13 Jul 2020 17:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <1594287420-24141-1-git-send-email-rnayak@codeaurora.org> <20200710124152.GC1567243@kroah.com>
In-Reply-To: <20200710124152.GC1567243@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 17:53:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJQaAHsDb6uvKpwU87qtqTQgNeoiuRr2kF9pqjBLhLpg@mail.gmail.com>
Message-ID: <CAD=FV=XJQaAHsDb6uvKpwU87qtqTQgNeoiuRr2kF9pqjBLhLpg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Drop the icc bw votes in
 suspend for console
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rajendra,

On Fri, Jul 10, 2020 at 5:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 09, 2020 at 03:07:00PM +0530, Rajendra Nayak wrote:
> > When using the geni-serial as console, its important to be
> > able to hit the lowest possible power state in suspend,
> > even with no_console_suspend.
> > The only thing that prevents it today on platforms like the sc7180
> > is the interconnect BW votes, which we certainly don't need when
> > the system is in suspend. So in the suspend handler mark them as
> > ACTIVE_ONLY (0x3) and on resume switch them back to the ALWAYS tag (0x7)
> >
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> > Note: Patch applies on qcom for-next, which has the ICC support patches.
> > The tag macros are currently not exported and hence the hardcoded values.
> > Perhaps if and when https://patchwork.kernel.org/patch/11619705/ lands I
> > can refresh this patch to use the macros.
>
> Feel free to take this patch through that tree.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Could you post a v2?  Bjorn landed some of my geni serial patches to
make console / kgdb work better, but then I realized that your patch
no longer applies cleanly.  It's trivial to resolve, so hopefully a v2
should be quick and then Bjorn can land?

Thanks!

-Doug
