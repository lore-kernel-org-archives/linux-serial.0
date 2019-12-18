Return-Path: <SRS0=1HLL=2I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD8BC43603
	for <linux-serial@archiver.kernel.org>; Wed, 18 Dec 2019 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464F62176D
	for <linux-serial@archiver.kernel.org>; Wed, 18 Dec 2019 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576674773;
	bh=knPBaCnFj8U3BhTFY1EU38+tOZecBbs5N+0WNBGwyUo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JKnmu1otjYd/79CphiZU/+mRmW3xV6CdpvP/W+C1bsXcAPGIsMwezdp2w5+ZCgh0x
	 7asHaCanfRbdFvwpDvvTz6GXUCvvefmLifpVELdAt29MLA7JLVXWby8ZwdhxggkYpE
	 XPU6LXxDh0KwpSXM+ZqnyS585EUcAp1F7hDymbAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfLRNMx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:12:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39756 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfLRNMw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Dec 2019 08:12:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so1664668lfb.6;
        Wed, 18 Dec 2019 05:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnikZguWA1RXd3FXpDoBBFmrN7lLJJJG6TIoC5TI72o=;
        b=OfBrhVulOMGgsGB8mYCCKlhN+39CNnci4vHjOuuPKpdfofqM2LQ7XgYTVouA/b91dm
         3Un961lD5UNiL/vH7ZsnSgQn5HzkzZE+z6eUeAJW6fPcOnPn+/Mr37ea3Y+57YQHorPg
         kIzMTNn85gjOUrY+4f+molSIgQ9cEpgMEJLV/gD0DLQfE9QdtSyb51NswLdf9oEDZPW5
         HeVTJxwEblElO52Yy3IJEt2UtSi+UtRGHZz5Kzqf6fXm+7UcRG7xrrmmL7Nuz+5UgTUM
         0EuIWiSeQqyOKEfUrwcdk4Z7j40IzlOxBgbKODTRE7NgvBlQtLkQRnh4B9TGEHjYmBis
         UJ5w==
X-Gm-Message-State: APjAAAWC88NfIA7aaYq0Wst47VeHH/R5hK/vVJie4k0O0qZegRCsBoWY
        fgL9oDwNUauoNqpgCTAkAuc=
X-Google-Smtp-Source: APXvYqyDro71G9Jpnt8Wut4mtlSk2cZ4uT7ukhBZljHm9ZO9hpduk+CJYVjT8KddyJM7wwCoL1To6A==
X-Received: by 2002:ac2:599c:: with SMTP id w28mr1785854lfn.78.1576674768749;
        Wed, 18 Dec 2019 05:12:48 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id c27sm1104077lfh.62.2019.12.18.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:12:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ihZ88-0003Zx-RI; Wed, 18 Dec 2019 14:12:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] Revert "serdev: simplify Makefile"
Date:   Wed, 18 Dec 2019 14:11:54 +0100
Message-Id: <20191218131154.13702-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 54edb425346a4d5e17f7e54e8c97c0d0eac26315.

The offending commit caused serdev core to always be built-in, something
which breaks the build of dependent modules when serdev is being built
as a module:

ERROR: "__serdev_device_driver_register" [drivers/gnss/gnss-ubx.ko] undefined!
...
make[2]: *** [/home/johan/work/omicron/src/linux/scripts/Makefile.modpost:94: __modpost] Error 1

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index f71bb931735b..078417e5b068 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 serdev-objs := core.o
 
-obj-y += serdev.o
+obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
 
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
-- 
2.24.1

