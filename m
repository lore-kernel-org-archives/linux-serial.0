From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial:ifx6x60:SPI header is decoded incorrectly
Date: Tue, 6 Nov 2012 09:42:18 +0000
Message-ID: <20121106094218.0d2008cb@pyramind.ukuu.org.uk>
References: <1352171639.4445.33.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:40921 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2KFJhL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Nov 2012 04:37:11 -0500
In-Reply-To: <1352171639.4445.33.camel@bichao>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: chao bi <chao.bi@intel.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, jun.d.chen@intel.com

On Tue, 06 Nov 2012 11:13:59 +0800
chao bi <chao.bi@intel.com> wrote:

> 
> This patch is to correct the bit mapping of "MORE" and "CTS" in SPI frame header.
> Per SPI protocol, SPI header is encoded with length of 4 byte, which is defined
> as below:
> bit 0 ~ 11: current data size;
> bit 12: "MORE" bit;
> bit 13: reserve
> bit 14 ~ 15: reserve
> bit 16 ~ 27: next data size
> bit 28: RI
> bit 29: DCD
> bit 30: CTS/RTS
> bit 31: DSR/DTR
> 
> According to above SPI header structure, the bit mapping of "MORE" and "CTS" is
> incorrect in function ifx_spi_decode_spi_header();
> 
> cc: Chen Jun <jun.d.chen@intel.com>
> Signed-off-by: channing <chao.bi@intel.com>

Acked-by: Alan Cox <alan@linux.intel.com>
