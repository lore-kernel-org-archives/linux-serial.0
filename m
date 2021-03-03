Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF0FC43332
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F964EBA
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhCDAAB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452108AbhCCHMu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 02:12:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5615664ED4;
        Wed,  3 Mar 2021 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614755530;
        bh=7phTEiQJXmsXVrjVLKqq6u2dR8OXxMjy2lxbyjoBZxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmYi8FW2kZ6deHaXoVSqA6ZvDriIKld74ms96M0T/kABkxAGFbHKt5TA+jnj78JgG
         4455QIl21o68W5jYoxEiKVPQbEp0wHsAC6NPA5kjVaD3HuunGMvriZeQVILeAHEhXS
         rS0/4YGW5AHgGz5WLO4wHm+4A+qsf6YMd1JYfxmI=
Date:   Wed, 3 Mar 2021 08:12:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grant Edwards <grant.b.edwards@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: low_latency flag has gone missing
Message-ID: <YD82x3xXN41SJqaz@kroah.com>
References: <s1lj9r$r0u$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1lj9r$r0u$1@ciao.gmane.io>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 02, 2021 at 02:49:31PM -0000, Grant Edwards wrote:
> Some of the serial drivers that I maintain can make a tradeoff between
> CPU usage, throughput, and rx data latency. For the past 20 years,
> I've based that tradeoff on the tty struct's "low_latency" flag. This
> allowed the user to choose between high-throughput with low CPU usage,
> or higher CPU usage with lower latency and lower total throughput.
> 
> That low_latency flag appears to have "gone away" in v5.12.
> 
> How are users now supposed to indicate their desire for low-latency
> operation for a serial port?

Given that there are no in-kernel users of this "option", perhaps
hardware has caught up to the fact that it really wasn't doing anything
:)

Do you have proof that it was working as expected somehow?

thanks,

greg k-h
