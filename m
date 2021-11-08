Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D96C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3296125F
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 09:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhKHJDV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 04:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238289AbhKHJDT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 04:03:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E95CC6125F;
        Mon,  8 Nov 2021 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636362035;
        bh=w+Z+c08/dS94Y7UoRhXt2ErdH5SPSyigtuPykrOC1Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6gVIt9X6l/XkNONqBKX3ISzkBVi4nu7M2SzIpm4saqsdF5UJsOmftum5gRSDXJRc
         R8xHytLHNe0lfhuIE3+/yJBNZ9IVk2lLYDhySyw/BTAdZmF5b/BAomu+0mWwREiteg
         zYiAqPFdJ1F/KT0FVUNNQs05UZQafhuBeL8v0w25z8FVqFS1GHSWwY8p1ZPb+6aTMD
         SpxRY08gHa6mcPxjvTCTzWGXzUxmFkpt1uRDacHlG6Tm6q57FRDIoZNUO/ohcYMHbU
         l7NGf02jkVz+g5MatIA0ISpTcwZQJWALkdsWy0Hz+bMw2svjNVREP4YR4u4aqSTAO6
         sMR/buClBRQ0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mk0Vz-0003KE-IU; Mon, 08 Nov 2021 10:00:31 +0100
Date:   Mon, 8 Nov 2021 10:00:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH] tty: flush buffer on signal interrupted tty close
Message-ID: <YYjnL5SR76iirs95@hovoldconsulting.com>
References: <319321886d97c456203d5c6a576a5480d07c3478.1635781688.git.baruch@tkos.co.il>
 <YYjmoNkCGysVaCFr@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYjmoNkCGysVaCFr@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 08, 2021 at 09:58:08AM +0100, Johan Hovold wrote:
> On Mon, Nov 01, 2021 at 05:48:08PM +0200, Baruch Siach wrote:

> I can reproduce the problem and have posted a fix here:
> 
> 	https://lore.kernel.org/r/20211108083856.5261-1-johan@kernel.org

Sorry, that should have been:

	https://lore.kernel.org/r/20211108085431.12637-1-johan@kernel.org

Johan
