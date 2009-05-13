From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] 8250: Don't restore NS16550 mode when console suspend
 is disabled
Date: Wed, 13 May 2009 07:58:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905130755090.3343@localhost.localdomain>
References: <20090512210015.GA25540@plexity.net> <alpine.LFD.2.01.0905121452190.3343@localhost.localdomain> <20090513011842.22d9cd6c@lxorguk.ukuu.org.uk> <20090513002850.GA28422@plexity.net> <20090513094409.50c2409f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759697AbZEMPB1@vger.kernel.org>
In-Reply-To: <20090513094409.50c2409f@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dsaxena@plexity.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On Wed, 13 May 2009, Alan Cox wrote:
> 
> Then hard coding is no improvement either. It needs to restore the mode
> that was present at suspend.

Alan, you're missing the fact that this is a special-case for "this is the 
console, and we're not suspending consoles AT ALL".

IOW, it was never suspended either, and it's a case that is known to be 
fundamentally buggy (we're suspending all the PCI bridges, but not a 
serial device that may be behind them!), but often work in _practice_ 
(because people don't use this thing for random serial devices, but for 
things like integrated serial lines that don't lose power).

So we _could_ just save the mode, but that isn't really what this patch is 
all about. The patch in question is about a total hack to avoid touching a 
piece of hardware that we simply don't consider normal.

			Linus
