Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896EC433FE
	for <linux-serial@archiver.kernel.org>; Tue,  3 May 2022 06:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiECGe7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 May 2022 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiECGe7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 May 2022 02:34:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC43381A6;
        Mon,  2 May 2022 23:31:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21C2F1F747;
        Tue,  3 May 2022 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/LPOPn3cUAhg8MFXCjzVL28Mjke6V4g5iBBHycWtpNw=;
        b=CLC8WZ6eVqlKqOVcLHyslXW6PY5PK263n3dsz9eRSe1X7lwGkEKToDy5+eMsGzspwyA16p
        bHgIY3uxjFapKyZOLm5Bzmq0liqCrR0iZVm2ixZ2HnpWCm0/WHqz0A/TcxGNTyBFlRIa8G
        xkwjgFHYAaZVYTxOMOxX0w/E+uSodgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/LPOPn3cUAhg8MFXCjzVL28Mjke6V4g5iBBHycWtpNw=;
        b=+LFNd/FGqbQWecAZLBPSuPiuYMu9SgmJVPmTilWo+M9EJoDeOqLNOfHStql4UUOZWcMSq4
        cEul5ok/l4njIvBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1E882C141;
        Tue,  3 May 2022 06:31:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/11] serial: pic32: cleanup
Date:   Tue,  3 May 2022 08:31:11 +0200
Message-Id: <20220503063122.20957-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series:
* ! re-enables disabled irqs in pic32_uart_startup() (*)
* removes unused/unneeded stuff
* merges a separate .h into .c
* avoids potentially broken macros
* performs other cleanups

(*) I'm not sure how this driver could work until now. Maybe there is
some coincidental enablement of irqs I don't see. A contact to people
from microchip would be highly appreciated to check with them.

Jiri Slaby (11):
  serial: pic32: remove unused items from the header
  serial: pic32: move header content to .c
  serial: pic32: remove constants from struct pic32_sport
  serial: pic32: simplify clk handling
  serial: pic32: simplify pic32_sport::enable_tx_irq handling
  serial: pic32: remove pic32_get_port() macro
  serial: pic32: convert to_pic32_sport() to an inline
  serial: pic32: don't assign pic32_sport::cts_gpio twice
  serial: pic32: don't zero members of kzalloc-ated structure
  serial: pic32: free up irq names correctly
  serial: pic32: restore disabled irqs in pic32_uart_startup()

 drivers/tty/serial/pic32_uart.c | 159 +++++++++++++++++++++++---------
 drivers/tty/serial/pic32_uart.h | 125 -------------------------
 2 files changed, 116 insertions(+), 168 deletions(-)
 delete mode 100644 drivers/tty/serial/pic32_uart.h

-- 
2.36.0

