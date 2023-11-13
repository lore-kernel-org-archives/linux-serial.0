Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC3C4167D
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKMOL7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 09:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOL6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 09:11:58 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F2AD59
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 06:11:55 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso4374646276.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699884714; x=1700489514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJr1OXkuxnT03SCv+djqBRWs+VoPNnRqt/gpqMoKcS4=;
        b=dPhazqou+ayKP4zGXmB+bzWYXpFj2na6UysngAOocfO76BBDDfHgFB+8GVn/2Lry4k
         l0qmn+GxKZyYwtqjvecGw+Ji6JZ0bXN3uxrtoznmnRbVVcrSHHxfOaJ5mQa7dIvEX0KC
         NDnFpoDTBJQdKiXKOKDJsAs1zzTN0pTT5XY8Cz3KT/faS2rTKgKlDUH61ntJFT8XJv8n
         BPsZETaP6WEwiYNoVtOkqT8bvsuAJhbD/yAuKf47ZEQrL04tn1wiI7mtyTpVJ+Rf8du/
         0HcLl2ZGTe48CmWBa/e7lFjIipbFxLT1c99vqSeo8Q+rA/oNBwelIwpkeURr68QYfBKa
         Hq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884714; x=1700489514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJr1OXkuxnT03SCv+djqBRWs+VoPNnRqt/gpqMoKcS4=;
        b=TYST2ltNae4SpNsxmPnYEZENbKDUVBKgh/2YConGIsB/aHtQ2FsQIw9kdX1YnWhzSL
         2UrwECcfatA7MunjTTS6c8QRk6mE4CrpkG/8wgVLEz8aQoLWVXXhtjG2mWgmk0wJk21z
         D6XoRNaSjD2gDYdstbL7tt0B7wAiKg0PS1MKy5rQ723NH8YY9wgyGMDlvTJun/leOk/2
         trzMhnATfZ//kfV/SxbaF+rzpBI6PDsIiVQnUecw3Jje2UTem43ctaSmnxazvrVpyolL
         iy0MVB2S1Ntp4rc3CJKqtXVnwxqrYSmz5IFS2v4lr6dDDQS4WqjpvuVy9LhQu1vwOQ8p
         g+jw==
X-Gm-Message-State: AOJu0YzDkmxmg2Nll2TYJsl/uXdQM/XVKFnVQbnkuY1LWMrqWnCGIanX
        hTrTGtZ+bbv+hOR+WaAFHu4FbAgk7x86Fxu3MKnd7g==
X-Google-Smtp-Source: AGHT+IHOnTJi2b1Q0iw6JudAumqU6ptqzEHKAsTPQMqY6ERd/tzWqcc2NMGHeiZAy1A323D3e8TLe3gaGaKgn7ddmRc=
X-Received: by 2002:a25:d196:0:b0:d9a:4bc3:226e with SMTP id
 i144-20020a25d196000000b00d9a4bc3226emr5511950ybg.37.1699884713789; Mon, 13
 Nov 2023 06:11:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231031095014epcas2p2814fa2bb5f940ccb0d0951667df34f98@epcas2p2.samsung.com>
 <20231031094852.118677-1-jaewon02.kim@samsung.com>
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 15:11:42 +0100
Message-ID: <CACRpkdZRMJgWkLwKstpN_9=VGutbE1wBv+X_a15RJ=7ddNtbHw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce ExynosAutov920 SoC and SADK board
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Jaewon,

thanks for your patches!

On Tue, Oct 31, 2023 at 10:50=E2=80=AFAM Jaewon Kim <jaewon02.kim@samsung.c=
om> wrote:

>   dt-bindings: pinctrl: samsung: add exynosautov920 pinctrl binding
>   pinctrl: samsung: add exynosautv920 pinctrl

It is best if I can apply these two separately once Krzysztof is happy
with them. I hope that would work? I don't see any specific dependencies.

Yours,
Linus Walleij
