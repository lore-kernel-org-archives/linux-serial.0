Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D6C04AA5
	for <linux-serial@archiver.kernel.org>; Thu, 25 Aug 2022 09:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiHYJRT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiHYJRS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Aug 2022 05:17:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B0E9F8C5;
        Thu, 25 Aug 2022 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661419037; x=1692955037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4exIY7gU9hzEUKw5Nvq0efoD/gksy5jNEO5nY/heknk=;
  b=BLiscJOo3Uxd9qW+TYDRJJ1d7faPUfkrxySfp4MlN7ROEF1r+swbHau9
   OY9osE0Q6A27mPYkEsJwSuro42rt/mAXYxyqjMmXRFrjDE6QjogP9GXFD
   0WTKy6mUA+RomC9d+QttqbolWeHWNlmumSTa5aTqqIg6isQI0rEzP6j8u
   2S5v2J1/SR14YQbVKSd+b/f1pVgu0NUH3Y6LJwzw7vexyYKPTXZIfriTB
   aVJW7fEq60s7PfPj6qhCbhTIQ4mlgBNivZAwnr5WjM2HrIlClHcKtR3KR
   3N2uG7OxW/O+DTMSB0cSpxxQxJoFdcl5li3AA36RiQXBYQbe+zP64eqBN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355917152"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="355917152"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="938254118"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] serial: Add uart_xmit_advance() + fixes part (of a larger patch series)
Date:   Thu, 25 Aug 2022 12:17:04 +0300
Message-Id: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add uart_xmit_advance() helper to handle circular xmit buffer
advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
that previously lacked to accounting for DMA Tx.

Greg,
I've a another series on top this which is tty-next material making the
rest of the drivers to use uart_xmit_advance(). That series obviously
depends on the patch 1/3 of this series so if you end up putting these
3 patches into tty-linus, I'll need it to be merged into tty-next at
some point (I'm not in a big hurry with this so if you choose to delay
the merge, it's not a big deal).

Ilpo Järvinen (3):
  serial: Create uart_xmit_advance()
  serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
  serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting

 drivers/tty/serial/serial-tegra.c |  5 ++---
 drivers/tty/serial/tegra-tcu.c    |  2 +-
 include/linux/serial_core.h       | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.30.2

