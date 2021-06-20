Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C54C48BDF
	for <linux-serial@archiver.kernel.org>; Sun, 20 Jun 2021 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87A56023D
	for <linux-serial@archiver.kernel.org>; Sun, 20 Jun 2021 18:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFTSVa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Jun 2021 14:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhFTSVa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Jun 2021 14:21:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 128D0610C7;
        Sun, 20 Jun 2021 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624213157;
        bh=PlsS3euXua3z+OJ6tRgXb9zj8LgqpM/+lgRm4dr+ngk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=an4f4ckinHFgl1/qp8UwIEy6e/djfHvbni5LdgyzU3R/kC9UGzK9+bCn6yIdzHdc2
         VtljvHZQcMOCoMEXIA91pKtzx892hZfPSXDcOfS7ekFcTE+rzE7fdXd5r5xvpEU5W9
         9gTrl2jiWe/ukvTpmiSNm/mOMUHvER8KVRIFRD80=
Date:   Sun, 20 Jun 2021 20:19:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Li <jason.li@cortina-access.com>
Cc:     kernel test robot <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Subject: Re: [tty:tty-testing 218/218]
 drivers/tty/serial/serial_cortina-access.c:469:6: warning: no previous
 prototype for 'cortina_console_write'
Message-ID: <YM+Goo+qqPd3Tpcy@kroah.com>
References: <202106182351.TACYSsac-lkp@intel.com>
 <HK0PR01MB2499A2741A76C6610A20773CA20B9@HK0PR01MB2499.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB2499A2741A76C6610A20773CA20B9@HK0PR01MB2499.apcprd01.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jun 20, 2021 at 02:52:10PM +0000, Jason Li wrote:
> Hi Greg,
> 	I just fixed compile warning but fail to push to remote REPO:
> 	fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/': The requested URL returned error: 403

That's good to verify, no one should have write access to that except me :)

> 	So I attach patch for you review.

Please submit this properly, as is documented and I will be glad to take
it.

thanks,

greg k-h
