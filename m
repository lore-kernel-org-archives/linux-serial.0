From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH V2] serial: pxa: hold port.lock when reporting modem line changes
Date: Wed, 26 Nov 2014 18:10:29 +0100
Message-ID: <87egsp3n22.fsf@free.fr>
References: <1416993716-21005-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:31707 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaKZRKm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 12:10:42 -0500
In-Reply-To: <1416993716-21005-1-git-send-email-dbaryshkov@gmail.com> (Dmitry
	Eremin-Solenikov's message of "Wed, 26 Nov 2014 12:21:56 +0300")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Both uart_handle_dcd_change() and uart_handle_cts_change() require a
> port lock to be held and will emit a warning when lockdep is enabled.
> Held corresponding lock.
>
> This fixes the following warnings:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/serial_core.c:2760 uart_handle_dcd_change+0xc8/0xf8()
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc5+ #26
> [<c000dff8>] (unwind_backtrace) from [<c000bc70>] (show_stack+0x10/0x14)
> [<c000bc70>] (show_stack) from [<c00192ac>] (warn_slowpath_common+0x6c/0x8c)
> [<c00192ac>] (warn_slowpath_common) from [<c00192e8>] (warn_slowpath_null+0x1c/0x24)
> [<c00192e8>] (warn_slowpath_null) from [<c0182984>] (uart_handle_dcd_change+0xc8/0xf8)
> [<c0182984>] (uart_handle_dcd_change) from [<c018625c>] (serial_pxa_irq+0x268/0x3b0)
> [<c018625c>] (serial_pxa_irq) from [<c004d0d4>] (handle_irq_event_percpu+0x50/0x16c)
> [<c004d0d4>] (handle_irq_event_percpu) from [<c004d22c>] (handle_irq_event+0x3c/0x5c)
> [<c004d22c>] (handle_irq_event) from [<c004f7d0>] (handle_level_irq+0x94/0x118)
> [<c004f7d0>] (handle_level_irq) from [<c004ca0c>] (generic_handle_irq+0x20/0x30)
> [<c004ca0c>] (generic_handle_irq) from [<c004cbe0>] (__handle_domain_irq+0x38/0x70)
> [<c004cbe0>] (__handle_domain_irq) from [<c00085c4>] (ichp_handle_irq+0x24/0x34)
> [<c00085c4>] (ichp_handle_irq) from [<c000c7e4>] (__irq_svc+0x44/0x54)
> Exception stack(0xc07c7f58 to 0xc07c7fa0)
> 7f40:                                                       00000001 00000001
> 7f60: 00000000 20000013 c07c6000 00000000 00000000 c07ce0a4 c07d7798 00000000
> 7f80: c07e8fb8 0000004c 00000000 c07c7fa0 c0044798 c0009f20 20000013 ffffffff
> [<c000c7e4>] (__irq_svc) from [<c0009f20>] (arch_cpu_idle+0x28/0x38)
> [<c0009f20>] (arch_cpu_idle) from [<c003c974>] (cpu_startup_entry+0x1b8/0x220)
> [<c003c974>] (cpu_startup_entry) from [<c0338c54>] (start_kernel+0x39c/0x40c)
> ---[ end trace 4c1b7ae03f6d9d30 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/serial_core.c:2791 uart_handle_cts_change+0xa0/0xdc()
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Tainted: G        W      3.18.0-rc5+ #26
> [<c000dff8>] (unwind_backtrace) from [<c000bc70>] (show_stack+0x10/0x14)
> [<c000bc70>] (show_stack) from [<c00192ac>] (warn_slowpath_common+0x6c/0x8c)
> [<c00192ac>] (warn_slowpath_common) from [<c00192e8>] (warn_slowpath_null+0x1c/0x24)
> [<c00192e8>] (warn_slowpath_null) from [<c018528c>] (uart_handle_cts_change+0xa0/0xdc)
> [<c018528c>] (uart_handle_cts_change) from [<c018624c>] (serial_pxa_irq+0x258/0x3b0)
> [<c018624c>] (serial_pxa_irq) from [<c004d0d4>] (handle_irq_event_percpu+0x50/0x16c)
> [<c004d0d4>] (handle_irq_event_percpu) from [<c004d22c>] (handle_irq_event+0x3c/0x5c)
> [<c004d22c>] (handle_irq_event) from [<c004f7d0>] (handle_level_irq+0x94/0x118)
> [<c004f7d0>] (handle_level_irq) from [<c004ca0c>] (generic_handle_irq+0x20/0x30)
> [<c004ca0c>] (generic_handle_irq) from [<c004cbe0>] (__handle_domain_irq+0x38/0x70)
> [<c004cbe0>] (__handle_domain_irq) from [<c00085c4>] (ichp_handle_irq+0x24/0x34)
> [<c00085c4>] (ichp_handle_irq) from [<c000c7e4>] (__irq_svc+0x44/0x54)
> Exception stack(0xc07c7f58 to 0xc07c7fa0)
> 7f40:                                                       00000001 00000001
> 7f60: 00000000 20000013 c07c6000 00000000 00000000 c07ce0a4 c07d7798 00000000
> 7f80: c07e8fb8 0000004c 00000000 c07c7fa0 c0044798 c0009f20 20000013 ffffffff
> [<c000c7e4>] (__irq_svc) from [<c0009f20>] (arch_cpu_idle+0x28/0x38)
> [<c0009f20>] (arch_cpu_idle) from [<c003c974>] (cpu_startup_entry+0x1b8/0x220)
> [<c003c974>] (cpu_startup_entry) from [<c0338c54>] (start_kernel+0x39c/0x40c)
> ---[ end trace 4c1b7ae03f6d9d31 ]---
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> [Changes since v1 - lock whole function, not just check_modem_status().]

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
