Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C51C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 17 May 2022 11:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiEQLIA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 May 2022 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiEQLH4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 May 2022 07:07:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A111A02
        for <linux-serial@vger.kernel.org>; Tue, 17 May 2022 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652785673; x=1684321673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4a5Pg6xld+sAqm+8eEi4A+uUzEUIc3jgurKLQWcWFCY=;
  b=KmPhPZBWWwnsWLC2/ZlmhuI3i+63T8xthr6ZJHksT6eHbsLqIYUBdq//
   UA66FdF8nuqA/NG4B4av9SVxRD4wA1JOIPlCVMpz2Gypu4t8d/O6RzRqs
   FpQ9y00tbcdbVuTGUvJlARc5QCDuD+tMHhpca8IL2Ixzxj+e9YHBatLh2
   6zbC7FovrKMETrzAvVr63j6FyEZteVH6ACBZKfQckxk35ljeRf0tqc9cn
   mvIOlbLoLQhsAVQFWh39fxi1WhlTWR8ZF/u2J1GTB8d80QRefyhAXEfVH
   aTSI3nxHPiLYwfN20Z7PmcGSVxWgHDh1N8HoIzq5fLZtI9lD2N67LX8Hs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271268660"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271268660"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:07:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568830858"
Received: from mtarral-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.52.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:07:50 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/9] tty/serial: Termios flag fixes
Date:   Tue, 17 May 2022 14:07:28 +0300
Message-Id: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Here are a few termios flag fixes, mostly CSIZE but a few other flags
as well. The fixed flags returned to userspace should now match to what
the driver is using. Incorrect CSIZE also causes a miscalculation of
timeout in serial core (but it might not be a huge problem being just
a handwavy long timeout).

Ilpo Järvinen (9):
  serial: uartline: Fix BRKINT clearing
  serial: digicolor-usart: Don't allow CS5-6
  serial: rda-uart: Don't allow CS5-6
  serial: txx9: Don't allow CS5-6
  serial: sh-sci: Don't allow CS5-6
  serial: sifive: Sanitize CSIZE and c_iflag
  serial: st-asc: Sanitize CSIZE and correct PARENB for CS7
  serial: stm32-usart: Correct CSIZE, bits, and parity
  pcmcia: synclink_cs: Don't allow CS5-6

 drivers/char/pcmcia/synclink_cs.c    |  6 +++++-
 drivers/tty/serial/digicolor-usart.c |  2 ++
 drivers/tty/serial/rda-uart.c        |  2 ++
 drivers/tty/serial/serial_txx9.c     |  2 ++
 drivers/tty/serial/sh-sci.c          |  6 +++++-
 drivers/tty/serial/sifive.c          |  6 +++++-
 drivers/tty/serial/st-asc.c          |  4 ++++
 drivers/tty/serial/stm32-usart.c     | 15 ++++++++++++---
 drivers/tty/serial/uartlite.c        |  3 ++-
 9 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.30.2

