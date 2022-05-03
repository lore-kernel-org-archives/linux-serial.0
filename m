Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62754C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  3 May 2022 08:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiECIJs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 May 2022 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiECIJr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 May 2022 04:09:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F220F51;
        Tue,  3 May 2022 01:06:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CEC4D210E3;
        Tue,  3 May 2022 08:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pVdhTO58cA0WGYmIyIFXMLoTyXBBgEwBwsYTj6OYuVw=;
        b=tBKKadKZaMewyIEkXunzu47o2dCvAecpQNIQ39WOQL/cKt64z8nF4Kpn0bM9FgvaeXbmhO
        QkJXLbXUHVA8acmWW3oH/mwktHiNsWBq9rxKst6piJ/l0KmkKC+pE6rYGjnS7QMbIxJD1l
        UDG38pR2Qh187ZyuLROPhwlXTYPZMCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565173;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pVdhTO58cA0WGYmIyIFXMLoTyXBBgEwBwsYTj6OYuVw=;
        b=ivRCD+IqY+7m/LG+3Q9JFUvEjBhgRaEQclYoW1TqR8wTZo4AzeC/gVJb3KwbWJD1/dTSMF
        nhnzCjI4OQvL72Ag==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9CB682C142;
        Tue,  3 May 2022 08:06:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 0/7] serial: pch: cleanup
Date:   Tue,  3 May 2022 10:06:06 +0200
Message-Id: <20220503080613.27601-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series cleanup the TX path of the pch driver.

Jiri Slaby (7):
  serial: pch: move size check from pop_tx one level up
  serial: pch: don't overwrite xmit->buf[0] by x_char
  serial: pch: decomission pch_uart_hal_write()
  serial: pch: remove debug print from pop_tx
  serial: pch: remove xmit circ_buf size double check
  serial: pch: simplify pop_tx() even more
  serial: pch: inline pop_tx() into handle_tx()

 drivers/tty/serial/pch_uart.c | 77 ++++++-----------------------------
 1 file changed, 12 insertions(+), 65 deletions(-)

-- 
2.36.0

