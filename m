From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 20/26] 8250: Serial driver changes to support future
 Cavium OCTEON serial patches.
Date: Thu, 20 Nov 2008 20:02:12 +0000
Message-ID: <20081120200212.17e67add@lxorguk.ukuu.org.uk>
References: <49233FDE.3010404@caviumnetworks.com>
	<1227047057-4911-2-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35791 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754413AbYKTUCr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2008 15:02:47 -0500
In-Reply-To: <1227047057-4911-2-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

On Tue, 18 Nov 2008 14:24:14 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> In order to use Cavium OCTEON specific serial i/o drivers, we first
> patch the 8250 driver to use replaceable I/O functions.  Compatible
> I/O functions are added for existing iotypeS.
> 
> An added benefit of this change is that it makes it easy to factor
> some of the existing special cases out to board/SOC specific support
> code.
> 
> The alternative is to load up 8250.c with a bunch of OCTEON specific
> iotype code and bug work-arounds.

Neither are pretty but this looks the better option I agree. Only niggle
is the use of "_fn" - Linux generally doesn't put types into variable
names.
