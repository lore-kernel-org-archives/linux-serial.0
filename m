Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF3C433DB
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 09:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D8365007
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 09:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCPJDQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232406AbhCPJCj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Mar 2021 05:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 849BB65006;
        Tue, 16 Mar 2021 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615885358;
        bh=M1e4dCxNqa7lnPzI8G04WpXPFtY7D+DY/h7UQQ2EtSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DP5+IwIgaPva50R+0SFkc2ULhZSi0kJnd3Z6/LsO2F3dwV8ZoHbQfTooW8X8YdJB/
         ftRwGWmdLrL+1q9/gFSE25+HWXS5QbDElmFgugwUKxff7FbPtuRzHXnoFrCcMHhxQ9
         iIrgxIjrSv7yN+okHB52kU10C6ZKd6g1JPpW3reWNh5sSPasyTzPrgRMohZOEoo3cC
         Ar5Ms39f6PMvqhsEMa6mQXvHHZ+chyTmROIo5HdvEfKplTvBsWeRhNF4uaI57dblIa
         V0TY27UutOYsYw1koQ9pMHDz0aBz5XLsUDIspxJ+N/klmfaH5qVRRZxqDE4MOVfTR8
         w9dNe76aqF8aQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lM5bF-0000GS-9t; Tue, 16 Mar 2021 10:02:50 +0100
Date:   Tue, 16 Mar 2021 10:02:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Message-ID: <YFB0OcBg3Vj555eA@hovoldconsulting.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
> Since interrupt handler is called with disabled local interrupts, there
> is no need to use the spinlock primitives disabling interrupts as well.

This isn't generally true due to "threadirqs" and that can lead to
deadlocks if the console code is called from hard irq context.

Now, this is *not* the case for this particular driver since it doesn't
even bother to take the port lock in console_write(). That should
probably be fixed instead.

See https://lore.kernel.org/r/X7kviiRwuxvPxC8O@localhost.

Johan
