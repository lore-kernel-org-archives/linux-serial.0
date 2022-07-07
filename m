Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85359C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 14:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiGGOzc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiGGOzJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 10:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE257225
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 07:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8AA062307
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 14:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB84C341CE;
        Thu,  7 Jul 2022 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657205640;
        bh=bBQ4nDvhFzwNbduaomhv8GNzHnp4QLgYNwLwjQnkEpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxKGwUBqoXvlZ9nJXRE2Et7y67fKYb90d4QSypLTTQXIIQCS6BJuMx1qszqFz+8bL
         Yn2VEqIPfgSExmWwYpe8KCSNxuaAWuqj2/OAs5feGI8nbZTB6F/Ff3pmByM/XdypOd
         qrPYJvn6QWGTSzfScBUAa8HqGoyet9vTLqs4uDjitjsMKg94bzJCWdIkZuf0uDHeDt
         Lf9KyKmyJuhqcVGTyQgIpwiPsmODG5rj5E4d0CceGl8skcRdoGCFSA6zc4720Metbj
         0RmkaET7fgNpk6zUnW8xpDegvYPOquJAZgTDnsz331ohc1KaUIrmOLOBH3j00gDmbV
         jSAOvsLclhKzg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 1/7] USB: serial: ftdi_sio: Fix divisor overflow
Date:   Thu,  7 Jul 2022 16:53:48 +0200
Message-Id: <20220707145354.29705-2-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707145354.29705-1-kabel@kernel.org>
References: <20220707145354.29705-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Divisor in the register is a 17-bit wide number.
Therefore we need to clamp it on overflow.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Marek Behún <kabel@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b440d338a895..ea40f367e70c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1157,6 +1157,8 @@ static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
 	int divisor3 = DIV_ROUND_CLOSEST(base, 2 * baud);
 	if ((divisor3 & 0x7) == 7)
 		divisor3++; /* round x.7/8 up to x+1 */
+	if (divisor3 > GENMASK(16, 0))
+		divisor3 = GENMASK(16, 0);
 	divisor = divisor3 >> 3;
 	divisor3 &= 0x7;
 	if (divisor3 == 1)
@@ -1181,6 +1183,8 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
 	u32 divisor;
 	/* divisor shifted 3 bits to the left */
 	int divisor3 = DIV_ROUND_CLOSEST(base, 2 * baud);
+	if (divisor3 > GENMASK(16, 0))
+		divisor3 = GENMASK(16, 0);
 	divisor = divisor3 >> 3;
 	divisor |= (u32)divfrac[divisor3 & 0x7] << 14;
 	/* Deal with special cases for highest baud rates. */
@@ -1204,6 +1208,8 @@ static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base)
 
 	/* hi-speed baud rate is 10-bit sampling instead of 16-bit */
 	divisor3 = DIV_ROUND_CLOSEST(8 * base, 10 * baud);
+	if (divisor3 > GENMASK(16, 0))
+		divisor3 = GENMASK(16, 0);
 
 	divisor = divisor3 >> 3;
 	divisor |= (u32)divfrac[divisor3 & 0x7] << 14;
-- 
2.35.1

