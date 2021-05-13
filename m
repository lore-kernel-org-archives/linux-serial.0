Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DA7C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F309361442
	for <linux-serial@archiver.kernel.org>; Thu, 13 May 2021 15:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhEMPF6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 11:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhEMPFw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 11:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8730D61442;
        Thu, 13 May 2021 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620918283;
        bh=uvw6JdGpieO8fWu3uF/eB/i1wk3+ATqEwjinTXiwqqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKg4vx0M/6bdMgsdoV5662QHCEfS9RfrWraovkx3wGK1+WP7BpazCGHS559D3HhZm
         hKn2jkE41mqA1WsFFkr3UQRql6LdNlrSn6zPtNBPc/zmDJASXSdE+Cm5DhV4Kfi43R
         TJJZ1+sZ4GVnmLrz1TVWV+YJbtuhfgtwpRxTT41c=
Date:   Thu, 13 May 2021 17:04:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/35] tty cleanup for 5.14
Message-ID: <YJ1ACSO+JKRhZZ0/@kroah.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 05, 2021 at 11:18:53AM +0200, Jiri Slaby wrote:
> Hi,
> 
> this is again a series of various TTY cleanups. The stats say: 116 files
> changed, 661 insertions, 2602 deletions. The major part of the removal
> is a drop of BROKEN r3964 ldisc. The rest is mostly removal of dead
> code, or adaption to the current tty core state.

I've applied the first 33 patches in this series.  Can you resend the
last two after you have revised them based on the review?

thanks,

greg k-h
