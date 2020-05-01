Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C36C4724C
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 01:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EA92074A
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 01:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcshg76Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEABo6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABo5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 21:44:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B6C035494;
        Thu, 30 Apr 2020 18:44:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n24so3120957plp.13;
        Thu, 30 Apr 2020 18:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BJDB9lPyIL7yqfOmHsy2HCj6CJV5Y/ygJ4a/Yt4ueRw=;
        b=Tcshg76Y97lKweEKu4Gzgm583bqlkziZ4JStrZoKgao6MtHeAoodWQhMVO/lXjIY2G
         FvsHOLLcC0UIstahZaZG+KZ1bEgNSTltcuxq5krvhF6cOgx9Rh62+aJTs5Ho+2hC1v/i
         V/0Q+bgjzZQqIT5kvZzSa/8UWZi1+rWuqj3VP1iNWOL43pzieMbHk4n/WkLOh3uiq6sn
         VA4Y6GIn4cKd1U2WqH8DlczT3VzTPWI2DaO+ZuGk93UcqyB3SQ/rCq9jOTYNSXV1GJk2
         I/N01tnibHm6+a7oRtKOCa1vkElQ/Nxn5qwvm7yJQmzRGlMHW3zA8RMgLEfDq0HeWpOh
         v2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJDB9lPyIL7yqfOmHsy2HCj6CJV5Y/ygJ4a/Yt4ueRw=;
        b=nin/uEBjSoD4c/5FEt0TEzvRMtHRD55QWEahE4F6fFHL9zc7BpUdDdXdxLOh5jmxEI
         E/yWGmXvvtUYFhLHvT6GQzabuokc0uiXgx9c522DhxabeI3ulkirVdQWMD4uhA2GDKNV
         OASbvmnAnNiOWMMvm7t0FvBl716Z8rLwGY9wJN0aTrNXCOB4tOOPY0B3Ho6+Jt/9M8+e
         AaCTJuO6XtbsGcqOfrbhQ/oa+B1k26HmndzPcq++EithKgm/hj4fc/OLM6o/KzVl3czt
         wGgWtBZo7094XXFoF4/9CihIsymztzxx1oN1dGOMuPCknhzuow0k9PErgaXnrKQ/gR8k
         1h4Q==
X-Gm-Message-State: AGi0Pub5KrAfzvy+PzKq7DYvcqfEOnOFn9b+d/H3SDRS87Kys48B+4UY
        ZA9Pv0w7pHUREBLSMZOYDxA=
X-Google-Smtp-Source: APiQypLCLfp3rK10yUdbPAE4Edv32G102rWA36hKIIpdEzEYeJyZFhsbGJpCwWMJe+hOipaDHzEbbg==
X-Received: by 2002:a17:90a:2606:: with SMTP id l6mr1770330pje.188.1588297497099;
        Thu, 30 Apr 2020 18:44:57 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id d18sm850855pfq.177.2020.04.30.18.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 18:44:56 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 1 May 2020 10:44:54 +0900
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [RFC PATCH v2 1/3] printk: Add function to set console to
 preferred console's driver
Message-ID: <20200501014454.GB288759@jagdpanzerIV.localdomain>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200430161438.17640-2-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161438.17640-2-alpernebiyasak@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/04/30 19:14), Alper Nebi Yasak wrote:
> Currently, add_preferred_console sets a preferred console, but doesn't
> actually change /dev/console to match it. That part is handled within
> register_device, where a newly registered console driver will be set as
> /dev/console if it matches the preferred console.
> 
> However, if the relevant driver is already registered, the only way to
> set it as /dev/console is by un-registering and re-registering it.

Hmm. Preferred console selection is very fragile, there are too many
setups and workarounds that even minor tweaks introduce regressions
oftentimes.

We have, by the way, a pending patchset which changes the same
are - preferred console selection.

git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-5.7-preferred-console

[..]
> An example is the xenfb_make_preferred_console() function:
> 
> 	console_lock();
> 	for_each_console(c) {
> 		if (!strcmp(c->name, "tty") && c->index == 0)
> 			break;
> 	}
> 	console_unlock();
> 	if (c) {
> 		unregister_console(c);
> 		c->flags |= CON_CONSDEV;
> 		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
> 		register_console(c);
> 	}

I didn't know about this code.

> The code above was introduced in commit 9e124fe16ff2 ("xen: Enable
> console tty by default in domU if it's not a dummy"). In short, it's aim
> is to set VT as the preferred console only after a working framebuffer
> is registered and thus VT is not the dummy device.
> 
> This patch introduces an update_console_to_preferred function that
> handles the necessary /dev/console change. With this change, the example
> above can be replaced with:
> 
> 	console_lock();
> 	add_preferred_console("tty", 0, NULL);
> 	update_console_to_preferred();
> 	console_unlock();
> 
> More importantly, these two calls can be moved to vt.c in order to bump
> its priority when a non-dummy backend for it is introduced, solving that
> problem in general.

Let me take a look over the weekend.

	-ss
