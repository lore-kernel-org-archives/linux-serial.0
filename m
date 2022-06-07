Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CBFCCA48B
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350764AbiFGSS2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351676AbiFGSQg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 14:16:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD1168367;
        Tue,  7 Jun 2022 10:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3637B822CD;
        Tue,  7 Jun 2022 17:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9055C3411C;
        Tue,  7 Jun 2022 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654624189;
        bh=C3p8V+CShGR7nozEVmR7aMQKSLK+SVYLvPNgHctlLf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUG3+XhgZgpmffcMbPkC8s2EfFubH3J7+kLOsWCDlrqz0FW8l1RNK/AyTxJ7xqWA5
         xKnXaCI6KNHrJyJEV/XbLrGqP2ElRwhM0ZatierSYwC4UAXxTUkzFG5dcjthvU5rEL
         5KudYeoITjMrOwnpqEM6sGzFRBzHkMt4JH1kVDXdjjPnVBy2aXId+skBuxYfLgtQHv
         h+S4UdxKQ6wIjjfa4jl5ubSPzAXQTtXLxSLWF2zm2TBdp3CjKDohjmzCEM07lfjsVC
         5BOeGDBX7f8a0ewscUL4CTHEi/GnVz3wgQ8JmATeQYKRSAjEArvAUcSxsSoUJk1LSy
         BSJy+eFLBNxZw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huang Guobin <huangguobin4@huawei.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 09/68] tty: Fix a possible resource leak in icom_probe
Date:   Tue,  7 Jun 2022 13:47:35 -0400
Message-Id: <20220607174846.477972-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607174846.477972-1-sashal@kernel.org>
References: <20220607174846.477972-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Huang Guobin <huangguobin4@huawei.com>

[ Upstream commit ee157a79e7c82b01ae4c25de0ac75899801f322c ]

When pci_read_config_dword failed, call pci_release_regions() and
pci_disable_device() to recycle the resource previously allocated.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
Link: https://lore.kernel.org/r/20220331091005.3290753-1-huangguobin4@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/icom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 03a2fe9f4c9a..02b375ba2f07 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1501,7 +1501,7 @@ static int icom_probe(struct pci_dev *dev,
 	retval = pci_read_config_dword(dev, PCI_COMMAND, &command_reg);
 	if (retval) {
 		dev_err(&dev->dev, "PCI Config read FAILED\n");
-		return retval;
+		goto probe_exit0;
 	}
 
 	pci_write_config_dword(dev, PCI_COMMAND,
-- 
2.35.1

