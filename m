Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DBDC63777
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 23:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9720715
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 23:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyWeTNzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgK3Xgv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 18:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388050AbgK3Xgv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 18:36:51 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE2EC0613D2;
        Mon, 30 Nov 2020 15:36:10 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id u7so7291389vsq.11;
        Mon, 30 Nov 2020 15:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mDHtJHxDKIp9CgY2O+nZjtN8N0N6lB3CW2FBJTaTi0A=;
        b=gyWeTNzlTl0DeF+0j42TkxN+JVx0t5Ty6AEA4GMo3p1pG1UeZWsjFN85M1+NC8ED7M
         waOdFNX9+wA2TZG1FisaLxU7kjiKBeQzbPepI+sZMIeJQ68SaVx3yoYRuUnrwq84e/XW
         BJpC6lGxL9t3BSdAprb4Jt0wUMzMRygmAiS0AcN50NdDGNAUKWJYvMvAbfDSIhhWMoHe
         ZalE7aBD98I/bc4zPzPNJe4vJVA6UUJPX9fRM/p11qNHyD37Reea/+unr6HMUCqHcg1T
         P/g0iPtav6PPCys55tJjAtkkJqqPnW+TXjMfoGnr38x2K+u6t6TN4s9MK7fF00BKC/Qz
         Hakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mDHtJHxDKIp9CgY2O+nZjtN8N0N6lB3CW2FBJTaTi0A=;
        b=gMMLRoJFixa0Sk05XiJ1qIeHjpWUQHjqh2CKjdr6IFYM/IUaM5m0yFlSUGMnjCaIKm
         3xKC8lXixcx7AChhDBJTimXqpLc2iNPirzXNs2KB5EPHQo/O2Ms3pamLuGa8ygfZKC9v
         Y9AhVfcu/Hpr85MtUCxhbB/1uzXSm513COvJEOPJcpquedvVltxmB6H4k+qjZhPHCAeF
         dT8viwO7F/p2edtEXT9FQaIPkoqINQIQuzh0PkpGcmjbgpKvJ3KEeaC9aO0RXrf3fSa0
         UZo6w3L5hvJxok3mOn0r+eHQlM0gh4fvOf/cxRWx3ndX08etvOLqvWtd2xNTgYlgvcrh
         uikw==
X-Gm-Message-State: AOAM530kNp0C02vTNV5gD2ujON8ichk7GMcJ2BdlGkDCCnbkyXdOrIDT
        uEzHUKkSyU9Np8NeBAS9n325DYGKMf2dVc4zlmygbJzGXJhwFQ==
X-Google-Smtp-Source: ABdhPJw8hWLwPNAhzCwQctQI+dhysoI8RR/URK0EQWh0dD/LVbWKdFbfaLlA/iTzKzaJ+EjITf+2+PQvD87dhbceFkQ=
X-Received: by 2002:a67:f883:: with SMTP id h3mr169632vso.47.1606779370211;
 Mon, 30 Nov 2020 15:36:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Mon, 30 Nov 2020 15:36:09
 -0800 (PST)
In-Reply-To: <20201130153742.9163-2-johan@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-2-johan@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 Nov 2020 15:36:09 -0800
Message-ID: <CA+uuBqZRyEw_YtNH7V2cSWhpLdKXWLgivkSbR6HqaLeH5CUaJg@mail.gmail.com>
Subject: Re: [PATCH 1/5] tty: add port flag to suppress ready signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Add a NORDY port flag to suppress raising the modem-control lines on
> open to signal DTE readiness.
>
> This can be used to implement a NORDY termios control flag to complement
> HUPCL, which controls lowering of the modem-control lines on final
> close.
>
> Initially drivers can export the flag through sysfs, which also allows
> control over the lines on first open.
>
> This can be use to prevent undesirable side-effects on open for
> applications where the DTR and RTS lines are used for non-standard
> purposes such as generating power-on and reset pulses.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Mychaela N. Falconia <falcon@freecalypso.org>
