Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D4AC433ED
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BE261450
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 16:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbhDUQ4x (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:56:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32898 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbhDUQ4x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 12:56:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id A79C74D2493BF;
        Wed, 21 Apr 2021 09:56:19 -0700 (PDT)
Date:   Wed, 21 Apr 2021 09:56:15 -0700 (PDT)
Message-Id: <20210421.095615.459544163755192519.davem@davemloft.net>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] serial: sunsu: drop low-latency workaround
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210421095509.3024-24-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
        <20210421095509.3024-24-johan@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 21 Apr 2021 09:56:19 -0700 (PDT)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Date: Wed, 21 Apr 2021 11:55:06 +0200

> The sunsu driver has been carrying a workaround for the infamous
> low_latency behaviour of tty_flip_buffer_push() by dropping and
> reacquiring the port lock in the interrupt handler since 2004.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks around.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
