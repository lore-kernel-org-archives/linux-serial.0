Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB0C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 14:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiBNObZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:31:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiBNObY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 09:31:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0FE4A920;
        Mon, 14 Feb 2022 06:31:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1998161123;
        Mon, 14 Feb 2022 14:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A4FC340E9;
        Mon, 14 Feb 2022 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644849075;
        bh=lVNr0T9Llyhl/bkpx/Xd3WSNs47kgWGgZNlFOmv/V04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOaS6m/2VFhtgD7wGcaQmFRLM1UO0ufGH9xDau+6cLQ3TCh6HkwovM4ygPHdgCslk
         5i5ZdiuisqfZxEf1AO8X1XKIHfmR2J5E8SkrGbhFUei5tPIJmmiKb5A8rXdzx9T2/q
         XbarQ3PwGLQgyyFS9MpNbBv00D+XfqiSh1uGvcXQ=
Date:   Mon, 14 Feb 2022 15:31:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: =?iso-8859-1?Q?Ad?=
 =?iso-8859-1?Q?d_Pali_Roh=E1r?= as mvebu-uart.c maintainer
Message-ID: <YgpnsA4wLrQ2ujAe@kroah.com>
References: <20220214124808.31971-1-pali@kernel.org>
 <YgpVaR421wQYx9mt@kroah.com>
 <20220214140641.v2wlfr43lqgxvw7e@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214140641.v2wlfr43lqgxvw7e@pali>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 14, 2022 at 03:06:41PM +0100, Pali Rohár wrote:
> On Monday 14 February 2022 14:13:13 Greg Kroah-Hartman wrote:
> > On Mon, Feb 14, 2022 at 01:48:08PM +0100, Pali Rohár wrote:
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > I can not take patches without any changelog text, sorry.
> 
> Well, I'm the only one who has been working on this driver recently and
> I have development boards with this UART HW.

Wonderful, I was not objecting to the patch itself, only the lack of any
information in the changelog.

greg k-h
