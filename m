Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFABC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB81608FB
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 08:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKCI0i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhKCI0i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Nov 2021 04:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4BE760E9B;
        Wed,  3 Nov 2021 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635927842;
        bh=d4q5/VSk1jcRA03Odg1sNBNtMM6Yokux3hJLliBMD9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3jvM3QovJHGd3Cmj4qVscpsc/JznHCxa2mnYUVkV5tBl/mxCDAG6k+Nh1ceD+Wnr
         A7/UUNKfgTwNvQqi05sQLGlZz6vKYifOQ5NrkbWcbLlVE8G6D8s11w1iDAnVHqCaF2
         HbkF5xQNTqAjqdRQUFAV9Zc5bw4o0LFpaQFjzWQ4=
Date:   Wed, 3 Nov 2021 09:23:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jochen Mades <jochen@mades.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Extending serial port linux driver to toggle RS485 direction pin
 (GPIO)
Message-ID: <YYJHGhzdnwlu6y5k@kroah.com>
References: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
 <YYGKbfvFki8VN4HN@kroah.com>
 <527160377.1225435.1635924219001@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527160377.1225435.1635924219001@webmail.strato.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Nov 03, 2021 at 08:23:38AM +0100, Jochen Mades wrote:
> Hi Greg,
> 
> thanks for your fast reply. I checked the sources you mentioned below, that helps a bit..
> 
> Could you please give me some more background what you mean with your question:
> > You could do much the same in the pl011_rs485_tx_start() function when
> > SER_RS485_RX_DURING_TX and SER_RS485_RTS_ON_SEND are checked, right?
> 
> Is there already a concept for RS485 drivers?

Yes, RS485 drivers control lines like you are looking for in order to
properly handle the protocol requirements.

> ...or where to find "pl011_rs485_tx_start()"?

Look in the kernel source tree for that function, that's in the driver
you were looking to modify, right?

thanks,

greg k-h
