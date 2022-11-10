Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9BC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 10 Nov 2022 15:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiKJPCC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiKJPCA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Nov 2022 10:02:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9917A93;
        Thu, 10 Nov 2022 07:01:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B76EB228A4;
        Thu, 10 Nov 2022 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668092515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UadLsQEccn+ySRTxmVancO7NxIjqla4C8vINhEilzlQ=;
        b=W3FqqR7myIT+0mxgCtzM8pJGg8SAbSsLCUpzZ/MdmWC4UHEX+X6Gc6wwIyMo3TOoy601zd
        blo7zuvolQU1vKEqoEhJZJ24M4TIBL6QVXOnANz8ZsfgckyCOtzYrtsTB9cgzMSLQLX3WI
        qO+gmg6wFbBFMUa2IPgI+UopYkLyMqo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A61B2C141;
        Thu, 10 Nov 2022 15:01:55 +0000 (UTC)
Date:   Thu, 10 Nov 2022 16:01:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 29/40] tty: serial: samsung_tty: use
 console_is_registered()
Message-ID: <Y20SYvjPjFRP8Utu@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-30-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-30-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 2022-11-07 15:22:27, John Ogness wrote:
> It is not reliable to check for CON_ENABLED in order to identify if a
> console is registered. Use console_is_registered() instead.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
