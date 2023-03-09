Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9FBC61DA4
	for <linux-serial@archiver.kernel.org>; Thu,  9 Mar 2023 08:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCIIW4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 03:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCIIW1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:27 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFADF721;
        Thu,  9 Mar 2023 00:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350047; x=1709886047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tHtq6ZIyJtPvDKcfRGVQgt5pQ1iWkR5DQjr+pW50ZoA=;
  b=g8EYJDX4CKrUCOUO24cRK4zHFBKQTCKrlpA3RKXxEFOcGQpym3T5tewh
   k4rHfnzjHqUEL8NgSgNUI7/eeelev92Jy39gmWJkb0sEkGAvyCfMRuCrQ
   YT1Nu6SaBD4+xkzYeEAF93EwxkZfW3zVC12FH47v8FKQvKxCotZ1QbbA9
   JPPdSZEEHjn9EqhH+5od8voxQAFpsdgNcKZToeKFp3dmNooqBgfLkjzyp
   rhFbtvXX6bR/8sZBR8AmZtM9TS+ZvstNCHY764OdR2WBm6XnPWyEsdzUk
   AV3ITZr+bxu64tlXFTI/PV1I7yA5mxw4WMTYjaZuLJ4YFlPjeNbB8Vaup
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025715"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473820"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473820"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:20:45 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/8] tty: Cleanups
Date:   Thu,  9 Mar 2023 10:20:27 +0200
Message-Id: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Small cleanups to tty.

Ilpo Järvinen (8):
  n_tty: Convert no_space_left to space_left boolean
  tty_ioctl: Use BIT() for internal flags
  Bluetooth: hci_ldisc: Fix tty_set_termios() return value assumptions
  n_tty: Sort includes alphabetically
  n_tty: Use DIV_ROUND_UP() in room calculation
  n_tty: Cleanup includes
  n_tty: Reindent if condition
  tty: Convert hw_stopped in tty_struct to bool

 drivers/bluetooth/hci_ldisc.c     |  8 +++---
 drivers/char/pcmcia/synclink_cs.c |  6 ++---
 drivers/mmc/core/sdio_uart.c      | 10 +++----
 drivers/tty/amiserial.c           |  6 ++---
 drivers/tty/mxser.c               |  6 ++---
 drivers/tty/n_tty.c               | 43 +++++++++++++++----------------
 drivers/tty/synclink_gt.c         |  6 ++---
 drivers/tty/tty_ioctl.c           |  9 ++++---
 include/linux/tty.h               |  2 +-
 9 files changed, 48 insertions(+), 48 deletions(-)

-- 
2.30.2

