Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFCFC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 13:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiFFNcg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiFFNce (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 09:32:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B2B39823
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654522350; x=1686058350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2yHJC8Sm3uK/XacvPKDqInBl0xvWjTDXZbM8uHdxefs=;
  b=Iov/k3fvRi6l9wd9ZjW2J1TOWE+jMUguZQqu0+/Gw5VE8pUGXAPFhUEa
   V+NfqjfC0WCMnZFM/A4xyLhhc2nbqKiNvtlhaeS3kplKsJ8pIgSHAIRvb
   nf0TtisTnzAexr6OfhED71qwVRk2gftGIWrIfZ2M9feYCN4Bn8MVI6i6X
   CGCKAYXurvVBNlNhepvD6AteMa3rb3Id/cYm1wHjzktI486ElnywQ3d07
   v1uEZbXjDAuRBtkFbeKcZEkmOx82OVOx/anhLEvpQfvU6aV+i0LzTfffW
   8YxcE7z+6Q9xXI8P1w7y2mT3/U+x9ghZ5GtdVoKSTVUS+eHe0EgCUHFee
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="264590581"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="264590581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:32:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="906550621"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:32:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 0/2] tty/serial: Process XON/XOFF robustly
Date:   Mon,  6 Jun 2022 16:32:13 +0300
Message-Id: <20220606133215.57537-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

XON/XOFF are used for software flow-control on serial lines. XON and
XOFF appear as characters within the stream but should be processed as
soon as possible.

The characters received by the UART drivers are in intermediate buffers
until TTY receives them. In the case where the TTY is not read from,
the characters may get stuck into those intermediate buffers until
user-space reads from the TTY. Among the characters stuck in the
buffers, can also be those XON/XOFF flow control characters. A stuck
flow-control character is not very useful.

This patch series addresses the issue by checking if TTY is slow to
process characters, that is, eats less than the given amount. If TTY is
slow, a lookahead is invoked for the characters that remain in the
intermediate buffer(s).

Then at a later time, receive_buf needs to ensure the flow-control
actions are not retaken when those same characters get pushed to TTY.

This patch series fixes an issue but I'm not able to pinpoint to a
specific commit id to provide a Fixes tag. The last patch of the series
is not needed for minimal fix (and has a small chance of regression
too), thus that patch shouldn't be sent to stable.

v1 -> v2:
- Add flow ctrl char funcs in separate change & rework logic a bit.
  I believe it's now cleaner than it would have been with the
  suggestions during v1 review, please recheck.
- Renamed n_tty_lookahead_special to n_tty_lookahead_flow_ctrl
- Fixed logic for START_CHAR == STOP_CHAR case
- Use unsigned int for lookahead_count in receive_buf call chain
- Use consistent types in lookahead call chain
- Improved indentation & line splits for function params
- Corrected tty_ldisc.h comments documenting tty_ldisc_ops
- Tweaked comment format

v2 -> v3:
- Split preparatory patch moving/rearranging code to two
- Fix closing path giving change for ... || xx to execute
  instead of skipping the flow-control char
- Use the same flow-control char function on closing path
  (just a cleanup, non-fix as last patch, a small change of
  regression exists)

v3 -> v4:
- Rework lookahead_count, it is now kept internal to n_tty ldisc rather
  than passed around through the whole callchain
- Dropped Gilles' Tested-by due to major changes
- Improve comments & changelogs

v4 -> v5:
- Rebased & removed the applied patch
- Explain the algorithm a bit more in the commit message


Ilpo Järvinen (2):
  tty: Implement lookahead to process XON/XOFF timely
  tty: Use flow-control char function on closing path

 drivers/tty/n_tty.c        | 91 ++++++++++++++++++++++++++++++--------
 drivers/tty/tty_buffer.c   | 59 ++++++++++++++++++++----
 drivers/tty/tty_port.c     | 21 +++++++++
 include/linux/tty_buffer.h |  1 +
 include/linux/tty_ldisc.h  | 13 ++++++
 include/linux/tty_port.h   |  2 +
 6 files changed, 159 insertions(+), 28 deletions(-)

-- 
2.30.2

