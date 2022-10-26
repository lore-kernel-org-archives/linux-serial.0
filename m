Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE69C38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 03:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJZDHj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Oct 2022 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiJZDGw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Oct 2022 23:06:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF4BD4
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 20:06:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n7so12800977plp.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Oct 2022 20:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fv8tZlCE2C/8RjSw8oIgAc0C5xSK3s6TOZjbQcug7xk=;
        b=Wzd1KdGC6G/8JvgpWjIBQyvt3bd+fvzErMRt2vXj9IboIB/xhU3AY3CtIWwU+aW9dM
         a6kjk/ql8RQr8qFgmkZPuD9zju4pCKQylFVvFCIpbnQ0zEeWlEi4LTOabhbAvw8wsJp4
         TZtIbspdn/Dh8dPKNZhTVT+rCAEYpRZDJLiQo3wIIe135h2rM+mS0n0NqkPRWc0vdxxh
         4h6p10HBSNWHMd4gdlbzZAOMv8eVfwIixx7Pv3fy+lq2PSHhwW+Nq0gH2wOM5XWDg6ni
         KzK99/JireSPTExYPkZe4Sunqo2/6g9U+U3RBeFMumfFO74nopIOKw7dNgEglqhE5KOJ
         Qd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv8tZlCE2C/8RjSw8oIgAc0C5xSK3s6TOZjbQcug7xk=;
        b=LKZF5Y+nibxCWzJUNW9hvPbbDpRuhHz8r3BHGbOirao8PXRt2z4oRnxHQNTAvN1V7P
         YsLz4qywnEjcHxQCvcJ+wjs1TyWDVvTmRcGbV7MNzbr/q1uW9ycWZBsTjD5uvCPXSMPz
         OE5fp0PN2XzCulmKT+JRUUV0Xf9fxE5AJeVuE9whut76SzssyVEZ2YYCgI/tN0RsYDr7
         OuHoS8TBBD8k420n0e/dbJVIaOifMC1gEDcKhiGHvzxZLWpXIl43HOTAPAm+GJivyXKH
         QVokXn8QZK6kDqGU5BQOdvBjnAjkFHrC3Tu5O6OGI6xSVDo2/XMizdunVJ8mfzTPo2Vj
         b2bA==
X-Gm-Message-State: ACrzQf29l1pOqCgd3fLFE4q6vS1bKL7rnig1qsmM2fzRPQ3rnHVfYfXi
        HBgZyNHgwqp79vjmobhSl0Z6gB3U8R5l2aMErIE=
X-Google-Smtp-Source: AMsMyM7nCk47BC2AYPGALr62Zx4JP+0QPj6dxYohfMurO0tN4+SYXrJTXu7M2pD2fivnoqDP73qRK29ZH9uS9RwkwiI=
X-Received: by 2002:a17:90b:190f:b0:211:5d2a:ade9 with SMTP id
 mp15-20020a17090b190f00b002115d2aade9mr1792929pjb.76.1666753607474; Tue, 25
 Oct 2022 20:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
In-Reply-To: <20221003110850.GA28338@francesco-nb.int.toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Oct 2022 00:06:34 -0300
Message-ID: <CAOMZO5BWUrFWyLFo8X=TfOBtoc6U0vNYR3k7wPNcVXd93q+Wjg@mail.gmail.com>
Subject: Re: imx serial chars lost issue
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Francesco,

On Mon, Oct 3, 2022 at 8:08 AM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> Hello all,
> recently I have been experiencing an issue with the imx uart on i.MX6ULL

Does this also happen with other i.MX devices or only on i.MX6ULL?

> SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
> are lost when typing "fast" (copy/paste or writing to the uart using
> automated tools).
>
> This was tested on Linux 6.0, however it does not look like a brand new
> regression, kernel 5.4 was somehow subject to the same issue, although
> it was way more difficult to trigger it.
>
> While I do understand that without flow control this is something that
> cannot be prevented, it is pretty fishy that is always the chars after
> the 32nd.
>
> I guess that might be happening is that the FIFO is emptied only by a
> timer or when it is full, instead of emptying it when half-full, and the
> CPU might not be fast enough leading to an overflow and the chars lost.
>
> Any idea?

Can you share a reproducer?
