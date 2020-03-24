Return-Path: <SRS0=BK0i=5J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6EEC10DCE
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193B02074D
	for <linux-serial@archiver.kernel.org>; Tue, 24 Mar 2020 06:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC8RSUsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCXGuD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:50:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41604 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXGuD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Mar 2020 02:50:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so7014920plr.8;
        Mon, 23 Mar 2020 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaCNXsC3UAwYO4xUT1ocD5hAqCfIFkIpUm3n4JspozY=;
        b=FC8RSUsQWfVgEN/J5OAPYJqDYUCWq9SbVwhAwPc21LbX5pJl5nQM8vloM0XNbtsSt5
         zPB2acM5o3sG/JrvYG6Pyvew2Yp2teJ3QSxKQyrLLK+w+VkrAVtEwSvah5QW2pi8Cwj1
         HqrLlH2GBrMJ4RayVy8/rWszEMjD5w9+gYcJAHx54klw+Ov3j3M6/i8Z4Ybp4DqC7OYT
         bdB/qAREyZgcDnnA1yMo81481ApmgZWkTwAMe/l746SUjLo+hU00Jy1EQzvPCjKIl+73
         XdCoIbu2yvXYtFLpG3/+qVdxwVqzdEvA3/hexqR+BCzxY3rjlmBYvu0ERiaHPkJHUWmQ
         UDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaCNXsC3UAwYO4xUT1ocD5hAqCfIFkIpUm3n4JspozY=;
        b=twlOfj8YKuvDR3dMd484Pz8gksUeXFJNSrpMq46L0sY3duAOHc3pJ16Nv3jLYllnPa
         C+GMAIk/bQWp/yo33FK9LCfr4m+yT/Q5Pf8to1Nw4P56/zDi8gGs2sWcZowIKsUzzQ5o
         ry1Yhe9EA3oCJdURih4OAYJS8DSpeY3rht3SQmLiEH6ip+hYzA/aBZYjgld9200+z9AS
         6QNoc7WMo4euDulC9be/pf+bghc5QP5YvBi8/fg/Wu5Y5rdewA1crbYvLaTbJT9pcXWr
         YgaTgB3gJs9GrVntxA+S6DgUVemjFruznt3tqubL8A41XViCqXtyyRtm/s6GnRhzBt8t
         CuWA==
X-Gm-Message-State: ANhLgQ0Mpp0yu+wn/xv68p/wmMZFsiXrZylLALSiM5iH0dtOK5NQARI2
        aW+cjIkZxTg+0xN2U+U3Z9Q=
X-Google-Smtp-Source: ADFU+vu37vNKpUBlGeUMaTZdqjHfQEpIM7AmSsRUZWGk0J3YrM9jL5kKt/K16/BKB1WkXjsfk6W85g==
X-Received: by 2002:a17:902:b489:: with SMTP id y9mr25883954plr.144.1585032602145;
        Mon, 23 Mar 2020 23:50:02 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t3sm8680103pfl.26.2020.03.23.23.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:50:01 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] tty: serial: make SERIAL_SPRD depends on ARM or ARM64
Date:   Tue, 24 Mar 2020 14:49:49 +0800
Message-Id: <20200324064949.23697-1-zhang.lyra@gmail.com>
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

Because some mips Kconfig-s select CONFIG_HAVE_CLK but not CONFIG_COMMON_CLK,
so it's probably that clk_set_parent is missed for those configs.

To fix this error, this patch adds dependence on ARM || ARM64
for SERIAL_SPRD.

Fixes: 7ba87cfec71a ("tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b43dce785a58..417f7e45a3f8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1444,6 +1444,7 @@ config SERIAL_MEN_Z135
 config SERIAL_SPRD
 	tristate "Support for Spreadtrum serial"
 	select SERIAL_CORE
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  This enables the driver for the Spreadtrum's serial.
 
-- 
2.20.1

