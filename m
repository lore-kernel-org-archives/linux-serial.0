Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7BC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4BA60F8F
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 08:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhJRIob (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 04:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhJRIo1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 04:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A451360F9E;
        Mon, 18 Oct 2021 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634546536;
        bh=XEdsBfpd7s7ZmRNDLwGz3ok6z2toWim9gOJ4pD2xCtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txWQQdU7/NYJo2XggT0khMpLlcFOE+VSm0dakVpA3MKUa+seW7y3u/d+/6Uz9Yf19
         tnI+RrlktWEpmBK9HehgBoN1JZI29nBdiD6YlvSQveoLYKCP4wZl3cHktWeKkZMpVz
         KyghzvXiRcgkd1qDQz5ztQKBrEoxhpgVvUQsulLg=
Date:   Mon, 18 Oct 2021 10:42:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, michals@xilinx.com,
        shubhrajyoti.datta@gmail.com, git-dev@xilinx.com
Subject: Re: [PATCH] uartlite: Update the default for the parameter
Message-ID: <YW0zZVBLImlS4g1R@kroah.com>
References: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 18, 2021 at 01:50:00PM +0530, Shubhrajyoti Datta wrote:
> Update the default number of uarts.
> The commit b44b96a060f3 changed the default from 16 to 1 change it back to 16.
> 
> Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)
> 

No extra line here please.

Also, your subject is odd, please make it more obvious what is
happening.

But nost importantly, _WHY_ are you making this change?  What happened
since that commit was made that now we should have the default be 16?
Previously that commit said the default should NOT be 16, and here you
are changing it back.  What changed to require this?

thanks,

greg k-h
