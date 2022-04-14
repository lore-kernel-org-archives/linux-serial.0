Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D6C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiDNJqo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiDNJqZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:25 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:59 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E3710D8
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:59 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220414094249b3206f392fd4a86da6
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GdQfGxCXfdHiLKx0XYK3usSDpPXKEHJrcncLZSvBuPI=;
 b=LEDdZP6wOe+DL8jJmBd7pfREXFUJfv8JgDryDxgCX2ro8nk/qVQSzVB5nS5F0eXtd8cbIj
 oujm/wynUYBkZ4Gk2xiFEVE9oNqce77yQMdKssOVGiiNWLon4rXocf5iAFuVHLqq4sYmjyeC
 PSTElhPdNbZeSZZ0n7x0eW2SMkGMc=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 14/20] tty: n_gsm: fix missing tty wakeup in convergence layer type 2
Date:   Thu, 14 Apr 2022 02:42:19 -0700
Message-Id: <20220414094225.4527-14-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

gsm_control_modem() informs the virtual tty that more data can be written
after receiving a control signal octet via modem status command (MSC).
However, gsm_dlci_data() fails to do the same after receiving a control
signal octet from the convergence layer type 2 header.
Add tty_wakeup() in gsm_dlci_data() for convergence layer type 2 to fix
this.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 23418ee93156..f3fb66be8513 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1615,6 +1615,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 		tty = tty_port_tty_get(port);
 		if (tty) {
 			gsm_process_modem(tty, dlci, modem, slen);
+			tty_wakeup(tty);
 			tty_kref_put(tty);
 		}
 		fallthrough;
-- 
2.25.1

