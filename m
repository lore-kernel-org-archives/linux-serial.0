From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] serial: mxs-auart: ctrl removed from mxs_auart_port
Date: Sat, 27 Sep 2014 11:03:46 +0100
Message-ID: <20140927100345.GB5182@n2100.arm.linux.org.uk>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl> <1411811197-12638-2-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:44749 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752031AbaI0KEB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 06:04:01 -0400
Content-Disposition: inline
In-Reply-To: <1411811197-12638-2-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

On Sat, Sep 27, 2014 at 11:46:34AM +0200, Janusz Uzycki wrote:
> The ctrl variable duplicated mctrl, member of uart_port structure
> in serial_core.h.
> The code duplicated uart_update_mctrl() and uart_tiocmget()
> in serial_core.c.
> mxs_auart_get_mctrl() reads back RTS line. It could be removed too
> but not sure.

The only thing which the .get_mctrl method is supposed to do is to return
the state of the /input/ lines, which are CTS, DCD, DSR, RI.  The output
line state is stored in port->mctrl, and is added to the returned value
by serial_core when it's required.  RTS output state should not be
returned from the .get_mctrl method.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
