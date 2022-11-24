Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C3C43217
	for <linux-serial@archiver.kernel.org>; Thu, 24 Nov 2022 13:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKXNAC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Nov 2022 08:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXNAB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0982D1E1;
        Thu, 24 Nov 2022 05:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294801; x=1700830801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T7DGfIQYASFIJXluenM17UH1kYkhH74aAzpWc3A8ROs=;
  b=BoypodCG0B48NuSBHtQFMURFFgqiLb+EozhCewACVk6LmwNFKHx5mz+q
   nJcVz++TatlymgajtTEQlflkVtm5moNN/zJOvep2xQ68ZQzLNuG6Sq0QL
   gF32atGC3eHPRu8BQQLqI3ORXVIgeo1frZv7nAcrw1u8tn3tj5ROl2YJL
   gZhTP0uvoqCC+zDs7iPfFKnk98sRfTlgAJjkl3pL8LlIU6Tp03LAQAS+d
   tjfcr6r86Oqlo24YMZeAH8w7gwtvroqGaMCWjZbWuxGsFy4g12JC2knN/
   c54pWf5X1R352x25dKVidR2RgG5dM35ikHriWmrN1zHzpWMKnzfV35ex9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932025"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932025"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367515"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367515"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 04:59:59 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/6] serial: Cleanup literals
Date:   Thu, 24 Nov 2022 14:59:42 +0200
Message-Id: <20221124125948.23432-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert plenty of register write literals to use the proper defines. In
most of the cases the defines already exist but a few new defines are
added too for combined sets of flags.

Ilpo Järvinen (6):
  serial: 8250: Use defined IER bits
  serial: 8250: Name MSR literals
  serial: 8250: Cleanup MCR literals
  serial: 8250: Add IIR FIFOs enabled field properly
  serial: 8250: Define IIR 64 byte bit & cleanup related code
  serial: 8250_early: Convert literals to use defines

 drivers/tty/serial/8250/8250_early.c |  4 +--
 drivers/tty/serial/8250/8250_port.c  | 47 ++++++++++++++--------------
 include/linux/serial.h               | 10 ++++++
 include/uapi/linux/serial_reg.h      |  5 +++
 4 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.30.2

