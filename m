Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5EC5AE5B
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjKTVp6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjKTVp4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 16:45:56 -0500
Received: from mxe-1-ab7.seznam.cz (mxe-1-ab7.seznam.cz [IPv6:2a02:598:128:8a00::1000:ab7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0223ECA
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:45:51 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxe-b7dc65f8c-crqsd
        (smtpc-mxe-b7dc65f8c-crqsd [2a02:598:128:8a00::1000:ab7])
        id 353a18c8cbceaa6235b496d0;
        Mon, 20 Nov 2023 22:45:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
        s=szn20221014; t=1700516726;
        bh=tV7rRu+hZULtUAqYXJOLdln7sRyZoCRG7oXpFuJMw7s=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:References:
         In-Reply-To:Mime-Version:X-Mailer:Content-Type:
         Content-Transfer-Encoding;
        b=S4hf9s8fOGz0Bi1ZB1E1OhQzuEo2siqlty/soQvv6+Nm1vjSk6eDqSG1H/g4DqAwD
         j6MJIQdSAOsMmYRw/w2CPbHp6fcOoVq2zNdGDlbWA5Q5kblFZBGEy5o/XJeVTCsKFT
         4wAJhVtB/lYUceQUGR3dvslro4LEj2k3fpKnGR31RWU6KxUoFPO8J+TEwnuTa3tIRl
         FBfEWaJq5h7Qhh3XdrMFtRfAWoZ9wQksrxZ38sLk6/n4Uoq6nb2i0UqjYSN3sRT1zr
         GI2OQ0ma53agm6InaDqeeVnq6UYllSllm4TguAAAnySLuwLUCbxi8epkAlJdzqKv6H
         CSc/zabkjm3jA==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Mon, 20 Nov 2023 22:45:23 +0100 (CET)
From:   "Tomas Paukrt" <tomaspaukrt@email.cz>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     <linux-serial@vger.kernel.org>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v3_2/2=5D_dt-bindings=3A_serial=3A_Add_o?=
        =?utf-8?q?ption_to_enable_RS485_mode_via_GPIO_?=
Date:   Mon, 20 Nov 2023 22:45:23 +0100 (CET)
Message-Id: <3Nk.ZZrp.5w3Yn0Ecy5C.1bMzDp@seznam.cz>
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
        <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
        <2cZ.ZZqF.1YADr1CLFoQ.1bMn3d@seznam.cz>
        <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
In-Reply-To: <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the device tree property "rs485-mode-gpio".

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documen=
tation/devicetree/bindings/serial/rs485.yaml
index 9418fd6..7a72f37 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -47,6 +47,10 @@ properties:
       later with proper ioctl.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-mode-gpio:
+    description: GPIO pin to enable RS485 mode at boot time.
+    maxItems: 1
+
   rs485-rx-during-tx:
     description: enables the receiving of data even while sending data.=

     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.7.4
 
