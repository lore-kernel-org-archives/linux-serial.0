Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A086DC07545
	for <linux-serial@archiver.kernel.org>; Tue, 24 Oct 2023 04:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJXEvR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Oct 2023 00:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjJXEvQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Oct 2023 00:51:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DEB1118
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 21:51:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2C3C280BB;
        Tue, 24 Oct 2023 04:51:11 +0000 (UTC)
Date:   Tue, 24 Oct 2023 07:51:09 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@kernel.org>
Cc:     Thomas Richard <thomas.richard@bootlin.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231024045109.GT27774@atomide.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hfs213u0r.fsf@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Kevin Hilman <khilman@kernel.org> [231023 21:31]:
> Instead, what should be happening is that when `no_console_suspend` is
> set, there should be an extra pm_runtime_get() which increases the
> device usecount such that the device never runtime suspends, and thus
> the domain will not get powered off.

We already have the runtime PM usage count kept in the driver (unless
there's a bug somewhere). The issue is that on suspend the power domain
still gets shut down. I suspect that some of the SoC power domains get
force shut down on suspend somewhere?

Regards,

Tony
