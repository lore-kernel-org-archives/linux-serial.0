Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B38BC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 13 May 2022 08:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378210AbiEMI3U (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 May 2022 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378215AbiEMI3T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 May 2022 04:29:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1AE2A7C36
        for <linux-serial@vger.kernel.org>; Fri, 13 May 2022 01:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652430558; x=1683966558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y55pFPeNh6kZi8hRsizET5/kqUMcGDSTd28bgP3B334=;
  b=eCfR7M+lkXv7XfbblJSU9Vjaa603LmFhtBCmpTVJeRWmhcZT6nI6aFy8
   nPokuazscvl9N3Au42JKYlQ+JOKxZFt0ZYz9MnS7EgqxG9y9IX8UjSXEd
   bKd8sfW2MmTMfRR5XpjQC5gjddUzOV3h40EJyGACRLV57GBsgZzmOotlu
   tz1SAV9fXHmJbCSQoftCHAsJj2FL5THKRsZAzETffSlvpf0jKMg4ARuVC
   DCrWTgA11XlCBK4Fw/zM7VK0k93OliWTvHCQw7PMSOlKbIYenC5jHz2qX
   izDGZFy6QZ0uVm1WfeEH6KhprRW9ob0nv+VBcBls0gBzkEARenfFREYDu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270385160"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270385160"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="567107449"
Received: from huberth-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/5] tty/serial: termbits cleanups
Date:   Fri, 13 May 2022 11:29:01 +0300
Message-Id: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A few simple cleanups that I've come across while playing with the
termbits.

v2:
- Make shortlog simpler
- Note when in the history ifdefs became unnecessary
- Balance braces
- Remove extra parenthesis from the same lines

Ilpo Järvinen (5):
  tty: remove CMSPAR ifdefs
  tty: remove BOTHER ifdefs
  tty: remove IBSHIFT ifdefs
  serial: fsl_lpuart: Remove unnecessary clearing for CRTSCTS
  serial: jsm: Use B0 instead of 0

 drivers/char/pcmcia/synclink_cs.c   |  2 --
 drivers/tty/amiserial.c             |  2 --
 drivers/tty/mxser.c                 |  5 ++---
 drivers/tty/serial/8250/8250_port.c |  2 --
 drivers/tty/serial/fsl_lpuart.c     |  8 +++----
 drivers/tty/serial/jsm/jsm_cls.c    |  8 +------
 drivers/tty/serial/jsm/jsm_neo.c    |  8 +------
 drivers/tty/serial/sunsu.c          |  2 --
 drivers/tty/tty_baudrate.c          | 35 +++++++----------------------
 drivers/tty/tty_ioctl.c             |  2 --
 drivers/usb/class/cdc-acm.h         |  8 -------
 drivers/usb/serial/ark3116.c        |  3 +--
 drivers/usb/serial/whiteheat.c      |  4 ----
 13 files changed, 16 insertions(+), 73 deletions(-)

-- 
2.30.2

