Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F000C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 08:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1648023159
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 08:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbhATICG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jan 2021 03:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbhATIBX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jan 2021 03:01:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3934023158;
        Wed, 20 Jan 2021 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611129643;
        bh=xbIP+WPsJ6E98Erl+eKehzZs7uNKeW7OigVWbF+7uFM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=X+m8B59A7d3TnUA2HfoqkW+rQ5yzm5wAZNbkuQrZYMYQhZ1PsSBaL0hzLRu0cJeGl
         7dUNIkExXfvKsuefwGqoIhPynhhhDl/ipJGQ39Z2dU5Qd+sOs/Kznkf5N4O0XVaOM1
         OQ6HHKJDVSQhTF/Qflg7GQQ9jd0tHoD5X5kQICzU=
Date:   Wed, 20 Jan 2021 09:00:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: serial: renesas,hscif: Add r8a779a0
 support
Message-ID: <YAfjJwije0H56wp7@kroah.com>
References: <20201228112715.14947-1-wsa+renesas@sang-engineering.com>
 <20201228112715.14947-4-wsa+renesas@sang-engineering.com>
 <20210119221624.GA3651@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119221624.GA3651@kunai>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 19, 2021 at 11:16:24PM +0100, Wolfram Sang wrote:
> On Mon, Dec 28, 2020 at 12:27:10PM +0100, Wolfram Sang wrote:
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> 
> Can we apply this via the serial tree? Or shall we take it via
> renesas-soc? Thanks!

I can take it, but normally I try to wait for a DT maintainer ack.

If you want to take it, feel free to as well.

thanks,

greg k-h
