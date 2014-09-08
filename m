From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/2] tty: serial: 8250: Add Mediatek UART driver
Date: Mon, 8 Sep 2014 15:32:49 -0700
Message-ID: <20140908223249.GA26114@kroah.com>
References: <1407852737-17265-1-git-send-email-matthias.bgg@gmail.com>
 <1407852737-17265-2-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407852737-17265-2-git-send-email-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, jslaby@suse.cz, grant.likely@linaro.org, alan@linux.intel.com, varkabhadram@gmail.com, tklauser@distanz.ch, heiko@sntech.de, yingjoe.chen@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 12, 2014 at 04:12:16PM +0200, Matthias Brugger wrote:
> The device has a highspeed register which influences the calcualtion of the
> divisor. The chip lacks support for some baudrates. When requested, we set the
> divisor to the next smaller baudrate and adjust the c_cflag accordingly.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c |  294 ++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |    7 +
>  drivers/tty/serial/8250/Makefile   |    1 +
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_mtk.c

This doesn't apply to my tree, care to refresh it against linux-next and
resend?

thanks,

greg k-h
