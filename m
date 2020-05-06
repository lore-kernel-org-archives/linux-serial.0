Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D1C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECDA20663
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K+If0UPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgEFHX3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 03:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728073AbgEFHX2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 03:23:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61E3C061A10
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 00:23:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so560755pfx.6
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2020 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjwZKQ/MsOEoyrI1M9q54kkv4zKzlSrLRr8tdH7/u6g=;
        b=K+If0UPxcEszSaumR/NuK1/VhEn/oTDJddd23FqiNVVBAl32UGkD3t8Ahb2L7gAg3J
         c0BwnArx3xdme3E0yTCfDY0ITbByJRm4LJbTTpx9ASYux8G/7/spyYpAMKwpT5bhAMfW
         wO4gjMLL2G0vsIj4ftf3LKoYDTUnqKgV0rXAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjwZKQ/MsOEoyrI1M9q54kkv4zKzlSrLRr8tdH7/u6g=;
        b=Cq0QEk1TpATbB6oDsmCea3C1Mt/V08R8D/xiEdHixu8ma7YGOD0xPKkaLVQIYRFXId
         gxWNiYseCw6PX0qWWdZzvM3CUnhAGwd53/LsktGxrKZwkFfZfvaxnvZvPjf8YQlsZrQH
         Xcb8y8Iuy9CjOKnNduuCsXAxZ/VbRsPXiIf9qX88xDEJa7zvOFkeWcLvuyiy4K4uiPTF
         4iGXXzSrnSr9kIYlnZIjL0PDqG8dUak+Djrddz5eZgVqgNcvJH9FvexTyZulF45CDCGw
         ex4TghBA/Kz1dnAXVl9l2un4hc9r2yk3uYxf1G68cNeGlzb7OM2zmA30xCc7Rjhgml8E
         wa0A==
X-Gm-Message-State: AGi0PuaXyDb/yXSfWl1BV+ig3BYOOYJJbIUxXoe7vX3uEqGa6jgHudmf
        wus0k+WhH6n1ofHB8OupKCAqXh5WtR8=
X-Google-Smtp-Source: APiQypIUf1EiFl44Et+u6l1H3cnWCYGcfkquxMyqGWV5GjOWfcnttjRAbg2g3LDbGI2TFev31Xa/pw==
X-Received: by 2002:aa7:808e:: with SMTP id v14mr7000734pff.168.1588749808248;
        Wed, 06 May 2020 00:23:28 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id x10sm993142pgq.79.2020.05.06.00.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:23:27 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        long.cheng@mediatek.com, changqi.hu@mediatek.com
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH 0/3] add wakeup_irq for in-band wakeup support
Date:   Wed,  6 May 2020 15:23:11 +0800
Message-Id: <20200506072314.112409-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since some uart controllers may be off in S3, add additional wakeup_irq
to support in-band wakeup.

Claire Chang (3):
  serdev: ttyport: add devt for tty port
  tty: serial_core: add wakeup_irq to support in-band wakeup
  uart: mediatek: move the in-band wakeup logic to core

 drivers/tty/serdev/serdev-ttyport.c |  2 ++
 drivers/tty/serial/8250/8250_core.c |  1 +
 drivers/tty/serial/8250/8250_mtk.c  | 24 +++---------------------
 drivers/tty/serial/serial_core.c    |  8 +++++---
 include/linux/serial_core.h         |  1 +
 5 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

