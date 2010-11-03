From: Greg KH <greg@kroah.com>
Subject: Re: [PPC/MPC5200B] strange data loss on uart reception
Date: Tue, 2 Nov 2010 21:02:48 -0700
Message-ID: <20101103040248.GA7305@kroah.com>
References: <20101101031003.GA2903@kroah.com> <1288622520.1807.0@antares> <1288721170.1923.0@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33379 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab0KCECC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Nov 2010 00:02:02 -0400
Content-Disposition: inline
In-Reply-To: <1288721170.1923.0@antares>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Albrecht Dre? <albrecht.dress@arcor.de>
Cc: linux-serial@vger.kernel.org

On Tue, Nov 02, 2010 at 07:06:02PM +0100, Albrecht Dre? wrote:
> Am 01.11.10 15:41 schrieb(en) Albrecht Dre?:
>> Am 01.11.10 04:10 schrieb(en) Greg KH:
>>> On Sun, Oct 31, 2010 at 06:27:00PM +0100, Albrecht Dre? wrote:
>>>> Am I simply too dumb to use the uart correctly, or is there some issue in the kernel causing this effect?  I noticed that the function mpc52xx_uart_int_rx_chars() does not check the return value of tty_insert_flip_char().  If the system runs out of space (actually, the maximum buffer size used should be limited, in particular on embedded systems!), might this go undetected?  This might explain the bigger "chunks", as the '5200's uart has a rather big fifo (512 bytes).
>>>
>>> That might help, have you tried changing this and seeing if it fixes anything?
>
> Ummm.  Apparently this was a hardware problem.  No errors on a 2nd board, and re-soldering the chip on the 1st fixed it there, too.  Probably a "cold" soldering.

Ah, good, I like the "buggy hardware" type resolutions :)

thanks for letting us know.

greg k-h
