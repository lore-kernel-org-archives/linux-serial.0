Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE1C83F2D
	for <linux-serial@archiver.kernel.org>; Sun,  3 Sep 2023 10:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjICKta (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 3 Sep 2023 06:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKta (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 3 Sep 2023 06:49:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD0120
        for <linux-serial@vger.kernel.org>; Sun,  3 Sep 2023 03:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8130ACE0959
        for <linux-serial@vger.kernel.org>; Sun,  3 Sep 2023 10:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76017C433C7;
        Sun,  3 Sep 2023 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693738163;
        bh=cam6hNHCdF7HDCfpkJYrRrUS83LTpQVgC62J4spNNyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlnrI1hK1jUoHzLHNtP2esIl79eTKtO2MXqxYGYzmO/YYbW7Mk+YJynlpIjV4T3eA
         S4KWkAILsNdDioxl5kc67ewn2zOniMT1UcsMhX9UYzh/tso4Tgfl/WFniihE/W4qtA
         ck86E1P8tGnruDSPzwbEazTPwTMYBoP5fmwsFTik=
Date:   Sun, 3 Sep 2023 12:49:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     davem@davemloft.net, jirislaby@kernel.org, jag.raman@oracle.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: vcc: Add check for kstrdup() in vcc_probe()
Message-ID: <2023090321-conch-stopper-51c7@gregkh>
References: <20230903101322.205537-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903101322.205537-1-yiyang13@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 03, 2023 at 06:13:22PM +0800, Yi Yang wrote:
> Add check for the return value of kstrdup() and return the error, if it
> fails in order to avoid NULL pointer dereference.
> 
> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/tty/vcc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index a39ed981bfd3..420d334f6077 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -579,6 +579,10 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  		return -ENOMEM;
>  
>  	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
> +	if (!name) {
> +		kfree(port);
> +		return -ENOMEM;

Please just add another goto target later in the function like the rest
of the error paths follow.

And how did you test this patch?

thanks,

greg k-h
