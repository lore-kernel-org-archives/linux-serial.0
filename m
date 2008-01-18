From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] [SERIAL] qe-uart: add support for Freescale QUICCEngine
 UART
Date: Fri, 18 Jan 2008 00:47:17 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801180047020.16260@blarg.am.freescale.net>
References: <12004125733910-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47329 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbYARGtn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Jan 2008 01:49:43 -0500
In-Reply-To: <12004125733910-git-send-email-timur@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

On Tue, 15 Jan 2008, Timur Tabi wrote:

> Add file ucc_uart.c, a serial device driver for the Freescale QUICCEngine.
> Update the Kconfig and Makefile accordingly.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Updated to reflect comments from Kumar.
>
>  drivers/serial/Kconfig    |   10 +
>  drivers/serial/Makefile   |    1 +
>  drivers/serial/ucc_uart.c | 1514 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1525 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/serial/ucc_uart.c
>

applied.

- k
