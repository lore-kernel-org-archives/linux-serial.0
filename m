Return-Path: <SRS0=2m+P=4R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3FAC3F2C6
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 16:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A83B24699
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 16:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eaxlabs.cz header.i=@eaxlabs.cz header.b="U7FACzCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgB2QaF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:30:05 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:33612 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgB2QaF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Feb 2020 11:30:05 -0500
X-Greylist: delayed 1456 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Feb 2020 11:30:04 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=0sL7frbHX+9iov4VRw0n07dyNagmVgH6U/A+xu41NOk=;
        b=U7FACzCGC/KpiyvYGzuV/ssi7fk91JfFx3sPnZIDuDGZDcVFCc5/dLoE37026ZTSmjgiwKDe1kC7W1Mw7wn1lkqRmS4lynTk0j80KGn67sWnqOgYfSiHTbnBbxunDOAwu4LipcXyTZf1a1qmFClCUKIDkVj2Tjrnilv4aiwc+zg=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1j84ca-000150-MZ; Sat, 29 Feb 2020 17:05:46 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     Martin Devera <devik@eaxlabs.cz>
Subject: [PATCH 2/2] dt-bindings: serial: Add st,swap to stm32-usart
Date:   Sat, 29 Feb 2020 17:05:07 +0100
Message-Id: <20200229160507.31309-2-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200229160507.31309-1-devik@eaxlabs.cz>
References: <20200229160507.31309-1-devik@eaxlabs.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add new st,swap property to allow for RX & TX pin swapping.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 08b499045a38..cbfa1f9f4b17 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -24,6 +24,7 @@ Optional properties:
 - pinctrl-n: Phandle(s) pointing to pin configuration nodes.
   For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
+- st,swap: bool flag to swap RX and TX pins.
 - rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
   linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
-- 
2.11.0

