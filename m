Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DCC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF1D222D9
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBSIuL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgBSIty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B1DAAD3C;
        Wed, 19 Feb 2020 08:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/10] n_gsm: add missing \n to prints
Date:   Wed, 19 Feb 2020 09:49:45 +0100
Message-Id: <20200219084949.28074-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d866884c105b..8afe635a04fd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2789,7 +2789,7 @@ static void gsm_destroy_network(struct gsm_dlci *dlci)
 {
 	struct gsm_mux_net *mux_net;
 
-	pr_debug("destroy network interface");
+	pr_debug("destroy network interface\n");
 	if (!dlci->net)
 		return;
 	mux_net = netdev_priv(dlci->net);
@@ -2818,7 +2818,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 	if (nc->adaption != 3 && nc->adaption != 4)
 		return -EPROTONOSUPPORT;
 
-	pr_debug("create network interface");
+	pr_debug("create network interface\n");
 
 	netname = "gsm%d";
 	if (nc->if_name[0] != '\0')
@@ -2826,7 +2826,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 	net = alloc_netdev(sizeof(struct gsm_mux_net), netname,
 			   NET_NAME_UNKNOWN, gsm_mux_net_init);
 	if (!net) {
-		pr_err("alloc_netdev failed");
+		pr_err("alloc_netdev failed\n");
 		return -ENOMEM;
 	}
 	net->mtu = dlci->gsm->mtu;
@@ -2844,7 +2844,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 	dlci->data = gsm_mux_rx_netchar;
 	dlci->net = net;
 
-	pr_debug("register netdev");
+	pr_debug("register netdev\n");
 	retval = register_netdev(net);
 	if (retval) {
 		pr_err("network register fail %d\n", retval);
-- 
2.25.0

