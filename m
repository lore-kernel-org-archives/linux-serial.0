Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485BC00140
	for <linux-serial@archiver.kernel.org>; Mon,  8 Aug 2022 15:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbiHHPYx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiHHPYw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Aug 2022 11:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1513FBD;
        Mon,  8 Aug 2022 08:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94AC60FF6;
        Mon,  8 Aug 2022 15:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC12DC433C1;
        Mon,  8 Aug 2022 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659972288;
        bh=4XY3xBz5yQioCmLh6CZ+vJkSZt3r2PnoAwGejge7qto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5IG8qBVtvxtRh2rTlcciIqRrsSdXOJaFyViVj5ViDq/7AyyODBFaPUbVe47hzupq
         3dZ1lFTDEp6MO+e+qHgG0yT8IQ2mGBserPwm1JaFbvR8R8sT8E3ZKfukFo1SQYvVhU
         Yl9o5i3xQiWT1atahADKUcmvOAtCEwZPJWDisG7c=
Date:   Mon, 8 Aug 2022 17:24:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: fsl_lpuart: Remove repeated word
Message-ID: <YvEqvf6rk+nde6vT@kroah.com>
References: <20220808151537.846-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808151537.846-1-dengshaomin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 08, 2022 at 11:15:37AM -0400, shaomin Deng wrote:
> Remove the repeated word "as" in comments.
> 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>

Shouldn't this be "Shaomin Deng"?

thanks,

greg k-h
