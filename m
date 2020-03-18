Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85ECC4332B
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B934020775
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584571211;
	bh=5CXgk4u7sot4GXwLFTU4u6p7tEEId9Kvi4q1jQBioOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IgO3yBKBF/8BG75uLsudB2n7oxdreCvgLZ6O5nB5YA0Tn0fkFNL9LXYEaQFLVCGGW
	 hDm5XhOX5ZnqoXblu+r6hzkkEq27Cu/yccc1TivHdGoEM1mbY1tHGfPTJ0J3QpxVHp
	 4XywMoEGfPDaGbqB4rr0L1qBu2mhFoI3b9Jn6++o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgCRWkL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgCRWkL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 18:40:11 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C55E20754;
        Wed, 18 Mar 2020 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584571210;
        bh=5CXgk4u7sot4GXwLFTU4u6p7tEEId9Kvi4q1jQBioOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+rPH4st3gp+MNk3mdQPkCKdcBd3e8wW3HG/fap6IJ1ea2I61rmLoTcIbC/JsGhpo
         IWzTuhhwn05roD9OlZDdteH3bN1X8WKvj+qV7VwjrcIQQsrM0kaAMCw3fG2ESa5hoS
         JU96fFlS6ta91ZlrouIq/K0QaoqxUqJa3r802HwY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 0/2] vt: fix some vt_ioctl races
Date:   Wed, 18 Mar 2020 15:38:08 -0700
Message-Id: <20200318223810.162440-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318222704.GC2334@sol.localdomain>
References: <20200318222704.GC2334@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix VT_DISALLOCATE freeing an in-use virtual console, and fix a
use-after-free in vt_in_use().

Changed since v1:
    - Made the vc_data be freed via tty_port refcounting.
    - Added patch to fix a use-after-free in vt_in_use().

Eric Biggers (2):
  vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
  vt: vt_ioctl: fix use-after-free in vt_in_use()

 drivers/tty/vt/vt.c       | 14 +++++++++++++-
 drivers/tty/vt/vt_ioctl.c | 24 ++++++++++++------------
 2 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.25.1

