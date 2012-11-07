From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do
 mrdy_assert when fifo is not empty
Date: Wed, 7 Nov 2012 09:11:47 +0000
Message-ID: <20121107091147.18243ea0@pyramind.ukuu.org.uk>
References: <1352307844.4332.63.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42414 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab2KGJGl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Nov 2012 04:06:41 -0500
In-Reply-To: <1352307844.4332.63.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Bi Chao <chao.bi@intel.com>, serial <linux-serial@vger.kernel.org>, "russ.gorby" <russ.gorby@intel.com>

On Wed, 07 Nov 2012 12:04:04 -0500
Jun Chen <jun.d.chen@intel.com> wrote:

> 
> This patch check whether the fifo lenth is empty before writing new data to fifo.If condition
> is true,ifx_spi_write need to trigger one mrdy_assert. If condition is false,the mrdy_assert
> will be trigger by the next ifx_spi_io.
> Cc: Bi Chao <chao.bi@intel.com>
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
