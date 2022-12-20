Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6D3C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 20 Dec 2022 10:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiLTKXX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Dec 2022 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiLTKXW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Dec 2022 05:23:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DC9FC2
        for <linux-serial@vger.kernel.org>; Tue, 20 Dec 2022 02:23:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so17850196lfb.13
        for <linux-serial@vger.kernel.org>; Tue, 20 Dec 2022 02:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWWKzfzdEw02CXWzTtJ3spBnu+z+PbFfCS1jlEMXEFE=;
        b=Yi8+aWvxmQFOEj1teONIUvffmVjonwArVPcZvEyoOJxcvp0F0/3w3hNowW07/nNA8Q
         yJAapg38HVACVAbznixOxGgkV3fSvKjUmDWEdl6R7PCTfYqB3hKtOWUvZnKRW7eiVOZK
         Tj5bL9eRvCe7gmK9avZ/OqyhQgRcR1fHByT+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWWKzfzdEw02CXWzTtJ3spBnu+z+PbFfCS1jlEMXEFE=;
        b=U6R9gjLE/o9lyhG1/1BzxU/RUC2Mi8TMjuAoUBWqdmubQeMDnkabLwApbZqkwsGEAk
         W40el55Ek1mQ5/rQxGTuajXz8RFuFnR5B8XIjmyAJ8+5pFwLAwQm51myh+RiVzaYpf44
         hhOxNC23ZqK3o1K2wgj/8uYrNIvDB4ZjBxo4cHk8r+CypAGBpaD0bD34ZcwVcsOLtWtt
         QAXEU4/i+QVAYy7hfYtgrWIq/42hFobc2mF5RndUpnRPnFq3KfFP0CpxX2k+4HqtWFwx
         Ut9Y/1rZQj5jVoARARFxjHMpKsdlZCkyTyNr/T2FcUNfcP5isjx3j9Z90COx7v1agAnS
         dFsQ==
X-Gm-Message-State: AFqh2kropO0OGwYebBfjKc6b0EyRlysGL6DjiEZGQSoQ6cWjGekPHMAe
        gDkssN6VLyeW2LdOctgAEnOkSg==
X-Google-Smtp-Source: AMrXdXttkc5MuDNWOzy2BWKbs+Ksgf6NylYAj4xPhYL8Ic9pSnk696ZuC2diaqiSOgcCnHgb3vgmFw==
X-Received: by 2002:ac2:4c8e:0:b0:4b6:ee97:36d2 with SMTP id d14-20020ac24c8e000000b004b6ee9736d2mr484244lfl.40.1671531798972;
        Tue, 20 Dec 2022 02:23:18 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512214a00b004b52f4ea0d3sm1387167lfr.192.2022.12.20.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:23:18 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Daisuke Mizobuchi <mizo@atmark-techno.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     stable@vger.kernel.org, linux-serial@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 5.15.y] tty: serial: fsl_lpuart: fixup error path in lpuart_probe()
Date:   Tue, 20 Dec 2022 11:23:15 +0100
Message-Id: <20221220102316.1280393-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in
driver-specific way") got backported to 5.15.y, there known as
b079d3775237, this hunk was accidentally left out. So if the "goto
failed_get_rs485;" is hit, the cleanup will do uart_remove_one_port()
despite uart_add_one_port() not having been called.

Add the missing hunk.

Fixes: b079d3775237 ("serial: Deassert Transmit Enable on probe in driver-specific way")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Not quite sure how to submit patches for a specific -stable series
only, or if the Fixes tag is appropriate and correct. Please let me
know if you'd have preferred anything different.

drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 595430aedc0d..fc311df9f1c9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2784,9 +2784,9 @@ static int lpuart_probe(struct platform_device *pdev)
 	return 0;
 
 failed_irq_request:
-failed_get_rs485:
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 failed_attach_port:
+failed_get_rs485:
 failed_reset:
 	lpuart_disable_clks(sport);
 	return ret;

base-commit: fd6d66840b4269da4e90e1ea807ae3197433bc66
-- 
2.37.2

