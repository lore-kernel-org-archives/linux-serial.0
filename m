Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4711CC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 07:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074E564DDA
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 07:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhBRH3l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Feb 2021 02:29:41 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:36171 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhBRHVn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Feb 2021 02:21:43 -0500
Received: from windsurf.home (lfbn-mar-1-663-162.w109-208.abo.wanadoo.fr [109.208.193.162])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EE06A20000A;
        Thu, 18 Feb 2021 07:20:58 +0000 (UTC)
Date:   Thu, 18 Feb 2021 08:20:51 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] Revert "serial: max310x: rework RX interrupt handling"
Message-ID: <20210218082051.648b8122@windsurf.home>
In-Reply-To: <YC4TJQew3QK4iPvP@kroah.com>
References: <20210217080608.31192-1-shc_work@mail.ru>
        <20210217235345.7326201b@windsurf.home>
        <20210218065553.864bbf0cc2b3d398504c5b95@mail.ru>
        <20210218075127.5023d878@windsurf.home>
        <YC4TJQew3QK4iPvP@kroah.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Greg,

On Thu, 18 Feb 2021 08:11:33 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> What aspects need configuring and why is this uart so unique from all
> others that it can't use the normal configuration methods?

What makes is stand out from other UARTs is that it is over SPI. So
accessing every single register of the UART is much more expensive than
with UART controllers on MMIO.

As explained in commit fce3c5c1a2d9cd888f2987662ce17c0c651916b2, in its
original state, the driver was configuring the UART to get an interrupt
for every single byte being received, causing a huge CPU load (25% in
my use case) for a very simple workload that consists in receiving 20
bytes every 16ms.

What fce3c5c1a2d9cd888f2987662ce17c0c651916b2 does it to configure the
UART controller to not interrupt at every byte being received, but only
when the RX FIFO has reached a certain threshold *or* after some time
without receiving data. Clearly, this is trading throughput against
latency.

So what needs to be configured are two aspects:

 * How many bytes the UART will receive before triggering an interrupt
   and delivering data to the TTY layer/userspace.

 * How much time with no data received before the UART triggers and
   interrupt, and received data is delivered to the TTY layer/userspace.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
