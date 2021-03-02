Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40CC28E89
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1264764E75
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349044AbhCCCR1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442188AbhCBLR6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 06:17:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF217AAC5;
        Tue,  2 Mar 2021 11:16:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DB9EBDA8BB; Tue,  2 Mar 2021 12:14:37 +0100 (CET)
Date:   Tue, 2 Mar 2021 12:14:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 34/44] tty: do not check tty_unregister_driver's return
 value
Message-ID: <20210302111437.GF7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jiri Slaby <jslaby@suse.cz>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org,
        Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>
References: <20210302062214.29627-1-jslaby@suse.cz>
 <20210302062214.29627-34-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302062214.29627-34-jslaby@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 02, 2021 at 07:22:04AM +0100, Jiri Slaby wrote:
> These drivers check tty_unregister_driver return value. But they don't
> handle a failure correctly (they free the driver in any case). So stop
> checking tty_unregister_driver return value and remove also the prints.
> 
> In the next patch, tty_unregister_driver's return type will be switched
> to void.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>
> ---

For

>  drivers/tty/ipwireless/tty.c        | 7 +------

Acked-by: David Sterba <dsterba@suse.com>

Thanks.
