From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V4] tty/serial: add support for Xilinx PS UART
Date: Wed, 27 Apr 2011 21:40:45 +0100
Message-ID: <20110427214045.6f6d179d@lxorguk.ukuu.org.uk>
References: <beef0ca4-f7d3-4f61-b22a-d9eeeb0618f4@VA3EHSMHS010.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48292 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755722Ab1D0Ujy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Apr 2011 16:39:54 -0400
In-Reply-To: <beef0ca4-f7d3-4f61-b22a-d9eeeb0618f4@VA3EHSMHS010.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, michal.simek@petalogix.com, joe@perches.com, grant.likely@secretlab.ca, greg@kroah.com, John Linn <john.linn@xilinx.com>

On Wed, 27 Apr 2011 12:17:36 -0600
<johnlinn@comcast.net> wrote:

> From: John Linn <john.linn@xilinx.com>
> 
> The Xilinx PS Uart is used on the new ARM based SoC. This
> UART is not compatible with others such that a seperate
> driver is required.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>

Acked-by: Alan Cox <alan@linux.intel.com>
