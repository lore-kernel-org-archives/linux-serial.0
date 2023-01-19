Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28CC00A5A
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjASQYc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjASQYL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 11:24:11 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E58A0EB
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 08:23:57 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4e9adf3673aso34294027b3.10
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hwcZBKN6nb1xq72ow8KaOfZt6J/SA8DFMlt8Qh/R5v8=;
        b=JPbPiCkz4kNHzakLjp0YQMcD2elPSJ3SHYZ0OaoeYg51q6KjfwskxQyGQFaUbTFEGj
         QnaHClp5yVkgTyMQVE11T7zVe+Jwnk9zaL3/D9mw9LweHvHYqt9siyWpNjURGzHTXSZh
         B6daHX0dtr3DhKhE0ZvxMigchVgWWYt3wY+861a3TTThvKk2/kNfIhFw4l8ZBoHBnbOf
         rt3kcFGCdkckhLpjmgqdAi3W6z/s3bVVVTvbwGjTcUxrZUFbDZCiZJWIL12M6yqSsZyq
         MFc3qy4JWqPHlnnv5VOaf5RAsDGcXbrKQaKrg510w66yS3k9lMdUNGkIEFfi9kKi0fVU
         Z33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwcZBKN6nb1xq72ow8KaOfZt6J/SA8DFMlt8Qh/R5v8=;
        b=JviNoTEec43suNKw8HY47XDEl/m0Ci/V3S/qQ3GuupgEkYzQaC25JPqMdVqtNqsgBt
         b0AB7o4fg9qjx2FioC697Ls2Xo4FHMzICjeRxqQCX1+QnoQEbs4hzF0ye9FpiaTRRaU7
         LfK5+7yUcHXStNHGgLY0H+CtGY3gFU6PG8RM7HahK7XgwpOT6X8UkD1or+lxatiVbrdN
         jiqKWP7Y6GN9AgyfwIIitm4UuAFMFvFoPUzqcv75WDDqQuaVhMhZ9DR0ldLGSKJMT1TU
         ha2OzD/HbnIUxaoFpgQvK+MCkxVl6bzuU6LrGHN9DDxi/gYrYpP9vc4CSEGrDh8OXA3g
         qHKg==
X-Gm-Message-State: AFqh2krP/aAyP15cwRBEkEVQvWT4zLjhjSETQJgIilXy7YtespfQ0Xjf
        r6N5rnKYMDbuiBpDI8nJqiAXG5kZ70Gv9KbpKpg=
X-Google-Smtp-Source: AMrXdXuW4wOYztlH8Cm0JaJM+ZSffE3dq8tuqOEk27LgRoIz+AFDNVlDuG6N0PUpg/IKjuyilZ49ZA==
X-Received: by 2002:a81:1b45:0:b0:4f9:dde1:ab0b with SMTP id b66-20020a811b45000000b004f9dde1ab0bmr2322320ywb.18.1674145436553;
        Thu, 19 Jan 2023 08:23:56 -0800 (PST)
Received: from tstest-VirtualBox.int.sealevel.com ([12.18.222.51])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b007064fa2c616sm9958447qko.66.2023.01.19.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:23:56 -0800 (PST)
From:   Matthew Howell <mrhowel@g.clemson.edu>
X-Google-Original-From: Matthew Howell <ts-test@tstest-VirtualBox>
Date:   Thu, 19 Jan 2023 11:23:51 -0500 (EST)
To:     linux-serial@vger.kernel.org
cc:     gregkh@linuxfoundation.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: [PATCH v2] serial: exar: Add support for Sealevel 7xxxC serial
 cards
Message-ID: <alpine.DEB.2.21.2301191117110.21493@tstest-VirtualBox>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Add support for Sealevel 7xxxC serial cards.

This patch:
* Adds IDs to recognize 7xxxC cards from Sealevel Systems.
* Updates exar_pci_probe() to set nr_ports to last two bytes of primary
dev ID for these cards.

Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>

Moved "This patch..." above signed-off line.

Let me know if I need to make any more changes.

diff --git a/drivers/tty/serial/8250/8250_exar.c
b/drivers/tty/serial/8250/8250_exar.c
index 314a05e00..64770c62b 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -43,6 +43,12 @@
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358

+#define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
+#define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
+#define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
+#define PCI_DEVICE_ID_SEALEVEL_780xC		0x1008
+#define PCI_DEVICE_ID_SEALEVEL_716xC		0x1010
+
 #define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
 #define UART_EXAR_SLEEP	0x8b	/* Sleep mode */
@@ -638,6 +644,8 @@ exar_pci_probe(struct pci_dev *pcidev, const struct
pci_device_id *ent)
 		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
 	else if (board->num_ports)
 		nr_ports = board->num_ports;
+	else if (pcidev->vendor == PCI_VENDOR_ID_SEALEVEL)
+		nr_ports = pcidev->device & 0xff;
 	else
 		nr_ports = pcidev->device & 0x0f;

@@ -864,6 +872,12 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
+
+	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
+	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
