Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE70C197A0
	for <linux-serial@archiver.kernel.org>; Thu, 16 Nov 2023 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjKPNh4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Nov 2023 08:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjKPNhz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Nov 2023 08:37:55 -0500
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 05:37:50 PST
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BBED4B
        for <linux-serial@vger.kernel.org>; Thu, 16 Nov 2023 05:37:50 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4SWLYl5Gmrzvjfn; Thu, 16 Nov 2023 14:32:27 +0100 (CET)
Date:   Thu, 16 Nov 2023 14:32:27 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 04/52] serial: altera_jtaguart: Convert to platform
 remove callback returning void
Message-ID: <20231116133227.5cpzpm2hm4jmw5qa@distanz.ch>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
 <20231110152927.70601-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110152927.70601-5-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023-11-10 at 16:29:32 +0100, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
