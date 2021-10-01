Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFCEC433F5
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846EA61A07
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJANu1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 09:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhJANu0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 09:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DA89619F9;
        Fri,  1 Oct 2021 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633096122;
        bh=KxoXi+34NWlEGYpaOtbUH6D6Iq4F5KpAQp+v4NZq5nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHqPKTd4/akh6ZxyRnYCdQQkaOGNMGPELyK0YPXLAn1NIQpJkbKoxJlhLye29tqi6
         15gwUNvwaRJviDJX1T7AgLHjpXB1nvjrjaq8o5WdPmFmp1YBqFwKrWbM9TCDKGDT4s
         KhMWt9rcnEMt0evI+4kZAPLF9ibjEe0VXV2SvdFULEUrpVlpiItKTmmyn4J5jIG/1Z
         bMwo87iB3+k5puKkx/TtK770U7gsQL+D7/TUnoJInGz5adwzaVYfCUf13vM5TGbP0v
         4aHEo/X8IMVnDietoV3lt2PPjs4cjtkCWAXH5qLeodIEA0QOlsNWB4JR3y0Z54Ih6+
         w62/2iaXT0qLQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mWIu5-0008RF-NC; Fri, 01 Oct 2021 15:48:45 +0200
Date:   Fri, 1 Oct 2021 15:48:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, linux-serial@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] serial: imx: Fix sysrq deadlock
Message-ID: <YVcRvYDqLWZ4liVl@hovoldconsulting.com>
References: <20210929214324.44910-1-festevam@denx.de>
 <YVVtRw/JlUzn4H54@hovoldconsulting.com>
 <bae11ec74a0515841ad36403b9f5a47b@denx.de>
 <YVa+VL5W+Gnp7TUa@hovoldconsulting.com>
 <CAOMZO5BD95rpU-ChZp591JnnYbGFUZuUdTVxwDNsMUObWVmA_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BD95rpU-ChZp591JnnYbGFUZuUdTVxwDNsMUObWVmA_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 01, 2021 at 07:17:53AM -0300, Fabio Estevam wrote:
> Hi Johan,
> 
> On Fri, Oct 1, 2021 at 4:53 AM Johan Hovold <johan@kernel.org> wrote:
> 
> > Why did you drop the cast? If there's anything in the high bits you'd
> > see the help text printed as you report below (even if it seems
> > unlikely).
> 
> That was it, thanks!
> 
> I have taken your feedback into consideration and sent a v3.
> 
> The only one that I didn't do was to reorganize the code to avoid the
> unlock/lock as
> this would require a significant rework.

Judging from a quick look at the code is very straight-forward, and we
don't want to add interrupt latency just to shut up lockdep.

Johan
