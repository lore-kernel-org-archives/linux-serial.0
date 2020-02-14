Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5408C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E7424650
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703832;
	bh=8ZM05lNKpU6kdaPrhIh/NDaUPwNaVKRoptZj+HHqS/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BOZxD8Hwl34zI7eItSmtgwPbHiriLbUQTCAwTwtLoRRnEDBKzXE9DtorvPQERRVSu
	 j5QFbSaN050KMl15mUybxXGGmAUEFT0+SseeupOyDKBFWnUCMMhn2IVjS+YE0zxhWC
	 I1grI+Ehm382qJUmb8ofQUQQ+Pj8FQkbTD99ALz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgBNSKa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgBNPxn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BB824682;
        Fri, 14 Feb 2020 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695623;
        bh=8ZM05lNKpU6kdaPrhIh/NDaUPwNaVKRoptZj+HHqS/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0X82fS4vqMCW82aYrM5qCPh1XoL5ECdTqViJON/O8jcCMiXlRtt+Fi5WJmcjZB2/A
         oe1CyNnvExiLp0Lv5C5BD0zBtiBQdU9YrjGobf21lH7MdxJJku11QVlf5uzXrp9ueV
         jyyqCFjuhgtRYEdtSgpN16k0nfROoGcdH52pwRIw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Engraf <david.engraf@sysgo.com>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 222/542] Revert "tty/serial: atmel: fix out of range clock divider handling"
Date:   Fri, 14 Feb 2020 10:43:34 -0500
Message-Id: <20200214154854.6746-222-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 6dbd54e4154dfe386b3333687de15be239576617 ]

This reverts commit 751d0017334db9c4d68a8909c59f662a6ecbcec6.

The wrong commit got added to the tty-next tree, the correct one is in
the tty-linus branch.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Engraf <david.engraf@sysgo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 1ba9bc667e136..ab4d4a0b36497 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2270,6 +2270,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		mode |= ATMEL_US_USMODE_NORMAL;
 	}
 
+	/* set the mode, clock divisor, parity, stop bits and data size */
+	atmel_uart_writel(port, ATMEL_US_MR, mode);
+
 	/*
 	 * Set the baud rate:
 	 * Fractional baudrate allows to setup output frequency more
-- 
2.20.1

