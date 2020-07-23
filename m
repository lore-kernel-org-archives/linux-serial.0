Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DDEC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 09:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A9D20709
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 09:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="wyRq9SX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgGWJug (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:50:36 -0400
Received: from mail.intenta.de ([178.249.25.132]:43888 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgGWJug (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 05:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=DTpO2wSxcH/F8/ps/tsSTU3i0/beUuu607Y/JU3khSg=;
        b=wyRq9SX7gnl/eqjBXhZz2MngmWJAo+/KjR8zanUzaR1R/TJDRlKTQU7oZhuyMroTZ9mXXruxM57gRVv35xmpUbJMgH/8i80Zrzg4J19bsufIyGYOhngrcdoSUenJFENPgskQmikSqfXkiEccug9/L188X2v1NJ9R+hJoG8E0l4w2ypFx96oZvrVDjnSaYWtDB9/FlUvzNpPE869qLK/sslHdzMv3oFRnOj1crmw8TBlkh9KyWckYvy6DlAplPjAK0uqcvTtcSmStPt2nzCUMN6PCcZadexY1AvQrTZwoB7y/jPPP+Zp8GCZcEqyBb+ixqD91LGtWaKGmvqeyEfcf+w==;
Date:   Thu, 23 Jul 2020 11:50:30 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "Jan Kiszka" <jan.kiszka@web.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tty: xilinx_uartps: Really fix id assignment
Message-ID: <20200723095030.GA23929@laureti-dev>
References: <f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com>
 <20200709074849.GA28968@laureti-dev>
 <a3b9df28-8142-fc04-317f-44d65a24f38e@xilinx.com>
 <20200713071123.GA1994@laureti-dev>
 <e7b766ab-8c99-d30c-2352-6d7b09033537@xilinx.com>
 <20200713121019.GA6920@laureti-dev>
 <7fea9efe-f439-33a3-966f-4215681ec4c8@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7fea9efe-f439-33a3-966f-4215681ec4c8@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Michal,

On Wed, Jul 22, 2020 at 09:14:40AM +0200, Michal Simek wrote:
> On 13. 07. 20 14:10, Helmut Grohne wrote:
> > Can we maybe trim down the matrix somehow? In my context, the need for
> > swapping the serial aliases arises from a limitation in u-boot-xlnx and
> > the desire to use one dtb for both linux and u-boot. It requires that
> > the serial0 alias is the console. Are there other reasons to swap them?
> > If not, maybe fixing u-boot would be an option?
> 
> I am not aware about any limitation in u-boot in this space. U-Boot is
> working with aliases and also with stdout-patch selection.
> Can you please elaborate more on this?

I have retested this (with more recent versions than earlier).

I confirm that u-boot correctly deals with aliases and
chosen/stdout-path. Using linear aliases and assigning stdout to serial1
works.

I also confirm that having ttyPS1 without having ttyPS0 works (only
tested with this patch applied). I questioned this earlier.

So it seems that the need for reversing these aliases is less strong
now. If I remember correctly, Jan Kiszka was also using reversed
aliases, but I don't know why.

Helmut
