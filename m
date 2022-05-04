Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B319AC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  4 May 2022 07:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbiEDHcn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 May 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiEDHcm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 May 2022 03:32:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92B237CA
        for <linux-serial@vger.kernel.org>; Wed,  4 May 2022 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651649335; x=1683185335;
  h=date:from:to:subject:message-id:mime-version:content-id;
  bh=RYiibE949eX+HzYcvgANsPtKHTCf9sjeyAFNdy9Ti3E=;
  b=RYbEJCx7rX8gZOx0/TVSscUE9VDMMjpL5b4lYVtcH7vdLzpGjCqCS3Zx
   H9sicSeJ0mpj/bbEnoTnII3Gf/J+XPM4VgwHC9jyU9wsd6o1mqHqeZUiY
   xBbn1wMEFYuFqXi5ggfvrPfZjYM3UQle3j1F80xhfpqJBYiX8zoEsfGvI
   RucBVt15q6yL9tW4ZJA+MbaucFdYFWIWLeB3koJwXqWbWYvpQ8Qv4OcmO
   lzuVsJ5+BZjpQI7Tk4LhmKBj05savdAgjywACtPcCLWY0P1IgCnwMls5Y
   ukVX1Va4EWYLh6EooiU20pqGFDH6+KvJXWv5k4NbIQ6KpYme7ppTmV3PI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="328231239"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="328231239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:28:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="584598324"
Received: from unknown (HELO ijarvine-MOBL2) ([10.251.218.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:28:53 -0700
Date:   Wed, 4 May 2022 10:28:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: [PATCH RESEND] serial: men_z135_uart: Drop duplicated iotype
 assignment
Message-ID: <14b71e1-2396-3d83-3a97-9582765d453@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2007442200-1651649275=:1623"
Content-ID: <10a3dd25-5ade-67e-7443-1aeda973150@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2007442200-1651649275=:1623
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <f476544d-f233-66a3-46ba-a1868fbfbca0@linux.intel.com>

The driver assigns same iotype twice. Drop one of them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---

Resending with correct linux-serial address.

 drivers/tty/serial/men_z135_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 9acae5f8fc32..12117b596e73 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -833,7 +833,6 @@ static int men_z135_probe(struct mcb_device *mdev,
 	uart->port.iotype = UPIO_MEM;
 	uart->port.ops = &men_z135_ops;
 	uart->port.irq = mcb_get_irq(mdev);
-	uart->port.iotype = UPIO_MEM;
 	uart->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	uart->port.line = line++;
 	uart->port.dev = dev;

-- 
tg: (672c0c517342..) cleanup/dbl_iotype_assign (depends on: master)
--8323329-2007442200-1651649275=:1623--
