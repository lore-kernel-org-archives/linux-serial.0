Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD5C43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBC02077D
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585849086;
	bh=8TKMvcm7H2z/3JqiFbPy34g8B9B8UtFXWv7Lm07TM4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oq+lg2rzhcCW5wdup18qNiewvjF4v0yS1a3rVROVPhIijij6rSSn1AUFz0Jx7bY3L
	 lmXCFHiYvNpcwKjRR3tG2K1E8mOHqrbNW5P4uSHqVUO+WInsBBvqTlMAetNFAT32qo
	 rahnN5ysMQKWSRhW8GlNh7Wf+iiJ8Nr126Lz2bEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgDBRiF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388677AbgDBRiF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 13:38:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A71D20737;
        Thu,  2 Apr 2020 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585849084;
        bh=8TKMvcm7H2z/3JqiFbPy34g8B9B8UtFXWv7Lm07TM4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMWGqHBotZSv4dxqhZXnjfOzJQ6Wm3jfa3qpPEzuxuFqxpgDI/92CA1PC0/+TLZeW
         mHHDXuoU9ZBeFnL/j6LNygsZONH2hjUPQX5X3UVnlu+K134zuGFGzsHdkONpxB+M0L
         BFhqCsWB0dR8GFtRJpTY1lFrvubSlJ6D6Shwt9cM=
Date:   Thu, 2 Apr 2020 19:38:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, sparclinux@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v1] serial: sunhv: Initialize lock for non-registered
 console
Message-ID: <20200402173800.GA3220509@kroah.com>
References: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 08:20:26PM +0300, Andy Shevchenko wrote:
> The commit a3cb39d258ef
> ("serial: core: Allow detach and attach serial device for console")
> changed a bit logic behind lock initialization since for most of the console
> driver it's supposed to have lock already initialized even if console is not
> enabled. However, it's not the case for Sparc HV console.
> 
> Initialize lock explicitly in the ->probe().
> 
> Note, there is still an open question should or shouldn't not this driver
> register console properly.
> 
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/sunhv.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, will pick this up after -rc1 is out.

greg k-h
