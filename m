Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E26AC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 19 Apr 2022 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbiDSKol (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348250AbiDSKok (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Apr 2022 06:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE023170
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 03:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 012A561257
        for <linux-serial@vger.kernel.org>; Tue, 19 Apr 2022 10:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5F4C385A7;
        Tue, 19 Apr 2022 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650364917;
        bh=PXdlODeKyEoDq2bnGoxQqk3lsZ1MZxkBcM2urX1Md8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqW5XMdk4n99VwVG1MueE+4Z9hZIJAK5PynZbB5ipU7Ve7OoUE1KGleDMRhFOH6qY
         f20OBPs/NNr9d5fZt8EOXa6XN6A4wxDq5OJGCYxdyOjplvLxD8Yxzgg7qTgrchU5Sn
         TFoPwERAUx5f0R6Bum7sgcUdSP4uy03NSpv2eMs0=
Date:   Tue, 19 Apr 2022 12:41:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Lukas Wunner <lukas.wunner@intel.com>, kernel@pengutronix.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: [PATCH v3 1/3] serial: 8250: Handle UART without interrupt on
 TEMT using em485
Message-ID: <Yl6R8rG4YmMyMLxh@kroah.com>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
 <20220330104642.229507-2-u.kleine-koenig@pengutronix.de>
 <1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com>
 <20220330142119.ejjlxbsnkp36nwy7@pengutronix.de>
 <174a96fe-8953-6533-34d7-26c15b8f140@linux.intel.com>
 <893fcf29-20da-2a4-5951-d956472f85f@linux.intel.com>
 <Yl6KyWGmB5+KOAKU@kroah.com>
 <de499011-16e2-1ef5-5cb6-ae6dcdc3f2de@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de499011-16e2-1ef5-5cb6-ae6dcdc3f2de@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 19, 2022 at 01:36:28PM +0300, Ilpo Järvinen wrote:
> On Tue, 19 Apr 2022, Greg Kroah-Hartman wrote:
> 
> > On Tue, Apr 19, 2022 at 11:09:56AM +0300, Ilpo Järvinen wrote:
> > > Hi Greg,
> > > 
> > > This change now appears in your tty-next tree.
> > 
> > What change?  Please never top-post.
> 
> f6f586102add59d57bcc6eea06fdeaae11bb17a1 (serial: 8250: Handle UART 
> without interrupt on TEMT using em485).
> 
> > > As you seem to have missed 
> > > there is an obvious problem with it, I'm asking which direction I should 
> > > take to fix it.
> > 
> > Send a fix!  You don't need my permission to do so.
> 
> Yes, I know I don't need permission :-).
> 
> What I asked is whether I should provide:
>   a) a minimal fix to the issue in this particular change
> or
>   b) send patches that replace this notemt approach with the another
>      that I believe is better than this one (*)
> ?

Or c) a patch to revert this now and then submit a correct series later?

I prefer c)

thanks,

greg k-h
