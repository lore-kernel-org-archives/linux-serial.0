From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix warning in 8250.c
Date: Wed, 4 Jan 2006 15:51:22 -0800
Message-ID: <20060104155122.0bdfcffb.akpm@osdl.org>
References: <200601031012.49068.vda@ilport.com.ua>
	<20060104181425.GE3119@flint.arm.linux.org.uk>
	<20060104181801.GA3605@infradead.org>
	<20060104191241.GF3119@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:60370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWADXt6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2006 18:49:58 -0500
In-Reply-To: <20060104191241.GF3119@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: hch@infradead.org, vda@ilport.com.ua, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > While we're at it can we please kill _INLINE_?  Those functions that should
> > be inlined can become inline, but this macro just obsfucates the serial code.
> 
> No idea - I don't know about x86 nuances and why they wanted:
> 
> #if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
> #define _INLINE_ inline
> #else
> #define _INLINE_
> #endif
> 
> Maybe someone in the x86 world needs to comment?  Does the above even
> mean that we'll ever inline anything marked _INLINE_ ?

I suspect the reasoning behind this is lost in the mists of pre-bk time. 
I'd be inclined to just nuke it and see what happens.  Nothing, I expect.
