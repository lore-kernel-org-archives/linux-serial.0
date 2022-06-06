Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C6C43334
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiFFNLi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbiFFNLg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 09:11:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F3C03B5
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654521095; x=1686057095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nkx9spFyAYMO58GmiSLEwQKGUDaLRNG2wTxavHlr/MY=;
  b=NGuCGUo2duP3Vvtng89+VGLytGqVrlDWz8+hs4DCTXE8MljEsVgBc34N
   +W9+uO4WpobwVIJQwTIqNfqE+fl8ec9H4K37tMrdGibYcLamEBnEErt2Z
   dAZzmWFZoLXZVJM9qUGwr/Dnf5jZkReb4+BNrjzDGOB3AnEa4SxTXMpBd
   Jkr86ghpUIzZGSCFeBxg0qrRxzMBDo3pFTv2n25Vz2ODSVp2oelEfaQlc
   9W7+E4QzAl3I5jVthC3mJYpQe5sYjS+RJfdej5i3MjhP8E+U7iHxSXnyR
   4oS6psE9LSDGz/KWJ2LRaBjLeKaOijEcAFrusGIubELeYTEWQ/0DHrMf+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="274191237"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="274191237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583630893"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:11:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@penugtronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/6] LSR flag preservation improvements
Date:   Mon,  6 Jun 2022 16:11:18 +0300
Message-Id: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Note to Greg: the first patch of this series is the fix I submitted
earlier but it was not yet applied as the merge window was about to
begin at that point (thus, using v2 to differentiate, the rest of the
series have not been sent earlier).

Improve LSR flag preservation. Not all devices preserve all LSR flags
on read. Therefore, the non-permanent flags must be stored until
consumed. 8250_port has handled this for some of the reads (but not
all). Drivers not so much but it's unclear to me which of the devices
actually clear flags on read so this series only does per driver fixes
for DW.

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

