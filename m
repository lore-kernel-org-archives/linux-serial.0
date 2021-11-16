Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C143C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 10:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2346C63217
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 10:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhKPKja (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234115AbhKPKj3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 05:39:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9A1D63217;
        Tue, 16 Nov 2021 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637058993;
        bh=QZ/FMpmY1kVL7n+vcO7O8uJGlKkR5Q6bc6KtmYPncXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nk40zMueg2wHmqQBZzSlPNGAhDsI6kVUIOVz6bPjXg88cpPAoHhvU852NpF7Cch5b
         kcRfAI4D2FABJiD/3VMok0nZCSgkXrHfa5sU6xuRhF4IAT7z5lmujL69iiLX9dU21p
         HNmpjC1MHxbYqsxRM1CZSd0eRckJLlS49nQQN7TQ=
Date:   Tue, 16 Nov 2021 11:36:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sahil Patidar <sahilpatidar4051@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: jsm: jsm_neo: fixed a conditional statement
 coding style issue
Message-ID: <YZOJriqNtHfps72o@kroah.com>
References: <20211116103411.71987-1-sahilpatidar4051@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116103411.71987-1-sahilpatidar4051@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 16, 2021 at 04:04:11PM +0530, Sahil Patidar wrote:
> Fixed a coding style issue

What issue?

And why in a tty driver?

I would recommend doing coding style fixes in drivers/staging/, where
they are welcome and you can learn the basics of kernel patches first,
before going out into the rest of the kernel.

thanks,

greg k-h
