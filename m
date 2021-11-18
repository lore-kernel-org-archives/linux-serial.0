Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01740C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEA861A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhKRHWO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:22:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243352AbhKRHWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:22:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A0A76212C5;
        Thu, 18 Nov 2021 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637219951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KpU4PD4+X7zcilkYqdW+aP0APYZdMy95FNaC1CHxDno=;
        b=iO6n6kdGZhVtwSV+aCwiO6IuXVCDff+S4LUIgRHDJr1Oegu1orvXKKq68gZIC1qZ5KbfQW
        XmfYODI7FYMEQr/MNkshcIxp0jln6Hfklvvzwa+Zu6cBCJd23oOZgem235mgYn/U24Uy+r
        EyDwIB2+NS3AU3bJWocm6K8Evcm4tQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637219951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KpU4PD4+X7zcilkYqdW+aP0APYZdMy95FNaC1CHxDno=;
        b=oPJCmRl0GHEywTzY3TdILTet1gglOaicKxPQvn9NexQDTRhnFDeIiGrIVRRA5ucewh7ZHM
        TdZfSqSmcyys9TBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 781B4A3B83;
        Thu, 18 Nov 2021 07:19:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/4] tty: small tidying
Date:   Thu, 18 Nov 2021 08:19:07 +0100
Message-Id: <20211118071911.12059-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is only 4 small random cleanups in tty.

Jiri Slaby (4):
  tty: remove TTY_SOFT_SAK part from __do_SAK()
  tty: remove tty NULL check from __do_SAK()
  tty: clean up whitespace in __do_SAK()
  tty: serial, join uport checks in uart_port_shutdown()

 drivers/tty/serial/serial_core.c | 12 ++++--------
 drivers/tty/tty_io.c             | 15 +++++----------
 2 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.33.1

