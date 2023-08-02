Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0844C001DF
	for <linux-serial@archiver.kernel.org>; Wed,  2 Aug 2023 15:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjHBPV5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Aug 2023 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjHBPVk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Aug 2023 11:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C516E8E;
        Wed,  2 Aug 2023 08:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A6DB619F4;
        Wed,  2 Aug 2023 15:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F1C433C8;
        Wed,  2 Aug 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989447;
        bh=zCG2ZBd2we+fd27UTmu6rhjgwUlTuUjqhSSKE4Jo9tk=;
        h=From:To:Cc:Subject:Date:From;
        b=s7SFB7RKYOBIxWmgwOhfXom5MqafkZjArUC6xzXeLX3sHSZzxTk7UfBhdK3zXnbuQ
         G08WzNpkP44JpVBQ5gAtNY8ESItymYb8yF76eSCFmbPkRbqa0fmV3I6KdH152EScuC
         eCeBCADPOarvKkijcxa4rRGZD7VZFWntEZv+/gnzvMLbKf+4RFCIaD/iBYJU0sN7yG
         t0dLfP8SB51iCPmvjg7JxrhRc01NlEiD25F2lSdL75RyHI5hh8oieHtMa2OiMJTf57
         sBukbpb5rXpKvUiq/ASVYpbZ7+jhja2wqf5hAfe4awmTq6dfioLf9XsigFujOc90L7
         qegjIB1U2nmKA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250_dw: fall back to poll if there's no interrupt
Date:   Wed,  2 Aug 2023 23:05:43 +0800
Message-Id: <20230802150545.3742-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When there's no irq(this can be due to various reasons, for example,
no irq from HW support, or we just want to use poll solution, and so
on), falling back to poll is still better than no support at all.

patch1 makes the interrupt property in dt-binding optional
patch2 falls back to poll if there's no interrupt

Jisheng Zhang (2):
  dt-bindings: serial: snps-dw-apb-uart: make interrupt optional
  serial: 8250_dw: fall back to poll if there's no interrupt

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml      | 1 -
 drivers/tty/serial/8250/8250_dw.c                         | 8 ++++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.40.1

