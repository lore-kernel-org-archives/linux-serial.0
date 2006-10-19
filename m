From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] tty: preparatory structures for termios revamp
Date: Thu, 19 Oct 2006 07:45:08 +0100
Message-ID: <1161240308.3376.463.camel@pmac.infradead.org>
References: <1161193175.9363.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:3552 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1945981AbWJSGpV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Oct 2006 02:45:21 -0400
In-Reply-To: <1161193175.9363.111.camel@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, 2006-10-18 at 18:39 +0100, Alan Cox wrote:
> In order to sort out our struct termios and add proper speed control we
> need to separate the kernel and user termios structures. Glibc is fine
> but the other libraries rely on the kernel exported struct termios and
> we need to extend this without breaking the ABI/API
> 
> To do so we add a struct ktermios which is the kernel view of a termios
> structure and overlaps the struct termios with extra fields on the end
> for now. (That limitation will go away in later patches). Some platforms
> (eg alpha) planned ahead and thus use the same struct for both, others
> did not.
> 
> 
> This just adds the structures but does not use them, it seems a sensible
> splitting point for bisect if there are compile failures (not that I
> expect them) 

Why have separate copies of almost identical structures in each
architecture -- can we not put the new structure in
asm-generic/termbits.h and use that for all but SPARC, which has the
extra _x_cc field?

-- 
dwmw2

