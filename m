Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEDFE7D0AB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjIUWIa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjIUWIU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 18:08:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72E113EB;
        Thu, 21 Sep 2023 14:29:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8A9C433C8;
        Thu, 21 Sep 2023 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695331758;
        bh=CIj3Yjfyu5jYKgrbLyzudHxDeXI8ZnR9Fcl5Y/YjJeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIq4EN9+jOOREbOZJhEGZfFj43PB2eO//DSpvDiWMKyDLpmMugWgLne635O70Xys6
         bJYa7OXed0DzbVlKEdGbdmu/cIfplfUfX0lrpOwbLRQWZAzgxZPN6i9kBIzQq0Yhnv
         gvRyN1jm17SYaTezuVY3UEha0a2N8OhP6LbnkT3M=
Date:   Thu, 21 Sep 2023 23:29:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: 8250: Add more support for and fix up
 Brainboxes cards
Message-ID: <2023092134-wizard-nintendo-9b74@gregkh>
References: <DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 21, 2023 at 10:13:33PM +0100, Cameron Williams wrote:
> Add support for the rest of the Brainboxes range of serial cards,
> except the 3-port variants as there is no suitable configuration
> in this driver.
> 
> - The pci_ids.h file has been updated to define each card's ID, cleaner
> than using the raw ID.

That's not happening in this patch, are you sure you got this correct?

> - IntaShield IS-200 PCI ID comment corrected
> - Added some missing device revision IDs
> - All Oxford Semiconductor-based revisions of the cards had broken baud
> rates, as they were tested against the same card on another PC which had
> the same broken baud rate. After adding the correct init and setup quirks
> these have now been re-tested against a third-party FTDI-based USB
> converter and work fine. Thanks to Maciej W. Rozycki for clarification on
> this IC.

This all needs to be broken up into smaller changes, one per logical
thing, for us to be able to take them.

thanks,

greg k-h
