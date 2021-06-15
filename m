Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F92C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64046162B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 15:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFOPmc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPmc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 11:42:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AB39614A7;
        Tue, 15 Jun 2021 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623771627;
        bh=0/iJJ3+XKp5sJZc5AAbZZ9NFk2IBuJKpX+hA7dyq40M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNrGFppXsNH+JBIHX758FGJ+LI6sg4aM4/1kkUhVps3ZQmpj49/65AJiC2iaCV7j8
         CH0F0U8bFbwR8GTd6/qmD0qhAQ3YW45Fj+jJkmLxYng/DOutmWRq3kB6czxT2jRBCs
         soyu0TrfiGY3ZT/H97RbCL+0xqRqMwqsXAd9NaSM=
Date:   Tue, 15 Jun 2021 17:40:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YMjJ6bWIGCUrhjfb@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <YMiUgpRbfwMHCqD+@kroah.com>
 <DA86E839-4208-4535-B70C-ACFC94438BEB@cortina-access.com>
 <YMi1mIwOTLYs8h8/@kroah.com>
 <49AAFE67-C151-4A7D-AE6D-E8981CBC9503@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49AAFE67-C151-4A7D-AE6D-E8981CBC9503@cortina-access.com>
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

On Tue, Jun 15, 2021 at 02:33:57PM +0000, Alex Nemirovsky wrote:
> Does the serial driver portion in the first patch, require any more changes from your point of view
> as the serial driver maintainer?  If there are no issues with the driver itself, we can engage with the DT team to figure out why they have not 
> ACK or provided any feedback on the DT portion.   Are you good with the content of the serial driver itself minus the lack of ACK from the DT team?

I was waiting for the DT review before I looked at the serial driver
again.

thanks,

greg k-h
