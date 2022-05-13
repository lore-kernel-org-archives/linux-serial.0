Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A1C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 13 May 2022 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiEMNun (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 May 2022 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382351AbiEMNrL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 May 2022 09:47:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA04BFE3
        for <linux-serial@vger.kernel.org>; Fri, 13 May 2022 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652449630; x=1683985630;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-id;
  bh=H2EQ5pmDrOoMyH/GjKpitjLtiV8han2Ap779ubreZUM=;
  b=FhfVy7N9y4iHza0yVBBxFzXv8ghs6v4SNoQihcsk9rr+r8yYA+vFSBUf
   6tCVdQg3qbmbhiBklOaHWir96m3VZhVb8kzZ6Y9F0Sq7wIgOaCqFxCy3h
   UowZ+QMQvrFhT4orN2CMWs3wWUpuNdR6wIxrl1BiXKCv7RRK4xIkEtcEo
   U/uOy5dGOdu52o1y3/hZ+/MTHBTsLlFZp+UBx0hWOjhsO2cnscwEhfDO4
   o8lJffEm8Lu9Typ9i24Pr/erhvoKootnZo/oFhi2iQm8k1wyNBc7qTrWK
   beObz+dHVKNFPf+9RcreewUhXPrF/cfss+7Gz9u7OnHPb0Bi0jMPCGr6t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269141233"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269141233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:47:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="595228854"
Received: from huberth-mobl.ger.corp.intel.com ([10.252.34.58])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:46:48 -0700
Date:   Fri, 13 May 2022 16:46:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH] serial: 8250_fintek: Check SER_RS485_RTS_* only with RS485
Message-ID: <035c738-8ea5-8b17-b1d7-84a7b3aeaa51@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1629563579-1652448945=:1620"
Content-ID: <7e215adb-69e3-dc9f-aa14-2d4f9f45076@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1629563579-1652448945=:1620
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c9a72977-517b-c59-2fc5-c4ded8df256@linux.intel.com>

SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND relate to behavior
within RS485 operation. The driver checks if they have the same value
which is not possible to realize with the hardware. The check is taken
regardless of SER_RS485_ENABLED flag and -EINVAL is returned when the
check fails, which creates problems.

This check makes it unnecessarily complicated to turn RS485 mode off as
simple zeroed serial_rs485 struct will trigger that equal values check.
In addition, the driver itself memsets its rs485 structure to zero when
RS485 is disabled but if userspace would try to make an TIOCSRS485
ioctl() call with the very same struct, it would end up failing with
-EINVAL which doesn't make much sense.

Resolve the problem by moving the check inside SER_RS485_ENABLED block.

Fixes: 7ecc77011c6f ("serial: 8250_fintek: Return -EINVAL on invalid configuration")
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/8250/8250_fintek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 251f0018ae8c..dba5950b8d0e 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -200,12 +200,12 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	if (!pdata)
 		return -EINVAL;
 
-	/* Hardware do not support same RTS level on send and receive */
-	if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
-			!(rs485->flags & SER_RS485_RTS_AFTER_SEND))
-		return -EINVAL;
 
 	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Hardware do not support same RTS level on send and receive */
+		if (!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+		    !(rs485->flags & SER_RS485_RTS_AFTER_SEND))
+			return -EINVAL;
 		memset(rs485->padding, 0, sizeof(rs485->padding));
 		config |= RS485_URA;
 	} else {

-- 
tg: (4419da5d5d4b..) fix/8250-fintek-rts-check (depends on: tty-next)
--8323329-1629563579-1652448945=:1620--
