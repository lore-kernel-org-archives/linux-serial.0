Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F581C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jun 2022 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbiFOJIA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbiFOJHr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jun 2022 05:07:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F93D1D1
        for <linux-serial@vger.kernel.org>; Wed, 15 Jun 2022 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655284041; x=1686820041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VUQ6LzZzY9wCNv+jUIBtpgLafWcqy4m6v9mDKXVWANg=;
  b=Qo6w0zQxEFUZlEVizySN7CWJg3wyAph1xFQVGD0Daq1hgJ8Ss3evBLW1
   CDSIT8MBqfUzIkHTHv/TBADHsfymRmVGsR5h6Xe2dQufV2PovS6SHTU5x
   eJkOwLjXCLxWlbB5giz7jSs1Bh4N4kifOOd3zV4FcA7tB7sjsY8G5LRMA
   JXXgK89LJBG8W72Rcy1pmx7wIYesO8tg1i+G4go1xb+6qVAFzeHBMe0xI
   X0OOXiavsGJnLRI1jpgtEb4hc5fV88idgHaCcocCb0AWqqLCpWhUP7T/G
   1PeoT+Fwi4cCzPNtcOaJwrMflmKmAhXgSltVmvdeoe8rkechGtqXI2BHF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276464673"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276464673"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830934147"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:07:19 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] Serial: Two concurrency fixes & one related cleanup
Date:   Wed, 15 Jun 2022 12:06:48 +0300
Message-Id: <20220615090651.15340-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Here are two fixes to problem that have been introduced by recent
changes. In addition, one cleanup patch to the related code (to keep
the fix change strictly a fix).

Ilpo Järvinen (3):
  serial: 8250: fix __stop_tx() & DMA Tx restart races
  serial: 8250_dw: Take port lock while accessing LSR
  serial: 8250_dma: No need for if (dma->tx_err)

 drivers/tty/serial/8250/8250_dma.c  | 7 +++----
 drivers/tty/serial/8250/8250_dw.c   | 3 +++
 drivers/tty/serial/8250/8250_port.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.30.2

