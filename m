Return-Path: <SRS0=VEyX=C6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D0C43465
	for <linux-serial@archiver.kernel.org>; Mon, 21 Sep 2020 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFAB20EDD
	for <linux-serial@archiver.kernel.org>; Mon, 21 Sep 2020 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STLvHlHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIUIoZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUIoZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Sep 2020 04:44:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92354C061755
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2020 01:44:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so10349164ljd.10
        for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2020 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8+aTpIZGsRYJnNBDSVViGsEByKBiybockbd4X8mpdU=;
        b=STLvHlHK1D1lKO4Bma+Wke5acxclyLHYwBFN9jXcyJR7SI7cs72omoVv03jaWWI7Y2
         It0Im7/4jooAK4A6Igg4hTkkf+gjT2kRomaFq/+KuCo6/u+6IAjmCOE4ixfk4/GXcq5Z
         SwYOqF8DF1exSV1X+h/EVZV7PxUEnoLtx76VicgZUAvB1X+MeupSxdX90tvbyykw0Y1K
         3hIAxMM5jwR6jGrEORwFxm/or/9c2Egu4UVJE45qNqML54FZk8eIEDVGxc7VWgbnEh7d
         Tvft6X3VlvDqtpBevX9RzomVEX3RJgcIbxtAf5g7QfZOiZXHSq0XsCY4My9If9Af2NqH
         rryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8+aTpIZGsRYJnNBDSVViGsEByKBiybockbd4X8mpdU=;
        b=t8g9L03m3yyTmCRE9knRAO9HTOKy928OlSfYktCMOLTRQ7FD3rtosLUGGxNcI3yx/C
         ErghEWE4Bagijnr9UU5Nfs56FIfPBJWq80h0RZycnUK3b3FFOACy0tS8pyOA1ehXR5Hv
         Uw6FmWqBa0ja2sqFh6okmVE9+FmJ5wG5Tfah3Q75CtWsAG7/lIvxaNHpZWVUK8Yl5KCO
         7OZvRs+yr55hEy6b0nOFIWUr8Aa7GimHBMWEbACNe6JATuI/p9+ZSEGmR4zLiB2WxXsD
         3XtNblej8+wv192uStK+eO+f5vOZm3APHFtrLbQ2G5u0s62PfJ7gq5Z2A/b2wvuvG89o
         PEKA==
X-Gm-Message-State: AOAM533l4HpGhHDH1UQ6ffvLg9lRB7kNJ2fgpCETcB1iJ37yFmiDjJe6
        8TpgLm8bJYRW0s0RNP+AENH/u+7Z9LkPYzQTyso=
X-Google-Smtp-Source: ABdhPJwUGgnj/GcV/LrkhWi8Mk/u8tPVkfZQoL7qQByUTenVoEOhG2EIraYLaPhWnjd2joypMTMLLQ==
X-Received: by 2002:a2e:548:: with SMTP id 69mr16795771ljf.386.1600677862787;
        Mon, 21 Sep 2020 01:44:22 -0700 (PDT)
Received: from localhost.localdomain (110.80-203-69.nextgentel.com. [80.203.69.110])
        by smtp.gmail.com with ESMTPSA id f6sm2388842lfq.211.2020.09.21.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:44:22 -0700 (PDT)
From:   drolevar@gmail.com
X-Google-Original-From: aabyzov@slb.com
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Andrij Abyzov <aabyzov@slb.com>
Subject: [PATCH 1/1] serial: 8250: Fix TX interrupt handling condition in 8250_fsl.c
Date:   Mon, 21 Sep 2020 10:43:13 +0200
Message-Id: <20200921084313.1536884-2-aabyzov@slb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921084313.1536884-1-aabyzov@slb.com>
References: <20200921084313.1536884-1-aabyzov@slb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andrij Abyzov <aabyzov@slb.com>

This is a port of the commit
db1b5bc047b3cadaedab3826bba82c3d9e023c4b ("Fix TX interrupt handling condition")
to the FSL-specifific interrupt handling routine.

Interrupt handler checked THRE bit (transmitter holding register
empty) in LSR to detect if TX fifo is empty.
In case when there is only receive interrupts the TX handling
got called because THRE bit in LSR is set when there is no
transmission (FIFO empty). TX handling caused TX stop, which in
RS-485 half-duplex mode actually resets receiver FIFO. This is not
desired during reception because of possible data loss.

The fix is to check if THRI is set in IER in addition of the TX
fifo status. THRI in IER is set when TX is started and cleared
when TX is stopped.
This ensures that TX handling is only called when there is really
transmission on going and an interrupt for THRE and not when there
are only RX interrupts.

Signed-off-by: Andrij Abyzov <aabyzov@slb.com>
---
 drivers/tty/serial/8250/8250_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 0d0c80905c58..ceac6cfce4c7 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	serial8250_modem_status(up);
 
-	if (lsr & UART_LSR_THRE)
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
 		serial8250_tx_chars(up);
 
 	up->lsr_saved_flags = orig_lsr;
-- 
2.25.1

