Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB50C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3601A60F35
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhGWJvq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhGWJvp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD57C061575;
        Fri, 23 Jul 2021 03:32:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h10so1135234edv.8;
        Fri, 23 Jul 2021 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2Vkuzv3cnuMP0GxiEF27wDY+yi/FEH4Ut6uI+huwP0=;
        b=M4HA+KzzNqeB7KYgOeW+k+S/J92R0GVg6qALNZz8NSXXlQnxoiOsIXEr8vo9EUEUJt
         9JykDOJAWstEAUy/Q5glBMHiCcjYtg58hY/aHkPdkdtoqkU7CyDef3xAkXzwwu0+vHH+
         xCvYxrpbSm0XpQn2jinK13cUkqFBcTXhPiNnAah0uss4Zp+q2kY3VnaIPmKw/gqVhVrX
         EprCxL9RSIxdV7NHYElgFcewofa9FMmXx8/kGCkFk5MEW/BTm9WNegtHE3RjDJxXaj0W
         Ydwd6m9Y3ZbSPXx/gy3cGeXtdv7l64Wcm3wDIuBNsGwnLxlQHqKHsr91TuPM6wBSmhqP
         nDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2Vkuzv3cnuMP0GxiEF27wDY+yi/FEH4Ut6uI+huwP0=;
        b=TyepV7nB7y/KZ4IkF1tClZ78Jo3xJEUOvp0Bc6TVWDiDSU4Lnd1sBNSV6b8RfnnR65
         SMFGwYg5Ik6VN2NNAEAbmID+QqhBb8f/c2fjyY18GXa9ijVCq69mVfkQsfz1UJp29LHb
         /qNa7+C/WEr3IwlaFSigtHbEdcrOkjND0Lzh+ZqZFdrgGrkhVH5BB5R8Wv7zeIopg51U
         gceh1L4+ZWFvJ+JY5pYmSuHrHbvvwDijOVhwlmewF3ZjgGX7N0hMASIKwZIM8PDcv613
         tiSS3irQ8vqSRgXyNHolaZTbljbOfjn0yLQBqCC+gNyn8FtSh4zg2iKgBfXaM4+vFqVs
         vcaA==
X-Gm-Message-State: AOAM5331kNtomJjW07tET1nb3858jpKvQGzjkOVl/0gHzUVv2Bcy5EFO
        Hsoq27MN/wUHMSqZcJWxZSm/RXheqYBT4Y6Q0Ng=
X-Google-Smtp-Source: ABdhPJwfshdjPb/onbK/Z9mze7NQAQt1TO6WQHDhR0dOZOK0WYlU1JOXQ8GWGsV1BQbG6Lex8Z3vAXFsBGsa1aOoOys=
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr4750849edd.237.1627036336984;
 Fri, 23 Jul 2021 03:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210723074317.32690-1-jslaby@suse.cz> <20210723074317.32690-8-jslaby@suse.cz>
In-Reply-To: <20210723074317.32690-8-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 23 Jul 2021 03:32:05 -0700
Message-ID: <CAMo8Bf+bLr73Gt67A0UFRQ_3yY5bxEuFA2VgvuDEdSfsAx0ywg@mail.gmail.com>
Subject: Re: [PATCH 7/8] tty: drop put_tty_driver
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 23, 2021 at 12:43 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> put_tty_driver() is an alias for tty_driver_kref_put(). There is no need
> for two exported identical functions, therefore switch all users of
> old put_tty_driver() to new tty_driver_kref_put() and remove the former
> for good.

>  arch/xtensa/platforms/iss/console.c    | 2 +-

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
-- 
Thanks.
-- Max
