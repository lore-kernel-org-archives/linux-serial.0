Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2737EC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 03:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7CE611C5
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 03:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhIUEAr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Sep 2021 00:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhIUEAm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Sep 2021 00:00:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCDC061574;
        Mon, 20 Sep 2021 20:59:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s11so19479909pgr.11;
        Mon, 20 Sep 2021 20:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJuxCA+lr9aQqZZBT5ST0vvzTYsVU9ziB3RzbVagWdY=;
        b=Zn7eGmlQ2ODCP6PbCnG87aTNmNcU9IQZudac1EfAt7dKL8YcLe+9f+nlnOEE/kmIyL
         5ldZV6Jr77aLr7D2CmIqb3yd9e5oYOxBLbwwdD/FcoYiDruTd5vQBz+ez333TGmrWq+Y
         pOBGeFOh3RbbjrsPZDybbugkuvkFA7WJXlZJASPcRogD7BdxlJDT5oaRDM5eF4job5vn
         /lFlLIJtwIhdx1JBUSE0CCVkgIJ/BFPIgCEkNw1+Y0l6zMxsqv5teWXKE4NkiP1h6U3f
         vmg0NBRqUx01wO2+BiqjB5amg0BNf7KCgsfRTQH6fjLL3QWn/VQEK9Fc6IKrYp+hWMdD
         cA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJuxCA+lr9aQqZZBT5ST0vvzTYsVU9ziB3RzbVagWdY=;
        b=uu50vEBOHy1rKsfzQm4j0NGMrX9Njvki/eJWoXAnGjo5D8Kwa4GxGHyM5phQs4FTPU
         aNyRk3jTIxQXISX6hUovuw0N2SLV1Kdep0mJi5Xb3q6Jg4DrtFNRWORoDyZfEUMtQiex
         1pBo/Yq4x+BqOsiJ7MFNvUYw9KsumHhXig8Li1jpicWJnV1/TFJb4ywKfgN6UirnJPKC
         RSJDWaUAkantJR7cguYJN4AIRsO0suT1Le2BkQ1+vXZ98HM8pNNlIk2uzGLj8MSa70VX
         uTJ3sXyDlQLsQqOeogZGWfANCqGJrIDcGvu4cWyYEvkpAdHgYi2P7o+bZOuAJoETUVWT
         LZZw==
X-Gm-Message-State: AOAM532qjcZ+ZSZLDMA2BR0+vkQ2zesrPQ9a5Fsk3jrglPhcV0tHWUv3
        ukwcs9i8C9Zr8sgOTuHc9TE=
X-Google-Smtp-Source: ABdhPJytZlhnayh07mqRDvv42PYDgjOF+j7pVNZCzv3Yjcmxur5gjwgsGchuhhyucaUnA38ZdzIk4g==
X-Received: by 2002:a63:720d:: with SMTP id n13mr26275111pgc.470.1632196754368;
        Mon, 20 Sep 2021 20:59:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a5b4:f272:6a63:5b57])
        by smtp.gmail.com with ESMTPSA id k3sm795327pjg.43.2021.09.20.20.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 20:59:13 -0700 (PDT)
Date:   Mon, 20 Sep 2021 20:59:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 04/16] tty: make tty_ldisc_ops::hangup return void
Message-ID: <YUlYjs+lYhPDSHGe@google.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914091134.17426-4-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 14, 2021 at 11:11:22AM +0200, Jiri Slaby wrote:
> The documentation says that the return value of tty_ldisc_ops::hangup
> hook is ignored. And it really is, so there is no point for its return
> type to be int. Switch it to void and all the hooks too.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
>  Documentation/driver-api/serial/tty.rst | 2 +-
>  drivers/input/serio/serport.c           | 3 +--

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
