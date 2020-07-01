Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F5C433E0
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 13:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17332207F5
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593609986;
	bh=+PuAt1GcsWcVCIdMAT4isueNwyuOKhwz5N/3g/TfwlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aOeY5kRnm2rOktbVVr0JoWIz6Y4akweQrdTw4Cgj3EyECUNXPCEhQcYgv721ajywX
	 kAixsk1G+gvUilMQh9E5rgjRqGN79nhfY+BcSGYqadCZEE1Vuc6vMRfJKY2aD9Adhs
	 72GkXB6cUUugBDBxhwYcJ+fhqewQ/+h5Mvg71eMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgGAN0V (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbgGAN0U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 09:26:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF20D206BE;
        Wed,  1 Jul 2020 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593609980;
        bh=+PuAt1GcsWcVCIdMAT4isueNwyuOKhwz5N/3g/TfwlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLYN4dQVt/Vf2Ju08hqrAZSstU94sGlP+YeVgHDJVsEAapNbPEIhiORBA1axBTBbJ
         sBYnQPztCertMJJxQQEsyKf5JxbmnTv6RhDra/C9xROCHD5zWzwNkVE+/LV7tE2b2X
         r1V+jnl9LEQIAyBOQ838GzFOd+1q2+HnqWxFr8+Y=
Date:   Wed, 1 Jul 2020 15:26:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "serial: 8250: Fix max baud limit in generic 8250
 port"
Message-ID: <20200701132606.GA2363542@kroah.com>
References: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 30, 2020 at 04:42:11PM -0700, Daniel Winkler wrote:
> This reverts commit 0eeaf62981ecc79e8395ca8caa1570eaf3a12257.
> 
> The change regresses the QCA6174A-3 bluetooth chip, preventing
> firmware from being properly loaded. We have verified that without
> this patch, the chip works as intended.
> 
> Signed-off-by: Daniel Winkler <danielwinkler@google.com>

No cc: stable?  No Fixes: tag?

{sigh}

