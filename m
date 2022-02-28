Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA92BC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 11:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiB1LBa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiB1LBa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 06:01:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448595F48
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 03:00:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so14745444wrg.11
        for <linux-serial@vger.kernel.org>; Mon, 28 Feb 2022 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=wQf7m/26uVP31VMRB429E5WZLQAKTBVOvjmZow4UeUo=;
        b=n3/4I/b/w0kS8fX6M4bfXoQAqX7z4MjpWWVV88BZTBN9Nu5gAAMCBoTMOMAKkIjRCR
         HABk7GTeVif/cKH6kAA5keI498lgXjv5RJViiy5Thc+17ZllOQCUyjNgTuDi0aUStxh3
         Q5DV/jxCJ5oW78SQ2CTenKImMoUTqR0W3zmcC+KCwufuKxL/ySVIhlW5HjoEkMcUf8am
         Uo5tJTjWlsqvRDXNNgcsZOmVku4B9FtLXOFjAL69XVlPxMVITfBqGpRMCFJVUWcC2UIx
         kPy0gdo5h1y3HTKDq/7ArppulbZ/yBOEvks5h5qxQab2qySn7E5YlC3SdLm/NFLWfNwT
         8+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=wQf7m/26uVP31VMRB429E5WZLQAKTBVOvjmZow4UeUo=;
        b=gt7L8oIhxU8bojnJWMfBTkuutIIQQTE7NnlPuQI/hL7dQErTfthWhWkwCKgMpfzTzQ
         ECyDD0Lwk+zmJAMNEJQnUUbpHdFcyr022rxaJXGOx8X/lt6Nn4QLrQy4LqLzjpRLvRnp
         I7hMdGI3YqZmvhFF9uv7WskQ/5CZFdnkBlU+M6IgQiFL62zWGcFqacg70xFdInhmoAFu
         7gdl28lIeTYrSMoq0Rogt/0mq54GyYSSAfcox53aqEHYikMB/TTJ/4h6F0ZV6a/ykucO
         nip320+2135zEnMVaEZm4YcYEdgjLOXE+ERRACK+NH0PbyrqN0WJu9CM1/cJCaItDsWD
         E1Zg==
X-Gm-Message-State: AOAM531KBlkwo0nNpVesb6pUYqTwD4nVC/gqzsa1HYt17Raq9k0plo4y
        ZOwojmReVCVTt8OZSD00ccKIyQ==
X-Google-Smtp-Source: ABdhPJxeIv2FdVQ1UEoGzvwvf4aCugQmj8spQHXPxmB/liTIRCixUmzia8vt0dANCzMVJ1SLNZP/ow==
X-Received: by 2002:a5d:6047:0:b0:1ea:9a8a:9542 with SMTP id j7-20020a5d6047000000b001ea9a8a9542mr14900226wrt.243.1646046049864;
        Mon, 28 Feb 2022 03:00:49 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b00380def7d3desm11455779wms.17.2022.02.28.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:00:49 -0800 (PST)
References: <20220225073922.3947-1-yu.tu@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Date:   Mon, 28 Feb 2022 11:59:53 +0100
In-reply-to: <20220225073922.3947-1-yu.tu@amlogic.com>
Message-ID: <1j8rtvxnkv.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Fri 25 Feb 2022 at 15:39, Yu Tu <yu.tu@amlogic.com> wrote:

> Using the common Clock code to describe the UART baud rate
> clock makes it easier for the UART driver to be compatible
> with the baud rate requirements of the UART IP on different
> meson chips. Add Meson S4 SoC compatible.
>
> The test method:
> Start the console and run the following commands in turn:
> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>
> Since most SoCs are too old, I was able to find all the platforms myself
> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
> G12A and S4.

GXL based board are still very common an easy to come by.
I'm quite surprised that you are unable to test on this SoC family

>
> Yu Tu (6):
>   tty: serial: meson: Move request the register region to probe
>   tty: serial: meson: Use devm_ioremap_resource to get register mapped
>     memory
>   tty: serial: meson: Describes the calculation of the UART baud rate
>     clock using a clock frame
>   tty: serial: meson: Make some bit of the REG5 register writable
>   tty: serial: meson: The system stuck when you run the stty command on
>     the console to change the baud rate
>   tty: serial: meson: Added S4 SOC compatibility
>
> V6 -> V7: To solve the system stuck when you run the stty command on
> the console to change the baud rate.
> V5 -> V6: Change error format as discussed in the email.
> V4 -> V5: Change error format.
> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
> in the email.
> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
> the DTS before it can be deleted
> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
> discussed in the email
>
> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/
>
>  drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>  1 file changed, 154 insertions(+), 67 deletions(-)
>
>
> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8

