Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE22C4167B
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A22723406
	for <linux-serial@archiver.kernel.org>; Mon,  7 Dec 2020 09:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLGJLL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:11:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLGJLL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Dec 2020 04:11:11 -0500
Date:   Mon, 7 Dec 2020 10:11:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607332233;
        bh=8xKWMhKYK84sL6uqXAiBJHtHpN21wnhm+X1ict120Sw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJWuAyZefWmBHRFzK5/FXnqzmcN1cVEourttY4XdoDonxXHrwFj2Lkk6cVvt0SmuC
         58qiD4JLjy1o7bo+iVSmHRtMrOBNy2TxekoBux3TCWez6cpFz9foHcOkk7G+tE1jkm
         lOMcpxoPR0XQYj0vBSZmdJUaDZLhyl2ABGq23+S8=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mka@chromium.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, saravanak@google.com
Subject: Re: [PATCH  3/3] Serial: Separate out earlycon support
Message-ID: <X83x0BZmGYtQSMUU@kroah.com>
References: <1607330847-15522-1-git-send-email-akashast@codeaurora.org>
 <1607330847-15522-4-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607330847-15522-4-git-send-email-akashast@codeaurora.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Dec 07, 2020 at 02:17:27PM +0530, Akash Asthana wrote:
> Separate out earlycon support from serial driver and remove it's
> dependency on QUP wrapper driver.
> 
> This enable us to manage earlycon independently and we can re-use the
> same earlycon driver for android project which currently uses
> downstream version of QUP drivers.

What do you mean by "downstream" here?

> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  drivers/tty/serial/Kconfig              |   9 +
>  drivers/tty/serial/Makefile             |   1 +
>  drivers/tty/serial/qcom_geni_earlycon.c | 649 ++++++++++++++++++++++++++++++++
>  drivers/tty/serial/qcom_geni_serial.c   |  97 -----

So you are replacing 97 lines of code with 649 lines?  How is this
benefiting anyone?

confused,

greg k-h
