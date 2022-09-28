Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF5C04A95
	for <linux-serial@archiver.kernel.org>; Wed, 28 Sep 2022 11:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiI1LOS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Sep 2022 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiI1LOB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Sep 2022 07:14:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E582746;
        Wed, 28 Sep 2022 04:12:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r20so7653015qtn.12;
        Wed, 28 Sep 2022 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=O+7aN7Pyi7vB73016tct0OjiYxGBoeThuIOSnpHypbo=;
        b=EbL2+Kg0+T5h9wU7g/Mwbc/+gz1rX/B0OwRN3wCxTOrAPLNUVAHLSKrenWD9DMDlZH
         0xKHdQQ9EnzuJz3jED1RnTpv7ZWCUYtRBbyGnUnEANy3FSO3DOlR+KCKDPo6+Na9Z5CT
         jSZR6zO2v7+JexYWqs7Fo/rhcosfjZafYS3RztWMTxYHIKBIyXRVU8R93tTh5tjU1OVy
         RAVgQyvZUv1CulWOo3Bt+dLMeGFJ34TdbD6LhrlmWDvhyaXL2IEcmwHCGzDiYtbIpugw
         D1/0sRiPD5s0OUepOLTq9pxUQdlhtpFqdBYxYeTMfny2zEdk/sZO7oOsbZMPd++ur4km
         NdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=O+7aN7Pyi7vB73016tct0OjiYxGBoeThuIOSnpHypbo=;
        b=fZBo2hFKZQkDwYxZ45CaIKD1nOecdN311+ZMVPzuExtvFi2yoXsEEixHU6N3JZ4EgC
         w4BJ91k1C6kfsOD751k0edCTQuMxiH0sjmcKgdO3RCL7Zz081ec2ACONqyczlcKp3Tfx
         0lH9Fo+0FnE1DmZECJwOriyKcVlfvjG77w+D8Y3sUZyu6UXLBpZ8WXtxIexT7Cpp9/xp
         VcIO9FeIWSHeHn3y/xMlEz5iHL/jxEWhiUZYl6LckhcMFyV7g3fOW1xpTVkU6B0uURBr
         5ldL7XgB+rQj1ANnWi+D+WAUT6CW1TdF0vnxzalrxX9PbKfOv9FN0sdNsx5fhemjli7n
         udXw==
X-Gm-Message-State: ACrzQf1NFykxrm05rDEOW3/ljsPblPGcToP1QCFmk7Yxj4y2ibZFaish
        c83Jv4jxBypxacT4QU1oKQYG/7OaLUP9EcsAJC8=
X-Google-Smtp-Source: AMsMyM4f5GGBrZrstWM5cw+DgDSKan0EQIaXJRPTO2p1SCYeseOiR8QvjBJanttgRMZjKjQkzChd+D/u6f5zWiFDbqw=
X-Received: by 2002:ac8:7c43:0:b0:35c:cd8f:3da5 with SMTP id
 o3-20020ac87c43000000b0035ccd8f3da5mr26282721qtv.61.1664363547646; Wed, 28
 Sep 2022 04:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Sep 2022 14:11:51 +0300
Message-ID: <CAHp75Vd3ZEDvSjdf61b8+GKX9Tfa_rZgA7tS7ShF6Hr8uXbzGw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] serial: RS485 kerneldoc/documentation improvements
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 28, 2022 at 2:05 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> RS485 documentation improvements. While doing the kerneldoc conversion,
> a few other items came up so they're now included to this series.

in this


LGTM, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> v3:
> - More fixes to kernel doc formatting (thanks to Jiri)
> - Added a few other related improvements
>
> v2:
> - Include serial_rs485 into documentation
> - Add * to multi-line flag descriptions
>
>
> Ilpo J=C3=A4rvinen (4):
>   serial: Convert serial_rs485 to kernel doc
>   Documentation: rs485: Link reference properly
>   Documentation: rs485: Mention uart_get_rs485_mode()
>   Documentation: rs485: Fix struct referencing
>
>  .../driver-api/serial/serial-rs485.rst        | 36 ++++++-----
>  include/uapi/linux/serial.h                   | 62 ++++++++++++-------
>  2 files changed, 60 insertions(+), 38 deletions(-)
>
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
