Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631A8C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 11 May 2022 10:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiEKKLz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 May 2022 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiEKKLy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 May 2022 06:11:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4AA20F9E3
        for <linux-serial@vger.kernel.org>; Wed, 11 May 2022 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652263910; x=1683799910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zpq9V3K72SaasCGZkftE4QqDrDdAPlGYVNxuJxrQnyg=;
  b=fLCqfGm4sdhjkZBg7mDVOLMR5a2saZH9FX45of1nxCAVTzFVGXMJGGbX
   mD3OAZlsoH1ZfP05oSTURABArbUh0LBZk+VAYqKDLDxuQFzLBXoowRvhA
   sw7Roa7ZhVFj2yBlwcn7dYlYwy64G2Jno7dGpY4CuSv/iGOe0v0ELKaYN
   LzHdHH0lO2uT5yvi/sU9WVUQLJgxsaEbtmpVxuyaAlSwLVyMrJTRbPZSb
   B9mwa6xk0zKmVlCFsIknyMAjBEUqu8028oLRB3kQ5AGSKuuW4jOr8UuW6
   GZYQZOqaoK+kD+ndr9imG0awAAtc22XCJlZcwD/PiOpwYLB/PT28n9gvr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332691970"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="332691970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:11:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594049537"
Received: from meliyahx-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:11:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/5] tty/serial termbits cleanups
Date:   Wed, 11 May 2022 13:11:34 +0300
Message-Id: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A few simple cleanups that I've come across while playing with the
termbits.

Ilpo Järvinen (5):
  tty/termbits: remove #ifdef CMSPAR that is always defined
  tty/termbits: remove #ifdef BOTHER that is always defined
  tty/termbits: remove #ifdef IBSHIFT that is always defined
  serial: fsl_lpuart: Remove unnecessary clearing for CRTSCTS
  serial: jsm: Use B0 instead of 0

 drivers/char/pcmcia/synclink_cs.c   |  2 --
 drivers/tty/amiserial.c             |  2 --
 drivers/tty/mxser.c                 |  2 --
 drivers/tty/serial/8250/8250_port.c |  2 --
 drivers/tty/serial/fsl_lpuart.c     |  8 +++-----
 drivers/tty/serial/jsm/jsm_cls.c    |  8 +-------
 drivers/tty/serial/jsm/jsm_neo.c    |  8 +-------
 drivers/tty/serial/sunsu.c          |  2 --
 drivers/tty/tty_baudrate.c          | 31 ++++++-----------------------
 drivers/tty/tty_ioctl.c             |  2 --
 drivers/usb/class/cdc-acm.h         |  8 --------
 drivers/usb/serial/ark3116.c        |  3 +--
 drivers/usb/serial/whiteheat.c      |  4 ----
 13 files changed, 12 insertions(+), 70 deletions(-)

-- 
2.30.2

