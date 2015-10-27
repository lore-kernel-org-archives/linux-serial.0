From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/8] drivers/tty/: Deinline functions when it saves at
 least 300 bytes per function
Date: Tue, 27 Oct 2015 13:00:05 -0400
Message-ID: <562FAD95.9080600@hurleysoftware.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/27/2015 12:39 PM, Denys Vlasenko wrote:
> Denys Vlasenko (8):
>   tty/cyclades.c: Deinline cyy_readb, save 368 bytes
>   tty/cyclades.c: Deinline cyy_writeb, save 880 bytes
>   tty/cyclades.c: Deinline serial_paranoia_check, save 304 bytes
>   tty/isicom.c: Deinline WaitTillCardIsFree, save 1120 bytes
>   tty/serial/bcm63xx_uart.c: Deinline wait_for_xmitr, save 374 bytes
>   tty/serial/jsm/jsm_neo.c: Deinline neo_parse_isr, save 688 bytes
>   tty/serial/serial_core.c: Deinline uart_update_mctrl, save 304 bytes
>   tty/tty_ldisc.c: Deinline tty_ldisc_put, save 368 bytes
> 
>  drivers/tty/cyclades.c            | 6 +++---
>  drivers/tty/isicom.c              | 2 +-
>  drivers/tty/serial/bcm63xx_uart.c | 2 +-
>  drivers/tty/serial/jsm/jsm_neo.c  | 2 +-
>  drivers/tty/serial/serial_core.c  | 2 +-
>  drivers/tty/tty_ldisc.c           | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

For series,

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
