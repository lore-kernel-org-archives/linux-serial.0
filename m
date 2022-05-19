Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371EDC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 19 May 2022 08:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiESITL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 May 2022 04:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbiESISo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 May 2022 04:18:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F466FA2;
        Thu, 19 May 2022 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948322; x=1684484322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RnQRuR6bhTHb3WuNEk9N0DsLlzhv/5aX1wkEj3xq6s=;
  b=dl2Qcqgz51ttzzAgti3NiRWNaH0bAEeQxXZY7cLDNXQHOhtVMIE1jfcm
   FoeL64zbhGQI7yWia+wsvcG5dCoGCXH6Pl9w1AaLOq2ndCkkNe5GzfKGU
   /Q5Q4iKyKtYjPuyB7PU1bKiIG3k5Og0r16IsZjV+0gTGGTFA5BoOqlsS0
   PkB2MoLp5H+Ku+3j/JjTta0Mrn2I4grbtqAWb+2MZKPT7tQRZBEqe8gcb
   yGl7Ur8xsFRydryEbdPW6b/E3ZdL7wrhoUzHqODeh8Wo2se5r5QzDho9V
   jHZps0OpjXOb+mKtU4E1NTawtgQThw+66Cnd2RyF7BXAKkYWIONuOcm7G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272219035"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272219035"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431479"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 6/9] serial: sifive: Sanitize CSIZE and c_iflag
Date:   Thu, 19 May 2022 11:18:05 +0300
Message-Id: <20220519081808.3776-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
References: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Only CS8 is supported but CSIZE was not sanitized to CS8.

Set CSIZE correctly so that userspace knows the effective value.
Incorrect CSIZE also results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Similarly, INPCK, PARMRK, and BRKINT are reported textually unsupported
but were not cleared in termios c_iflag which is the machine-readable
format.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Fixes: 45c054d0815b (tty: serial: add driver for the SiFive UART)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sifive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index f5ac14c384c4..c1c0fb9c1822 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -666,12 +666,16 @@ static void sifive_serial_set_termios(struct uart_port *port,
 	int rate;
 	char nstop;
 
-	if ((termios->c_cflag & CSIZE) != CS8)
+	if ((termios->c_cflag & CSIZE) != CS8) {
 		dev_err_once(ssp->port.dev, "only 8-bit words supported\n");
+		termios->c_cflag &= ~CSIZE;
+		termios->c_cflag |= CS8;
+	}
 	if (termios->c_iflag & (INPCK | PARMRK))
 		dev_err_once(ssp->port.dev, "parity checking not supported\n");
 	if (termios->c_iflag & BRKINT)
 		dev_err_once(ssp->port.dev, "BREAK detection not supported\n");
+	termios->c_iflag &= ~(INPCK|PARMRK|BRKINT);
 
 	/* Set number of stop bits */
 	nstop = (termios->c_cflag & CSTOPB) ? 2 : 1;
-- 
2.30.2

