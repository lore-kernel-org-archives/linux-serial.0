From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Question:  How to power-manage UART-attached devices.
Date: Mon, 30 Apr 2012 16:50:16 -0700
Message-ID: <4F9F2538.4080407@zytor.com>
References: <20120501082209.0b560708@notabene.brown> <4F9F178F.3030408@zytor.com> <20120501094752.2ea16f23@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33201 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704Ab2D3Xue (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Apr 2012 19:50:34 -0400
In-Reply-To: <20120501094752.2ea16f23@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On 04/30/2012 04:47 PM, NeilBrown wrote:
> 
> I imagine this proposal as being like a virtual DTR line.  It may
> not always be appropriate to connect DTR to the power switch, but
> sometimes it is.
> 

Yeah, that's pretty much what I'm suggesting.

	-hpa

