Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F10C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 08:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3561052
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 08:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKJINg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:13:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhKJINg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 03:13:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79C0660FDA;
        Wed, 10 Nov 2021 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636531849;
        bh=u8b5cf1EBSxtufFdQN4PMhOxgUC210Wh/YSOnRXF7Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUSdi1XyLhDhnWPmsceU86FDly+91QHJNd/3k4DSapQq89WuSlWwCiqsP5H4o4UGh
         V66NAEfPp3klHGoHxxIM7tHbiZX0VESNXIOZwNDtTgFYXUcNXvCrQyxrL6KY9vvAgY
         k9yX+YIXp/h34xymLRmPfTIQdP3qeg21CUqz7i2Q=
Date:   Wed, 10 Nov 2021 09:10:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     johan@kernel.org, jirislaby@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, zev@bewilderbeest.net, yao.jing2@zte.com.cn,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: Replace snprintf in show
 functions with  sysfs_emit
Message-ID: <YYt+hmfOPSDg0NVM@kroah.com>
References: <20211110024028.135887-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110024028.135887-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 10, 2021 at 02:40:28AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.

Same subject and changelog comments as the staging driver change you
sent in :(

