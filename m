Return-Path: <SRS0=6WdS=ZF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B70C43331
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE43222BD
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573642566;
	bh=KBx/b0dirKLTbFfP7/jEaLLnYxEjsagGtB3v5uWvdPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bGC1tNQZdYIZOr2p0bYKfC8+hKjXaHHmgjB01aIp3iHe5YmUDVI+4szT55zlpxuzU
	 Z0A+eKELS3y8V2xezhqqOwMCn2rt4oqPjCHPToKQQoIbRaneKGnRfr0yx1lq3Gz0CW
	 peBTutUZKlYfCUx1aJgfX7qqqvyuYtuQUlDzxa6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKMK4G (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMK4G (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Nov 2019 05:56:06 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E37C222BD;
        Wed, 13 Nov 2019 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573642565;
        bh=KBx/b0dirKLTbFfP7/jEaLLnYxEjsagGtB3v5uWvdPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAmiGDceGvMOoZlMX4bEhBqFyPRauyq0NrKhaRRKUl+dyItOFZS68mhkxJk8GVtiF
         6PqC6fFQvzFBgAIBSxF6Xp1vWdZPLUP4VQUlmbrnU/RO08x+AsCeYbJQyrWn4Ss4tC
         lEB6fFZzigHjBBRUDwn40oXjVx5HesDJa4Ggb5SI=
Date:   Wed, 13 Nov 2019 18:56:03 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, swboyd@chromium.org,
        msavaliy@codeaurora.org
Subject: Re: [PATCH v5 1/3] tty: serial: qcom_geni_serial: IRQ cleanup
Message-ID: <20191113105603.GA2083219@kroah.com>
References: <1573642111-17479-1-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573642111-17479-1-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 13, 2019 at 04:18:31PM +0530, Akash Asthana wrote:
> Move ISR registration from startup to probe function to avoid registering
> it everytime when the port open is called for driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in v5:
>  - No change.

This series does not apply at all to my tty-next branch of my tty git
tree.  What did you make it against?  Please rebase it and resend so
that it can be applied.

thanks,

greg k-h
