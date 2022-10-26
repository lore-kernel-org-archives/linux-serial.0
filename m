Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C697C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 07:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiJZHlN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 03:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiJZHk7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 03:40:59 -0400
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 00:40:55 PDT
Received: from smtp-out-01.comm2000.it (smtp-out-01.comm2000.it [212.97.32.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5B1F2E5
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 00:40:54 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-01.comm2000.it (Postfix) with ESMTPSA id DB7F584106B;
        Wed, 26 Oct 2022 09:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1666769555;
        bh=tk2nREhQl0utXeHMzH46bLFONbRz9b4Ce3MtPt47TF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JsSVuB7H2rLe8ewnMFl0fQh71OMYmRoR7sWFaMd5fUUkwXmq+LI9i3pq2anYGdR9V
         zpXOWFPNxS9ofoc0E3N2lFp1xSM8BvhqN+cQ5Ku1gZv1i3OhTstx9JsXbmVDflmoEX
         10uywzRmidpXSvg2+2Z9EH0/MODl2qWF5YthJzEXw+QrbxGYCLWmyF7uvfGxjXE0IX
         nYjqT1/vTe/x8MiA38rYjhRH0tklC4hr5LTpr5+mLNQPq3knBgOoDRXoYJPiBMXsrU
         T3N9P7kWmFFBLBckP2FiigVm7+QZssxX951S3ZO8NSO5sV9dNv35IMtmsF5LzggnVL
         y+imKFgTvtmzA==
Date:   Wed, 26 Oct 2022 09:32:22 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: imx serial chars lost issue
Message-ID: <Y1jihi+8L4ctFO9B@francesco-nb.int.toradex.com>
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
 <CAOMZO5BWUrFWyLFo8X=TfOBtoc6U0vNYR3k7wPNcVXd93q+Wjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BWUrFWyLFo8X=TfOBtoc6U0vNYR3k7wPNcVXd93q+Wjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 26, 2022 at 12:06:34AM -0300, Fabio Estevam wrote:
> Hi Francesco,
> 
> On Mon, Oct 3, 2022 at 8:08 AM Francesco Dolcini
> <francesco.dolcini@toradex.com> wrote:
> >
> > Hello all,
> > recently I have been experiencing an issue with the imx uart on i.MX6ULL
> 
> Does this also happen with other i.MX devices or only on i.MX6ULL?

I do not know for sure, I did not try to actively reproduce the issue on
another SoC. On the other hand the issue with the i.MX6ULL was noticed
during some testing, and we do exactly the same tests on other SoC and
there the issue is either not present or just happening very
infrequently.

> > SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
> > are lost when typing "fast" (copy/paste or writing to the uart using
> > automated tools).
> >
> > This was tested on Linux 6.0, however it does not look like a brand new
> > regression, kernel 5.4 was somehow subject to the same issue, although
> > it was way more difficult to trigger it.
> >
> > While I do understand that without flow control this is something that
> > cannot be prevented, it is pretty fishy that is always the chars after
> > the 32nd.
> >
> > I guess that might be happening is that the FIFO is emptied only by a
> > timer or when it is full, instead of emptying it when half-full, and the
> > CPU might not be fast enough leading to an overflow and the chars lost.
> >
> > Any idea?
> 
> Can you share a reproducer?

Just open the uart console with a terminal application and copy/paste the
following:

 echo -n "12345678901234567890123456789012345678901234567890123456789012345678901234567890" | wc

This is supposed to count 80 chars, you'll get less.

For doing that minicom is not a good choice since we noticed that it
introduces quite some delay between each chars, while using `screen` I
am able to reproduce the issue systematically. We initially reproduced
the issue using `ser2net` with the exact same test.

Francesco

