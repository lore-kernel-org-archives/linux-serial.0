From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] tty: serial: Add driver for MEN's 16z135 High Speed
 UART.
Date: Thu, 17 Apr 2014 15:53:24 +0100
Message-ID: <20140417155324.6fe03e8c@alan.etchedpixels.co.uk>
References: <1397742478-2894-1-git-send-email-johannes.thumshirn@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48193 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaDQOyM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2014 10:54:12 -0400
In-Reply-To: <1397742478-2894-1-git-send-email-johannes.thumshirn@men.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Thomas Schnuerer <thomas.schnuerer@men.de>

On Thu, 17 Apr 2014 15:47:58 +0200
Johannes Thumshirn <johannes.thumshirn@men.de> wrote:

> Add driver for MEN's 16z135 High Speed UART.
> 
> The 16z135 is a memory mapped UART Core on an MCB FPGA and has 1024 byte
> deep FIFO buffers for the RX and TX path. It also has configurable FIFO
> fill level IRQs and data copied to and from the hardware has to be
> acknowledged.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>

Reviewed-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>

Alan
