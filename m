Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35504C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 04:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F29A611C7
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 04:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhIUECL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Sep 2021 00:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhIUECK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Sep 2021 00:02:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A481C061574;
        Mon, 20 Sep 2021 21:00:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso1552593pjb.3;
        Mon, 20 Sep 2021 21:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xFCBnQVx7npXDlKdoLeZ/0OzLiroLMQUu5YtCtK5R/A=;
        b=Q4FRE//aZyBLPYmYSgYNOZh5Wem2OHElLIbESwDWTnksykkSqx+p3fhl98yDO9jB6r
         Aw85l1zm/jISGVoFK30gMtQ3GoEvJnFKQIKN4z1D8QF+3Zal2pPsCcKtFed+laOU6XJ3
         xPvIhBswDJNfd6smnd4X6ua3sFLnihk5jXtVUA73GRulGujkm2CnYJZsrIJyx0JLJoIq
         K58/n8TaLSwejRqonGUYFkqPPpHXyfQ3/W6Elu/6lIGASIYFLatVoYEmrGqya8cURKXw
         nXV95KPqP5CmpzY/E7qFoGEZ+CETN/wyD4WIeX1sZFoP6QO0/lRnGbQd4/sP5E3GV1EK
         A8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xFCBnQVx7npXDlKdoLeZ/0OzLiroLMQUu5YtCtK5R/A=;
        b=I9nW3U2puHCxSdsvkAPn2TMlxlSrOYbDJ12+JrpbQc0AYQg3u/ZLKmG01xu8Yq/5iJ
         FjcKjWC1nT4+D+YgALcAbNkFyDd7UaYZ6xzxOGrfOXGyFUQnWiXhSS2lK3MQLHLOWEG9
         krr96incj9yLx1/bxAPTgz4hZQP+3D/YaeMRkIvwS9ZBssjG0VayNzpJOMW6//ZLMca6
         fPB1KwMWhr24lzCIjAW6hA/QY56aIw5qH6EP4MO/JInv/k7QbjcKHCZsJ1C4vPGR1vOE
         WXS4nQLNEFutTxAbsvWDBntGUj6eAM6ZPJfZp8dQWUzVfqISRK7Ce0T0BlNN5ejjI6BR
         G2mw==
X-Gm-Message-State: AOAM531llbwgvLv4l1Dq3ALiNupVf3zMs56hOzRTdL48hZ20Xj5gUP2Z
        doMSoyOnN7KL5kzyrNq4nUU=
X-Google-Smtp-Source: ABdhPJyvmmWmg+W05WZ/0c4SOltqO7vYIWdarVbkMT82paHNLIuqXJmk5YpfjVsY0ndE0/sXZkgdBA==
X-Received: by 2002:a17:902:7e4b:b0:13d:b90d:cdc1 with SMTP id a11-20020a1709027e4b00b0013db90dcdc1mr4477092pln.72.1632196842000;
        Mon, 20 Sep 2021 21:00:42 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a5b4:f272:6a63:5b57])
        by smtp.gmail.com with ESMTPSA id u10sm15780695pfn.147.2021.09.20.21.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:00:41 -0700 (PDT)
Date:   Mon, 20 Sep 2021 21:00:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
Message-ID: <YUlY5pQQWf2P2fKn@google.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914091134.17426-7-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Jiri,

On Tue, Sep 14, 2021 at 11:11:25AM +0200, Jiri Slaby wrote:
> diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
> index 17eb8f2aa48d..55e91d0e70ec 100644
> --- a/drivers/input/serio/serport.c
> +++ b/drivers/input/serio/serport.c
> @@ -207,8 +207,8 @@ static void serport_set_type(struct tty_struct *tty, unsigned long type)
>   * serport_ldisc_ioctl() allows to set the port protocol, and device ID
>   */
>  
> -static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
> -			       unsigned int cmd, unsigned long arg)
> +static int serport_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
> +		unsigned long arg)

Can we please keep arguments aligned as they were? Otherwise

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
