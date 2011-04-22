From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V2] tty/serial: add support for Xilinx PS UART
Date: Fri, 22 Apr 2011 17:23:52 +0100
Message-ID: <20110422172352.308455ce@lxorguk.ukuu.org.uk>
References: <90e49570-bc82-41a9-ac79-2f5007e93a2a@VA3EHSMHS018.ehs.local>
	<4DB14626.8090002@petalogix.com>
	<ad920746-773d-475a-9c0e-dc5dd7a4b1e1@VA3EHSMHS026.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44165 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756107Ab1DVQWz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Apr 2011 12:22:55 -0400
In-Reply-To: <ad920746-773d-475a-9c0e-dc5dd7a4b1e1@VA3EHSMHS026.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: michal.simek@petalogix.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, greg@kroah.com, grant.likely@secretlab.ca

> I don't have a problem removing the empty lines, but is there some
> guideline on that
> which I'm ignoring and should know?

Not in general - mostly its people inventing style. There's a lot to be
said for consistency in spacing but quite frankly people worrying about it
could spend their time more usefully on fixing actual bugs and really
ugly code of which the kernel still has a plentiful supply.

Alan
