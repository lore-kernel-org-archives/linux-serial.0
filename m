From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: USB-serial console and lockdep
Date: Wed, 31 Dec 2014 21:07:59 -0500
Message-ID: <54A4ABFF.5000304@hurleysoftware.com>
References: <20141118161833.GA22786@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141118161833.GA22786@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Johan,

On 11/18/2014 11:18 AM, Johan Hovold wrote:
> I get this missing-lockdep-annotation warning which I haven't seen
> before when booting with a usb-serial console on 3.18-rc5. It's been a
> while since I last tested this, though, and the tty_ldisc_ref wasn't
> introduced until 833efc0ed19c ("USB: serial: invoke dcd_change ldisc's
> handler.").

Sorry it took me so long to finally look at this -- at least I'm looking
at it in the same year ;)  (in my tzone anyway)

Is this easily reproducible?

Because for lockdep to be trying to register the ldsem lock class
from the tty_ldisc_ref() means that no tty has yet been opened [see 1].
So how did the call to tty_port_tty_get() in pl2303_update_line_status()
return a tty?

If you can easily reproduce this, I can supply you with a debug patch
to find out what's going on.

Regards,
Peter Hurley 

> [   10.575225] usbserial: USB Serial support registered for pl2303
> [   10.575561] pl2303 1-2.1:1.0: pl2303 converter detected
> [   10.627563] usb 1-2.1: pl2303 converter now attached to ttyUSB0
> [   10.650939] INFO: trying to register non-static key.
> [   10.651000] the code is fine but needs lockdep annotation.
> [   10.651000] turning off the locking correctness validator.
> [   10.651031] CPU: 0 PID: 68 Comm: udevd Tainted: G        W      3.18.0-rc5 #10
> [   10.651092] [<c0016f04>] (unwind_backtrace) from [<c0013978>] (show_stack+0x20/0x24)
> [   10.651123] [<c0013978>] (show_stack) from [<c0449794>] (dump_stack+0x24/0x28)
> [   10.651184] [<c0449794>] (dump_stack) from [<c006f730>] (__lock_acquire+0x1e50/0x2004)
> [   10.651214] [<c006f730>] (__lock_acquire) from [<c0070128>] (lock_acquire+0xe4/0x18c)
> [   10.651245] [<c0070128>] (lock_acquire) from [<c027c6f8>] (ldsem_down_read_trylock+0x78/0x90)
> [   10.651275] [<c027c6f8>] (ldsem_down_read_trylock) from [<c027a1cc>] (tty_ldisc_ref+0x24/0x58)
> [   10.651306] [<c027a1cc>] (tty_ldisc_ref) from [<c0340760>] (usb_serial_handle_dcd_change+0x48/0xe8)
> [   10.651367] [<c0340760>] (usb_serial_handle_dcd_change) from [<bf000484>] (pl2303_read_int_callback+0x210/0x220 [pl2303])
> [   10.651428] [<bf000484>] (pl2303_read_int_callback [pl2303]) from [<c031624c>] (__usb_hcd_giveback_urb+0x80/0x140)
> [   10.651458] [<c031624c>] (__usb_hcd_giveback_urb) from [<c0316fc0>] (usb_giveback_urb_bh+0x98/0xd4)
> [   10.651489] [<c0316fc0>] (usb_giveback_urb_bh) from [<c0042e44>] (tasklet_hi_action+0x9c/0x108)
> [   10.651519] [<c0042e44>] (tasklet_hi_action) from [<c0042380>] (__do_softirq+0x148/0x42c)
> [   10.651550] [<c0042380>] (__do_softirq) from [<c00429cc>] (irq_exit+0xd8/0x114)
> [   10.651580] [<c00429cc>] (irq_exit) from [<c007ae58>] (__handle_domain_irq+0x84/0xdc)
> [   10.651611] [<c007ae58>] (__handle_domain_irq) from [<c000879c>] (omap_intc_handle_irq+0xd8/0xe0)
> [   10.651641] [<c000879c>] (omap_intc_handle_irq) from [<c0014544>] (__irq_svc+0x44/0x7c)
> [   10.651641] Exception stack(0xdf4e7f08 to 0xdf4e7f50)
> [   10.651672] 7f00:                   debc0b80 df4e7f5c 00000000 00000000 debc0b80 be8da96c
> [   10.651702] 7f20: 00000000 00000128 c000fc84 df4e6000 00000000 df4e7f94 00000004 df4e7f50
> [   10.651702] 7f40: c038ebc0 c038d74c 600f0013 ffffffff
> [   10.651733] [<c0014544>] (__irq_svc) from [<c038d74c>] (___sys_sendmsg.part.29+0x0/0x2e0)
> [   10.651763] [<c038d74c>] (___sys_sendmsg.part.29) from [<c038ec08>] (SyS_sendmsg+0x18/0x1c)
> [   10.651794] [<c038ec08>] (SyS_sendmsg) from [<c000fa00>] (ret_fast_syscall+0x0/0x48)
> [   10.692871] console [ttyUSB0] enabled


[1] Call tree for registering the ldsem lock class

tty_open
  tty_init_dev
    alloc_tty_struct
      init_ldsem (macro in include/linux/tty_ldisc.h)
        * the static lock_class_key is expanded here *
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
