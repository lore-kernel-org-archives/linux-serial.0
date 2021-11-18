Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C495C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E854617E3
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbhKRHe1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbhKRHe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 79603217BA;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PC2kSso+ODcF1LQn8/7pAYShEhcuBORpg4utwOiB8qE=;
        b=hzdxzvzD3sPdESzpX24erilkDtKMMEKUNZpEe2CX4hA1Nc5Uak+LW8ZC16HZMFHr//uRKD
        3SSHis806DbmwNVgbLTP28Tul4m0xqRUzg6f2G5a8HZwXQK5YUNcajZHMUqgpzi76k0l3W
        y2Vt8WJPMzRzZVr+M2w4M3/efyavG60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PC2kSso+ODcF1LQn8/7pAYShEhcuBORpg4utwOiB8qE=;
        b=yvGNEk+7RIVO89TQ3uKkAGVzEeHEeJimXI55wmmD68zoH7V1Ur1BGTMbEDmwyi26Y+P/zf
        yythTy08IgbMYkCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5170EA3B83;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/19] mxser: another round of cleanups and fixes
Date:   Thu, 18 Nov 2021 08:31:06 +0100
Message-Id: <20211118073125.12283-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver needs care. This is another round of tested changes to clean
up the driver.

Jiri Slaby (19):
  mxser: remove wait for sent from mxser_close_port
  mxser: rename mxser_close_port() to mxser_stop_rx()
  mxser: keep only !tty test in ISR
  mxser: move MSR read to mxser_check_modem_status()
  mxser: clean up tx handling in mxser_transmit_chars()
  mxser: remove pointless xmit_buf checks
  mxser: remove tty->driver_data NULL check
  mxser: call stop_rx from mxser_shutdown_port()
  mxser: don't flush buffer from mxser_close() directly
  mxser: use tty_port_close() in mxser_close()
  mxser: extract TX empty check from mxser_wait_until_sent()
  mxser: use msleep_interruptible() in mxser_wait_until_sent()
  mxser: clean up timeout handling in mxser_wait_until_sent()
  mxser: don't throttle manually
  mxser: remove tty parameter from mxser_receive_chars_new()
  mxser: increase buf_overrun if tty_insert_flip_char() fails
  mxser: add MOXA prefix to some PCI device IDs
  mxser: move ids from pci_ids.h here
  mxser: use PCI_DEVICE_DATA

 drivers/tty/mxser.c     | 306 +++++++++++++++++-----------------------
 include/linux/pci_ids.h |  18 ---
 2 files changed, 132 insertions(+), 192 deletions(-)

-- 
2.33.1

