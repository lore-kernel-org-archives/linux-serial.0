From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH][7/8] kgdb: exclusive use kgdb8250 uart I/O driver
Date: Sat, 09 Feb 2008 17:40:02 +0100
Message-ID: <47ADD762.1010206@web.de>
References: <1202564114-18587-1-git-send-email-jason.wessel@windriver.com> <1202564114-18587-2-git-send-email-jason.wessel@windriver.com> <1202564114-18587-3-git-send-email-jason.wessel@windriver.com> <1202564114-18587-4-git-send-email-jason.wessel@windriver.com> <1202564114-18587-5-git-send-email-jason.wessel@windriver.com> <1202564114-18587-6-git-send-email-jason.wessel@windriver.com> <1202564114-18587-7-git-send-email-jason.wessel@windriver.com> <1202564114-18587-8-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:47702 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbYBIQkE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Feb 2008 11:40:04 -0500
In-Reply-To: <1202564114-18587-8-git-send-email-jason.wessel@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jason.wessel@windriver.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

jason.wessel@windriver.com wrote:
> @@ -2175,9 +2187,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  
>  		/*
>  		 * Power down all ports by default, except the
> -		 * console if we have one.
> +		 * console (real or kgdb) if we have one.
>  		 */
> -		if (!uart_console(port))
> +		if (!uart_console(port) && !uart_kgdb(port))
>  			uart_change_pm(state, 3);

Jason, thinking about this hunk again, it appears broken to me. If we
needed it for 8250_kgdb, we would also need it without
CONFIG_KGDB_CONSOLE. However, powering on the UART with a special dance
after we took over with 8250_kgdb is a job that has to be done _there_,
not by this hook here. So let's drop the whole serial_core.c hunk from
this patch.

Jan
