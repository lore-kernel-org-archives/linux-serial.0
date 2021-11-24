Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F874C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 09:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbhKXKCW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 05:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240199AbhKXKCT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 05:02:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2688C60D42;
        Wed, 24 Nov 2021 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637747950;
        bh=sZppXwtoig0B/zrn4YFor/95Bz0Y7XP1eVFnz+DrIKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bK4e0JUa406aHNCyBPSQUEljn/f52oBxbUa17ski12QdUaxyQG+/HVA3XzBq+LXjB
         60mRsJrHwsEhUcoy36INmfkHL4WppNGlHIqGzAfbUoeyaQh2FyPwXkyPCE7MbQN/Lx
         IrGdzuxtFA7n2MtT+8kSR4A6RVXKVFHeNuvjIm1M=
Date:   Wed, 24 Nov 2021 10:59:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Message-ID: <YZ4M6aM6lGxTi2y7@kroah.com>
References: <20211123105122.7913-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123105122.7913-1-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 23, 2021 at 06:51:22PM +0800, Sherry Sun wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> Disable the UCR4_OREN bit in .stop_rx() before the uart receiver is disabled
> maybe better than in the .shutdown() function.

Why is it better?  What does this "fix"?

thanks,

greg k-h
