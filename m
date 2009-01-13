From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: pnx8xxx_uart: Fix break signal handling
Date: Tue, 13 Jan 2009 13:48:12 +0000
Message-ID: <20090113134812.0ff43e4e@lxorguk.ukuu.org.uk>
References: <200901131109.n0DB9DRJ010712@pc67243907.ddns.nl-htc01.nxp.com>
	<20090113121135.5565b302@lxorguk.ukuu.org.uk>
	<4142f31c0901130522n5273fb67j41cf1aaf7b32853c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53200 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752956AbZAMNry (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Jan 2009 08:47:54 -0500
In-Reply-To: <4142f31c0901130522n5273fb67j41cf1aaf7b32853c@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mischa Jonker <m.d.s.x.jonker@gmail.com>
Cc: "Jonker M.D.S.X." <nlv14114@e3.nl-htc01.nxp.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> > This appears to be unrelated.
> >
> 
> Correct, you can look to it as two separate bugs:
> a) the next character is not ignored while it should;
> b) the status bits 31-8 are copied to the 'ch' variable while they shouldn't.
> 
> Both bugs prevent correct break signal handling (and therefore correct
> behaviour of the magic SysRq key). Bug b didn't cause too much trouble
> earlier because in most situations the status bits are all zero; for
> this case they unfortunately aren't.

Ok that makes sense - no need to split them.
