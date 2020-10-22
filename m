Return-Path: <SRS0=OWvP=D5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86242C388F9
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 20:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3724C2080C
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 20:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7kxTO8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372048AbgJVU4O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372046AbgJVUze (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 16:55:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A27BC0613CE;
        Thu, 22 Oct 2020 13:55:34 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o18so3156982edq.4;
        Thu, 22 Oct 2020 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+YUmu0XSELNiYyqU33MOteA9uI8G07MKxivq1uSP6k=;
        b=U7kxTO8JyuAyBYYkLInHMXXWPa+YbTjJx/k9WhajqjRhCqpZy/6hFDngruWeWFXRK8
         M2HHRW6tmo8jDISOME/OoHmDP6rGQGaGcFgAlkGZcFyfIUXcUNKGvTqmXsdgfenjnslw
         wj2Eah+BrLt4E3rYIZro/EgzdqX4PbbQ0ThGxJRfmjhXPIOZkNg1V6m4frt0A+/OGTK1
         0NemO+aymffE0npO0ihgi/f4ylcsW6N8tAb+UN48uqj2BeRZQ8qgl09mo6lJ5+Wv2zC3
         pCMDM49LBO+2DmY+53XGAORuJEcdEld29ZK7cPTO/7wjozHHrVF+rfn9FI3bx8lPwgiH
         aHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m+YUmu0XSELNiYyqU33MOteA9uI8G07MKxivq1uSP6k=;
        b=MUdGkxzNjFLGJYffo09VJv1ZgddtbQBQjSIKjeQkaxjy6fdCWpCnV+AXqpwqTVhhkO
         yGLErAndS15K3BQxZm1yjqg7wQ5bbUctv1HLjIfadN5tgZN4fAFKSWnvX0/nei4DcsdC
         rSSU3ozXneTLzKr3Q830u//hpz+TD3ACoP4BcXEK9cMOAa9y60Lg1Qhnpeb93N11tW2Q
         QbHLjGLoufKzMIkjug6icXCmmZj6T3bTHqla2xOYOUDYnNBHpNcDrK6HocY3oR8JlNrb
         9X93y6GWavN+anQUmVL0jt+mmMRqWHd6o62c9MyM2t8gjXVGP1O6ZyrmCS0/QPeicSy2
         gb9Q==
X-Gm-Message-State: AOAM533utV1+mnnLWc/TRFm8tE5m0LRDN6NWQjK2/2iAcnOqj1hyhnH3
        +3CPW+a0OGZ5MFIo456VvJs=
X-Google-Smtp-Source: ABdhPJx9zp72BGL6TcQ++4R1pnLJTEnLDpe7EIsHupS5Iyi/2UMnsLR2o3jRAnBobrPBut1vK/1wTQ==
X-Received: by 2002:aa7:d349:: with SMTP id m9mr4008742edr.51.1603400132849;
        Thu, 22 Oct 2020 13:55:32 -0700 (PDT)
Received: from skbuf ([188.26.174.215])
        by smtp.gmail.com with ESMTPSA id i18sm1468651ejr.59.2020.10.22.13.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:55:32 -0700 (PDT)
Date:   Thu, 22 Oct 2020 23:55:31 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: LS1021A has a FIFO size of 32
 datawords
Message-ID: <20201022205531.5264ncmfuibp3vmj@skbuf>
References: <20201022151250.3236335-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022151250.3236335-1-olteanv@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 22, 2020 at 06:12:50PM +0300, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Similar to the workaround applied by Michael Walle in commit
> c2f448cff22a ("tty: serial: fsl_lpuart: add LS1028A support"), it turns
> out that the LPUARTx_FIFO encoding for fields TXFIFOSIZE and RXFIFOSIZE
> is the same for LS1028A as for LS1021A.
> 
> The RXFIFOSIZE in the Layerscape SoCs is fixed at this value:
> 101 Receive FIFO/Buffer depth = 32 datawords.
> 
> When Andy Duan wrote the commit in Fixes: below, he assumed that the 101
> encoding means 64 datawords. But this is not true for Layerscape. So
> that commit broke LS1021A, and this patch is extending the workaround
> for LS1028A which appeared in the meantime, to fix that breakage.
> 
> When the driver thinks that it has a deeper FIFO than it really has,
> getty (user space) output gets truncated.
> 
> Many thanks to Michael for suggesting this!
> 
> Fixes: f77ebb241ce0 ("tty: serial: fsl_lpuart: correct the FIFO depth size")
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Please don't merge this yet. The patch works, but the commit message is
a mess. Right now I suspect there might be some issues in the documentation.
I'll return with a v2 when I get that clarified.
