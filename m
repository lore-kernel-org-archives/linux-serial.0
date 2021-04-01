Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72859C433B4
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 03:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFE361056
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 03:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhDADx7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 23:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDADxe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 23:53:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D611C0613E6;
        Wed, 31 Mar 2021 20:53:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x14so975857qki.10;
        Wed, 31 Mar 2021 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynRSJXMe9xUcg10OAWzr/tvimnliI6ylqTuryl124LU=;
        b=k28dPf9+9ZWLitCLxO/Y4duFpo/NPIr6ux8Dj0VU+cTkuGaDXgSxKXEb8ulHzl2EJ1
         iLkBIsSjajBqW2NXH6miRAsqy9P1X7NoEzMih5e070JakakYXniZ9B2dpQoZdwdyvhal
         XsiJliB4xNFudomEk0/ZpwJBn1t2mAMG2CD+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynRSJXMe9xUcg10OAWzr/tvimnliI6ylqTuryl124LU=;
        b=AnEBPNhBNquYgGPPoKo38CzGxpU8wBpu8/byVOF6W2Cll7Ba9CG4ruZfQVf48a6oxb
         hYaA0aRe/gHUM/IiCi6rbfZ08zMR5lOm8Suw0fJ3cD/NSfz1JD6aCMApxU9LRCgKGOTA
         vAAaaEVyGd3D+bV8DDRx5j6FEJZRYnI6WaVRp9FnZs0sIVeC11P10Z+mVDhMZfCKUHp1
         Pg7cpqtDnW5yTRPFU84ln3C2vOeSnOTwronkyAQ/DInAqxnTMd0KykqvAS/JHrWi2qzA
         JWUa9djolpduWk/iY5vtrYDlM4B2J0fPRwMcDc3wngUkKPLbOHK2KqQLKN/3yPvxXwEm
         jFXg==
X-Gm-Message-State: AOAM5316Z136+RbX8dVKwsr/1O5t8BuzYSMWHhovwp83Kii5zq0NC3Px
        pe43axPaqI9zcp+IVTwJ8hu8CI2gBTtNFLhGiWA=
X-Google-Smtp-Source: ABdhPJxaNMdmBWCwd9YGCoGxx/iaWHZVuxoWEevTeG6nQZ2AfTjZP0zBKZX/ucE2hwmt118D2hD7FjWOTGdDe6iREL8=
X-Received: by 2002:a05:620a:1410:: with SMTP id d16mr6462091qkj.465.1617249213346;
 Wed, 31 Mar 2021 20:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net> <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-2-zev@bewilderbeest.net>
In-Reply-To: <20210401005702.28271-2-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 1 Apr 2021 03:53:21 +0000
Message-ID: <CACPK8Xeqrvtb4Qku545QcbLeqgbHOZHkpgMp3G332c0aMdMCvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 1 Apr 2021 at 00:57, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This property ties SIRQ polarity to SCU register bits that don't
> necessarily have any direct relationship to it; the only use of it
> was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index f54cae9ff7b2..491b9297432d 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -188,6 +188,7 @@ properties:
>        offset and bit number to identify how the SIRQ polarity should be
>        configured. One possible data source is the LPC/eSPI mode bit. Only
>        applicable to aspeed,ast2500-vuart.
> +    deprecated: true
>
>  required:
>    - reg
> --
> 2.31.1
>
