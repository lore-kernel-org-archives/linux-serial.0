Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA80C18E5B
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8E620663
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWq3ZSNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCYIOh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:14:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45821 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCYIOh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 04:14:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so783583pgc.12;
        Wed, 25 Mar 2020 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHriMRRnBlnzmaQlY1pxbBcl5uot0p0Yl6mHzSeiY0w=;
        b=PWq3ZSNUpvOaBMwo5MFqymaxHPGaAAVl+lDwGQhstHsVI8xm23z+XLs3izHJplQ6Ig
         NjqQmiuzvvdp8iei98+wdxzNvu7YB4rTWnDGx12d+IUbbsWIs+YE6K+FCDSS5vUNMsK5
         yqPKY9f98DvyXxEkWT9zg6ESd7NSGTptCxS2A+gcd2vRcBKav25VLx8uRd4dcAiiaCfh
         5C2NfRodHPNxubNEcMhEIHxcBshk0Nj8Ivp+zOCmN164nW5tfzUclABzXTvLQvzOp7P+
         xE8wndofldx/VmkoNDa7QL2Bzk9Rr7PQ0v9MRxAnJUXQD+5mAZMpnBXSu/A/wdt3c9vg
         T9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHriMRRnBlnzmaQlY1pxbBcl5uot0p0Yl6mHzSeiY0w=;
        b=UqpyatctPCi5Nzqgoj7LFgYfaDxllO0v3pgJwOeLv24C7L6UJxinPpOFayJ8k8gIC3
         WhVnsdtt6p73yuHMpJzazWzuZRlKbtjD8VTiwrtbE+/w+TI0NPAeNLtm/K+X2wEP0bii
         G73CQareVImAfXYGvzr7woFjBQIRwY6z4FyEJGc06xFmnmeYtV0ZqV/gXTBkQpboTqtC
         DeD+WwC8pSFevhSWKrVYlq2SxxfvPTPlvMPaXZON7GQzPr5v8jI0pf5HxfiFVf7vNkYB
         +ZU4QDU8UupbnjTo3JtJkNB81C2VteLZJTWiZ8nAPi3tnaAFn1BGTS/QfbzwyglG/0sx
         /+Lw==
X-Gm-Message-State: ANhLgQ2T4RFMs1H+dBbCmeY9qY0NZZGBVoDzd+IbiP3VdBLZD/XqKubq
        uKhZ/e+NrlmjijTjCRYhh2Y=
X-Google-Smtp-Source: ADFU+vsWjVwmho5mKXPOUHGggde/eZaV7TnENdUUVoDY3fxC/MWXMcRKVAxNhD0gw4fxe4DTGQVDAA==
X-Received: by 2002:aa7:8685:: with SMTP id d5mr2221555pfo.3.1585124074438;
        Wed, 25 Mar 2020 01:14:34 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 5sm17893766pfw.98.2020.03.25.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:14:33 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2] tty: serial: make SERIAL_SPRD depend on COMMON_CLK
Date:   Wed, 25 Mar 2020 16:14:27 +0800
Message-Id: <20200325081427.20312-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

kbuild-test reported an error:

  config: mips-randconfig-a001-20200321 ...
  >> drivers/tty/serial/sprd_serial.c:1175: undefined reference
  to `clk_set_parent'

Because some mips Kconfig selects HAVE_CLK but not COMMON_CLK and no
clk_set_parent implemented, so the error was exposed. So adding
dependence on COMMON_CLK can fix this issue.

Fixes: 7ba87cfec71a ("tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes from v1:
* Change to depend on COMMON_CLK instead of ARM
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b43dce785a58..ff942ca95b66 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1444,6 +1444,7 @@ config SERIAL_MEN_Z135
 config SERIAL_SPRD
 	tristate "Support for Spreadtrum serial"
 	select SERIAL_CORE
+	depends on COMMON_CLK
 	help
 	  This enables the driver for the Spreadtrum's serial.
 
-- 
2.20.1

