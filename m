Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A9C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  4 Mar 2022 18:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiCDStn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCDStn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Mar 2022 13:49:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF5156C6E;
        Fri,  4 Mar 2022 10:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6F19B82843;
        Fri,  4 Mar 2022 18:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8745CC340E9;
        Fri,  4 Mar 2022 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646419732;
        bh=8AHE+FmAngIrfiBRcQ3Z7bcE+LNrJLhOoPKv6Ea4Pao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn2HO/dr2Aasa3SPDpBahX1mbfDrKo4Lg8d20izr1YdonbWi573mPTt+Yqc49mqYl
         fLNdU9kh/IUo4X+Qm12zaV987ndTxTh+41Tle2gfJ97iKesEee5viJGb54xsVjzhIQ
         9Ioj7q6oOvsUz+lQlGMtv6ZlzXCVWhaJSBTi/HnQ=
Date:   Fri, 4 Mar 2022 19:48:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] serial: 8520_mtk: Prepare for
 platform_get_irq_optional() changes
Message-ID: <YiJfDRrkzfre/Iqb@kroah.com>
References: <20211217181547.48182-1-andriy.shevchenko@linux.intel.com>
 <YiJWPhWGEGg63zbe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiJWPhWGEGg63zbe@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 04, 2022 at 08:11:10PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 17, 2021 at 08:15:47PM +0200, Andy Shevchenko wrote:
> > The platform_get_irq_optional() is going to be changed in a way
> > that the result of it:
> >    = 0 means no IRQ is provided
> >    < 0 means the error which needs to be propagated to the upper layers
> >    > 0 valid vIRQ is allocated
> > 
> > In this case, drop check for 0. Note, the 0 is not valid vIRQ and
> > platform_get_irq_optional() issues a big WARN() in such case,
> > 
> > It's safe to assume that 0 is not valid IRQ in this case since
> > the driver is only instantiated via Device Tree and corresponding
> > OF APIs should never ever return 0 for valid IRQ. Otherwise it is
> > a regression there.
> 
> Can it be applied now?

What changed to make this viable?
