Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F4CDB482
	for <linux-serial@archiver.kernel.org>; Fri, 13 Oct 2023 21:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjJMV3T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Oct 2023 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJMV3S (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Oct 2023 17:29:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52676B7
        for <linux-serial@vger.kernel.org>; Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-419b53acc11so35551cf.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232556; x=1697837356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbnszuC6zZy9ZUsF74yWxSFhfV0I+Nmxa40zOQ2lSHM=;
        b=IgK+mnsKu8Ft4bT9XiWU9pObZSzyJRLvAieYMC3f08hehTP9jVLMkTpG10L1paiBlK
         JkSv10u18Ix5Kq/P4422fRm9wWDW+pDCrPRZ9XsHRaTlVNHrRcSb8QhVxi/y/nJGMD5U
         UNdxHsKsCkH5Sf7EA7pd0mO2a/UACdhOjE7wJfaXI5cyMIdpBt1E9cvInLGU38j+0hxr
         jW7Z0FQre9XxK2ru6nRlUMZ+PpElyLsbOob09vzxk4ivzXtq4PECLZt6O6fxhC1aFBrn
         QpSZ/KyLCt8dKeQDAFY6yzkUStE9cEU9N1C6ry5HLETWcFATZekPscERJmpGHj76FgUM
         gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232556; x=1697837356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbnszuC6zZy9ZUsF74yWxSFhfV0I+Nmxa40zOQ2lSHM=;
        b=Li3BQEeyJzLvR7sSoHm1n2Jn4bQvSTYeqGPAbAYdwlqecvOtytySjcVpNS9C9Bvvz9
         1x9cDGqsP6mM8fippusER+kBXeJFbxC9WNHkimoTQ0rtxlJ6rGkx9XJSIUnnSxAF6lP2
         pub1uGfS463zNpKkQKJtklkVhLaFa+1CDKFaPZQPkA/qWZSmUpt0LbsmYWk4zuBXNGu8
         IXaFLW1Z68y8P494DJZ4mz8VgbdVGBxKXXs0/vgFxJwkm9Jn/RL4nfalXUGJqFDm3qWo
         TobLiStymSrRvpcMzlIz9SajqrwfRtX+5Y63tpByt7uO0dCEGJIPV5DELTsJrek11hIi
         fGtA==
X-Gm-Message-State: AOJu0Yy13aB3bYvOPf5smZK+6NrkptgSfVkDupakm+WiX85Q3Or2tPf1
        JdWaelF0sZjmkqXo1KVbrwU07o9FynYfRRL+J9c8lQ==
X-Google-Smtp-Source: AGHT+IHpRGFmriEzL/KQ9RKsS2oHgCTUAzVCmj/q0lNV14br53Tcpyvzbb4wsjq5Hz1EXcDQc6RCLu7ojVHBJSnpDQs=
X-Received: by 2002:a05:622a:2c02:b0:417:9238:5a30 with SMTP id
 kk2-20020a05622a2c0200b0041792385a30mr283qtb.29.1697232556224; Fri, 13 Oct
 2023 14:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013154742.76836-1-emkan@prevas.dk>
In-Reply-To: <20231013154742.76836-1-emkan@prevas.dk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 Oct 2023 14:28:40 -0700
Message-ID: <CAGETcx-MP7XNUa0uObFpEDBiwjaGgTGvKu6Q-RXkrh0+hvXZvQ@mail.gmail.com>
Subject: Re: [PATCH] serial: amba-pl011: set fwnode from parent device
To:     Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 13, 2023 at 8:48=E2=80=AFAM Emil Kronborg Andersen <emkan@preva=
s.dk> wrote:
>
> After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> detection more robust"), consumer devices without their fwnode set
> printed errors like the one below:
>
> [    0.261887] uart-pl011 3f201000.serial: Failed to create device link (=
0x180) with soc:firmware:gpio
>
> To fix this, set the fwnode so fw_devlink can find and handle it
> properly.
>
> Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more =
robust")
> Signed-off-by: Emil Kronborg Andersen <emkan@prevas.dk>
> ---
>  drivers/tty/serial/amba-pl011.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 3dc9b0fcab1c..29cef84b71c0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2798,6 +2798,8 @@ static int pl011_probe(struct amba_device *dev, con=
st struct amba_id *id)
>         int portnr, ret;
>         u32 val;
>
> +       device_set_node(&dev->dev, dev_fwnode(dev->dev.parent));
> +

Can we do this at a tty/serial framework level instead of just this
driver? Also, this is the latest kernel? I feel like I fixed exactly
this (but at a framework level) several months ago.

-Saravana

>         portnr =3D pl011_find_free_port();
>         if (portnr < 0)
>                 return portnr;
> --
> 2.41.0
>
