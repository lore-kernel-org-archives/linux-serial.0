From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] arch/x86: remove pci uart early console from
 early_prink.c
Date: Thu, 14 May 2015 17:07:30 -0700
Message-ID: <20150515000730.GB4385@kroah.com>
References: <20150514234442.GA91197@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514234442.GA91197@worksta>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Gao <bin.gao@linux.intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 14, 2015 at 04:44:42PM -0700, Bin Gao wrote:
> >From 78ab0810176c544e2b6f14ca8b19c90d339fa6f1 Mon Sep 17 00:00:00 2001
> From: Bin Gao <bin.gao@intel.com>
> Date: Thu, 14 May 2015 15:49:58 -0700
> Subject: [PATCH] arch/x86: remove pci uart early console from early_prink.c
> 
> The arch independent uart8250 early console driver has good
> support for memory mapped and io port based 8250 uarts. Since
> pci is arch independent so it's natural to extend uart8250 to
> support mem, io and pci. Hence pci uart early console in
> arch/x86/kernel_printk.c by the following commit:
> 'commit 5140fda16051 ("Specify PCI based UART for earlyprintk")'
> is removed. And its equivalent function will be available from
> uart8250 early console driver.
> 
> This patch comes with another patch:
> serial_core: add pci uart early console support

What is this here for?  If this is 2/2, of course we know patch 1/2
needs to come first...
