Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDBEC54EBE
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 09:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjAMJn6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 04:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjAMJmj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 04:42:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A318B00;
        Fri, 13 Jan 2023 01:33:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673602391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvgzUZVNOsJhrqogIQbaF7fQVkfnjfGBZPgEF4xaofg=;
        b=Fvr6S+TAOcieooMZX85FljvZhT4t7vYP9xck6nG2qMhv8sqQqKAWjfo35vgJLOQcVGFglm
        cazR8mUlO3qXlW7UOdsOrXwXVclqWKS62fF0lI8cQAW7QLBVvP0fyU9pTHIkZUryqly9XK
        cb6PaObMXSyo3X7cTmtRf9YL825S28NcO36nYs1Twio8A8e7rzoCQWmMZ6y6GnHeVoux65
        1Cu7NJ8BRGCTY7nfnOasdxc3n9BXSw4RFsjYwid8oJWNgd2SP0bA9Lj82fE1LJVlhk3F2J
        o39gTHznmEz2VWbLDGypw3HCyaTKPH/TNTjG0Ijzx0duQ5pz4oFZs8694xxzWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673602391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvgzUZVNOsJhrqogIQbaF7fQVkfnjfGBZPgEF4xaofg=;
        b=iglIjw7zXlYGoZfbluYCITvytDBZK7rl6BH8l1Ibpx4tcr7SfY5rRccDR8Xh64R3TB3jaD
        FY3ZD1JQZz7aoPDw==
To:     Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <Y8Eg1wDOOkSCAh2E@alley>
References: <20230112161213.1434854-1-john.ogness@linutronix.de>
 <Y8Eg1wDOOkSCAh2E@alley>
Date:   Fri, 13 Jan 2023 10:38:24 +0106
Message-ID: <87r0vypyon.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023-01-13, Petr Mladek <pmladek@suse.com> wrote:
> JFYI, the patch has been committed into printk/linux.git,
> branch rework/console-list-lock.

Thanks!

> I am going to give it few days in linux-next. If there is no problem
> I will send a pull request for 6.2-rc5 later the following week.

Sounds good to me. For the 6.2 pull request, please also add Sergey's
reviewed-by tag.

John Ogness
