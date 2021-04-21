Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F38C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8E96143B
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 10:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhDUKMa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbhDUKMa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 06:12:30 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B2C06138A;
        Wed, 21 Apr 2021 03:11:57 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4FQGN84tpkzvjfm; Wed, 21 Apr 2021 12:03:36 +0200 (CEST)
Date:   Wed, 21 Apr 2021 12:03:36 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/26] serial: altera_uart: drop low-latency workaround
Message-ID: <20210421100335.gfpowqfacqtn4e3r@distanz.ch>
References: <20210421095509.3024-1-johan@kernel.org>
 <20210421095509.3024-4-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421095509.3024-4-johan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-04-21 at 11:54:46 +0200, Johan Hovold <johan@kernel.org> wrote:
> Commit dd085ed8ef6c ("tty: serial: altera: drop uart_port->lock before
> calling tty_flip_buffer_push()") claimed to address a locking
> issue but only provided a dubious lockdep splat from an unrelated
> driver, which in the end turned out to be due a broken local change
> carried by the author.
> 
> Unfortunately these patches were merged before the issue had been
> analysed properly so the commit messages makes no sense whatsoever.
> 
> The real issue was first seen on RT which at the time effectively always
> set the low_latency flag for all serial drivers by patching
> tty_flip_buffer_push(). This in turn revealed that many drivers did not
> handle the infamous low_latency behaviour which meant that data was
> pushed immediately to the line discipline instead of being deferred to a
> work queue.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks
> around.
> 
> Link: https://lore.kernel.org/linux-serial/cover.1376923198.git.viresh.kumar@linaro.org/
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
