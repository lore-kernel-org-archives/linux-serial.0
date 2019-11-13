Return-Path: <SRS0=6WdS=ZF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC37C43331
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAE222C2
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573644209;
	bh=TVEx8HBqZEoLdlgwPL6Lp6A6Zzc+wUnGd1qAGqyPTBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hXpFLcpd6s3HuYOzTBah9cSYdOjLkUtSXGoxR3HCQH/etRsqeMQnOm43CB0njW+X9
	 Buxni2zKJ5TlRWf2nXU2q/cwOdB6M0jERAVx9+AWMuwT+knFXFWij4HK/I9bD/u+U5
	 OLPAcbj+UWbUP2M0hlJj256gghPQner4TMZ0mJ2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKMLX3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbfKMLX3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Nov 2019 06:23:29 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B23C21783;
        Wed, 13 Nov 2019 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573644208;
        bh=TVEx8HBqZEoLdlgwPL6Lp6A6Zzc+wUnGd1qAGqyPTBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDez6JFRCPzNm2Ous+Kmkus7EsKk4DkgADQl1to+DnbGTS8uFXyUhUml0hSprElji
         CoY9Yt/laq3sdhY96i264opsYS4gqlh11+dulopSqPRVfjzKfIJYB7Zp115jiqsdG3
         NRdzKeBdEjoLQsHYxaPkDHKDn5K6uxNnFceOkmUQ=
Date:   Wed, 13 Nov 2019 19:23:26 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, jacmet@sunsite.dk,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCHv4 4/4] serial: uartlite: Fix compilation issue on !OF
 platforms
Message-ID: <20191113112326.GA2224502@kroah.com>
References: <1573555271-2579-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1573555271-2579-4-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1573555271-2579-4-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 12, 2019 at 04:11:11PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Michal Simek <michal.simek@xilinx.com>
> 
> There is missing ulite_of_match on !OF platforms.
> Use of_match_ptr() to fix it.
> 
> Warning log:
> drivers/tty/serial/uartlite.c: In function ‘ulite_get_id’:
> drivers/tty/serial/uartlite.c:774:33: error: ‘ulite_of_match’ undeclared
> (first use in this function)
>    ret = of_alias_get_alias_list(ulite_of_match, "serial",
>                                  ^
> drivers/tty/serial/uartlite.c:774:33: note: each undeclared identifier
> is reported only once for each function it appears in
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v5:
> new patch addition

This needs to get merged into the previous patch as I can not take any
single patch that breaks the build, sorry.

greg k-h
