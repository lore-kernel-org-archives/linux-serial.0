Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8DC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 30 Sep 2022 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiI3IHw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Sep 2022 04:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI3IHv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Sep 2022 04:07:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C18129FDE;
        Fri, 30 Sep 2022 01:07:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 994041F8CA;
        Fri, 30 Sep 2022 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664525268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBNuBx7p4zWFfPy4deHXA3HcsMwaAOAXCFunK8Xif5k=;
        b=BSR8neqz3BpAFGFBTVg2CCGqAaYv8EYiK5BtMQIFh/QCewhQrL71CMojiimvqgHgRqLN3/
        Vy5u99mkTaHs0WPAhNOtcLXiqbP7lC2NT5x9u4TYpkO5aG3mD8/pK22eFTOeYaobEWqQHJ
        21BHANgcrkjvh5rPHs8w/fTIlNRdZxI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 488412C15F;
        Fri, 30 Sep 2022 08:07:48 +0000 (UTC)
Date:   Fri, 30 Sep 2022 10:07:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk 09/18] serial: kgdboc: Lock console list in probe
 function
Message-ID: <Yzaj0wBz8uRXU5S/@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-10-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat 2022-09-24 02:10:45, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Unprotected list walks are not necessarily safe.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

It looks correct in principle. There is still a discussion [1] whether
to introduce console_list_lock() or use the existing console_lock(),
see https://lore.kernel.org/r/20220924000454.3319186-7-john.ogness@linutronix.de

Depending on the result of the discussion, with either
console_list_lock() or console_lock():

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
