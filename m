Return-Path: <SRS0=ofBx=AS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5954C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 04:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30BB20738
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 04:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Yhu813YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGGEpX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:45:23 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:51794 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGEpX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jul 2020 00:45:23 -0400
Date:   Tue, 07 Jul 2020 04:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1594097121;
        bh=fH5/HdjSb8oz99/5DFAoCk3Q9u/dm9G5NN5+HwuIL40=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Yhu813YAEMBZwkfsml8d4Z+VEXCylrVM3kr5eaVB7Dse/7r38AqIVRhprg7LjzMgE
         NJlr+AVYqdAzHpOkP3PjsI/Bi839PmFV2a6FNpmpv9a1GS9QIAR91sMta+p6pb36jr
         3i3m9Gru7cGtFIs+La2Iz94gpgtkY3l7ktavyb4A=
To:     gregkh@linuxfoundation.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH] tty: correct kernel-doc inconsistency
Message-ID: <20200707044458.235243-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Silence documentation build warning by correcting argument names in
kernel-doc comment.

./drivers/tty/serial/serial_core.c:3300: warning: Function parameter or mem=
ber 'port' not described in 'uart_get_rs485_mode'
./drivers/tty/serial/serial_core.c:3300: warning: Excess function parameter=
 'dev' description in 'uart_get_rs485_mode'
./drivers/tty/serial/serial_core.c:3300: warning: Excess function parameter=
 'rs485conf' description in 'uart_get_rs485_mode'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 drivers/tty/serial/serial_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index 57840cf90388..845323d979c3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3289,8 +3289,7 @@ EXPORT_SYMBOL(uart_remove_one_port);
=20
 /**
  * uart_get_rs485_mode() - retrieve rs485 properties for given uart
- * @dev: uart device
- * @rs485conf: output parameter
+ * @port: uart device
  *
  * This function implements the device tree binding described in
  * Documentation/devicetree/bindings/serial/rs485.txt.
--=20
2.26.2


