From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2]  8250_pci: Replace commits 448ac154 and e86ff4a
Date: Tue, 3 Apr 2012 21:58:32 +0100
Message-ID: <20120403215832.0520f93d@pyramind.ukuu.org.uk>
References: <4F7B52D8.101@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49539 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab2DCU4R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Apr 2012 16:56:17 -0400
In-Reply-To: <4F7B52D8.101@fb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sudhakar <sudhakar@fb.com>
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, nhan.h.mai@intel.com, linux-kernel@vger.kernel.org

On Tue, 3 Apr 2012 12:43:20 -0700
sudhakar <sudhakar@fb.com> wrote:

> 
> From: Sudhakar Mamillapalli <sudhakar@fb.com>
> 
> 
> The following commits don't completely fix the KT serial missing
> interrupt problems.  So they have been replaced instead by
> enabling serial backup timer.  The iir-once + msi tried approach tried
> to enforce one read of the iir per THRE event, but its defeated by any
> other event occurring at the wrong time, particularly MSR events.
> 
> 448ac15 serial/8250_pci: setup-quirk workaround for the kt serial controller
> e86ff4a serial/8250_pci: init-quirk msi support for kt serial controller

These are already in tree. If you are reversing them and adding a
different fix then please post the series as

- two revert patches exactly reverting the two commits
- a follow on patch or two adding the replacement

That makes it much easier to review and much more obvious. It also helps
make testing simpler.

Alan
