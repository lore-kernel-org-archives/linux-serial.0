Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90CC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 06:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75512610A4
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 06:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhJZGqd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 02:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233421AbhJZGqb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 02:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0229E610A0;
        Tue, 26 Oct 2021 06:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635230648;
        bh=Sh+wfnXRQ67bQuLN9DyafIqnAo4eS9bltOLbt+wYjTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKNgvDmoqkHhwUhXiNWLqzPeRB2m2zRY76ItdxdVj5DLLybQt7DrVMm8On4Ztpj8q
         PYLs1/Kpk74L08GSLNmoR2XMoy0tXK1h3N+Ax/h/MF1cI2LGc0aKv1Bp/DB76ghfRV
         Q0L9MEDLqWkj3Msm4YScJXyj+nhsTkAAjeEFbIqw=
Date:   Tue, 26 Oct 2021 08:44:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: 8250_pci: Refactor the loop in
 pci_ite887x_init()
Message-ID: <YXejtg5qZ3nLeu2S@kroah.com>
References: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
 <db3f31f4-46ed-0b6b-89a5-b3cb447e0fa7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db3f31f4-46ed-0b6b-89a5-b3cb447e0fa7@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 26, 2021 at 07:26:18AM +0200, Jiri Slaby wrote:
> On 22. 10. 21, 15:51, Andy Shevchenko wrote:
> > The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
> > This reduces code base and makes it easier to read and understand.
> 
> Why don't we have array_for_each() BTW?
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Jiri Slaby <jslaby@kernel.org>

And now my emails are bouncing as you typed your address incorrectly :(

