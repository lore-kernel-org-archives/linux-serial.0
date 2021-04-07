Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9CC43460
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118FB611C0
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350358AbhDGJws (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350323AbhDGJwi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8084613C6;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=oJDNnRo5m7mG8WyAHMekJOKQ1/wGAnWuQz2CFqv9xw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2w/RLOy9MdKRNn/LR0/JztYToahLZMcIGcTQP7bzTpaKsMj5WLMDSHjs58N9sg8t
         AYoq8b+939gbctKdxH0Oj1zBtQiSnQUo4Wipda3waWTCx+Dj3n4ZE53e/fMj7uG/7R
         93JMY5hh84nKj0u9L2Xi/fp0BhGGBsddzFoPp6ftN55tU0pMOU6UGF3KIYAa39t9gB
         Jp5TW57EvuDBHORZfhsh+Iyr3t7CNeJuKdiBCh97Q3YkA0vF6hBNDKUJ5N7rA2rsOb
         X8sL/bBIlnSOwsku5xZpQqiuQrHkNO25MYsIM5d3rdfR8TjMnWfmwjML22ldSl/Ena
         1xNYNBR5O1Clw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rE-0008Ig-Ab; Wed, 07 Apr 2021 11:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/8] serial: core: drop redundant TIOCGSERIAL memset
Date:   Wed,  7 Apr 2021 11:52:07 +0200
Message-Id: <20210407095208.31838-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit 5099d234a52a ("serial_core: switch to ->[sg]et_serial()")
the serial structure passed to uart_get_info() has already have been
cleared by the tty layer so drop the redundant memset.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ba31e97d3d96..59336943a86f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -759,8 +759,6 @@ static int uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
 	struct uart_port *uport;
 	int ret = -ENODEV;
 
-	memset(retinfo, 0, sizeof(*retinfo));
-
 	/*
 	 * Ensure the state we copy is consistent and no hardware changes
 	 * occur as we go
-- 
2.26.3

