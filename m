Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E917EC43464
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD692221EC
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600395069;
	bh=xHtK5ZBofi48UebHt83K9iVMvxfhA+Cef7KXu2AT7wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJoHfTHPSO9kc7qJGlmvQfxm96bS58VUCz7j7PEKFDdUZUNrNQXGW8ZyT4TAV3Xw/
	 JFS96ROo8AUZvxHAUuMqiH5cJgwz68DJ/bWFV5xXjvibc418LKOFVZ2Cq5F031dind
	 DuxFExBMv0TfSvV5yjw9lz9FKONroFUSZJaxdwj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgIRCK6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgIRCK5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Sep 2020 22:10:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D105208E4;
        Fri, 18 Sep 2020 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395056;
        bh=xHtK5ZBofi48UebHt83K9iVMvxfhA+Cef7KXu2AT7wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8STfrBv74RSSydk0KL9jnG89TMGse8gkpvJl+Vzl3lkxoR3dmmlDu+8dDlgZOtCW
         1WpwSFCohKJjnI1q4sA3nwIvWZirwRMQVrszWoprvgqK4EiaXBqTYDlwEZfHEezvrq
         WCOC7zJeyha7awxipp4U3k4lMbEAJhjRg3HhuBs8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 143/206] serial: uartps: Wait for tx_empty in console setup
Date:   Thu, 17 Sep 2020 22:06:59 -0400
Message-Id: <20200918020802.2065198-143-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

[ Upstream commit 42e11948ddf68b9f799cad8c0ddeab0a39da33e8 ]

On some platforms, the log is corrupted while console is being
registered. It is observed that when set_termios is called, there
are still some bytes in the FIFO to be transmitted.

So, wait for tx_empty inside cdns_uart_console_setup before calling
set_termios.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Link: https://lore.kernel.org/r/1586413563-29125-2-git-send-email-raviteja.narayanam@xilinx.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 31950a38f0fb7..23f9b0cdff086 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1236,6 +1236,7 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	unsigned long time_out;
 
 	if (!port->membase) {
 		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
@@ -1246,6 +1247,13 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
+	/* Wait for tx_empty before setting up the console */
+	time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
+
+	while (time_before(jiffies, time_out) &&
+	       cdns_uart_tx_empty(port) != TIOCSER_TEMT)
+		cpu_relax();
+
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-- 
2.25.1

