Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF0CD5485
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 07:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjISHfl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHfk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 03:35:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C74FC;
        Tue, 19 Sep 2023 00:35:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572D9C433C7;
        Tue, 19 Sep 2023 07:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695108935;
        bh=evYOWvbDYFjP8Eu0XuktXsPEcE1QzwtYkt/hB9wimnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJ2+u0USOaHsrNJciFtW+z8bdHivf0K78PhVS9RR/kPbir4R3tdKvhNPvsSaVuo47
         C87f6m9L/OFz4Epy9Nm1NKofzPRO4fJQi0lgc27MwbFuHb3g8lU66CW0IaA1o7c0Gq
         cYBVbz/qa8iAxSDTniwCktVP3t4E4OLGvHZunszg=
Date:   Tue, 19 Sep 2023 09:35:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <eadavis@sina.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: fix memory leak in gsm_activate_mux
Message-ID: <2023091954-algebra-hastiness-3bb8@gregkh>
References: <2023091846-expand-underfeed-1794@gregkh>
 <20230919034524.3425915-2-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919034524.3425915-2-eadavis@sina.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 19, 2023 at 11:45:25AM +0800, Edward AD wrote:
> When the call to gsm_register_devices() fails, we need to reclaim the memory
> requested in gsm_dlci_alloc().
> 
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> Signed-off-by: Edward AD <eadavis@sina.com>
> ---
>  drivers/tty/n_gsm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

<snip>

You sent 5 of these, all identical, all rejected by lore.kernel.org, are
you sure your email servers are not on some spam blacklist somewhere?

greg k-h
