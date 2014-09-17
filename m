From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: [PATCH v3] tty: serial: men_z135_uart: Fix driver for changes in
 hardware
Date: Wed, 17 Sep 2014 12:54:33 +0200
Message-ID: <20140917105432.GA17369@jtlinux>
References: <1410845068-2954-1-git-send-email-johannes.thumshirn@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410845068-2954-1-git-send-email-johannes.thumshirn@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@men.de>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 16, 2014 at 07:24:28AM +0200, Johannes Thumshirn wrote:
> 16z135 IP Core has changed so the driver needs to be updated to respect
> these changes. The following changes have been made:
>
> * Don't invert the 16z135 modem status register when reading.
> * Add module parameter to configure the (baud rate dependent) RX timeout.
>   Character timeout in seconds = (timeout_reg * baud_reg * 4)/freq_reg.
> * Enable the handling of UART core's automatic flow control feature.
>   When AFE is active disable generation of modem status IRQs.
> * Rework the handling of IRQs to be conform with newer FPGA versions and
>   take precautions not to miss an interrupt because of the destructive read
>   of the IIR register.
> * Correct men_z135_handle_modem_status(), MSR is stat_reg[15:8] not
>   stat_reg[7:0]
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> ---
> Changes to v1:
> Incorporated comments of Jiri Slaby:
>
> * Timeout value is documented in module parameter description
> * rx_timeout variable is uint
> * Changed IRQ handled variable to bool
> * Changed if statement for RDA or CTI IRQ
>
> Changes to v2:
> Correct men_z135_handle_modem_status(), MSR is stat_reg[15:8] not stat_reg[7:0]

We've found a bug in this patch during our tests so please do not en-queue it yet.

Sorry for the inconvenience.

Thanks,
Johannes
