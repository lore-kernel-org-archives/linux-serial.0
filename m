Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF8C04A6A
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 13:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjHCNaI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjHCN3r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 09:29:47 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1734688;
        Thu,  3 Aug 2023 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HKMd41ztEQhdCZJks87581+xSsxJKDmGF5+5ygoMIxI=; b=XGOgrevrfCnRiUIRPwXG6WNdtu
        47haAKBh0Dobgfm7Q5SB0LDtOlIGAHZb09HfV2K60izf5hkRwsFFD5C+3agiaNWRP0Err1pmYuZ/3
        tkiZdBoQpk9CrjIrFgi+NF889G7PIhWpPzoGbZqlzTrM464VC4ySvOhfsczJ3lhpV0aE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:40832 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRYNG-0008NY-U6; Thu, 03 Aug 2023 09:28:19 -0400
Date:   Thu, 3 Aug 2023 09:28:18 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230803092818.15ec39cf05745e22e0aa2999@hugovil.com>
In-Reply-To: <2023073155-unpaired-dropper-f8fe@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-11-hugo@hugovil.com>
        <2023073155-unpaired-dropper-f8fe@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v9 10/10] serial: sc16is7xx: improve comments about
 variants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 31 Jul 2023 17:56:53 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:42AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Replace 740/750/760 with generic terms like 74x/75x/76x to account for
> > variants like 741, 752 and 762.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> 
> You have now mixed a patch series full of commits that are to be
> backported to stable kernels (i.e. fixes) and general changes that do
> not need to be.
> 
> Please make these two separate patch series, you can have one depend on
> the other, but I can't apply them both to the "for Linus" branch as
> obviously they are not all fixes nor need to go to Linus now.
> 
> thanks,
> 
> greg k-h

Hi,
Ok, will do.

Thank you,
Hugo.
