Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1160C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhKZRNL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhKZRLK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 12:11:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DEC0613A1
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2021 08:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2695622F2
        for <linux-serial@vger.kernel.org>; Fri, 26 Nov 2021 16:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F26C93056;
        Fri, 26 Nov 2021 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637944887;
        bh=Ru0gtAEBYGVOt4VIH/S87WMZ5RjlQI9ZG9Lt8KmFBY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyY3z4W+9RoV08oUnzZ8FyxaFM3fJEt3aiGboZFWqBFwhYM7wypRKT/GR7B2X0Dzj
         qbaLuWHcBBgkW7hjfMoFuF200ab/85yRlhny6snmsFLi8Gi20xjW3rFbWpZFU4s7vh
         6G7jo0eskvwbnXMUa9LJVZ7FrUwViq1QnBtrkYnQ=
Date:   Fri, 26 Nov 2021 17:41:24 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     wigin zeng <wigin.zeng@dji.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: Serial_DMA issue discussion
Message-ID: <YaEONCTJStvkg5KS@kroah.com>
References: <0e1b6299f9a247e4801cb47d64fd0710@MAIL-MBX-cwP11.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1b6299f9a247e4801cb47d64fd0710@MAIL-MBX-cwP11.dji.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 26, 2021 at 07:42:10AM +0000, wigin zeng wrote:
> This email and any attachments thereto may contain private, confidential, and privileged material for the sole use of the intended recipient. Any review, copying, or distribution of this email (or any attachments thereto) by others is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.

Now deleted.

