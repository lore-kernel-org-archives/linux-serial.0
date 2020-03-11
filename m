Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB7C2BB1D
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967A20750
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DChAntug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgCKW5j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:57:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731168AbgCKW5i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 18:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=L55NNbRZrnFez8C39HrIWuvzlloT4S/Vj/OMB4/VKlI=; b=DChAntugS8Bhxk1vNc9e1B3pPd
        MXEQYh95hTVEbyuiykq0eQj/QC/JEYzAR3LevIA7UTxyESzbybnBNsm/VZ5QNxtm9bNn+XL9MS9qP
        8XzM8ETEBFEDstLkPSiVrOduTmyf/s7i7F6dPFcElhzx1gUogDcjuPk3rEXNv98y+MLNn4jQN3WYW
        NxlofB0axAlOG3QU6MKg3m0vJxaddRY+i5S+knW8veM1Cf92QzgsoEj2ZIn8B9m4et0b0rugs7zq+
        cA2XcM6YuqVCXvMwJJrjehcz7Hc0GdP6UB0X49hZIbs+66qYppYh+g+5JfKYjwL/P6XNXwk8fqJ4V
        AFJ71oOQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCAID-0001PR-WD; Wed, 11 Mar 2020 22:57:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 0/3 v2] char/tty: clean up menus
Date:   Wed, 11 Mar 2020 15:57:33 -0700
Message-Id: <20200311225736.32147-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series cleans up the Character devices & TTY menus.

[PATCH 1/3 v2] char: group dev configs togther
[PATCH 2/3 v2] tty: source all tty Kconfig files in one place
[PATCH 3/3 v2] tty: reorganize tty & serial menus

 drivers/char/Kconfig       |  105 +++++++++-----------
 drivers/tty/Kconfig        |  179 +++++++++++++++++------------------
 drivers/tty/hvc/Kconfig    |    3 
 drivers/tty/serial/Kconfig |    4 
 4 files changed, 142 insertions(+), 149 deletions(-)
