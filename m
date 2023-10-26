Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB0C25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 06:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjJZGAM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 02:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGAL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 02:00:11 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AECC115
        for <linux-serial@vger.kernel.org>; Wed, 25 Oct 2023 23:00:07 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202310260600042a3d288aba308fb64f
        for <linux-serial@vger.kernel.org>;
        Thu, 26 Oct 2023 08:00:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=i3xb5thx0MStC8QddfRm44mVBZo7gXtRg05zVb8PFKg=;
 b=Yk9TWcAbRChesErzaiTjGYrKUXMFp+QoYKQtTK3Vu7Thfiou1vhn8n3v2UZJODaJVssXlD
 DY8CRagUEvSAZAe7FF3GzAG2zFmN42qjnRtch0dVeP7YTrLVbytL36gbu6IRkWuN+58XlrTM
 KCIC2V4hXgD3CRpelYBJQ8Iiwlck8=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/2] tty: n_gsm: fix race condition in status line change on dead connections
Date:   Thu, 26 Oct 2023 07:58:43 +0200
Message-Id: <20231026055844.3127-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

gsm_cleanup_mux() cleans up the gsm by closing all DLCIs, stopping all
timers, removing the virtual tty devices and clearing the data queues.
This procedure, however, may cause subsequent changes of the virtual modem
status lines of a DLCI. More data is being added the outgoing data queue
and the deleted kick timer is restarted to handle this. At this point many
resources have already been removed by the cleanup procedure. Thus, a
kernel panic occurs.

Fix this by proving in gsm_modem_update() that the cleanup procedure has
not been started and the mux is still alive.

Note that writing to a virtual tty is already protected by checks against
the DLCI specific connection state.

Fixes: c568f7086c6e ("tty: n_gsm: fix missing timer to handle stalled links")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1f3aba607cd5..0ee7531c9201 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -4108,6 +4108,8 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 {
+	if (dlci->gsm->dead)
+		return -EL2HLT;
 	if (dlci->adaption == 2) {
 		/* Send convergence layer type 2 empty data frame. */
 		gsm_modem_upd_via_data(dlci, brk);
-- 
2.34.1

