From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] [V2] uartlite: move from byte accesses to word accesses
Date: Thu, 21 Jan 2010 09:25:39 +0100
Message-ID: <87tyuflv98.fsf@macbook.be.48ers.dk>
References: <70e0020c-98ac-48d0-bfa6-1f2230ad2d0b@VA3EHSMHS026.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:37790 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0AUIZo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Jan 2010 03:25:44 -0500
Received: by ewy19 with SMTP id 19so2085967ewy.1
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2010 00:25:43 -0800 (PST)
In-Reply-To: <70e0020c-98ac-48d0-bfa6-1f2230ad2d0b@VA3EHSMHS026.ehs.local>
	(John Linn's message of "Wed, 20 Jan 2010 17:06:39 -0700")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com

>>>>> "John" == John Linn <john.linn@xilinx.com> writes:

 John> Byte accesses for I/O devices in Xilinx IP are going to be less
 John> desired in the future such that the driver is being changed to
 John> use 32 bit accesses.

 John> This change facilitates using the uartlite IP over a PCIe bus
 John> which only allows 32 bit accesses.

 John> Signed-off-by: John Linn <john.linn@xilinx.com>
 John> ---
 John>  drivers/serial/uartlite.c |   36 ++++++++++++++++++------------------
 John>  1 files changed, 18 insertions(+), 18 deletions(-)

 John> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
 John> index 377f271..9f83949 100644
 John> --- a/drivers/serial/uartlite.c
 John> +++ b/drivers/serial/uartlite.c
 John> @@ -86,7 +86,7 @@ static int ulite_receive(struct uart_port *port, int stat)
 John>  	/* stats */
 John>  	if (stat & ULITE_STATUS_RXVALID) {
 port-> icount.rx++;
 John> -		ch = readb(port->membase + ULITE_RX);
 John> +		ch = (u8)in_be32(port->membase + ULITE_RX);
 

I don't believe all those (u8) casts are needed (and they could
potentially mask away other problems in the future).

Other than that,

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
