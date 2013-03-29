From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: make[2]: *** No rule to make target
 `drivers/serial/serial_core.c', needed by
 `Documentation/DocBook/kernel-api.xml'.
Date: Fri, 29 Mar 2013 09:51:15 -0700
Message-ID: <20130329165115.GA26331@kroah.com>
References: <5153256d.SyZXdcYq+1mLl7KI%fengguang.wu@intel.com>
 <20130328010012.GA14108@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130328010012.GA14108@localhost>
Sender: linux-doc-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: serial <linux-serial@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 28, 2013 at 09:00:12AM +0800, Fengguang Wu wrote:
> 
> Hi Greg,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
> commit: ab4382d27412e7e3e7c936e8d50d8888dfac3df8 tty: move drivers/serial/ to drivers/tty/serial/
> date:   2 years, 2 months ago
> config: make ARCH=x86_64 allmodconfig
> 
> All error/warnings:
> 
>    make[2]: *** No rule to make target `kernel/sched/core.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `kernel/sched/cpupri.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `kernel/sched/fair.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `drivers/base/syscore.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `drivers/base/dma-buf.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `drivers/base/fence.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `include/linux/fence.h', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `drivers/base/reservation.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `include/linux/reservation.h', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `drivers/tty/serial/8250/8250.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `include/linux/hsi/hsi.h', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `drivers/hsi/hsi.c', needed by `Documentation/DocBook/device-drivers.xml'.
>    make[2]: *** No rule to make target `arch/x86/include/asm/io_32.h', needed by `Documentation/DocBook/deviceiobook.xml'.
>    make[2]: *** No rule to make target `drivers/gpu/drm/drm_dp_helper.c', needed by `Documentation/DocBook/drm.xml'.
>    make[2]: *** No rule to make target `arch/x86/include/asm/atomic_32.h', needed by `Documentation/DocBook/kernel-api.xml'.
>    make[2]: *** No rule to make target `block/blk-barrier.c', needed by `Documentation/DocBook/kernel-api.xml'.
>    make[2]: *** No rule to make target `block/blktrace.c', needed by `Documentation/DocBook/kernel-api.xml'.
> >> make[2]: *** No rule to make target `drivers/serial/serial_core.c', needed by `Documentation/DocBook/kernel-api.xml'.
> >> make[2]: *** No rule to make target `drivers/serial/8250.c', needed by `Documentation/DocBook/kernel-api.xml'.
>    make[2]: *** No rule to make target `drivers/net/wan/syncppp.c', needed by `Documentation/DocBook/networking.xml'.
>    make[2]: *** No rule to make target `arch/powerpc/kernel/rio.c', needed by `Documentation/DocBook/rapidio.xml'.
>    make[2]: Target `htmldocs' not remade because of errors.

I can't duplicate this on my tree, sorry.

greg k-h
