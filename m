From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: Provide capability to disable modem status
 interrupts in 8250 driver
Date: Tue, 4 Jan 2011 13:56:21 +0000
Message-ID: <20110104135621.56a4770e@lxorguk.ukuu.org.uk>
References: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51368 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750897Ab1ADN5a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Jan 2011 08:57:30 -0500
In-Reply-To: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, linux-serial@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org

> This patch was tested using a MityDSP-L138F platform having a UART CTS pin
> connected to a clock signal (and configured, via pinmux, as a clock input
> for another peripheral function).

Please hide such horrors in your platform code. We are trying todrive all
the quirks stuff we can out of the core code.

Instead provide your own I/O methods when registering the port and mask
the appropriate bogus bits in the register.

