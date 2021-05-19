Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96528C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7349D613AF
	for <linux-serial@archiver.kernel.org>; Wed, 19 May 2021 09:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbhESJL7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 05:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344591AbhESJKk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 05:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9A84610CB;
        Wed, 19 May 2021 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621415360;
        bh=QUWBfeqsTp8xJF3RZ/3yi288bftbqWdbw4makigUEw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjjkYb+b9w/+khrth8YyfkjGe3ZnLBx53MoEr9EEhJkTA7sIMr3rDhso3IJJqOp+9
         fPRVOAIBznJmlfAN0/Le3ey4d7YNDY0r+l1TbkhyEIZrZ9hMsPDZxvLWKQXsPgHjGo
         /EAWl8xGlzo9zykup4ZT3wkuAd5ZDR97yKYddYIUs3UqkkalmciTPHYgKjvq6npoz/
         VXXFPayg3CxKWkthOJrPzAIj7b6ovXEQtjeo1Cq5kpzeZhxnCH6I5TSCIXMCQ9MlB7
         ISAOsEb6mljMh9mjIcWX8GG6eVTAoO+nuNvD8u0nKL29JEjZRnxLfd6QQes0/mVuES
         VsoW24Abotz9Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljICd-0002Re-7i; Wed, 19 May 2021 11:09:19 +0200
Date:   Wed, 19 May 2021 11:09:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 27/35] serial: make usb_serial_driver::chars_in_buffer
 return uint
Message-ID: <YKTVv/zw0So8Y/9J@hovoldconsulting.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-28-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505091928.22010-28-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 05, 2021 at 11:19:20AM +0200, Jiri Slaby wrote:
> tty_operations::chars_in_buffer was switched to uint in the previous
> patch. So do the same for usb_serial_driver's chars_in_buffer too.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied with an amended commit message (e.g. fixed subject prefix).
Thanks.

Johan
