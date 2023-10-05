Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F93EE14D8
	for <linux-serial@archiver.kernel.org>; Thu,  5 Oct 2023 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjJENzy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Oct 2023 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjJENtF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Oct 2023 09:49:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0167FA5EA
        for <linux-serial@vger.kernel.org>; Thu,  5 Oct 2023 02:32:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b2cee55056so140739866b.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Oct 2023 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696498371; x=1697103171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdLOn08HJMrX2Ou2DkH0AnNqsbvAINSqQuseGJAmCt0=;
        b=hHpq1jnNTJvqDyADj+w00PSih1ks2bzAQ2JLnQumUe5tM8tnwyzVR2+Cia5H8agxTD
         MnBzxiSrUf+q6DcwSSFBf7fVUIjAI7MQN9MB5ggTzn8le6ze6kW6HmCZgRbxxh2ImOgv
         IBV23glvYDtO+a7qul8BnaSuNgMLGK+fNQAacNBN6mcVdZLHQtZhveKpkrnM2XPY7tCP
         CKxwWsE5vwzj2CooSXTDRoTAGMbpeNKELEucG0XeK2QPjsNwu9uvgQBW6GL1nK2TyWfw
         2ZMxyPc4cej04yGjMeRy/TZSo1cfgn3KOIvOqfx4d921R85yGdVAV0e20AEo8aXncBIK
         R4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498371; x=1697103171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdLOn08HJMrX2Ou2DkH0AnNqsbvAINSqQuseGJAmCt0=;
        b=s8WYuJhnIpzGp9WtTdw3x1N6Jt4fzETheIqN+pHWmE1W7Ysu6E1t6sC7LgaXi+tXp5
         VbyAHk07yn+oFUajo7BrLb9cyi0yDswiykYNDn/JQKTRPcnM4UBoZi3iYrDP+F2rEAnf
         RL7O0pEwmgd4quGXdFijB0uhtHDdWPZL8rrl+WH3460/7qzI0Jl8IXhIR9snbtUnsCHM
         8b9T+UPWqvtLMORXQtozOZvVH1MBOEvYjAsvAxWT2X6XktygnGpA5l6pFhlbT/kdim47
         fxIjiCj7OJMusGd+8t51bgHGnuwR9Jf3rAxl2RpJZkXqRXyiFFf4zSTQiKtpdPkCdo9s
         K3BA==
X-Gm-Message-State: AOJu0YxNC+7163lOfYjhBlVywxey7/gm/wQfSKduE/ghogLco4j03y+l
        RjBhZ6VEbkaFUdnrBuhGNch0vQ==
X-Google-Smtp-Source: AGHT+IEGiwd6GZAfK3FbFUd2UMYw/vGyBuvevBUIP7Ff7gNZtLv+jk3/3mwwnVIKtSHWpnmRH8BORw==
X-Received: by 2002:a17:906:74cc:b0:9a1:d0bb:d215 with SMTP id z12-20020a17090674cc00b009a1d0bbd215mr4501972ejl.5.1696498371530;
        Thu, 05 Oct 2023 02:32:51 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm863893ejb.58.2023.10.05.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:32:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] dt-bindings: serial: allow naming of Bluetooth with GPS children
Date:   Thu,  5 Oct 2023 11:32:47 +0200
Message-Id: <20231005093247.128166-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
References: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some devices attached over UART combine Bluetooth and GNSS/GPS receiver,
so allow "bluetooth-gnss" naming of children nodes.

Link: https://lore.kernel.org/all/20231004070309.2408745-1-andreas@kemnade.info/
Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 5727bd549dec..468af429c3e6 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -96,7 +96,7 @@ then:
     rts-gpios: false
 
 patternProperties:
-  "^(bluetooth|gnss|gps|mcu)$":
+  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
     if:
       type: object
     then:
-- 
2.34.1

