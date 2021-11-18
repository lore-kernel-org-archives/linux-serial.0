Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236ABC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D69361875
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbhKRHef (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbhKRHe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E46C61FD37;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqtdodw6qf92XPPiHkSJ05IPJu6Cc0cYUhgjELbsJOI=;
        b=rm65yxUZiAxVNd2Hs77jBTUrVk6E/J+JseJcVESNQYRx8b7Ahbq/STuca0LCMQ7zG5jnj3
        Og+eAGTF9Io8jaKTlqOpd0Nxta/x9T1anbqz7tJFJUNrpFHxhztZZHlxARQaVceh3IGJu5
        qqJNPQXA9JYfnbFBASAMHRyHrYLBtas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iqtdodw6qf92XPPiHkSJ05IPJu6Cc0cYUhgjELbsJOI=;
        b=HBogkW3OE5ZZofPw7T58XO6uBVCtokiNXfGueQzyyXkiPzdMNvnPtkiUmIyBT/Ytei2dr4
        RI76dzceeauKL3BQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BC948A3B84;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/19] mxser: remove tty->driver_data NULL check
Date:   Thu, 18 Nov 2021 08:31:13 +0100
Message-Id: <20211118073125.12283-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Noone sets tty->driver_data to NULL in the driver, so there is no point
to check that in mxser_close(). Remove the check.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6e5e1c74bf3e..6b47a0607f59 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -905,8 +905,6 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	struct mxser_port *info = tty->driver_data;
 	struct tty_port *port = &info->port;
 
-	if (info == NULL)
-		return;
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
 	mutex_lock(&port->mutex);
-- 
2.33.1

