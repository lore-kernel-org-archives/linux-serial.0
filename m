From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] m68k/atari: SCC - Move Atari serial driver to staging
Date: Thu, 3 Nov 2011 15:12:41 +0000
Message-ID: <20111103151241.70955a9f@bob.linux.org.uk>
References: <alpine.DEB.2.00.1103201010001.13805@ayla.of.borg>
	<CAMuHMdWVchre0g6dE1j_s-+Wc3n17uifQLH6kRfJ9Q2DKfqBLQ@mail.gmail.com>
	<CAOmrzkJGhoBfqeTGROWdDXeL4HVJq2XaPJEtn0CzuNTOyCab9A@mail.gmail.com>
	<CAMuHMdWCb-As2U1rxtaa9QWznc_yD_MWG3-5AMy5LDvp1jJUXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWCb-As2U1rxtaa9QWznc_yD_MWG3-5AMy5LDvp1jJUXw@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@googlemail.com>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> So let's ask the experts: what will be the preferred serial driver
> framework in 2012?

The tty_port code should now handle all the nasty horrible
open/close/hangup logic for you. The serial midlayer uses that and is
gradually shrinking into a buffering/locking helper. The goal was to
*not* create yet another mid layer but to provide helpers that mid
layer and driver code alike can use sensibly.

So either ought to work out.

Alan
