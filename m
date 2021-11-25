Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B4C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 25 Nov 2021 17:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhKYRfg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Nov 2021 12:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242689AbhKYRdf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Nov 2021 12:33:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCBBA61108;
        Thu, 25 Nov 2021 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637861424;
        bh=y2ryC9vV3LMewW7FNdCsbMxj/wAC0wxR5p8mLgvKM+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkCYL7QON+iPE0wbGRLwhipSAYR0Cr1pclMLhG7MXFqDT2mchW9eyWukkRO5w3RRc
         +s9CEYEqwDk47iYOy4B4cmVrl7xwiivBxdhlhsVzZ2hI41KarhZyPASGA3bVEPzf7p
         6nQoK3u5hpoDdKgu0oWlf6v96AErlBSBDm6Ft2Fk=
Date:   Thu, 25 Nov 2021 18:30:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_pci: rewrite pericom_do_set_divisor
Message-ID: <YZ/IKEHDrUPIaaA1@kroah.com>
References: <20211114183908.444923-1-jay.dolan@accesio.com>
 <20211114183908.444923-2-jay.dolan@accesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114183908.444923-2-jay.dolan@accesio.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 14, 2021 at 10:39:06AM -0800, Jay Dolan wrote:
> Fixes: 6bf4e42f1d19de10800f4483b4bb7945aab283cb

This needs to go down in the signed-off-by line area and use the format
as documented in the submitting patches documentation in the kernel.

thanks,

greg k-h
