From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: fix paging fault on
 spi_register_driver
Date: Tue, 7 Aug 2012 11:13:39 +0100
Message-ID: <20120807111339.4a369066@pyramind.ukuu.org.uk>
References: <20120807051247.GA24140@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34944 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab2HGKJK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Aug 2012 06:09:10 -0400
In-Reply-To: <20120807051247.GA24140@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Russ Gorby <russ.gorby@intel.com>

On Tue, 7 Aug 2012 13:12:47 +0800
Fengguang Wu <fengguang.wu@intel.com> wrote:

> [  117.240866] BUG: unable to handle kernel paging request at 815b627c
> [  117.240866] IP: [<813fe94b>] spi_register_driver+0xb/0x50
> ...
> [  117.240866] Call Trace:
> [  117.240866]  [<817de977>] ifx_spi_init+0xbe/0xf0
> 
> The root cause is, spi_register_driver() is trying to write into the
> passed *const* struct spi_driver.
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
