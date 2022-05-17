Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00779C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 17 May 2022 11:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiEQLIU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 May 2022 07:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344913AbiEQLIG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 May 2022 07:08:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD238AE5D;
        Tue, 17 May 2022 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652785685; x=1684321685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3rLSxMemifcCya5x4k0dLXnkqmQGBK5a9aBX6E+21uY=;
  b=UUt4+BRkbxWSsok34aBghj8DiGpTDRGeC9utQb9I49TEH5Du1/ZcxRVf
   rypfTainHbzWUU+smztuquLn4s4qQCpmwl8KseYzuYuQEW/9goCxYVAgK
   +M5f2il5e0r1+f6hZGX867GQfkQV7s+m4daJpcDK5CZ+Yj9UOUqkfGqjx
   G6bhdSYG76JYHktjUdw8KvklEwuvYdyu6RBTrAXZb8kHKNJ/BN/eRx7qu
   uUbcaRKTMt0CH4oPUr1TO+u+AV4bjr+z5njfFCNCJqvPaPO4MkOOElytE
   4X66kyjB34o7OnBKkonNB3lx8oZPo2KOQ/ZwqFea2w8NauaN/AEk0pswE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271268701"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271268701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568830979"
Received: from mtarral-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.52.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/9] serial: rda-uart: Don't allow CS5-6
Date:   Tue, 17 May 2022 14:07:31 +0300
Message-Id: <20220517110737.37148-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Only CS7 and CS8 are supported but CSIZE is not sanitized after
fallthrough from CS5 or CS6 to CS7.

Set CSIZE correctly so that userspace knows the effective value.
Incorrect CSIZE also results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Cc: Manivannan Sadhasivam <mani@kernel.org>
Fixes: c10b13325ced (tty: serial: Add RDA8810PL UART driver)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/rda-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index e5f1fded423a..f556b4955f59 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -262,6 +262,8 @@ static void rda_uart_set_termios(struct uart_port *port,
 		fallthrough;
 	case CS7:
 		ctrl &= ~RDA_UART_DBITS_8;
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS7;
 		break;
 	default:
 		ctrl |= RDA_UART_DBITS_8;
-- 
2.30.2

