From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: PROBLEM: BUG: scheduling while atomic in the 8250 serial driver
Date: Sat, 01 Feb 2014 09:42:57 -0500
Message-ID: <52ED07F1.60304@hurleysoftware.com>
References: <52ECED0D.4090202@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout60.mail01.mtsvc.net ([216.70.64.8]:40045 "EHLO
	mailout60.mail01.mtsvc.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932320AbaBAQpc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Feb 2014 11:45:32 -0500
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70] helo=n23.mail01.mtsvc.net)
	by mailout60.mail01.mtsvc.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <peter@hurleysoftware.com>)
	id 1W9bmu-000153-Bo
	for linux-serial@vger.kernel.org; Sat, 01 Feb 2014 09:43:16 -0500
In-Reply-To: <52ECED0D.4090202@ewanet.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Beat Bolli <bbolli@ewanet.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

On 02/01/2014 07:48 AM, Beat Bolli wrote:
> Hi

Hi Beat,

> Firstly, I hope that my analysis of the stack trace is correct and this
> is really a serial driver problem. Anyway, here goes:
>
> I have a serial GPS with PPS on the RTS pin attached to my Atom N270
> motherboard, using it, besides being my home server and Internet
> gateway, as a Stratum 0 NTP server. Recently[1], the kernel started
> producing BUGs as follows:
>
> [10671.576706] BUG: scheduling while atomic: blosxom.cgi/8118/0x10010000

<snip>

> [10671.578517] Call Trace:
> [10671.578538]  [<c13fe5a9>] ? dump_stack+0x3e/0x4e
> [10671.578549]  [<c13fc1c8>] ? __schedule_bug+0x4d/0x5e
> [10671.578561]  [<c140113c>] ? __schedule+0x6fc/0x710
> [10671.578573]  [<c1076170>] ? wake_up_state+0x10/0x10
> [10671.578584]  [<c114fba0>] ? poll_select_copy_remaining+0x110/0x110
> [10671.578595]  [<c1070676>] ? __wake_up_common+0x46/0x70
> [10671.578606]  [<c1074593>] ? __cond_resched+0x13/0x30
> [10671.578615]  [<c140145d>] ? _cond_resched+0x1d/0x30
> [10671.578624]  [<c1400758>] ? down_read+0x8/0x20
> [10671.578636]  [<c12b59dc>] ? n_tty_receive_buf2+0x2c/0xb0
> [10671.578656]  [<c12b59b0>] ? __receive_buf+0x7b0/0x7b0
> [10671.578666]  [<c12b89ba>] ? flush_to_ldisc+0xba/0x110

You can't use low_latency; only devices that receive data in
non-interrupt contexts (such as USB serial devices) can.

> [10671.578678]  [<c12cea51>] ? serial8250_rx_chars+0xa1/0x1b0
> [10671.578688]  [<c12cebb5>] ? serial8250_handle_irq.part.13+0x55/0x90
> [10671.578698]  [<c12cdf04>] ? serial8250_interrupt+0x44/0xb0
> [10671.578710]  [<c109124c>] ? handle_irq_event_percpu+0x2c/0x1a0
> [10671.578721]  [<c10913e2>] ? handle_irq_event+0x22/0x40
> [10671.578731]  [<c109342e>] ? handle_edge_irq+0x5e/0xf0
> [10671.578743]  [<c1010a10>] ? handle_irq+0x30/0x80
> [10671.578752]  [<c10103f1>] ? do_IRQ+0x31/0xa0
> [10671.578764]  [<c1409bb3>] ? common_interrupt+0x33/0x38
> [10671.578774]  [<c140007b>] ? __ww_mutex_lock_slowpath+0x9e/0x203
> [10976.065431] pps pps0: removed
>
> This is a stock Debian kernel, current as of today in Debian testing.

Regards,
Peter Hurley
