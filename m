From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 2/7] ARM: meson: serial: add MesonX SoC on-chip uart
 driver
Date: Sat, 6 Sep 2014 20:28:04 +0200
Message-ID: <20140906182804.GA14240@nuc>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-3-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35725 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbaIFS2L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Sep 2014 14:28:11 -0400
Content-Disposition: inline
In-Reply-To: <1408272594-10814-3-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com

On dom, ago 17, 2014 at 12:49:49 +0200, Carlo Caione wrote:
> The SoC has four fully functional UARTs which use the same programming
> model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
> which cannot be powered off.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---

Ping

-- 
Carlo Caione
