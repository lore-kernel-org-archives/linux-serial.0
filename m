From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] serial: Fix bug of ucc_uart
Date: Wed, 10 Jun 2009 22:39:08 -0500
Message-ID: <1A5D98E1-9A5A-4A4E-AA02-BB999CDC559C@kernel.crashing.org>
References: <1244471076-25905-1-git-send-email-daveliu@freescale.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50196 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968AbZFKDlP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Jun 2009 23:41:15 -0400
In-Reply-To: <1244471076-25905-1-git-send-email-daveliu@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dave Liu <daveliu@freescale.com>
Cc: linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org, timur@freescale.com


On Jun 8, 2009, at 9:24 AM, Dave Liu wrote:

> Current ucc_uart driver doesn't work at UART mode,
> The TxBD[READY] is not cleared by H/W (RISC engine)
> when user send characters to Tx buffer of QE UART.
> so, these characters stay on the QE forever, never
> go to UART line.
>
> The patch is fixing th bug.
>
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> ---
> drivers/serial/ucc_uart.c |   19 ++++++++++++++-----
> 1 files changed, 14 insertions(+), 5 deletions(-)

applied to next.

(Cleaned up the commit message a bit)

- k
