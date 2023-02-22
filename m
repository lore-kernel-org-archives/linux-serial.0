Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03260C6379F
	for <linux-serial@archiver.kernel.org>; Wed, 22 Feb 2023 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBVJ7D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Feb 2023 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBVJ7C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Feb 2023 04:59:02 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D713DF4
        for <linux-serial@vger.kernel.org>; Wed, 22 Feb 2023 01:58:37 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id cf8so7704426ybb.11
        for <linux-serial@vger.kernel.org>; Wed, 22 Feb 2023 01:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0bM7PsmE0wf0+asUiEYKD7QDlHNZHf9CvubfF1/sRs=;
        b=OQUMilmYM4f9BHwyWGIF9no/TYDPrVshmbeFNhazNpGTND4ALChT/6g8StUN/imNLN
         b2Kq7mcun8v15bEvnSE6Jn0XRSoQoO4IYFYg2gG8TOvt6vBgZLyEOCCWF+UHOIe+AA3m
         mp+MoTbXPjRc5aIvnDyirfaM6UxRC+RNmaRo6rjZb5tljWE8YMAhSoE4QDJ3wyX6YkQQ
         q0COW52QwFd11jIR00fprY0l7NsGxznQvRapc9uTeOSN8uZkduY4BYtXfidOZlr0LoPt
         D3Sj1m25p2AA7LNKYWsnHbmpNly/RZIYd+5JeWe5bsqKZMJOlSWD8lldvPgx19nQugqJ
         O7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0bM7PsmE0wf0+asUiEYKD7QDlHNZHf9CvubfF1/sRs=;
        b=HLvhe5zj9TA0GmXVdrCoCZL7O4mgbxJ/nOzDn3kIeFsFy4U8+1SJoTkzfmMMSEadB+
         DBNhtHMNu4iazZiwVRdAdkfV+1fQRWAKG5r/YwEqwOHWr27PVXEo08AOgw+q9CvK0l56
         NWMd9crg8eFJ4uh1s5JvH5RlWQ4BUVj2Jof/eVprZtdfQpBFyYI6DvkFUujKtOFs1vl3
         ji7d1fBvRRuwuR58om9ZVgIlbLxFWAjc69KguIAQjKf018y+uM8J3GBto8rLOL6JzVDh
         QDREYDzbtWPEpqxkgMwp2zUuPWcGVghugqdLKA/sjb8ZC9gSCjsGxfvMk5XuZcwWanZV
         6C1Q==
X-Gm-Message-State: AO0yUKUoRJITnzJRkBXPppJu1sTCVH8AaInMIFg5bvmnXvIwgZ+xN02I
        FGUgh65yRVk8uWzNKqMTNKEoJIUSx61UGxqCMjNiFA==
X-Google-Smtp-Source: AK7set8vuBlOWMUYuYN+7GHWG9+nSHIdD2Y0EYhXoFQmb1bQZHobbsI7ZupueVYF73il0ZfrErH/ZZ/NAh8nxua5/Z8=
X-Received: by 2002:a25:8a84:0:b0:92c:2340:4dd9 with SMTP id
 h4-20020a258a84000000b0092c23404dd9mr124057ybl.309.1677059916205; Wed, 22 Feb
 2023 01:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20230125143503.1015424-1-bero@baylibre.com> <20230125143503.1015424-10-bero@baylibre.com>
 <8c348b39-67f3-9210-1929-8b2f093be24c@baylibre.com> <Y/XenZUmT7Nh2qGP@kroah.com>
In-Reply-To: <Y/XenZUmT7Nh2qGP@kroah.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 22 Feb 2023 10:58:25 +0100
Message-ID: <CAFGrd9qp-p5+8_LNo7G_+sMbRUtCXKOtRSPMxspxTS7H7iBw5g@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] arm64: dts: mediatek: Initial mt8365-evk support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com,
        khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,
Thanks for the update, I appreciate it.

Alex

Le mer. 22 f=C3=A9vr. 2023 =C3=A0 10:21, Greg KH <gregkh@linuxfoundation.or=
g> a =C3=A9crit :
>
> On Wed, Feb 22, 2023 at 09:17:39AM +0100, Alexandre Mergnat wrote:
> > Hi Matthias,
> >
> > This is a gentle ping to know if you can take this patch please.
> > Sorry for the double mail, I screwed up the first send.
>
> It's the middle of the merge window, we can't take _ANYTHING_ now.
> Please wait until after 6.3-rc1 is out.
>
> thanks,
>
> greg k-h
