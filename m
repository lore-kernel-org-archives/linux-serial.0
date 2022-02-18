Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD65FC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Feb 2022 07:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiBRHdI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Feb 2022 02:33:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiBRHdA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Feb 2022 02:33:00 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 23:32:39 PST
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04EF29720E
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 23:32:38 -0800 (PST)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20220218073128298adc805521fffee6
        for <linux-serial@vger.kernel.org>;
        Fri, 18 Feb 2022 08:31:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2QoxEb5jjQqEe5geNwJ+mjwTK4TQqzNR+pyl04R918k=;
 b=ZeGM0muVikeLVW3ioAfDZNV2g2Cl5RsaHoqT0WQLRx5dRB8w8z9WrwyEfoi6mLA4tmkRFv
 MVuAUrAh6AJzR1KgOdLqX9SQ2KBnGMpl70c+uWHsscI1JBW5PY9cFSK6cez1SJ3rGhxo9I3T
 k8l1NnzzQsphVDTRZXAxMEFjgPUZc=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 4/7] tty: n_gsm: fix NULL pointer access due to DLCI release
Date:   Thu, 17 Feb 2022 23:31:20 -0800
Message-Id: <20220218073123.2121-4-daniel.starke@siemens.com>
In-Reply-To: <20220218073123.2121-1-daniel.starke@siemens.com>
References: <20220218073123.2121-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The here fixed commit made the tty hangup asynchronous to avoid a circular
locking warning. I could not reproduce this warning. Furthermore, due to
the asynchronous hangup the function call now gets queued up while the
underlying tty is being freed. Depending on the timing this results in a
NULL pointer access in the global work queue scheduler. To be precise in
process_one_work(). Therefore, the previous commit made the issue worse
which it tried to fix.

This patch fixes this by falling back to the old behavior which uses a
blocking tty hangup call before freeing up the associated tty.

Fixes: 7030082a7415 ("tty: n_gsm: avoid recursive locking with async port hangup")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..e63154ef0b6c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1748,7 +1748,12 @@ static void gsm_dlci_release(struct gsm_dlci *dlci)
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 
-		tty_hangup(tty);
+		/* We cannot use tty_hangup() because in tty_kref_put() the tty
+		 * driver assumes that the hangup queue is free and reuses it to
+		 * queue release_one_tty() -> NULL pointer panic in
+		 * process_one_work().
+		 */
+		tty_vhangup(tty);
 
 		tty_port_tty_set(&dlci->port, NULL);
 		tty_kref_put(tty);
-- 
2.25.1

