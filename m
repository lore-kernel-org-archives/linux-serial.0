From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] seria: sirf: only use lookup table to set baudrate
	when ioclk=150MHz
Date: Wed, 26 Dec 2012 15:04:33 +0000
Message-ID: <20121226150433.GB24604@n2100.arm.linux.org.uk>
References: <1356431162-8372-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36968 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab2LZPG1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Dec 2012 10:06:27 -0500
Content-Disposition: inline
In-Reply-To: <1356431162-8372-1-git-send-email-Barry.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: alan@linux.intel.com, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Barry Song <Baohua.Song@csr.com>

On Tue, Dec 25, 2012 at 06:26:02PM +0800, Barry Song wrote:
> @@ -375,7 +375,12 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
>  	int		threshold_div;
>  	int		temp;
>  
> -	ioclk_rate = 150000000;
> +	struct clk *clk = clk_get_sys("io", NULL);
> +	BUG_ON(IS_ERR(clk));

No.  Really, no.  Stop using BUG_ON() as some kind of crappy assert().
BUG_ON() takes the entire kernel out when it fails.  There's absolutely
no need for this what so ever - especially here.

Get the clock at probe or port initialization time.  Save that pointer.
Only give it up when the port is torn down.  And treat it as any other
clock - prepare and enable it, and disable and unprepare it when you're
done with it.

And there's no need to use this clk_get_sys() crap in drivers.  Add the
necessary clkdev entries or deal with it in DT.  Absolutely do not use
clk_get_sys() in drivers; it's there for *PLATFORM* code to use when
there's no other possibility for them and NOT drivers.
