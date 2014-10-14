From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCHv4] serial: of-serial: fix up PM ops on no_console_suspend
 and port type
Date: Tue, 14 Oct 2014 06:31:05 -0400
Message-ID: <543CFB69.50300@hurleysoftware.com>
References: <1413276146-20388-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:48902 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752778AbaJNKbM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Oct 2014 06:31:12 -0400
In-Reply-To: <1413276146-20388-1-git-send-email-jingchang.lu@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <jingchang.lu@freescale.com>, gregkh@linuxfoundation.org
Cc: arnd@arndb.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 10/14/2014 04:42 AM, Jingchang Lu wrote:
> This patch fixes commit 2dea53bf57783f243c892e99c10c6921e956aa7e,
> "serial: of-serial: add PM suspend/resume support", which disables
> the uart clock on suspend, but also causes a hardware hang on register
> access if no_console_suspend command line option is used.
> 
> Also, not every of_serial device is an 8250 port, so the serial8250
> suspend/resume functions should only be applied to a real 8250 port.

Thanks.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

