Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E194C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 22 Feb 2022 11:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiBVL4k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBVL4j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Feb 2022 06:56:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB1149959;
        Tue, 22 Feb 2022 03:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645530974; x=1677066974;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RMCXOHq+3w+kl411y7PHFbp9gU8NfcCKtDPj1hWZWJo=;
  b=QYj0RQ9eG+oGzBi+hjMy0kyfpzv4UtOxSEokg8QGiShBtxKvtAReJ4cE
   80XGEIJkgLfZYfs8ZfeAmcPGjW3x1MoPijFcu2g+alPHmLhOpD7Sbe1ZB
   rapjA5+sJinVm2bxlsSBAbNnpa6K5htOBfydU4GRFeSYPKFCF6iF/cND7
   jN6hU+z9BE8IsfVGmhK0bxsmF7AtPBchXFKAWN1EQ9+t/9nuNn9hqXqUx
   5e8JYPUUnNydM/LQXYOqrXKVdSquxq9xJqgo3fgUUkdjuGS66VfcumNE0
   W7ewwnr43qqWPhuYdK8p8EF6zO42YfASx3P8/BK0hlImHV7tSWAFUSpOJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276283510"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276283510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:56:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="547713568"
Received: from skatib-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.63.178])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:56:11 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-ia64@vger.kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 0/2] termbits.h cleanup
Date:   Tue, 22 Feb 2022 13:56:02 +0200
Message-Id: <20220222115604.7351-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Two simple cleanup patches to termbits.h. I prefer these to go
in through tty-next as I've some other work based on them that
I'll submit later.

Ilpo Järvinen (2):
  ia64: termbits.h is identical to asm-generic one
  xtensa: termbits.h is identical to asm-generic one

 arch/ia64/include/uapi/asm/termbits.h   | 209 ----------------------
 arch/xtensa/include/uapi/asm/termbits.h | 221 ------------------------
 2 files changed, 430 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/termbits.h
 delete mode 100644 arch/xtensa/include/uapi/asm/termbits.h

-- 
2.30.2

