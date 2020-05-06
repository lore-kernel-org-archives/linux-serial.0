Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED00C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1D420714
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEFLyb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 07:54:31 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:54181 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgEFLyb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 07:54:31 -0400
X-Greylist: delayed 20882 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2020 07:54:30 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3D6B5100AF93C;
        Wed,  6 May 2020 13:54:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A23BA5A487; Wed,  6 May 2020 13:54:28 +0200 (CEST)
Date:   Wed, 6 May 2020 13:54:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] serial: 8250: Avoid error message on reprobe
Message-ID: <20200506115428.rakbdkw7bqomefqi@wunner.de>
References: <cover.1588505407.git.lukas@wunner.de>
 <b3fbbe8688d5e9d173168ae45295719ca4c9d35f.1588505407.git.lukas@wunner.de>
 <20200505160101.GV185537@smile.fi.intel.com>
 <20200506060623.sf3kh3fwhoawawsd@wunner.de>
 <20200506100157.GB185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506100157.GB185537@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 01:01:57PM +0300, Andy Shevchenko wrote:
> On Wed, May 06, 2020 at 08:06:23AM +0200, Lukas Wunner wrote:
> > On Tue, May 05, 2020 at 07:01:01PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 05, 2020 at 04:42:01PM +0200, Lukas Wunner wrote:
> > > > Cc: stable@vger.kernel.org # v2.6.10+
> > > 
> > > Fixes tag?
> > 
> > The bug was introduced in the pre-git era, so I can't provide a Fixes tag:
> > 
> > https://git.kernel.org/tglx/history/c/befff6f5bf5f
> > 
> > This commit, which went into v2.6.10, added an unconditional
> > uart_remove_one_port() in serial8250_register_port().
> 
> We have history tree, but I heard you.
> 
> > In 2012, commit 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
> > made the call to uart_remove_one_port() conditional on uart->port.dev
> > being non-NULL and that allows me to fix the issue by setting that
> > pointer to NULL in the error path.  The commit went into v3.7, so it
> > should be possible to fix the problem going back to v3.7 with my patch.
> > And before that one needs to additionally make the call to
> > uart_remove_one_port() conditional.
> 
> Perhaps it will be the best candidate.

There's a syntax to specify prerequisites which is documented in:
Documentation/process/stable-kernel-rules.rst

So I intend to do the following:

Cc: stable@vger.kernel.org # v2.6.10
Cc: stable@vger.kernel.org # v2.6.10: 835d844d1a28: 8250_pnp: do pnp probe before legacy

And it probably doesn't hurt to include the explanation above
(which historic commit I'm fixing and so on) in the commit message.

Thanks,

Lukas
