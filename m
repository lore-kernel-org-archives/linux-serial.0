Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E05C4167B
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15DD422ADF
	for <linux-serial@archiver.kernel.org>; Wed,  9 Dec 2020 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgLIOcb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgLIOcW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Dec 2020 09:32:22 -0500
Date:   Wed, 9 Dec 2020 15:32:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607524301;
        bh=DVdQNudKxISru9wKnzGAdL7AdjvBiAsLCyiML1jmz+E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS7WcwrG29j4Ml7a96bpWp/xqSHfsujKALEimj9vR3zmW7k/LqnqU6+77z397fICW
         Sls5fVNKXN/e2CjE1m9HN5kM2lS5Aig5/QfgSydiIboXq6SEw4QNm3eQq5TboDE6H5
         kBXlkrYBaZDDsXKoqoGktWR/YSCQL7pOjnoDoVJ4=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, git@xilinx.com, jacmet@sunsite.dk,
        linuxfoundation.org@xilinx.com
Subject: Re: [PATCH 1/3] serial-uartlite: Disable clocks in the error path
Message-ID: <X9DgGWWkw9icaxZZ@kroah.com>
References: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607516301-26975-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Dec 09, 2020 at 05:48:19PM +0530, Shubhrajyoti Datta wrote:
> Disable clocks in the error path.

That says _what_ y ou did, but not _why_ you did it.

And please, check your cc: addresses, I think one of them is very
wrong...

thanks,

greg k-h
