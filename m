Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4CC433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 10:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3AF619E7
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 10:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353534AbhJAKTt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhJAKTs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 06:19:48 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EACC061775
        for <linux-serial@vger.kernel.org>; Fri,  1 Oct 2021 03:18:04 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id h30so10707213vsq.3
        for <linux-serial@vger.kernel.org>; Fri, 01 Oct 2021 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnzLo7JuOgPTex901OVvNPcD6zHhea0gzI4vIWPr/tI=;
        b=j6FXlORZs9bAVDLoXQsslelJVnsTa7XwScL9ogRK0Tx3/bM6Wdu7kF18zzgLPRh4Qp
         UHNg0ttE/l0QJIoHhUgXASQ+YJcDPA+CJKVo7lzSRF30YY5dWEftTteVTbcD6JVT1clC
         1jmnXRftzptGwhX2K7k8mxoA43+qNnlm57hiwp0rfnFM/ikuNdtEiO76WTyT/pWZVvYv
         Ik+BVzK6LSqPSc2kSqKTl0fGkhW9ylHS5+3PTHRAOkiCFAY3SbQwDgVYxdjOBFnoI17A
         bXseVkhfucvUKuQnc4vfPwCkZ1LmfuzQhu/DpcGPR1X/FG0ELmuk6ljSyPfxCVRo7E4u
         YjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnzLo7JuOgPTex901OVvNPcD6zHhea0gzI4vIWPr/tI=;
        b=JDLFmqC/J5SbzMT2B7l/Y9HFYQqxmNUG9JIYeofvHDDdVL5DpqUr12Lf1HafhGnH32
         5NSMe0vPJCi0A82UcD3ORuatK9I0V4B4+kOtnWAOBBBimqMQDUmqzOfzYMK015eTJMzl
         cyxHQoNtK89VinoPTBSrRZTZjR4cvz7FG1QriXkdtzVJZSZ0g84oeZ4BgCTmTNN/89ra
         svnu4YIZiUFyKF8xYUmLcZqeDULO6/3ahBVZqEqj+pzTnd4MBlxpv+7xHjP92sLt4G/3
         RKPPZAJEGm3BNOloRFTxsC96o1oVePFZ7kOCpIHjyEYcC88W8bD13i61dhZLit/iv115
         6zag==
X-Gm-Message-State: AOAM530VCpsgjkJLvms6jxLzl9/92s1R4VPQktFBSEalKUxIzpd3qPZ+
        DPsBktZI0277IMpbnLuKq4Twabo9Ocd6exvLBYA=
X-Google-Smtp-Source: ABdhPJwoKrNdNyS+N9YKh9eeDJ3wYiwESY6XgtPWJGFy7+ZR88ZFxOP77+Iw4k5F6F/rcePqSpbvgCvfyIrfwrJ5TEA=
X-Received: by 2002:a05:6102:40f:: with SMTP id d15mr3098228vsq.51.1633083483872;
 Fri, 01 Oct 2021 03:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210929214324.44910-1-festevam@denx.de> <YVVtRw/JlUzn4H54@hovoldconsulting.com>
 <bae11ec74a0515841ad36403b9f5a47b@denx.de> <YVa+VL5W+Gnp7TUa@hovoldconsulting.com>
In-Reply-To: <YVa+VL5W+Gnp7TUa@hovoldconsulting.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 1 Oct 2021 07:17:53 -0300
Message-ID: <CAOMZO5BD95rpU-ChZp591JnnYbGFUZuUdTVxwDNsMUObWVmA_A@mail.gmail.com>
Subject: Re: [PATCH v2] serial: imx: Fix sysrq deadlock
To:     Johan Hovold <johan@kernel.org>
Cc:     Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, linux-serial@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On Fri, Oct 1, 2021 at 4:53 AM Johan Hovold <johan@kernel.org> wrote:

> Why did you drop the cast? If there's anything in the high bits you'd
> see the help text printed as you report below (even if it seems
> unlikely).

That was it, thanks!

I have taken your feedback into consideration and sent a v3.

The only one that I didn't do was to reorganize the code to avoid the
unlock/lock as
this would require a significant rework.

Thanks,

Fabio Estevam
