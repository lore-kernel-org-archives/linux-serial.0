Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD4C43334
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiFFKGn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiFFKGd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1475A1406E5;
        Mon,  6 Jun 2022 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509987; x=1686045987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3RG7RiqLVkSjMY/0QXHmsqqxtOf4UPp+0s1mxIStBo=;
  b=QmDjmMN+E4MuCkOOUrGvLBhyHoQk8ycAbLTEJfI9yhtS2QVfg5jWFk3P
   YnYRqUzmytOj0HkkIEg6QpukYoKwuwO0uHlLtjP1StMN2POVOZgbBSjfo
   jCu04efKaRUhZMESPb5myDKU25LDkk0A8Zcofe+SwzYM7OqOM/R8eeGJ1
   EVt+6/egM30ZN1ukIZUUPRX96WS+XKVrEpqyVQjovwvTToqYW6GamkmoQ
   Ut7EpQKCpQn3jvcqZFusgC3IWcFvZHn2iNt856y0IvVNYFsP2AYEkfsym
   nAr9dF4fTqc3XnCpRsjlJbKhRPvOHi0Dd4EqChpQbJMDgLljgBmkT/O8V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987090"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:26 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523882"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:06:24 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 32/36] serial: max310x: Remove serial_rs485 sanitization
Date:   Mon,  6 Jun 2022 13:04:29 +0300
Message-Id: <20220606100433.13793-33-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Serial core handles serial_rs485 sanitization.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/max310x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9837f542a55a..d7d1791fcb57 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1035,8 +1035,6 @@ static int max310x_rs485_config(struct uart_port *port,
 	    (rs485->delay_rts_after_send > 0x0f))
 		return -ERANGE;
 
-	rs485->flags &= SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX |
-			SER_RS485_ENABLED;
 	port->rs485 = *rs485;
 
 	schedule_work(&one->rs_work);
-- 
2.30.2

