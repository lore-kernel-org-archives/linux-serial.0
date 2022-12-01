Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C406C47088
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLATAT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLATAT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 14:00:19 -0500
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 11:00:16 PST
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BD1DC23F4;
        Thu,  1 Dec 2022 11:00:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id A3484100AD8;
        Thu,  1 Dec 2022 18:52:49 +0000 (UTC)
Date:   Fri, 2 Dec 2022 03:52:42 +0900
From:   Max Staudt <max@enpas.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     dario.binacchi@amarulasolutions.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Palethorpe <richard.palethorpe@suse.com>,
        Petr Vorel <petr.vorel@suse.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH] can: slcan: fix freed work crash
Message-ID: <20221202035242.155d54f4.max@enpas.org>
In-Reply-To: <20221201073426.17328-1-jirislaby@kernel.org>
References: <20221201073426.17328-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

(CC: ltp@lists.linux.it because Petr did so.)

Hi Jiry,

Thanks for finding this!


Your patch looks correct to me, so please have a

  Reviewed-by: Max Staudt <max@enpas.org>

for both this patch to slcan, as well as an 1:1 patch to can327.



Some history:

This is actually my code from can327, which was backported to slcan as
part of Dario's larger modernisation effort.

The rationale for moving it was to flush the UART TX buffer in case of
ndo_close(), in order to bring the device into a more predictable state
between ndo_close() and ndo_open(). I guess that's actually
counterproductive - whatever is in the TX buffer at that time should
likely be fully sent. For example, can327 sends one last byte to abort
any running chatty monitoring mode from the adapter. So your patch also
fixes this as well ;)

Of course, this resulted in calling flush_worker() in both ndo_stop()
and ldisc_close(), so I wanted to avoid code duplication, and relied on
ndo_stop(). Oops.



Thanks,

Max
