From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Wed, 30 Apr 2014 02:59:46 +0200
Message-ID: <48241008.smQVDtv0CD@avalon>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au> <1986104.5bpNkKVN8D@avalon> <20140429214846.GA27566@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:44020 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbaD3A73 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Apr 2014 20:59:29 -0400
In-Reply-To: <20140429214846.GA27566@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Wednesday 30 April 2014 06:48:50 Simon Horman wrote:
> On Tue, Apr 29, 2014 at 03:44:46PM +0200, Laurent Pinchart wrote:
> > On Monday 28 April 2014 16:07:49 Simon Horman wrote:

[snip]

> > > BTW, are you planning to make the above mentioned driver update
> > > before or after re-posting enablement patches for Koelsch and/or Lager?
> > > I ask because I would like to make such patches the basis for
> > > a patch for Marzen.
> > 
> > I'll try to do so today, after my talk at the ELC :-)
> 
> I thought you might be a bit busy with ELC so I went
> ahead and made my Marzen patches. Hopefully they aren't
> too far away from what you have in mind for the Koelsch and Lager.

I was busy, but I've just sent the patches :-) Could you please test them ? If 
no problem is found I'd like the SCI patch to go in before this series, to 
avoid adding a dependency on sci_ick in the marzen DT.

-- 
Regards,

Laurent Pinchart

