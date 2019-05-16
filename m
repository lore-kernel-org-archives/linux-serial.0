From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Date: Thu, 16 May 2019 20:22:12 +0530
Message-ID: <CAKfKVtG5zKZDGK68pY9t1Xupr-Ak+bWK0jRBwxCZ2e=TG8NEpA@mail.gmail.com>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516040931.16276-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: jacmet@sunsite.dk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi YueHaibing,
Thanks for the patch.

On Thu, May 16, 2019 at 9:42 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> If ulite_probe is not called or failed to registed
s/registed/register
> uart_register_driver, unload the module will call
> uart_unregister_driver, which will tigger NULL
s/tigger/trigger
> pointer dereference like this:
>
> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
>
> CPU: 0 PID: 4246 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #26
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>  dump_stack+0xa9/0x10e
>  ? tty_unregister_driver+0x19/0x100
>  ? tty_unregister_driver+0x19/0x100
>  __kasan_report+0x171/0x18d
>  ? tty_unregister_driver+0x19/0x100
>  kasan_report+0xe/0x20
>  tty_unregister_driver+0x19/0x100
>  uart_unregister_driver+0x30/0xc0
>  __x64_sys_delete_module+0x244/0x330
>  ? __ia32_sys_delete_module+0x330/0x330
>  ? __x64_sys_clock_gettime+0xe3/0x160
>  ? trace_hardirqs_on_thunk+0x1a/0x1c
>  ? trace_hardirqs_off_caller+0x3e/0x130
>  ? lockdep_hardirqs_off+0xb5/0x100
>  ? mark_held_locks+0x1a/0x90
>  ? do_syscall_64+0x14/0x2a0
>  do_syscall_64+0x72/0x2a0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> This patch fix this by moving uart_unregister_driver
> to ulite_remove.
>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/tty/serial/uartlite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index b8b912b..2e49fb6 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       uart_unregister_driver(&ulite_uart_driver);
>         return rc;
>  }
>
> @@ -897,7 +898,6 @@ static int __init ulite_init(void)
>  static void __exit ulite_exit(void)
>  {
>         platform_driver_unregister(&ulite_platform_driver);
> -       uart_unregister_driver(&ulite_uart_driver);
>  }
>
>  module_init(ulite_init);
> --
> 1.8.3.1
>
>
