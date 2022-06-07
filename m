Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA5C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 08:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiFGI3u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiFGI3p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 04:29:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E08692A0
        for <linux-serial@vger.kernel.org>; Tue,  7 Jun 2022 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654590584; x=1686126584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9548YSNLV3+PDw8kWWTYltQi+ZeiHjNE111AUfE7Ucw=;
  b=kmun8dFeCYSoR7IKX6rUDX6eqU+MfPplKC08Jx38mAP8cE13lnBEo0Z/
   ZeEdBFRLn3Y63UOVNIS024md+IgrzUEh4i4kLC+e1TQylR8R+CPHjPZXS
   hFUq1bRIYSinRiOHqg8Uun+Icu0z1A47ZlT2PeADjWEvZzI/3OcuJlP1i
   3vJ9HOudZ9waxRomVuYomdsSLkSfQG9x8UizxvtlZkF1L/kKMFRikCCMr
   mlbtHneseNif0WrhibNE8IFUAPSSVvka74NfQM+cB2HyOuSZMBQP8Pz/R
   7jaqnIhdRnwKObu8zRoOX1PaelyRdi5YnMyriAi+Dx+h9W2yFGfZl3qE0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277393571"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277393571"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:29:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="584103443"
Received: from akmessan-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 01:29:42 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/6] LSR flag preservation improvements
Date:   Tue,  7 Jun 2022 11:29:28 +0300
Message-Id: <20220607082934.7242-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Improve LSR flag preservation. Not all devices preserve all LSR flags
on read. Therefore, the non-permanent flags must be stored until
consumed. 8250_port has handled this for some of the reads (but not
all). Drivers not so much but it's unclear to me which of the devices
actually clear flags on read so this series only does per driver fixes
for DW.

I've just put Uwe as Co-dev-by and SoB according to Andy's suggestion
in order to allow forward progress (Uwe indicated he's OK with any
sensible combination of tags anyway). I agree with Uwe's position
though that it would be nice to be able to record Acked-by in some
(probably quite rare) cases even if the person is already SoB but I
don't want to keep dragging this issue on and on over a single line
patch :-).

v2:
- Added more patches

v3:
- Fix Uwe's email and convert it to Co-developed-by


Ilpo Järvinen (6):
  serial: 8250: Store to lsr_save_flags after lsr read
  serial: 8250: Create serial_lsr_in()
  serial: 8250: Get preserved flags using serial_lsr_in()
  serial: 8250: Adjust misleading LSR related comment
  serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()
  serial: 8250_dw: Store LSR into lsr_saved_flags in
    dw8250_tx_wait_empty()

 drivers/tty/serial/8250/8250.h      | 20 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_core.c |  3 +--
 drivers/tty/serial/8250/8250_dw.c   |  7 +++++--
 drivers/tty/serial/8250/8250_port.c | 24 +++++++++++-------------
 4 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.30.2

