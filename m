Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7769C43600
	for <linux-serial@archiver.kernel.org>; Sun, 25 Apr 2021 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF23D61176
	for <linux-serial@archiver.kernel.org>; Sun, 25 Apr 2021 08:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhDYIit (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhDYIip (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Apr 2021 04:38:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2FC061574
        for <linux-serial@vger.kernel.org>; Sun, 25 Apr 2021 01:38:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e2so23030957plh.8
        for <linux-serial@vger.kernel.org>; Sun, 25 Apr 2021 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3W3NlpZ/7gGHJzSngRPZUKdly0z6CYcYYet1o/3cStA=;
        b=DXhgLEsi/UC0GR5eFowFBe6fqTQ08/CSV6CJndatd25PlCEktjX6zCvjc3ZChBLqXb
         fSYFeoB1EtLxUcP7zuBG6mt6+6dv+g9Dwt2WD/DdcWVMFbz++XjMeHA9MO2A0mor7pem
         uNRuFOmpx5UJ6r1mtRpyCmsPaPwgQUSsrw4azukPCNco++CoqM9+kgWXJ92EzFgRAF97
         6Q6OQgpNecQl25PNJd6A3M0OcP+el5d/oCjkpuZ8nzcVPJF0P+lI3KjaWuLvrtoi4Hzb
         7T02TQpjumvtN7bJCUMGMxdFPncIWy32CBPuYhIzuo/4DhgV5scbUJljgZDMqXkI9duF
         4o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3W3NlpZ/7gGHJzSngRPZUKdly0z6CYcYYet1o/3cStA=;
        b=cOgckIXU98Wrd+AAyleuz7iwM6tXLnSoguFoN1DUw58jhE+B3bfM9snpVcf10EVRM1
         T3i6+LIGhsNTtP2c8sO5LZdHNMuFzudean3BhMqGCKzujEkpYbr7BBAe1t71EApUuCpz
         Xr71vNwGswMY5l3WYDWnpv8Ap1fS4ZK0iVW4YtxJd3/6hhtjddqb7jAnGSobRfsMgniS
         NvCBYX0CWKNGDMNIU8K3ehRYxBbcaJ1T95/T5TlN8PrUIQICkUCBZZfqDP4BP2IAAtL8
         l5p1BCjtajC7BTICjHwGxGOuTALXGTMy/Zl+dWfX20gkLDnL6b1WmivKe/hHkLl7Jb1+
         E7fg==
X-Gm-Message-State: AOAM533Qnn+sy1mJXgfc3n+KEvbLpttddkspZg2o0WrObmwRznpXNjGj
        JcKnn4W7vXnzkmsKWfxwSrmINA==
X-Google-Smtp-Source: ABdhPJw2m1tS8wv7y7a1jo2Ew6sVzyL43/PoChNVNkvcYnSnbekk+H2+GIggB/9rbKvDSb23HTPzHw==
X-Received: by 2002:a17:902:9347:b029:e8:c21c:f951 with SMTP id g7-20020a1709029347b02900e8c21cf951mr12640722plp.14.1619339884119;
        Sun, 25 Apr 2021 01:38:04 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id fw24sm8820653pjb.21.2021.04.25.01.37.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Apr 2021 01:38:03 -0700 (PDT)
Date:   Sun, 25 Apr 2021 16:37:55 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] firmware: replace HOTPLUG with UEVENT in FW_ACTION
 defines
Message-ID: <20210425083754.GF15093@dragon>
References: <20210425020024.28057-1-shawn.guo@linaro.org>
 <YIUI3TZf/sZ6Sd3K@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIUI3TZf/sZ6Sd3K@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Apr 25, 2021 at 08:14:53AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 25, 2021 at 10:00:24AM +0800, Shawn Guo wrote:
> > With commit 312c004d36ce ("[PATCH] driver core: replace "hotplug" by
> > "uevent"") already in the tree over a decade, update the name of
> > FW_ACTION defines to follow semantics, and reflect what the defines are
> > really meant for, i.e. whether or not generate user space event.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/dma/imx-sdma.c                      |  2 +-
> >  drivers/media/platform/exynos4-is/fimc-is.c |  2 +-
> >  drivers/mfd/iqs62x.c                        |  2 +-
> >  drivers/misc/lattice-ecp3-config.c          |  2 +-
> >  drivers/net/wireless/ti/wlcore/main.c       |  2 +-
> >  drivers/platform/x86/dell/dell_rbu.c        |  2 +-
> >  drivers/remoteproc/remoteproc_core.c        |  2 +-
> >  drivers/scsi/lpfc/lpfc_init.c               |  2 +-
> >  drivers/tty/serial/ucc_uart.c               |  2 +-
> >  include/linux/firmware.h                    |  4 ++--
> >  lib/test_firmware.c                         | 10 +++++-----
> >  sound/soc/codecs/wm8958-dsp2.c              |  6 +++---
> >  12 files changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index d5590c08db51..e2b559945c11 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -1829,7 +1829,7 @@ static int sdma_get_firmware(struct sdma_engine *sdma,
> >  	int ret;
> >  
> >  	ret = request_firmware_nowait(THIS_MODULE,
> > -			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
> > +			FW_ACTION_UEVENT, fw_name, sdma->dev,
> 
> Naming is hard :)
> 
> I can take this after -rc1, but really, is it needed?
> 
> What problem does this renaming solve?

To me, it's a leftover from commit 312c004d36ce that made the rename at
driver core.  With this patch, the define will be more matching its user
request_firmware_nowait(..., bool uevent, ...).

> Who is the current name
> confusing?

I'm one at least :)

Shawn
