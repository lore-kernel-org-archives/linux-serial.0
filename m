Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68682C43334
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 13:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiF1Nms (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346761AbiF1Nmr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 09:42:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F982A738;
        Tue, 28 Jun 2022 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656423765; x=1687959765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xAJRIbhLENZdR85YOX2ocgJQSkdrBgWEURZ9BbQdpI0=;
  b=POu3N2c0dsmr2cAPqPF3Nn0MizRVqqsouvjyhuF5AAZdgQ4zeUhzzXOZ
   WasAzdb3z1RZ7rMuyQf9SIH96JbPSNWFVMqvbG7oY/vggN4y8M74EjIXv
   GhQgvsYtPYOLXTx6Ks9DhEGUyr1MbCTy3Ob5tq2u14MXPQ6EIMTl/GMcN
   yVTF37qDPhcfecsJAwIWpQv5UtLFCfSpkkPK7OE8lwfAuf20t6evzVA1Q
   KsbdsRxXEzwLYtGd8AOlc2x1l/yQZlZKNN5TiK42+ZnpCE6zCdEVKZsJb
   eiJ+Kmty87+0FP+v7hpY9/RoqDkkn1ah1Yb0PdlV+uNm6POn4m+TMdF2A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281780625"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281780625"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646918003"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] serial: 8250_dw: Rework ->serial_out() & LCR retry logic
Date:   Tue, 28 Jun 2022 16:42:30 +0300
Message-Id: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series reworks DW UART's write logic such that the write in
->serial_out() is reused for LCR retries which allows removing those
ugly duplicated writes in dw8250_check_lcr() (renamed to
dw8250_verify_write() by this series).

I've used label+goto since the retry is really an exceptional thing. If
somebody insists, I can convert those to do {} while (); but I feel it
will give wrong impression that there's a "loop" there.

Ilpo Järvinen (4):
  serial: 8250_dw: Use dw8250_serial_out() in dw8250_serial_out38x()
  serial: 8250_dw: Rename offset to reg_offset
  serial: 8250_dw: Move 16550 compatible & LCR checks to
    dw8250_verify_write()
  serial: 8250_dw: Rework ->serial_out() LCR write retry logic

 drivers/tty/serial/8250/8250_dw.c | 90 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 43 deletions(-)

-- 
2.30.2

