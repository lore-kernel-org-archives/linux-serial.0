From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4] tty: serial: men_z135_uart: Fix driver for changes
 in hardware
Date: Mon, 03 Nov 2014 16:01:00 -0500
Message-ID: <5457ED0C.3090705@hurleysoftware.com>
References: <1415030753-26885-1-git-send-email-johannes.thumshirn@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415030753-26885-1-git-send-email-johannes.thumshirn@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Thumshirn <johannes.thumshirn@men.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/03/2014 11:05 AM, Johannes Thumshirn wrote:
> * Enable the handling of UART core's automatic flow control feature.
>   When AFE is active disable generation of modem status IRQs.

So HUPCL doesn't work when CRTSCTS is set?

Is this because there's actually a problem with the IP core that
MSIs trash the autoCTS state, or is the problem that the driver
just shouldn't be calling uart_handle_cts_change() when autoCTS is
on?

Regards,
Peter Hurley
