Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F954C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 10 Nov 2022 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKJPAV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiKJPAU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Nov 2022 10:00:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1238B6;
        Thu, 10 Nov 2022 07:00:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1BE611FD34;
        Thu, 10 Nov 2022 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668092418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgH7RP9708poSiKSHyKoZckyhGjc0rkuVUOBFq3s34M=;
        b=kkrfcrooedaFwCfCVYG8Qcg1TIKUSiyl7N64pFltx8WSy5P0SKUG/YKPMCryfKn9VQSQNK
        pLkie6bst7XLTMOgEBIyLtEB1N/OR3p3fDcWI16UUvy2qMiR39ISzWx+cxgayH4Xs1K4PR
        mWr1G8GKZ42wHZGQ/2ZsMdpudwTZdIo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E60A42C141;
        Thu, 10 Nov 2022 15:00:17 +0000 (UTC)
Date:   Thu, 10 Nov 2022 16:00:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 27/40] tty: serial: earlycon: use
 console_is_registered()
Message-ID: <Y20SAUcLYrcTKSxL@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-28-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-28-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 2022-11-07 15:22:25, John Ogness wrote:
> It is not reliable to check for CON_ENABLED in order to identify if a
> console is registered. Use console_is_registered() instead.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
