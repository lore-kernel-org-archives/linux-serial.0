Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A724C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 10:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhKXKLI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 05:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235635AbhKXKLH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 05:11:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84C8160FDC;
        Wed, 24 Nov 2021 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637748478;
        bh=SzWIcSajmjog59kKztSwzG/K7pfWqxsRsLy5DgzA7+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zVTSrhLz9rVxhjHCHsYAXKlsJsfDVQL9KmhG8M52mj58zMfzt6C7RzUMarAeulhWN
         HQORYSxtNd0wzGwh2x9k9iKUolycW76RDIrwFHUgPQq5kzrdMOERlsYUe2AfK2CaA8
         73v5XNtCHw/G28JjpUjw2KXp5iVg2tBiQz980Wqc=
Date:   Wed, 24 Nov 2021 11:07:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        jacmet@sunsite.dk, git@xilinx.com
Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of
 control register
Message-ID: <YZ4O+qnkVyhGzuDy@kroah.com>
References: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 23, 2021 at 06:43:48PM +0530, Shubhrajyoti Datta wrote:
> The control register is a writeonly register that's why reading it
> doesn't make any sense.
> The manual states "This is a write-only register. Issuing a read request
> to the control register generates the read acknowledgment with zero data."

Are you sure this is ok to remove?  Usually you have to do a read after
a write to ensure that the write succeeded.

What ensures that the write succeeded now if you remove this read?

thanks,

greg k-h
