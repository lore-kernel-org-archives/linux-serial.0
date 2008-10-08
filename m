From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] serial: 8250 driver replaceable i/o functions.
Date: Tue, 07 Oct 2008 17:12:44 -0700
Message-ID: <48EBFAFC.3020501@zytor.com>
References: <48EBF426.9080500@caviumnetworks.com> <48EBF56D.3030203@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60081 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYJHAMz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Oct 2008 20:12:55 -0400
In-Reply-To: <48EBF56D.3030203@caviumnetworks.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, "Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>

David Daney wrote:
> /* sane hardware needs no mapping */
> -static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
> +static inline int map_8250_in_reg(struct uart_port *p, int offset)
> {
> -    if (up->port.iotype != UPIO_AU)
> +    if (p->iotype != UPIO_AU)
>         return offset;
>     return au_io_in_map[offset];
> }

With your changes, these functions cannot be called with p->iotype != 
UPIO_AU anymore, correct?  So there is no need for this test...

	-hpa
