From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Mon, 4 Jul 2011 23:54:30 +0200
Message-ID: <201107042354.31321.arnd@arndb.de>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de> <201107042237.05295.arnd@arndb.de> <20110704225520.2d0004f3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110704225520.2d0004f3@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Monday 04 July 2011 23:55:20 Alan Cox wrote:
> > How are people using those ISA cards today? The version of setserial
> > that I found is not able to set MMIO mode on those. I suppose you
> 
> Various ugly hacks, if its tricky we can drop support and see who screams

I don't think it's much of a problem, I just didn't expect these to exit.

	Arnd
