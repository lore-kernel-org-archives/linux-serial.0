From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Mon, 11 Dec 2006 19:15:43 +0000
Message-ID: <20061211191543.32ce2da8@localhost.localdomain>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
	<20061211102016.43e76da2@localhost.localdomain>
	<Pine.LNX.4.60.0612111954120.4039@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937573AbWLKTIG@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0612111954120.4039@poirot.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Corey Minyard <cminyard@mvista.com>, Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
List-Id: linux-serial@vger.kernel.org

> there as "protocols" for user-tty interfaces, i.e., you need a user, that 
> opens a tty, sets a line discipline to it, and does io (read/write) over 
> it, and NOT to be completely initialised and driven from the kernel.

Take a look at the SLIP driver. User space sets up the port but all the
actual I/O is to/from the kernel not via user space.
