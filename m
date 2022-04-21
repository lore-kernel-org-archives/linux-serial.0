Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE24C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 08:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387043AbiDUJBA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiDUJA7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 05:00:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186320F71;
        Thu, 21 Apr 2022 01:58:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7AE49210DC;
        Thu, 21 Apr 2022 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UPngWza2saxpKwq+0ab0aiX205LXtiW/Nfqjv/JihfM=;
        b=MT1y5JF3OQijX8Nb0kpC3kISnyluNTci09o1tumCOxcnMju4dIkL4jNMmQzSjW0laAgFWp
        B9pnMrCO2klY9Q4yF6r0QJGzwx5nzQkhrqloCvvlXyXEGr9Q6/kFgUbytFIfYA4F/PnGYi
        XZeBecqBSWYzLY6T7axD0z/VwQTksjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UPngWza2saxpKwq+0ab0aiX205LXtiW/Nfqjv/JihfM=;
        b=Yo7zaLB/VQ5FhHRk0cwvK43KjSrzSttuHvU5P9gZrME693fApEltugLPiyVP13MsldxhSy
        ddKJIzRWk9E1/TAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 498082C141;
        Thu, 21 Apr 2022 08:58:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/10] serial: icom: cleanup
Date:   Thu, 21 Apr 2022 10:57:58 +0200
Message-Id: <20220421085808.24152-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series:
* removes unused/unneeded stuff
* fixes sparse warnings
* removes a separate .h
* avoids potentially broken macros
* performs other cleanups

Jiri Slaby (10):
  serial: icom: remove ICOM_VERSION_STR macro
  serial: icom: switch vague casts to container_of
  serial: icom: remove to_icom_adapter() and icom_kref_release()
  serial: icom: use proper __le types and functions
  serial: icom: move header content to .c
  serial: icom: use ARRAY_SIZE
  serial: icom: make icom_acfg_baud const and unsigned
  serial: icom: use list_for_each_entry()
  serial: icom: delete empty serial hooks
  serial: icom: remove unused struct icom_port members

 drivers/tty/serial/icom.c | 536 +++++++++++++++++++++++++++-----------
 drivers/tty/serial/icom.h | 274 -------------------
 2 files changed, 385 insertions(+), 425 deletions(-)
 delete mode 100644 drivers/tty/serial/icom.h

-- 
2.36.0

