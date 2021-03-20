Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67ECC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A381E61944
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCTSTK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:19:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:57027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCTSTH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 20 Mar 2021 14:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264339;
        bh=xJcnBN1J6AwlpjL6XnhA7z8+cNAcOly79skhuWm8OhY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FFNzXu/lKQD7uNanoz0O9twVKQTJwxKyuo6/9N99vWPjDHNKU+bN7G5Il+vxvRdEf
         PDdOvV44X//D1G5pfvK9DR7rxFOgh/mHyxMLmCd5yqqVQG0YowWfmIVShF7AyYUuuB
         NnURRESyWM96dOilGrv3c3owUQgcgK3xnCYYmN0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4JmT-1lNxIo0mPp-000I0x; Sat, 20
 Mar 2021 19:18:59 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-serial@vger.kernel.org
Subject: [PATCH 04/14] dt-bindings: serial: 8250: Add nuvoton,wpcm450-uart
Date:   Sat, 20 Mar 2021 19:16:00 +0100
Message-Id: <20210320181610.680870-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320181610.680870-1-j.neuschaefer@gmx.net>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QeUUPtlUqlVLexPlH4ILr9nkaoFgSKUdwwzFKXl0oCP26XDXJoB
 DZT8tcFDulDnnLdmw1d7tCs6PGKqSuCQSMgnh2cvmoiBdqz/wERwAJYIKkQ0nKLNhd2Yu0S
 X0z8jjeCCbGnx2HWmY5BBuQYNBFLP6Tk/OTiSpC6gSYqhrXhlO2iYW6NrFKZxJKbHlsU4jY
 rdpjWniS3lrV9xDbhaYFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yfzjPC32jQA=:q1+WgT0XrgyFgnawBY3hbz
 iG9t8HwRMsoaIHLnjDoyEk0qAXvXgDOMLMEpdIbPFMxBKQUpJKfBImDA+/pQsGlEEv1AlcNEh
 /AMIQjFp+hFGcx4wp2MnaLEoQvGLAPUv9WEM+6ToRDL+VA0f0xa/XW1GXRQ5A/tkUXyxaqFBe
 aYt7Elo/PtxQKO8HXTkQ3G0JvTSUZewc7WeI/5SGuipOiBx9A/a335EEbbs3gK3W0RBouNF7V
 im15dhG/yoWWoIwpfsYDsVaU9/phEoYm2H6WmSAwejEgiyNmLIcT4aqwj9IiNZeWL2PVLjejV
 PaTkR37RyxJ+Vn3KJHtq9EFUsc58BxJepFkFWs6Svf1NPs+cBJpi4eoSw139q4vrXhNOp1z+e
 iqIyKnNK194uABp8eafjw6KgtIu91Du5Uxjw9e6X834/7HqLWJjRGWa8enW63CmoPA5DiR3vt
 jNslYKN52afaFxsnIhk7pojxtHvAxBqUpPgN3MMwpMjzAUVeCT0iqwg+jBkE2XAgzTiCauPZh
 KIgDIgRpTluYFOyV3e34SJ7GOeKP3q4AesZFAdfdNmGcNk1Iu/8Y51V+9LyggZzwQnP9U0COA
 b2M5U1DAzZ3lcco9tPk6DLwfM3dnO2scgSoRPuej9ys5fWCI3V8iAZnNGl3LVVCGky5uTkQfI
 ydyss1PIUu9knvlHbHlHPE+trsCZO0U/6gb7CuBysE96CWwB/phGspjTRgJanQXqf79oLGXW4
 clbqmTEijdH2XqGDvpx3FKdA/pwwlMZp1HaBORwyI4YjhYW/Zk8aj7QJ5SKKEgcgFJ4wHWmA3
 Nt01VaBtsMoeUhvay9xXsX5ZohVENE+YlrA30wArBGZQo5fnWrO2+YoD/L92l3qRfQhSt87BL
 XC7jYIqrMiorY2Pjstpw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a compatible string for the UART inside the Nuvoton WPCM450 SoC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Document=
ation/devicetree/bindings/serial/8250.yaml
index f54cae9ff7b28..c0e292cdaa6bc 100644
=2D-- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -55,6 +55,7 @@ properties:
       - const: aspeed,ast2500-vuart
       - const: intel,xscale-uart
       - const: mrvl,pxa-uart
+      - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
=2D-
2.30.2

