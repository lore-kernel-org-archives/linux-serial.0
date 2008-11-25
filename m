From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 10:22:30 +0000
Message-ID: <20081125102230.791fa168@lxorguk.ukuu.org.uk>
References: <1227585320-3711-1-git-send-email-sheng@linux.intel.com>
	<1227585503-3833-1-git-send-email-sheng@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36134 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752076AbYKYKWV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 05:22:21 -0500
In-Reply-To: <1227585503-3833-1-git-send-email-sheng@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sheng Yang <sheng@linux.intel.com>

On Tue, 25 Nov 2008 11:58:23 +0800
Sheng Yang <sheng@linux.intel.com> wrote:

> (Something wrong with encoding of the first mail...)
> 
> The patch based on linux-2.6 upstream and elimiate this compile warning
> info:
> 
> drivers/serial/8250.c: In function 'serial8250_shutdown':
> drivers/serial/8250.c:1612: warning: 'i' may be used uninitialized in this
> function

NAK - again.

There is no real bug here and you risk hiding future ones. It also
doesn't produce a warning with a modern gcc.

Alan
