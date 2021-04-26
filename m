Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E159C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0127261007
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 16:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhDZQSc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234229AbhDZQSc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E58CF61131;
        Mon, 26 Apr 2021 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619453870;
        bh=Vg7NsLqhVvyWjB6uIqGWiDftBlhQvk42ntCP6iU+jzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxZVpuUuwssCT/T3XGnCbB7025lIEKbfSEoS/sjk3tiLd7526vkjm9F6NLgabRa69
         TuJv6kGikyRjsE6dFFukoS7RoRYBF9ho5H49nK7H7uEYA5IZb/yGntYYiuk37yqe1N
         cEv8MoN2zBRKccQffyLX8Dta7OMuMjmZoK2lZgPU=
Date:   Mon, 26 Apr 2021 18:17:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-serial@vger.kernel.org,
        syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com,
        syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Hurley <peter@hurleysoftware.com>,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] serial: 8250: fix NULL pointer dereference in
 serial8250_do_startup()
Message-ID: <YIbnq2ljdQzaN8gy@kroah.com>
References: <00000000000044a65205994a7e13@google.com>
 <20210426161433.20829-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426161433.20829-1-vegard.nossum@oracle.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 06:14:33PM +0200, Vegard Nossum wrote:
> Syzbot reported a crash, here reproduced on a recent mainline kernel:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000005
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 120cf067 P4D 120cf067 PUD 135d4067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 2 PID: 4830 Comm: a.out Not tainted 5.12.0-rc7+ #209
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
>   RIP: 0010:mem16_serial_in+0x83/0xa0
>   [...]
>     Call Trace:
>     serial8250_do_startup+0x475/0x1e40
>     serial8250_startup+0x5c/0x80
>     uart_startup+0x360/0x870
>     uart_set_info_user+0x13a3/0x1c30
>     tty_ioctl+0x711/0x14f0
>     __x64_sys_ioctl+0x193/0x200
>     do_syscall_64+0x2d/0x70
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> A more readable reproducer is:
> 
>   #include <sys/ioctl.h>
>   #include <fcntl.h>
> 
>   #include <linux/serial.h>
> 
>   #ifndef SERIAL_IO_MEM16
>   #define SERIAL_IO_MEM16 7
>   #endif
> 
>   int main(int argc, char *argv[])
>   {
>           int fd = open("/dev/ttyS3", O_RDONLY);
> 
>           struct serial_struct ss = {};
>           ss.type = 0x10;
>           ss.baud_base = 0x7fffffff;
>           ss.io_type = SERIAL_IO_MEM16;
>           ioctl(fd, TIOCSSERIAL, &ss);
> 
>           return 0;
>   }
> 
> ioctl(TIOCSSERIAL) attempts to configure the serial port, but when
> requesting io_type SERIAL_IO_MEM*/UPIO_MEM* it goes on to dereference
> ->membase in serial8250_do_startup().
> 
> I propose this fix, which will fail validation of the TIOCSSERIAL request
> if you request a memory-based or io-based io_type when the underlying port
> has no valid ->membase or ->iobase, respectively.
> 
> As far as I can tell, this driver was written to support being able to
> switch between the two IO types for a given port (assuming the underlying
> driver supports it); see serial8250_do_startup()/set_io_from_upio().
> 
> I'm also adding a couple of WARN_ON_ONCE()s which are technically
> redundant, but which could help somebody else if they come across a
> similar issue in the future.
> 
> Reported-by: syzbot+4c7f1a69dfe24c6b3aeb@syzkaller.appspotmail.com
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index b0af13074cd36..aec3abff8e48e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -455,6 +455,33 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
>  
>  static int serial8250_default_handle_irq(struct uart_port *port);
>  
> +static int needs_membase(int iotype)
> +{
> +	switch (iotype) {
> +	case UPIO_MEM:
> +	case UPIO_MEM16:
> +	case UPIO_MEM32:
> +	case UPIO_MEM32BE:
> +#ifdef CONFIG_SERIAL_8250_RT288X
> +	case UPIO_AU:
> +#endif
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int needs_iobase(int iotype)
> +{
> +	switch (iotype) {
> +	case UPIO_HUB6:
> +	case UPIO_PORT:
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static void set_io_from_upio(struct uart_port *p)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(p);
> @@ -2151,6 +2178,11 @@ int serial8250_do_startup(struct uart_port *port)
>  	unsigned char lsr, iir;
>  	int retval;
>  
> +	if (WARN_ON_ONCE(needs_membase(port->iotype) && !port->membase))
> +		return -ENODEV;
> +	if (WARN_ON_ONCE(needs_iobase(port->iotype) && !port->iobase))
> +		return -ENODEV;

These WARN_ON() will still trigger syzbot.  Are you sure you tested this
and had syzbot verify it?

thanks,

greg k-h
