Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3723AC4167B
	for <linux-serial@archiver.kernel.org>; Mon, 13 Nov 2023 09:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjKMJ40 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Nov 2023 04:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjKMJ4Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Nov 2023 04:56:25 -0500
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 01:56:19 PST
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD87E10D2
        for <linux-serial@vger.kernel.org>; Mon, 13 Nov 2023 01:56:19 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id D25CD6045F;
        Mon, 13 Nov 2023 09:49:31 +0000 (UTC)
Date:   Mon, 13 Nov 2023 11:49:29 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Thomas Richard <thomas.richard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 01/52] serial: 8250: omap: Don't skip resource freeing if
 pm_runtime_resume_and_get() failed
Message-ID: <20231113094929.GA5166@atomide.com>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110152927.70601-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [231110 15:30]:
> Returning an error code from .remove() makes the driver core emit the
> little helpful error message:
> 
> 	remove callback returned a non-zero value. This will be ignored.
> 
> and then remove the device anyhow. So all resources that were not freed
> are leaked in this case. Skipping serial8250_unregister_port() has the
> potential to keep enough of the UART around to trigger a use-after-free.
> 
> So replace the error return (and with it the little helpful error
> message) by a more useful error message and continue to cleanup.

Looks good to me thanks:

Reviewed-by: Tony Lindgren <tony@atomide.com>
