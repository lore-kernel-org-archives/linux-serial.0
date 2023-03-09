Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE77C64EC4
	for <linux-serial@archiver.kernel.org>; Thu,  9 Mar 2023 16:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCIQcg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 11:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCIQcQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 11:32:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4337103BFC;
        Thu,  9 Mar 2023 08:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC61D61AD7;
        Thu,  9 Mar 2023 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA9C4339C;
        Thu,  9 Mar 2023 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678379005;
        bh=UmpnIPxcSpr2K6ja2UtmiZg3o4Ly0Tq5xmySsAkoy40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gc02k8IiO3BDEndLHrwML6nTy2LdyqYhuzgk5EMbriplCDYPqPtyNdyyNg3zkXcRy
         7KBx7MK4x4nAuLo6Xo6W7cfAUFfHcVweoTGo2CLQoYRMb6sHxtSuOl4tMQjA3zXBUR
         /KmG/ncy9TqvDqCyM9OwMlkC0FRISdjwl8+4j1/w=
Date:   Thu, 9 Mar 2023 17:23:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/serial-console: Document the behavior when
 the last console= parameter is not used
Message-ID: <ZAoH+vb6LIqdCpDI@kroah.com>
References: <20230308112433.24292-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308112433.24292-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 08, 2023 at 12:24:33PM +0100, Petr Mladek wrote:
> The console= kernel command-line parameter defines where the kernel
> messages appear. It can be used multiple times to make the kernel log
> visible on more devices.
> 
> The ordering of the console= parameters is important. In particular,
> the last one defines which device can be accessed also via /dev/console.
> 
> The behavior is more complicated when the last console= parameter is
> ignored by kernel. It might be surprising because it was not intentional.
> The kernel just works this way historically.
> 
> There were few attempts to change the behavior. Unfortunately, it can't
> be done because it would break existing users. Document the historical
> behavior at least.

Thanks for documenting this, now queued up!

greg k-h
