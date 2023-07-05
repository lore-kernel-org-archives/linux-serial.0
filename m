Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6178C001B0
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jul 2023 19:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjGETAY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjGETAS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jul 2023 15:00:18 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623321BD4;
        Wed,  5 Jul 2023 12:00:05 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-345ff28865aso19199485ab.1;
        Wed, 05 Jul 2023 12:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688583604; x=1691175604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q11DZxec5L1lkk4HsxoZsfErpJ5+1KB1UsFypJsHD4=;
        b=iefiRkebaAvTufaYrlEVkxlVJlDfuhX57NblJJRCcOS9E7c+ql68rBVbcRw5G+JfJf
         O9Go03eDhe8ok2UFxTp71TNBef1xcd1V7Ndw/nNov0SgnpMFtVozUbMXz5fp2K2Jj2AH
         Jyz+DKrO45KoOxWdb7gGkAQ1vwRQX5o5sQXUNp1untP8ilPb+nW4qK3bA6zvilqFYSke
         0Q81SxgFVGLSXgl+AcAwgLX1ypxZdtMjX8M/XXObQS0lBgW32ov0WSMynKhid68vBhjX
         ZusNe1nWc7C3uw4a20itmJu7qE0AreUTF+jtJUdpq37KCTg0nUaTih6bPBDKYAkUaTxn
         DOdg==
X-Gm-Message-State: ABy/qLZ49AmgFf6TnSgm5GXxebqmXzt+q0FgAvNqhk7EkZWiOirJgjDb
        9pz9FoUs6ZVph0lEScKdHQ==
X-Google-Smtp-Source: APBJJlFqSXuAN1fdMf7i+nqPki2M66lKvpwvplbv+HDdzMUHg1S2FBrZDgnaOOqjV/1/ssZ0tQ6ohw==
X-Received: by 2002:a92:c688:0:b0:345:fae5:666c with SMTP id o8-20020a92c688000000b00345fae5666cmr32802ilg.4.1688583604526;
        Wed, 05 Jul 2023 12:00:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c15-20020a02a40f000000b0042b2f8024c9sm3034530jal.149.2023.07.05.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:00:03 -0700 (PDT)
Received: (nullmailer pid 1592669 invoked by uid 1000);
        Wed, 05 Jul 2023 19:00:01 -0000
Date:   Wed, 5 Jul 2023 13:00:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-serial@vger.kernel.org, xianwei.zhao@amlogic.com,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        kelvin.zhang@amlogic.com, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, jbrunet@baylibre.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        jirislaby@kernel.org, rockosov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        martin.blumenstingl@googlemail.com, neil.armstrong@linaro.org,
        linux-arm-kernel@lists.infradead.org, kernel@sberdevices.ru,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v1 4/5] dt-bindings: serial: amlogic,meson-uart: support
 Amlogic A1
Message-ID: <168858360022.1592604.9922710628917242811.robh@kernel.org>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-5-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704135936.14697-5-ddrokosov@sberdevices.ru>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Tue, 04 Jul 2023 16:59:35 +0300, Dmitry Rokosov wrote:
> Introduce meson uart serial bindings for A1 SoC family.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

