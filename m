Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119CBCDB474
	for <linux-serial@archiver.kernel.org>; Fri, 20 Oct 2023 16:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjJTQQC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjJTQP5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Oct 2023 12:15:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F35114;
        Fri, 20 Oct 2023 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+yckRkFG8qkJeHSM7gJpLJWXmYYcv8nGS7sjBbidu2o=; b=T0zKb6Qe+rPgKfDjqH/Yy6akUz
        iPqrhSFIqIkEL5Zx1lo+Xf8Ln6ZtkAldLanYm/TC+BiWcrLRUcQ7aYSs2pLWZ2YieCBlAIb/k7M/7
        t3T+lTc5eljToOU5aSM5pXsfSvxK9Kqe9iVLwwl353CI80nUZL3HYDGXD5o3LdUX5/eNgvAIVv7EA
        h8ATW3NHs8MGFwvwj64DIAwyJQi8A56iiBnF2Cp+Iyh66H0pPzt8sPBJ35utrpRCrdTMTH1lXlnPa
        PQqmwpaCOZlnPANH8XpVwHB5IUUFp0nTpjJIVqMv813nea7BnGnAGOxQKOJKJmeEKBsRlybO9JZKq
        ftfzAo2Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qts9u-00E44D-7G; Fri, 20 Oct 2023 16:15:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qts9s-001UOT-0R;
        Fri, 20 Oct 2023 17:15:32 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dawei Li <set_pte_at@outlook.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Paul Durrant <paul@xen.org>
Subject: [PATCH v2 0/3] hvc/xen: Xen console fixes.
Date:   Fri, 20 Oct 2023 17:15:26 +0100
Message-Id: <20231020161529.355083-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It started out relatively simple, fixing the fact that the secondary
consoles didn't work at *all* due to bugs in the IRQ setup. There were
one or two other simple fixes that I snuck into the same patch in v1.

But it's much more broken than that, so split the fixes out, especially
the last one for hot-unplug.

Preserving the Reviewed-by: from Jürgen on the first two seems fair;
the third patch is new and exciting but *does* fix the case of removing
the console while userspace is spamming it.

And all I really wanted to do this week was spin up a PV guest under KVM 
so I could play with its SMEP behaviour...

David Woodhouse (3):
      hvc/xen: fix event channel handling for secondary consoles
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
      hvc/xen: fix console unplug

 drivers/tty/hvc/hvc_xen.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)


