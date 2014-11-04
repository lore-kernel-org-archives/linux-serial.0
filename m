From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Tue, 04 Nov 2014 18:06:37 +0100
Message-ID: <5459079D.7080703@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de> <1412014009-13315-12-git-send-email-bigeasy@linutronix.de> <20141104170233.GB24112@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33036 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaKDRGm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 12:06:42 -0500
In-Reply-To: <20141104170233.GB24112@csclub.uwaterloo.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org

On 11/04/2014 06:02 PM, Lennart Sorensen wrote:
> 
> According to the manual the DMA channels for UART7 to 10 are:
> 
> uart7:  144 145
> uart8:  146 147
> uart9:  148 149
> uart10: 150 151
> 
> Might as well add those too.  We have uart 7 and 8 in use on our board
> so I am about to go test it.

Mind sharing the manual with me? Mine does not mention DMA channels for
UART7-10. If you are able to test 7+8 (and it works) could you please
make patch which with for the remaining four devices?

Sebastian
