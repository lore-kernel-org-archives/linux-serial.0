Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556CCD4F4A
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 10:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjIVKKG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjIVKKF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 06:10:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A928F;
        Fri, 22 Sep 2023 03:09:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C11C433C7;
        Fri, 22 Sep 2023 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695377399;
        bh=jBzO78u3Uz4fuP6LmINazNgIXLZGGuu8aZ14RSS/1Mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKyTIHN4N2XzsAB6F62NPdjCKvy1a3ztgcGiOiJwWuGPnO0TMuM2IC3i+8bM8LDtd
         OpaZ9j0GjW+sGckLybL1C7BTmwE3buyaBWMnVQkB6TqfbOyqC9Vp1sB0aFSo2Bwc0p
         veTAgOJb2hUdL4EcrM9SDwPBrbzkE8Ulz3+a8bd4=
Date:   Fri, 22 Sep 2023 12:09:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: 8250: Add more support for and fix up
 Brainboxes cards
Message-ID: <2023092208-ripening-unflawed-4feb@gregkh>
References: <DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com>
 <2023092134-wizard-nintendo-9b74@gregkh>
 <2023092216-outcome-police-4a79@gregkh>
 <DU0PR02MB7899C4BBB0C099596F32F7BBC4FFA@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899C4BBB0C099596F32F7BBC4FFA@DU0PR02MB7899.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Sep 22, 2023 at 10:56:43AM +0100, Cameron Williams wrote:
> On Fri, Sep 22, 2023 at 11:19:27AM +0200, Greg KH wrote:
> > On Thu, Sep 21, 2023 at 11:29:14PM +0200, Greg KH wrote:
> > > On Thu, Sep 21, 2023 at 10:13:33PM +0100, Cameron Williams wrote:
> > > > Add support for the rest of the Brainboxes range of serial cards,
> > > > except the 3-port variants as there is no suitable configuration
> > > > in this driver.
> > > > 
> > > > - The pci_ids.h file has been updated to define each card's ID, cleaner
> > > > than using the raw ID.
> > > 
> > > That's not happening in this patch, are you sure you got this correct?
> > 
> > And where are patches 1-3 of this series?
> > 
> Patches 1 to 3 were cc'd to the LKML [1][2][3].

Please use scripts/get_maintainer.pl to send them to all of the proper
people/lists next time.

> 
> Please disregard this patch series. Bjorn [maintainer of the PCI subsystem]
> has declined the pci_ids.h update so I will have to v2 this series using
> raw hex IDs. I guess thats what I get for doing kernel work without putting in
> enough time to check everything :(. Sorry for the mess.
> 
> With regard to the 8250_pci.c file in particular, should I split each change
> into its own commit? I just want to avoid merge conflicts, and making all the
> changes in one commit made more sense to me but rules are rules, so I will
> follow them to get these devices supported. I'm still sort of new to patching
> like this so sorry for any mistakes :(.

Each patch should be a single logical change.

Don't worry about merge conflicts, where would the conflict come from,
and what is being merged anywhere else?

thanks,

greg k-h
