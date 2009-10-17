From: Julia Lawall <julia@diku.dk>
Subject: Re: question about drivers/serial/jsm/jsm_neo.c
Date: Sat, 17 Oct 2009 15:07:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0910171506330.8556@pc-004.diku.dk>
References: <Pine.LNX.4.64.0910171458110.8556@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:45209 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbZJQNHV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 Oct 2009 09:07:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 23E0A19BBF4
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2009 15:07:25 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09695-16 for <linux-serial@vger.kernel.org>;
 Sat, 17 Oct 2009 15:07:23 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id E006E19BBEA
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2009 15:07:23 +0200 (CEST)
Received: from pc-004.diku.dk (pc-004.diku.dk [130.225.97.4])
	by nhugin.diku.dk (Postfix) with ESMTP id CABCB6DF823
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2009 15:04:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pc-004.diku.dk (Postfix) with ESMTP id CE270384E3
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2009 15:07:23 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0910171458110.8556@pc-004.diku.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Sat, 17 Oct 2009, Julia Lawall wrote:

> The file drivers/serial/jsm/jsm_neo.c contains the following code in the 
> function neo_parse_modem:
> 
> 	jsm_printk(MSIGS, INFO, &ch->ch_bd->pci_dev,
> 			"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d " "RI: %d CD: %d\n",
> 		ch->ch_portnum,
> 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_DTR),
> 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_RTS),
> 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_CTS),
> 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_DSR),
> 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_RI),
> 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_DCD));
> 
> The whole function uses constants with the name "UART_MSR_..." except for 
> the first two lines of this print statement, which uses constants with the 
> name "UART_MCR_...".  Furthermore, UART_MCR_DTR is equivalent to 
> UART_MSR_DCTS and UART_MCR_RTS is equivalent to UART_MSR_DDSR.  Is this 
> intentional?

Hmm, maybe it is intentional because the | seems to be mixing both input 
(Status) and output (Control).

julia
