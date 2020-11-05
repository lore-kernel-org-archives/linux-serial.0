Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D2C4741F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E266E206A4
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOJb8U2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKEPli (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 10:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEPli (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 10:41:38 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FCC0613CF
        for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2020 07:41:37 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l2so2956962lfk.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2020 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjeebcJXavmd2z8RtxGEsVe+k4Dea5aVHoeGtZC60vc=;
        b=eOJb8U2RJxVCOIc3e3+fViBScIHpBgOjki2TMtU/sfY+Csm5509GdK71gL01XTtxwy
         ZhcnAV08tBSi7N0worrbv/zr15/CGaTkuosyP2+0l7Her15KzpK9A81HbaF+OraYyXwA
         b2Rmks9l18I6o6CWz6Qk+3JM4s8X/EnjbmAd2SzT5Ow4lEDHvvOlTjxXR53disPRp3dV
         WQwxHQlYbbSEA92M3nez8aP8HDmmsr5gUisCSOLIj5C7WMShhIdgvIFHEPWOunf/eqCA
         L/ZPvQOxyS3ZFj1JrIoo4jL90GAYRqLHb4O1lQeKH7qd5kSWFcOqyInVwFVW0nordW9S
         MZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjeebcJXavmd2z8RtxGEsVe+k4Dea5aVHoeGtZC60vc=;
        b=X5+QOhJ7seySQ8J1wgnJevaNK1tQxu7md38ZirLOp306fLzTKEjw0k+ML0+ReKszh0
         pjqlWbN+bMBDCqhc45gJ6/gUXzHDt/1MOi3RHZOKntWl8ugGoH2VXaUDlOAqxEXIEsNH
         f6Iw7rOoOCaDcH0kXMXvYmsWQ1tPmC6THEdeaA/ubGgyohBwhAFChHi3g4z86YcTlpcb
         Ne60BmQ/GrEorhFLbmLNoOpDx/D/cBZsAdGdYBmc0+IKWNjUj3U/TNDfAiMNLJ/+mOft
         fQ5XjxJT4o3xePWcR4tiyypgXLK5wmpadawbEvmr8EuWCSOyytAo6FXRoVw9iuWGrFZF
         BCVw==
X-Gm-Message-State: AOAM532Ofe+5vQwmJl1B1OebJj/G2Qsm0aRhpwVXTAyqkk04RSGizcZ+
        uSCGLZvGjY/vgT+5swGUj4W9YxTVtSfej509cUg=
X-Google-Smtp-Source: ABdhPJwy4hS1NE3QYoxRsKQHDooEUYlV81p4zk436GgzmVvPlz/PIEFE8TVhcOv6VBX7qvlLOsz1g5FpikL+PMUmoJQ=
X-Received: by 2002:ac2:418e:: with SMTP id z14mr1185047lfh.25.1604590894834;
 Thu, 05 Nov 2020 07:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20201105142844.1698969-1-l.stach@pengutronix.de>
In-Reply-To: <20201105142844.1698969-1-l.stach@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 5 Nov 2020 12:41:23 -0300
Message-ID: <CAOMZO5DNo=Yk5j+ip=T7giyuGP+vosy6Be58ySmBG3d-GbQBKg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: imx: enable eralycon by default if
 IMX_SERIAL_CONSOLE is enabled
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-serial@vger.kernel.org, patchwork-lst@pengutronix.de,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Lucas,

On Thu, Nov 5, 2020 at 11:29 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Since 699cc4dfd140 (tty: serial: imx: add imx earlycon driver), the earlycon
> part of imx serial is a separate driver and isn't necessarily enabled anymore
> when the console is enabled. This causes users to loose the earlycon
> functionality when upgrading their kenrel configuration via oldconfig.
>
> Enable earlycon by default when IMX_SERIAL_CONSOLE is enabled.
>
> Fixes: 699cc4dfd140 (tty: serial: imx: add imx earlycon driver)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

In the Subject: s/eralycon/earlycon
