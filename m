Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEE8E7D0B4
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 22:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjIUW5L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjIUW4y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76ACEF;
        Thu, 21 Sep 2023 15:56:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27474f0f483so195847a91.0;
        Thu, 21 Sep 2023 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695337005; x=1695941805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zCeZx485dzIdLOwHMiftTCXeqlVFvIXzm9Bah+eei4=;
        b=SJItNGJtpe3sagY9924sjG+hiPPiHvDWjVm/p95TEgEasuGfE6oKSngjIs8TA+++of
         a8fMyb3hdnlPoz70ViZpbBByWbaX9PQ1oSle0c30ovR4vbXaJFxGCX8S4FxhF8qgrjlC
         xZwvDQs4kRln/o195i0uQbaq4av6DQmPk5cLeqETOpyBmOxhb2zuklOw/0J/pM5LedKS
         NtvdfVkEx01RM8ahWFpJDvKptYtNMpfZfziguarQ4W352ykM8fQ21ZZp958Hl/neYTRa
         GKapXPZBuRhZDe4jGnDCkx8pQlF1qKGjzMUjeAvW5Exr3OcCLgyqacgvx9NBZDF1jGfV
         UKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695337005; x=1695941805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zCeZx485dzIdLOwHMiftTCXeqlVFvIXzm9Bah+eei4=;
        b=fuymh3NAEyTzSiHOSHze50dg2g5GMmOrijzYgkR7gbABIlZrxuRP8h+/WJm3qCxcjQ
         yvpVyOMix6eEja0CL9dqSFDDafx3sR3ip/GtdE7Qsz/QHThz4GFP5OHRsYDCteUZMBvf
         FkatN0tf8QLkTSNRJIl0/3gIpK3fgyj+HnR7Vd2YNoZhCwD9gy/715HmJWAnu7eNg9kp
         oG8vZVZs391q541g/LzSTC6MUIZI9W0YOV6eRGB2JhRqGlo5uE+K8YVM6oB18oGksMaF
         mGgl9/TLRSpCLeaW5hyBelma5C4gzfnXO06sUMNHIcaN4T/8dAFkEHwbTmRhVSJDy1+p
         4FJA==
X-Gm-Message-State: AOJu0Yydf42jFaWLQjRwyHRqW9CCCr6gab5+1Bp6/mnS8tIFtv5P1KoE
        ryf5maJo2Og0AKK1VrC9kED5pV6k703YnADjKO4=
X-Google-Smtp-Source: AGHT+IFlKgN/dwPJXZuDsc/8j9JD3kD9aIEkIBM4E3L9qNXtU9titNsVtfqZzZSzPga/oQH9zuZWSzxHhdGnDW1+Ol0=
X-Received: by 2002:a17:90a:6f61:b0:26d:4ade:fcf0 with SMTP id
 d88-20020a17090a6f6100b0026d4adefcf0mr6460502pjk.4.1695337004654; Thu, 21 Sep
 2023 15:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192729.71259-1-marex@denx.de>
In-Reply-To: <20230921192729.71259-1-marex@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Sep 2023 19:56:32 -0300
Message-ID: <CAOMZO5A2JOwnuRycKVSQQU04a6VGHgP-52PHXJ-x_Smwtx_G5Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: imx: Document wakeup-source property
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 21, 2023 at 4:27=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The i.MX UART can be used as a wake-up source, document the 'wakeup-sourc=
e'
> property as allowed property.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
