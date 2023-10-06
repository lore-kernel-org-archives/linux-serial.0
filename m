Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF738E92FFE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Oct 2023 10:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjJFKkm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Oct 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjJFKk0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Oct 2023 06:40:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4FF2
        for <linux-serial@vger.kernel.org>; Fri,  6 Oct 2023 03:40:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso3524277a12.0
        for <linux-serial@vger.kernel.org>; Fri, 06 Oct 2023 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696588823; x=1697193623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL660JTvgNMv01AOtRAXOmeJqphPs9MWYQMjjB+/Nzs=;
        b=LuAx4zLyWDHBXb98EtcdSEeWmQ272mqaRrP4K71VF6oKZyrrblaNtLiTLxM5ECTbow
         tFvGUVUXofHUN8vTkONcdYlX/wWHx+Cj/QLdfLjKSApZ+N92hoead9r/2T+tyZuksZVj
         vALp1A9Jif6j7OIKo0Tvg8rp3z04jn4h2BvsXhhgcdDWbTyHKvMUggueeYGmrUIhmHZ7
         6txRoiC9yC+7OS0zV0m80adkIkX3ayV1oxyl7TcortAAIhnhSoRBgyZCbYZ6am7qKta2
         EGUf85XMsUJgZKzB1XWL2Ug+yXvAO3oT0m4snr6ta9nbjZ/nb7GH4ghUEZ6700x8diD4
         HF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588823; x=1697193623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL660JTvgNMv01AOtRAXOmeJqphPs9MWYQMjjB+/Nzs=;
        b=mFW2kdQI15OuSR6e6pcX/qDPVlm2t9GhUbw9d5fKJnF9bbG97lpvkzbU2A2mtRgfRp
         1T2CUjrX4/qX/zmIBeypIVpFt3NsMY00xbBzq/gpZI+DZbN+PiubFUyBXHTLRs2r7lID
         YgCUjWP1FlFZEk7YwPeyn0SdpP+Q5DGC6X6+uoV01Bsj7lD8pkJzwDnPPbIlrdE8auC0
         DXIIl4eHFXWIDclgIM9qeBurwQlIx2806xsch9A2lMYSaJU17/g16SBwtyaUTvuXqPC3
         VUBRTCD2aHASdY5XSr09LpRPjSB0cMZh2ue/P0cNijog3HGa8FFvm+SLVB8uHJxZyze0
         lbzA==
X-Gm-Message-State: AOJu0YxeRO2vDBoLCbNtysbQrjWEVWijv7ulQgaT6PsMnAp6WvQOwQnk
        FoEFTqID6vFmHX08GGdhJJKJhA==
X-Google-Smtp-Source: AGHT+IEtDgPbBBiob6u07RaXy8TB7bwMOjw/M5zLj2w4nbWEgAF53z4825TolDg89Xz0OwJm7YTIDw==
X-Received: by 2002:a17:906:10dc:b0:9ae:6ffd:be12 with SMTP id v28-20020a17090610dc00b009ae6ffdbe12mr7393062ejv.76.1696588823494;
        Fri, 06 Oct 2023 03:40:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm2642490ejb.185.2023.10.06.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:40:23 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, magnus.damm@gmail.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: serial: renesas,scif: document r9a08g045 support
Date:   Fri,  6 Oct 2023 13:39:56 +0300
Message-Id: <20231006103959.197485-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231006103959.197485-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/G3S (R9A08G045) SoC. SCIF interface in
Renesas RZ/G3S is similar to the one available in RZ/G2L.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v3:
- none

Changes in v2:
- collected tags

 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 99030fc18c45..4610a5bd580c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -79,6 +79,7 @@ properties:
           - enum:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
+              - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
-- 
2.39.2

