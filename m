From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v5] tty: serial: men_z135_uart: Fix driver for changes
 in hardware
Date: Sun, 25 Jan 2015 16:17:27 -0500
Message-ID: <54C55D67.8060503@hurleysoftware.com>
References: <1421649881-2275-1-git-send-email-johannes.thumshirn@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421649881-2275-1-git-send-email-johannes.thumshirn@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Thumshirn <johannes.thumshirn@men.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/19/2015 01:44 AM, Johannes Thumshirn wrote:
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
> * Correct calling of uart_handle_{dcd,cts}_change()
> * Reset CLOCAL when CRTSCTS is set

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
