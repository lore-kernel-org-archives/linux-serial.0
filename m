Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B7C61DA3
	for <linux-serial@archiver.kernel.org>; Thu, 26 Jan 2023 13:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAZNy2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Jan 2023 08:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAZNyL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Jan 2023 08:54:11 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362643935
        for <linux-serial@vger.kernel.org>; Thu, 26 Jan 2023 05:53:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d132so2016906ybb.5
        for <linux-serial@vger.kernel.org>; Thu, 26 Jan 2023 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpuj4csXn4X99vb3I/8s21NoXDHeQ/0SUOopiJHmpcA=;
        b=T1OCixkhNVvyqIZG02I05yLXMmu0eRtoy7a1SbHSvmaUaNSxhw1D3/LIvUbLquayXB
         yV+BtLGzuQfszCSBlQ9R2P2LmFDhBpW5QHj6vNoet2lRvFj8mHM/2tGpoJwDJnX6vfGq
         9aG1wkd9GjOd0Qo5EMgr5y9lhqsZraSPNFYsOSMgJ90jdp8NZdl4VDBVh7+UXOdvYoUv
         aLPu8JIpl49wnMfa+jFlLrcWSoWGWtDdAWA31H+OqdURvRn2fO1wKsC98OoirxOfs102
         psM27Q4jO2ZFe+Mw/uTheQ0YXYL6e1JXsDMIYsioyjJA6+a0xudWPVol+9wiSlfZMCqZ
         1Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpuj4csXn4X99vb3I/8s21NoXDHeQ/0SUOopiJHmpcA=;
        b=TpD808BTnJshtz3BST9O4RSfzwdHPpXGTn0jlqT9JOnIjaWQREzSHbVy05lN8ZAy3H
         EA8wcvccZinlyuZp7vYvfwO1selgJnotzxlaF7zavevYtuboW7KWnaulPo+KNCtnHPSw
         YqYcGgycRh+DPfpEhBxfMK/dFVQPnFfb0j4nxEsS4RwvvFrbAU7sctMFJBfW2EM16eka
         JcC8+98dPR1EoXeuV2DKEjz2zPZ+wAlBnc2hKZgTVoTuBo3xTgsitYXuSlvPKyI0OymG
         PNP7qTv5K28+sMkX5TwMkzAANbZ1nGrxEEifm6YuIFXbetGKWd8LngYTPksyhnYvb+W+
         kdrQ==
X-Gm-Message-State: AO0yUKUWFj429MQuav+o+U9ZvWPHzIhd9oge3nLKKtcAR6MhbYdPrTPj
        21ZclISJT7rkNCROfUf/QNUEoYoU4dbcHEB85B5gwg==
X-Google-Smtp-Source: AK7set9K8VEvJWIIsQbzLpHPBdIj6YRdDIIsA2XTX+4WAVIQ5O4wlEhz7CX7+BOEhoz7cif/nbeZ9U+rSHTl2iHnGDQ=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr752679ybd.24.1674741217835; Thu, 26 Jan
 2023 05:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20230125143503.1015424-1-bero@baylibre.com> <20230125143503.1015424-5-bero@baylibre.com>
In-Reply-To: <20230125143503.1015424-5-bero@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 14:53:26 +0100
Message-ID: <CACRpkdYMif0--zeKe-tccUJvjiQAkbzBq2nCYMS8qU_imZmCmg@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 25, 2023 at 3:35 PM Bernhard Rosenkr=C3=A4nzer <bero@baylibre.c=
om> wrote:

> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
>
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This patch applied to the pinctrl tree, decreasing the depth of your
patch stack by 1!

Yours,
Linus Walleij
