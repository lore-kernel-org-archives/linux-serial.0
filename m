Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD10C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 16:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D12260527
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhINQHz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:07:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59124 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhINQHz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 12:07:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EB2F91FE25;
        Tue, 14 Sep 2021 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631635596;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2cmdmIUTV8GDHvneD23Att1WQ1+A8JvufcMAHGZJuk8=;
        b=p0I5tc5LtDjYjajveOf93qP8cyA0GL2rTSGB8TpfTNcFUVtG4YUY9oclDy9PaeVQgXGXlY
        sD4NAzqWPWCOt+SwKAFpaxJz/Y0wEqk5NoFNe62IqX6CaHYawgXqHAD0U8M9jRXO36/YsC
        lw/TEd1r4em8z31Y6e3jsDPZZBANLM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631635596;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2cmdmIUTV8GDHvneD23Att1WQ1+A8JvufcMAHGZJuk8=;
        b=mBESyHBlLmt0Ra++i1dFs3ZDPaafpOLsfyHjQu+ga4MAyLsTrB9g0VvUcR+DjTODdek8mY
        CpHz7EtizRwS4WBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DDB29A3B96;
        Tue, 14 Sep 2021 16:06:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B77E7DA781; Tue, 14 Sep 2021 18:06:28 +0200 (CEST)
Date:   Tue, 14 Sep 2021 18:06:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 09/16] tty: drivers/tty/, stop using tty_flip_buffer_push
Message-ID: <20210914160628.GD9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jiri Slaby <jslaby@suse.cz>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
 <20210914091415.17918-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914091415.17918-2-jslaby@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Sep 14, 2021 at 11:14:08AM +0200, Jiri Slaby wrote:
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
> going to remove the former, so call the latter directly in the rest of
> drivers/tty/.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>

For drivers/tty/ipwireless/*

Acked-by: David Sterba <dsterba@suse.com>
