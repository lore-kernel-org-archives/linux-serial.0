Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52FC001E0
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 19:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGaTAG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 15:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGaTAE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 15:00:04 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F601BD3;
        Mon, 31 Jul 2023 12:00:01 -0700 (PDT)
Received: from quatroqueijos.lan (201-43-195-14.dsl.telesp.net.br [201.43.195.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5C0C141E37;
        Mon, 31 Jul 2023 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690829999;
        bh=SpTi4eXcMBULgHrAPUO/kPqUwuzXKmursJQy7z+Cg9Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AqDCcghbdEu3jCMWuxXQIJ4aHH2y33CotZ3U1v2pOSPOCuz9e3DtVyiVV8C2cVfgB
         o0xufSifsRPc9R8+bCLc/yNiy0zdvvApWJUtCgCN8Bn/1luT1cjCmYCKhImZU9WpgH
         jsfiHM3lVLKYwHxjOZnA9qq2/I+wABqg2fbIG2QdIMc6tYFKAYbo7cU8VPDzYHcg/V
         7TEqKsbQy7bn3lgG5S/4iwKXEhvniFJNIqNVcyCUWmErxykEy61AhqpP8fPdvWVSxP
         wAPBgQG1yZm8p3dfLDgEi2gaWgPTrpCQYIvqGyPcY7OFMqbpupsFxUIKEk2ZNscgD2
         UFcBGiZ1z25ww==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc
Date:   Mon, 31 Jul 2023 15:59:42 -0300
Message-Id: <20230731185942.279611-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Any unprivileged user can attach N_GSM0710 ldisc, but it requires
CAP_NET_ADMIN to create a GSM network anyway.

Require initial namespace CAP_NET_ADMIN to do that.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1cdefac4dd1b..c7a787f10a9c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3576,6 +3576,9 @@ static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
-- 
2.34.1

