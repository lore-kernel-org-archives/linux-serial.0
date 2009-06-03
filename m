From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/11] Blackfin SPORT UART: fix overrun errors
Date: Wed, 3 Jun 2009 09:53:46 +0100
Message-ID: <20090603095346.64c874b1@lxorguk.ukuu.org.uk>
References: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
	<1243926700-30485-4-git-send-email-vapier@gentoo.org>
	<20090602100018.415b1dfc@lxorguk.ukuu.org.uk>
	<8bd0f97a0906030103i64bc1a9duc5aeaea7bd3f8365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52363 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753783AbZFCIzq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Jun 2009 04:55:46 -0400
In-Reply-To: <8bd0f97a0906030103i64bc1a9duc5aeaea7bd3f8365@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>

> > This should have no effect on a modern kernel.
> 
> well, we wouldnt be making changes if we werent seeing data overruns today

If it has an effect then something else is going on.
> 
> > There is 64K of queueing between you and the ldisc nowdays.
> 
> i dont think that really matters ... we do too much work in the
> interrupt and so we miss new data

Which the other patches addressed so my guess is the real fixes were the
other changes.

Alan
