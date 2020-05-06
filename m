Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2774C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B447E206F9
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588746671;
	bh=MFpFVaI2hBqLIIEtg/NvItpJR0h+j14MNwgPOuWazmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NhgaeH0Sr4ha95wVxslMQm1yr46l43z+SHiuncdrj1fvC9Rw4AsjY+H2DrGxAxwlZ
	 SlDaocfGuWfu/OP2pTruENRVSJ08V5WlW2WL0FzfXV/yrHUfftUCXQMSSprsxqvESl
	 xWEyQY1uYBSmyqDdf1cDDpPXMjhBaYd7cAWhrjEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgEFGbI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 02:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgEFGbI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 02:31:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FABC206E6;
        Wed,  6 May 2020 06:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588746668;
        bh=MFpFVaI2hBqLIIEtg/NvItpJR0h+j14MNwgPOuWazmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EpM8LnS4QQfFuOoQTFa7n+QHGjWh3YEmilYrQugomeBUci0nAmOVSwBUCYpiqr60y
         gkhA4deBwBb7/bnir48213vvxpxHX/VqDE/7fxQjxRhiEDCBKswqdfvM+McIIzbG5z
         gUc+hqPi1yv77BCXNTrLlhzVnorh7IqsuBJjc0/E=
Date:   Wed, 6 May 2020 08:31:05 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     'Kukjin Kim' <kgene@kernel.org>,
        'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Jiri Slaby' <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] serial: samsung: Replace rd_regb/wr_regb with
 rd_reg/wr_reg
Message-ID: <20200506063105.GA2246050@kroah.com>
References: <CGME20200420013322epcas2p263e72997dd4ebdaf00b095a83a6b6651@epcas2p2.samsung.com>
 <20200420013300.17249-1-hyunki00.koo@samsung.com>
 <20200505142325.GA816056@kroah.com>
 <000001d62335$33d03410$9b709c30$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001d62335$33d03410$9b709c30$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 08:30:46AM +0900, Hyunki Koo wrote:
> On Tuesday, May 5, 2020 at 2020 11:23:00 PM +0900, Greg Kroah-Hartman wrote:
> > On Mon, Apr 20, 2020 at 10:32:56AM +0900, Hyunki Koo wrote:
> > > This patch change the name of macro for general usage.
> > >
> > > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > 
> > This patch series creates the following build error, which is not
> > allowed:
> > 
> >   CC [M]  drivers/tty/serial/samsung_tty.o
> > drivers/tty/serial/samsung_tty.c:186:13: warning: ‘wr_reg_barrier’
> > defined but not used [-Wunused-function]
> >   186 | static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> >       |             ^~~~~~~~~~~~~~
> > 
> > Please fix up and resend.  Always make sure you keep the reviewed-by
> > tags from others as well.
> > 
> > greg k-h
> 
> I tested on latest kernel today one more time, there is no error and warning on my side, not only patch 1/3 and patch 3/3
> Line 1735:   CC      drivers/tty/serial/samsung_tty.o
> Line 343:   CC      drivers/tty/serial/samsung_tty.o
> 
> wr_reg_barrier is not defined in patch 1/3, 
> and wr_reg_barrier is define and used in patch3/3
> it might be no warning.

After I apply this series, I got the above build warning on my normal
x86 system, so I can not take the patches.  Please fix up and resend.

greg k-h
