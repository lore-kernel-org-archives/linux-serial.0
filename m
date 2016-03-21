From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Mon, 21 Mar 2016 19:08:21 -0400
Message-ID: <20160321230821.GA17910@kroah.com>
References: <56F07DA1.8080404@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56F07DA1.8080404@universe-factory.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 22, 2016 at 12:02:57AM +0100, Matthias Schiffer wrote:
> Hi,
> we're experiencing weird nondeterministic hangs during bootconsole/console
> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
> QCA953x likewise.

Can you try 4.4 or ideally, 4.5?  There's been a lot of console/tty
fixes/changes since the obsolete 3.18 kernel you are using...

thanks,

greg k-h
