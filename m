From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 10:43:54 -0400
Message-ID: <51BB2C2A.9050601@hurleysoftware.com>
References: <kpak75$9ko$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:60778 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752494Ab3FNOnz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 10:43:55 -0400
In-Reply-To: <kpak75$9ko$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On 06/12/2013 04:03 PM, Grant Edwards wrote:
> I see the uart_ops.flush_buffer method which is used to flush the
> UART's tx fifo (presumably when the user calls tcflush(TCOFLUSH)).
>
> How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?

It doesn't.

If you're seeing stale i/o, it's more likely due to the flip buffers
not being flushed (which I think is wrong but I haven't had the
inclination to do all the historical research to fix that).

Regards,
Peter Hurley

