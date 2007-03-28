From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: [PATCH] Add support for ITE887x serial chipsets
Date: Wed, 28 Mar 2007 11:08:52 +0200
Message-ID: <1175072932.3065.8.camel@wsa115.wincor-nixdorf.com>
References: <20070327183031.9989.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from truxi.wincor-nixdorf.com ([217.115.67.78]:50402 "EHLO
	truxi.wincor-nixdorf.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbXC1JJc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Mar 2007 05:09:32 -0400
In-Reply-To: <20070327183031.9989.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 2007-03-27 at 14:30 -0400, linux@horizon.com wrote:
> Minor point: the chip part numbers are actually IT887x, not ITE887x.

You are correct. Vendor is ITE, product IT887x (id=8872). What is the
advised naming convention for something like this?

> I STFW for a data sheet, but didn't have immediate luck.  Does anyone know where to find
> documentation?

I can't even find the product on the official ITE site... The sheets I
have come from our BIOS development team. I've uploaded them on our FTP
server. The files will be deleted automatically in a few days.

- <ftp://ftp.wincor-nixdorf.com/outgoing/IT8872_v0.2_07182000.PDF>
- <ftp://ftp.wincor-nixdorf.com/outgoing/IT8874F_V0.1_09202001.PDF>

-- 
Niels de Vos <niels.devos@wincor-nixdorf.com>
Wincor Nixdorf International GmbH

