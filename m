From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 12/13] serial: 8250_early: Use port->regshift
Date: Tue, 28 Apr 2015 13:38:36 +0200
Message-ID: <20150428113836.GA5838@kroah.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1428515119-25248-13-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428515119-25248-13-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 08, 2015 at 01:45:18PM -0400, Peter Hurley wrote:
> earlycon initializes struct uart_port::regshift to the correct
> value for UPIO_MEM32 already. Use the port field rather than
> hard-coded value.
> 
> This enables broader support for various i/o access methods in
> 8250 earlycon (eg., omap8250 earlycon).
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This patch fails to apply to my tty-testing branch.  Can you refresh it
and resend this one, and patch 13/13 so that I can apply them?

thanks,

greg k-h
