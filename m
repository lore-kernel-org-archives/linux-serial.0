From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: pl011: also enable DMA Rx polling with no
 platform data
Date: Thu, 12 Dec 2013 14:24:37 +0100
Message-ID: <CACRpkdZ2n64EnVaB81bo578jmMzmW+OMGjehVTO=7Pa1zBGAvA@mail.gmail.com>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
	<Pine.LNX.4.64.1312091229550.30018@axis700.grange>
	<Pine.LNX.4.64.1312120923160.32185@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51517 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3LLNYh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Dec 2013 08:24:37 -0500
Received: by mail-ob0-f181.google.com with SMTP id uy5so373263obc.26
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2013 05:24:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1312120923160.32185@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Phil Edworthy <phil@edworthys.org>

On Thu, Dec 12, 2013 at 10:18 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> An addendum to this patch, that might well lead to dropping it and,
> possibly, doing the opposite - removing the DMA Rx polling completely.

I agree with your reasoning, but not with dropping the Rx code
altogether. However we should also drop my patch so we restore
the opt-in-only characteristic until we can rootcause this.

Greg can you please drop or revert
commit 17438217a6f5e33d920ed3821a4b857311cc2872
"serial: pl011: use DMA RX polling by default"
from the TTY tree until this has been sorted out?

Yours,
Linus Walleij
