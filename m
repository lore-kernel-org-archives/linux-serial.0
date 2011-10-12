From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty/serial: Prevent drop of DCD on suspend for Tegra
 UARTs
Date: Wed, 12 Oct 2011 12:56:47 +0100
Message-ID: <20111012125647.6b9ec66e@lxorguk.ukuu.org.uk>
References: <1318377943-24519-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37095 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752747Ab1JLL6u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Oct 2011 07:58:50 -0400
In-Reply-To: <1318377943-24519-1-git-send-email-dianders@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Allen Martin <AMartin@nvidia.com>, Tom Warren <twarren@nvidia.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> NOTE: If we have people that are using UARTA on a Tegra and need to
> control DTR, we'll need to either add a separate port type for UARTA
> or we'll need to add some tegra-specific code to detect whether the
> DTR needs to be left high.

I have two problems with this change

- It adds more special cases into the 8250.c core code
- It breaks the UARTA port (which is a regression so not acceptable for
  upstream merging)

I think you should simply provide your platform with an appropriate
serial_in/serial_out method that does the needed masking. That way its
kept isolated from everyone else.

Alan
