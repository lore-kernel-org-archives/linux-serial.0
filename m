Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C480C54EBE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjAMNN4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbjAMNNi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 08:13:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E387928
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 05:01:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0CC3525513;
        Fri, 13 Jan 2023 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673614901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/OqbhbsKfXjsF4AocIDhio9AfQMHnKZW5A8YLWr5ig=;
        b=e710yCnHzPs6PmOCMPyvIFiQ2pYNTP1nP8K+bl0joD5vswiQDH88JUdBxsZoJKAaon3xA0
        VwZD0Gr30y5TAoAJkWRZs6FKL4drj1lOeeMvksNg+h5W32Cy4s3aMauEzlKw+UAbLLz/wd
        DnfJvwHtmQJLjeuQRk+WD1XM/QjoHsE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 77EF42C141;
        Fri, 13 Jan 2023 13:01:40 +0000 (UTC)
Date:   Fri, 13 Jan 2023 14:01:37 +0100
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
Subject: Re: [PATCH v2] tty: serial: kgdboc: fix mutex locking order for
 configure_kgdboc()
Message-ID: <Y8FWMd7nK5g7lV8M@alley>
References: <20230112161213.1434854-1-john.ogness@linutronix.de>
 <Y8Eg1wDOOkSCAh2E@alley>
 <87r0vypyon.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0vypyon.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri 2023-01-13 10:38:24, John Ogness wrote:
> On 2023-01-13, Petr Mladek <pmladek@suse.com> wrote:
> > JFYI, the patch has been committed into printk/linux.git,
> > branch rework/console-list-lock.
> 
> > I am going to give it few days in linux-next. If there is no problem
> > I will send a pull request for 6.2-rc5 later the following week.
> 
> Sounds good to me. For the 6.2 pull request, please also add Sergey's
> reviewed-by tag.

Done. Sigh, I have missed it in the original commit. I am somehow in
rush last three days and "b4" script did not get it.

Best Regards,
Petr
