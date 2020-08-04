Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C75EC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6DF22B40
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596535774;
	bh=BDVRKWhd/ahtDaxAjQb6ui5srULsGQG8iPjKOzeDYao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AdM/c06F4yb074tH1sqg27lG472kPn0gSpQsTl9BSAwG44gDvvMFanNM9iVuvIfdi
	 SHAbyUo9/vzSdf45VNmenVQPtQHg5lelkcnOl/V7zw0UGzHogxTSHt0KkfkONwnlzP
	 EHbEBpbKiPvTSuf5/6H2iGo7BLWULtr3h5dihK3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgHDKJd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgHDKJd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 06:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F59D2177B;
        Tue,  4 Aug 2020 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596535773;
        bh=BDVRKWhd/ahtDaxAjQb6ui5srULsGQG8iPjKOzeDYao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BW3ipZV+5YAVRX5Mn3sd2PMkK5RfgdNxEPEBVHalyf3pdxQYUpoQ/aWmu9g8OVNO/
         UHSDj/TmDBH1ny1fFVAMNTwHr5UsZ7dS/yOWnOaDiYecJ7q8FF5dJTSGn5ZQDWDsxP
         X+OXH8O94E8uZsnuiSeS4+o2q23ICjydFY0+r/Xc=
Date:   Tue, 4 Aug 2020 12:09:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH kernel] serial_core: Check for port state when tty is
 in error state
Message-ID: <20200804100912.GA2671027@kroah.com>
References: <20200728124359.980-1-aik@ozlabs.ru>
 <eb3cf1b2-8519-1722-22aa-6182ee734a27@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3cf1b2-8519-1722-22aa-6182ee734a27@ozlabs.ru>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 04, 2020 at 08:02:27PM +1000, Alexey Kardashevskiy wrote:
> Ping?
> 
> ps. Greg, your name came up in "git format-patch -M --stdout -1 HEAD |
> ./scripts/get_maintainer.pl --norolestats --l" ;)

It's in my queue to review, but can't do anything now that the merge
window is open.

Also, as it's an RFC, that means you don't think it should be merged, so
perhaps do some work to verify that you think this is correct and resend
it?

thanks,

greg k-h
