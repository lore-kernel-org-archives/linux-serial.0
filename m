Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABBBC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C961108
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhINJRg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:17:36 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40630
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229739AbhINJRc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:17:32 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C0A964026A
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 09:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631610974;
        bh=jxjZWeYzE1U9O4nD59VvfbtIKZY2vfyOzjYk3FCwwC0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=hjvpZDd8ecge18HPuC5QKbExWhds+DghA9closfxiewvs8b6YIBsgMDohlE8qUjAM
         T2A12JMkgeyxng9QXZLxFVFBljtZg3wZZEMPLEppEYd7RjB6TXoYKF+rcAakoW0m6e
         S/FFyoj19DuvSSkaAhP22i92GvDQ9WBtKj0EfRu318EshOgw/EHq7be3hMrj5H/nIi
         dL5JMpl6AwqqDZKU2mbHVEr4B2rw+wjD6cTtAaKQVm+D0TjZu40dJnw9VfcWn6I1nz
         HiZZ8rPcbytS0yipfh9VZV4Pm474UHeNtp9xCbTUkKch+tfN+l//Fx9IbpiCvVJpeo
         y8NDArl7o543A==
Received: by mail-wr1-f71.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so3508845wrq.18
        for <linux-serial@vger.kernel.org>; Tue, 14 Sep 2021 02:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxjZWeYzE1U9O4nD59VvfbtIKZY2vfyOzjYk3FCwwC0=;
        b=jDjkzuypJX6TnEdRYcbjiLtYZ32u5TJTZSaBgYGvg65QyS/GdfO44D+DZjys/FBgZz
         aNunAHiL022dGdf6zFgrlQL2Gzv0IJcGDI9iur4qSPd047/Spf1Uksu26YaiEowWqOx2
         NOfNIhGdWGtopiYtYYqrO3jaJb6gO3BbZd2aROynpKF/d/poBKUdTXwUYXr5p4EkYlqN
         MjYmw7TcHNvkURhB/HmGk4q9MTTscf4oJYwwW1a0WRPJkpRUf97+In+148HDCuIPiOoV
         raApQtL5sPaTPKuqz47otwVvHVJDoZD3zDcRZIqmwPveMDDlC/KKF6DQ7VcNNNC4cXKX
         XaEw==
X-Gm-Message-State: AOAM530h3SRFmkvdjMWS9G6y+ADel6xmCc0GwL5eK0z3r+YkqgxyD+Rb
        ugFNtrgwBnu2ufIGQlpkgrhFhNHA6Asc68i9VRe6U0FSCqCoEo+GTpkq5X2Jiy9+6m3h97Oeqsz
        d5ELTTa8lL+aMbI8i5sw74GZf5n7uquXTXPKz5xpYYQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr9551823wro.375.1631610974346;
        Tue, 14 Sep 2021 02:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBcxJ9+nhpnNlsX6tU3CX3V3dg3Nt9kYahBWD5t+KHoQHqK28w2iy95+n9ca/OanwGluxzRA==
X-Received: by 2002:adf:f486:: with SMTP id l6mr9551804wro.375.1631610974177;
        Tue, 14 Sep 2021 02:16:14 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o13sm7992153wri.53.2021.09.14.02.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:16:13 -0700 (PDT)
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5093137d-c30e-8cdb-585b-8d9198c8893d@canonical.com>
Date:   Tue, 14 Sep 2021 11:16:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914091134.17426-7-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14/09/2021 11:11, Jiri Slaby wrote:
> After the previous patches, noone needs 'file' parameter in neither
> ioctl hook from tty_ldisc_ops. So remove 'file' from both of them.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/bluetooth/hci_ldisc.c |  5 ++---
>  drivers/input/serio/serport.c |  5 ++---
>  drivers/net/can/slcan.c       |  4 ++--
>  drivers/net/hamradio/6pack.c  |  4 ++--
>  drivers/net/hamradio/mkiss.c  |  4 ++--
>  drivers/net/ppp/ppp_async.c   |  3 +--
>  drivers/net/ppp/ppp_synctty.c |  3 +--
>  drivers/net/slip/slip.c       |  4 ++--
>  drivers/tty/n_gsm.c           |  4 ++--
>  drivers/tty/n_hdlc.c          |  5 ++---
>  drivers/tty/n_tty.c           |  4 ++--
>  drivers/tty/tty_io.c          |  8 ++++----
>  include/linux/tty_ldisc.h     | 15 +++++++--------
>  net/nfc/nci/uart.c            |  5 ++---
>  14 files changed, 33 insertions(+), 40 deletions(-)
> 

For NFC:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>



Best regards,
Krzysztof
