Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53365C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 19 May 2022 08:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiESISg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 May 2022 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiESISZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 May 2022 04:18:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D057262CEA
        for <linux-serial@vger.kernel.org>; Thu, 19 May 2022 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652948299; x=1684484299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w9VMcqLOPWmz9VtnV9v4gs0T9a3YjWrIwM3KSoISY4k=;
  b=gZxLHuVq26FJNFHNL6E0GJMPbMF5DrZmFdA1dDxiFs7Hq8PwVOIds/ar
   t6vUCpKRG02y+X2lxm9sJA2jpYPbT3uSATuVogBd8qS6R15EiVeCG0qj4
   jlsEAMXWhlD5HzDiqyThevDoCDOmrRHNNOWw6rF6KCRL5Ol2fx5GHHoez
   o9QE0c3Dhntflf+HlzTUgNQsaRUry3p3e/2pVCYHxFNGRGSA2MEEV0wbU
   2rOiNymgR4XDFQAIWmJYwHvbIeBWK2ECKIOHEPxqyBRHTotBdx9V517qe
   7J7Hgnyi3EhRd6Tpr1Vnf3URUt75pntInNrX/CJWigwSmGUVLUpMBCg17
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272218819"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272218819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598431142"
Received: from ivanovbx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:18:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/9] tty/serial: Termios flag fixes
Date:   Thu, 19 May 2022 11:17:59 +0300
Message-Id: <20220519081808.3776-1-ilpo.jarvinen@linux.intel.com>
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

v2:
- Corrected shortlog typo

Ilpo Järvinen (9):
  serial: uartlite: Fix BRKINT clearing
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

