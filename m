Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54864C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 21:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E114619D0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 21:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhCWVdm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhCWVd2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 17:33:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038AC061574;
        Tue, 23 Mar 2021 14:33:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j3so25167390edp.11;
        Tue, 23 Mar 2021 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNqTp+4J55pn8UtxCWhZI9WKQ5OJTgrthkxSNaaR9fk=;
        b=Z1X62JgaNMMBhLZQ4QlhpGE30R7oq8YUDzrEMEzTRD0vNkPaAU0FqGpgvMQr3SNw4N
         TQ2lURRF9XEcvjjsQtWoYsO7GtMMtlQB/pagSghOAntjFN+62FySADdKePG/SaNFdkTw
         jjRiQNIFaAgrove9trejAd+bh2AI53ZwBbeUGI+rGNQUgiUDhrqm/52yIa8mSOHbRADc
         /Hl8zXqJYmy5UllL/i5DfDsUENesGkIKUATnioFFGXBBjUtDvmeZiEaQGPAi+S8F39FF
         81WLl9okrNOK9J9KAS05Up2FL0aVT//x6QW9B21AIw6AHfDL9xjBkEvHP9LtW5QOQSL8
         tjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNqTp+4J55pn8UtxCWhZI9WKQ5OJTgrthkxSNaaR9fk=;
        b=Idhul5mgPNGugbuXEskcPzt4awMsqs1sWibu2ZM9egxvHw+ugPwHFHyBp4XznH4hQl
         gue+Sj5yjFsa6/XgHN6ifi4KCiiREol+zss4C8tG8k9Veu8rSIoytvL/nHi6WUgCN6SN
         TgJP5Glvd++SIogMw15lQDLn6Kh27k8V0r1qm9NI4J8Ax3TrCyGGCahCHxkZGRSNph5g
         xtbDqTQVoW8BRfea0AQbF/Y+djKzxbM3IwZuITM0CXpTrDkhJFoO13745S+H7f0Jafqv
         /0RCMBPdn9Cl5DsBJoYGMPaOmUelRvt1bcuePKSmM/AqRKv5ve5s5oeEY5s1wN7DQ6Mx
         /lUA==
X-Gm-Message-State: AOAM532X12oxo46TZUDZeEVvR1jrYZLPIvwvfn5eaaYwZBFPHbnnRPCK
        DrPGcASCoToHNsgVdrMnJ4tyrMRGBENx3leD4L64HacQJdQ=
X-Google-Smtp-Source: ABdhPJxogLUC0j2kqIXnvE9ADeLdHe/dekVrvsjIiVez5mN8mdmstjeRi/0IbcBN4Amm2vqsw9nN/TGoA02CccJ8wno=
X-Received: by 2002:aa7:c957:: with SMTP id h23mr6431368edt.301.1616535206608;
 Tue, 23 Mar 2021 14:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210315083459.359773-1-narmstrong@baylibre.com> <20210315083459.359773-2-narmstrong@baylibre.com>
In-Reply-To: <20210315083459.359773-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 23 Mar 2021 22:33:15 +0100
Message-ID: <CAFBinCA1WhtWLEfJ-QyBbZpsY75r=su6uzyWamY6nHOQ+HYvAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: amlogic, meson-uart: add
 amlogic, uart-fifosize property
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

 Hi Neil,

On Mon, Mar 15, 2021 at 9:37 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
do we still need wrapping of long lines in commit messages?
if so I think the line above is too long

> a different FIFO size from the other ports (64bytes).
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

one additional note below

> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 75ebc9952a99..e0a742112783 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -55,6 +55,12 @@ properties:
>        - const: pclk
>        - const: baud
>
> +
> +  amlogic,uart-fifosize:
> +    description: The fifo size supported by the UART channel.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [64, 128]
I personally think this is generic enough to be described as fifo-size
(as it's done in Documentation/devicetree/bindings/serial/8250.yaml)
let's wait and hear what Rob thinks


Best regards,
Martin
