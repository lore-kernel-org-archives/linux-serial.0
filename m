Return-Path: <SRS0=aY4b=7G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FCC433E1
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B53420787
	for <linux-serial@archiver.kernel.org>; Sun, 24 May 2020 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgEXPJq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 May 2020 11:09:46 -0400
Received: from mail.h3q.com ([213.73.89.199]:17948 "EHLO mail.h3q.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgEXPJq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 May 2020 11:09:46 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 11:09:46 EDT
Received: (qmail 50384 invoked from network); 24 May 2020 15:02:23 -0000
Received: from mail.h3q.com (HELO mail.h3q.com) (mail.h3q.com)
  by mail.h3q.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 24 May 2020 15:02:23 -0000
From:   Denis Ahrens <denis@h3q.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Hardwore FlowControl for 16C950 is not activated
Message-Id: <FB64D491-C668-44D0-AB9D-FEE2CEF4705E@h3q.com>
Date:   Sun, 24 May 2020 17:02:19 +0200
To:     linux-serial@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi

While playing around with on old SBC with an 16C950 UART I noticed that it does not work properly. After investigating I found out that it is not running with Hardware Flow Control enabled.

It is a simple patch which only affects the 16C950.

https://github.com/torvalds/linux/compare/master...denis2342:patch-1

Sadly I would not know anybody other than me to test this.

Denis Ahrens

