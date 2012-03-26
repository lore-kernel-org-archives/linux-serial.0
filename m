From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: pl011: implement workaround for CTS clear
	event issue
Date: Mon, 26 Mar 2012 09:17:56 +0100
Message-ID: <20120326081756.GI5611@n2100.arm.linux.org.uk>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50624 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab2CZISJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Mar 2012 04:18:09 -0400
Content-Disposition: inline
In-Reply-To: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christophe Arnal <christophe.arnal@stericsson.com>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Matthias Locher <Matthias.Locher@stericsson.com>, Chanho Min <chanho0207@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

On Mon, Mar 26, 2012 at 10:01:08AM +0200, Linus Walleij wrote:
> -	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
> +	unsigned int status;

Why are you removing the pass counter and associated code, which was
there before your work-around patch was applied?
