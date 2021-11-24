Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4413EC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 11:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhKXL1y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240520AbhKXL1x (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 06:27:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9599A604DC;
        Wed, 24 Nov 2021 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637753084;
        bh=OrDMNxn6RAm3Z/OE6/TDbSJ8/FGQwKGE0lcOgr/MaAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3+m0qyRiC+9vjCYIuc5igZodsoCZ7e47fd27JvpqBaIN6PpiHt450UDA7TNJZyj0
         UVZF20O/t5MaTjLA0jEn4qMWeNlnlYBKh4JM6X8nBOGcZxs+0ykkfEqrBjWDuAvLL1
         3wxMW6eE/awc8k5DGdqoHrtoSldlh9eKeLQhjvmk=
Date:   Wed, 24 Nov 2021 12:24:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
 instead of .shutdown()
Message-ID: <YZ4g+U7PZ4bdjVjm@kroah.com>
References: <20211123105122.7913-1-sherry.sun@nxp.com>
 <YZ4M6aM6lGxTi2y7@kroah.com>
 <DB9PR04MB841142300744686983652AB992619@DB9PR04MB8411.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR04MB841142300744686983652AB992619@DB9PR04MB8411.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 24, 2021 at 10:56:43AM +0000, Sherry Sun wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 2021年11月24日 17:59
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: jirislaby@kernel.org; u.kleine-koenig@pengutronix.de; linux-
> > serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx <linux-
> > imx@nxp.com>
> > Subject: Re: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx()
> > instead of .shutdown()
> > 
> > On Tue, Nov 23, 2021 at 06:51:22PM +0800, Sherry Sun wrote:
> > > From: Fugang Duan <fugang.duan@nxp.com>
> > >
> > > Disable the UCR4_OREN bit in .stop_rx() before the uart receiver is
> > > disabled maybe better than in the .shutdown() function.
> > 
> > Why is it better?  What does this "fix"?
> 
> Since I am not clear about the history of this patch, so I haven't found any obvious issues without this patch so far.

Then why submit it?

> But after discussing with the IP owner, it is still recommended to disable the receiver-related interrupts like OREN before disabling the receiver.

recommended by what?  The hardware designers?

> If not, when we have the overrun error during the receiver disable process, the overrun interrupt will keep trigging until we disable the OREN interrupt in the .shutdown(), because the ORE status can only be cleared when read the rx FIFO or reset the controller.  Although the called time between the receiver disable and OREN disable in .shutdown() is very short, there is still the risk of endless interrupt during this short period of time. So had better to disable OREN before the receiver been disabled in .stop_rx().

Please document this in the changelog, otherwise we have no idea why
this is needed.

thanks,

greg k-h
