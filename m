Return-Path: <SRS0=CVbj=7E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F53BC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19BC20663
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mg2kS9Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgEVPai (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 May 2020 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbgEVPag (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 11:30:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DEBC05BD43
        for <linux-serial@vger.kernel.org>; Fri, 22 May 2020 08:30:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so10547920wra.7
        for <linux-serial@vger.kernel.org>; Fri, 22 May 2020 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pGeQM1dfUNV6yQ38TOhnl5g6+/IaVOCSaD7SXsj2Qr0=;
        b=mg2kS9Pu1T9ifwA0mpe05G6x1t3Ppsu6Qa9bXzWW2e6DFx59fezJbsW2NF+OXfSVuC
         Blu/dzlOcOswC+7Iw8mDznR1oinY/l1z2OI2khb6hZvq4I4YmdUZP2CPUwqDsEaufnyR
         TMzgi4MvNkrvCwbWY/UagHowidZFgkx+JT8N2ubypvj/d/NlXd13PO3c1cDmOKeyYF2X
         VCsLocQmET+wvTcAc8fK1tjVUi9HlV+FVExJyheWj/mr1qZ4snmmJHrtj30zfcoHYnEL
         VA3V+lp2ZccpcgXMGRm9gcGo7HEEJkJIKsWnOz0OZYCegnBIdfRlOXwkScDCaclM3+To
         YvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pGeQM1dfUNV6yQ38TOhnl5g6+/IaVOCSaD7SXsj2Qr0=;
        b=FICHqHVoEDmSG09/ML5e2PY5fvwK2dFKS5DEC7/NBur1IU6o9BBEHLFZXF/BoRQz74
         XhtN9FDC3V46GupkQoeKiV0MIdkD+qIDQnWpKol8e+pgP8uW/1Wnqc+nuLkAX0FT2jq+
         0t3/OMORQSV7PF0XWVDCYNBmNaaaNhQz0vedxly2RvqItb9Aik9XjqFTePRgQzCWQRp0
         sHliAGuGEWV7w/wbtcXjH14omw90eCHKS9HGE+qLGqOHBEPh8ePb6qKzDjQRiPyBYurM
         Wiy3itsbw/oHRszRZhTjoA7ENhZqNbMHrCju4KDNdGIP1I/5CXv8lyx9ZGDxOk23rVQG
         12Fw==
X-Gm-Message-State: AOAM530FtczUccnSUmko4UIh659bxJqYflv5XLZcAnjTyfivLDCMsWq5
        xybsWDPvNOsSTcayexU38cRyvQ==
X-Google-Smtp-Source: ABdhPJykHFJmAf/i5dNkdymoFT6Eq28I067RserzsVvEDrvOVnCQI48w16BcpwS4ezASlB8WW50Iig==
X-Received: by 2002:adf:dc50:: with SMTP id m16mr3857267wrj.329.1590161433623;
        Fri, 22 May 2020 08:30:33 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z132sm10873040wmc.29.2020.05.22.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 08:30:32 -0700 (PDT)
Date:   Fri, 22 May 2020 16:30:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v2] serial: kgdboc: Allow earlycon initialization to be
 deferred
Message-ID: <20200522153031.2ydgx4k6jl7dsiqn@holly.lan>
References: <20200429170804.880720-1-daniel.thompson@linaro.org>
 <20200430161741.1832050-1-daniel.thompson@linaro.org>
 <CAD=FV=U64XLRFkTyTi1qDZjTYQKJ9WVBf3OoULpw6yncOQURTg@mail.gmail.com>
 <CAD=FV=Xut=5y-MyJSu+ERdMRkKbSf8SGMhUHg5OP=y8zA1N-xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xut=5y-MyJSu+ERdMRkKbSf8SGMhUHg5OP=y8zA1N-xQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, May 21, 2020 at 10:18:10AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 30, 2020 at 9:47 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Apr 30, 2020 at 9:18 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > Currently there is no guarantee that an earlycon will be initialized
> > > before kgdboc tries to adopt it. Almost the opposite: on systems
> > > with ACPI then if earlycon has no arguments then it is guaranteed that
> > > earlycon will not be initialized.
> > >
> > > This patch mitigates the problem by giving kgdboc_earlycon a second
> > > chance during console_init(). This isn't quite as good as stopping during
> > > early parameter parsing but it is still early in the kernel boot.
> > >
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >
> > > Notes:
> > >     v2: Simplified, more robust, runs earlier, still has Doug's
> > >         recent patchset as a prerequisite. What's not to like?
> > >
> > >     More specifically, based on feedback from Doug Anderson, I
> > >     have replaced the initial hacky implementation with a console
> > >     initcall.
> > >
> > >     I also made it defer more aggressively after realizing that both
> > >     earlycon and kgdboc_earlycon are handled as early parameters
> > >     (meaning I think the current approach relies on the ordering
> > >     of drivers/tty/serial/Makefile to ensure the earlycon is enabled
> > >     before kgdboc tries to adopt it).
> > >
> > >     Finally, my apologies to Jason and kgdb ML folks, who are seeing
> > >     this patch for the first time. I copied the original circulation
> > >     list from a patch that wasn't kgdb related and forgot to update.
> > >
> > >  drivers/tty/serial/kgdboc.c | 41 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > Thanks, this looks great!
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Are you planning to rebase this patch atop what landed?  It seems like
> a useful feature.  If you want me to give a shot a rebasing, let me
> know!

I've got it on it's way...


Daniel.
