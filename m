From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] serial: set correct baud_base for Oxford
 Semiconductor Ltd EXSYS EX-41092 Dual 16950 Serial adapter
Date: Mon, 22 Sep 2008 14:15:50 +0100
Message-ID: <20080922141550.6e043f44@lxorguk.ukuu.org.uk>
References: <48D79977.30403@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42382 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753230AbYIVNQA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Sep 2008 09:16:00 -0400
In-Reply-To: <48D79977.30403@wincor-nixdorf.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: linux-serial@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org

On Mon, 22 Sep 2008 15:11:19 +0200
Niels de Vos <niels.devos@wincor-nixdorf.com> wrote:

> The PCI-card identified as "Oxford Semiconductor Ltd EXSYS EX-41092 Dual
> 16950 Serial adapter" is only usable with other devices (i.e. not the same
> card) after doing a "setserial /dev/ttyS<n> baud_base 115200".  This
> baud_base should be default for this card.
> 
> Signed-off-by: Niels de Vos <niels.devos@wincor-nixdorf.com>

Ok we'll give that one a go and hopefully it won't clash with anything
else this time. Queued for the ttydev tree


Alan
