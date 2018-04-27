From: Nathan Royce <nroycea+kernel@gmail.com>
Subject: drivers/tty/serial/samsung.c s3c24xx_uart_copy_rx_to_tty
Date: Fri, 27 Apr 2018 11:41:20 -0500
Message-ID: <CALaQ_hq0CevQY8tUbh4D3-t_RrnmqQuHHN=MjwdsjY+e=rTvFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

No idea why, but I will say that something I've done recently was
re-enabl my ath9k_htc wireless adapter which tends to firmware-panic
quite a bit which also sometimes kills off my ppp usb adapter.
I have a script running that monitors the journalctl and restarts
hostapd everytime my ath device firmware-panics and comes back alive.
Same with netctl for my ppp.

The first time I've noticed this particular issue was yesterday when
my ssh session became sluggish and I was eventually forced to pull
power from my odroid. I only have 4 cores enabled, otherwise the usb
issues increase.
I cobbled together a setup with my ATX power supply providing power to
everything (including usb devices and hubs).
*****
Apr 27 10:27:39 computername kernel: [<c041fc38>]
(s3c64xx_serial_handle_irq) from [<c016da24>]
(__handle_irq_event_percpu+0x50/0x11c)
Apr 27 10:28:42 computername systemd-journald[22668]: Missed 5173
kernel messages
Apr 27 10:28:42 computername kernel: CPU: 0 PID: 99 Comm: mmcqd/1
Tainted: G      D W       4.14.0-dirty #6
Apr 27 10:28:42 computername kernel: Hardware name: SAMSUNG EXYNOS
(Flattened Device Tree)
Apr 27 10:28:42 computername kernel: [<c010f428>] (unwind_backtrace)
from [<c010ba74>] (show_stack+0x10/0x14)
Apr 27 10:28:42 computername kernel: [<c010ba74>] (show_stack) from
[<c0731e9c>] (dump_stack+0x88/0x9c)
Apr 27 10:28:42 computername kernel: [<c0731e9c>] (dump_stack) from
[<c011cab8>] (__warn+0xe8/0x100)
Apr 27 10:28:42 computername kernel: [<c011cab8>] (__warn) from
[<c011cbc8>] (warn_slowpath_null+0x20/0x28)
Apr 27 10:28:42 computername kernel: [<c011cbc8>] (warn_slowpath_null)
from [<c041f814>] (s3c24xx_uart_copy_rx_to_tty+0xa0/0xd4)
Apr 27 10:28:42 computername kernel: [<c041f814>]
(s3c24xx_uart_copy_rx_to_tty) from [<c041fb84>]
(s3c24xx_serial_rx_chars+0x14c/0x1b8)
Apr 27 10:28:42 computername kernel: [<c041fb84>]
(s3c24xx_serial_rx_chars) from [<c041fc38>]
(s3c64xx_serial_handle_irq+0x48/0x60)
Apr 27 10:28:42 computername kernel: [<c041fc38>]
(s3c64xx_serial_handle_irq) from [<c016da24>]
(__handle_irq_event_percpu+0x50/0x11c)
Apr 27 10:28:42 computername kernel: [<c016da24>]
(__handle_irq_event_percpu) from [<c016db1c>]
(handle_irq_event_percpu+0x2c/0x7c)
Apr 27 10:28:42 computername kernel: [<c016db1c>]
(handle_irq_event_percpu) from [<c016dba4>]
(handle_irq_event+0x38/0x5c)
Apr 27 10:28:42 computername kernel: [<c016dba4>] (handle_irq_event)
from [<c0171448>] (handle_fasteoi_irq+0xa4/0x158)
Apr 27 10:28:42 computername kernel: [<c0171448>] (handle_fasteoi_irq)
from [<c016cda0>] (generic_handle_irq+0x24/0x34)
Apr 27 10:28:42 computername kernel: [<c016cda0>] (generic_handle_irq)
from [<c016d2b8>] (__handle_domain_irq+0x5c/0xb4)
Apr 27 10:28:42 computername kernel: [<c016d2b8>]
(__handle_domain_irq) from [<c01014d8>] (gic_handle_irq+0x3c/0x78)
Apr 27 10:28:42 computername kernel: [<c01014d8>] (gic_handle_irq)
from [<c010c78c>] (__irq_svc+0x6c/0x90)
Apr 27 10:28:42 computername kernel: Exception stack(0xede8baf8 to 0xede8bb40)
Apr 27 10:28:42 computername kernel: bae0:
                          ede8bcf4 ede98c80
Apr 27 10:28:42 computername kernel: bb00: 00000000 00000002 a00c0113
eddfec00 ede8bce0 00000000 ee20f904 ede8bd58
Apr 27 10:28:42 computername kernel: bb20: 00000100 c0c02080 c0801550
ede8bb48 c074c7dc c074c7e0 600c0113 ffffffff
Apr 27 10:28:42 computername kernel: [<c010c78c>] (__irq_svc) from
[<c074c7e0>] (_raw_spin_unlock_irqrestore+0x10/0x14)
Apr 27 10:28:42 computername kernel: [<c074c7e0>]
(_raw_spin_unlock_irqrestore) from [<c05aecb0>]
(dw_mci_request_end+0xa8/0xdc)
Apr 27 10:28:42 computername kernel: [<c05aecb0>] (dw_mci_request_end)
from [<c05af000>] (dw_mci_tasklet_func+0x31c/0x3dc)
Apr 27 10:28:42 computername kernel: [<c05af000>]
(dw_mci_tasklet_func) from [<c0121808>] (tasklet_action+0x7c/0x118)
Apr 27 10:28:42 computername kernel: [<c0121808>] (tasklet_action)
from [<c01015f8>] (__do_softirq+0xe0/0x248)
Apr 27 10:28:42 computername kernel: [<c01015f8>] (__do_softirq) from
[<c0121bf8>] (irq_exit+0xd8/0x140)
Apr 27 10:28:42 computername kernel: [<c0121bf8>] (irq_exit) from
[<c016d2bc>] (__handle_domain_irq+0x60/0xb4)
Apr 27 10:28:42 computername kernel: [<c016d2bc>]
(__handle_domain_irq) from [<c01014d8>] (gic_handle_irq+0x3c/0x78)
Apr 27 10:28:42 computername kernel: [<c01014d8>] (gic_handle_irq)
from [<c010c78c>] (__irq_svc+0x6c/0x90)
Apr 27 10:28:42 computername kernel: Exception stack(0xede8bc28 to 0xede8bc70)
Apr 27 10:28:42 computername kernel: bc20:                   ede8bcf4
ede98c80 00000000 00000001 7fffffff ede8bcf4
Apr 27 10:28:42 computername kernel: bc40: ede8a000 00000002 00000000
c0c05448 00000000 ede8bcf0 00000100 ede8bc78
Apr 27 10:28:42 computername kernel: bc60: c074c7ec c074c7f0 600c0013 ffffffff
Apr 27 10:28:42 computername kernel: [<c010c78c>] (__irq_svc) from
[<c074c7f0>] (_raw_spin_unlock_irq+0xc/0x10)
Apr 27 10:28:42 computername kernel: [<c074c7f0>]
(_raw_spin_unlock_irq) from [<c0748324>] (wait_for_common+0xa0/0x168)
Apr 27 10:28:42 computername kernel: [<c0748324>] (wait_for_common)
from [<c05921b0>] (mmc_wait_for_req_done+0x8c/0x110)
Apr 27 10:28:42 computername kernel: [<c05921b0>]
(mmc_wait_for_req_done) from [<c0592e34>] (mmc_wait_for_cmd+0x68/0x9c)
Apr 27 10:28:42 computername kernel: [<c0592e34>] (mmc_wait_for_cmd)
from [<c0598de4>] (__mmc_send_status+0x68/0x98)
Apr 27 10:28:42 computername kernel: [<c0598de4>] (__mmc_send_status)
from [<c05a0fac>] (card_busy_detect+0x64/0x150)
Apr 27 10:28:42 computername kernel: [<c05a0fac>] (card_busy_detect)
from [<c05a2378>] (mmc_blk_err_check+0x180/0x5bc)
Apr 27 10:28:42 computername kernel: [<c05a2378>] (mmc_blk_err_check)
from [<c05929d4>] (mmc_start_areq+0xb0/0x3bc)
Apr 27 10:28:42 computername kernel: [<c05929d4>] (mmc_start_areq)
from [<c05a35f4>] (mmc_blk_issue_rw_rq+0xb8/0x39c)
Apr 27 10:28:42 computername kernel: [<c05a35f4>]
(mmc_blk_issue_rw_rq) from [<c05a3ec0>] (mmc_blk_issue_rq+0x1a4/0x844)
Apr 27 10:28:42 computername kernel: [<c05a3ec0>] (mmc_blk_issue_rq)
from [<c05a4624>] (mmc_queue_thread+0xc4/0x164)
Apr 27 10:28:42 computername kernel: [<c05a4624>] (mmc_queue_thread)
from [<c0139b18>] (kthread+0x14c/0x154)
Apr 27 10:28:42 computername kernel: [<c0139b18>] (kthread) from
[<c0107e50>] (ret_from_fork+0x14/0x24)
Apr 27 10:28:42 computername kernel: ---[ end trace 2f940e396221e98e ]---
Apr 27 10:28:42 computername kernel: samsung-uart 12c20000.serial:
RxData copy to tty layer failed
Apr 27 10:28:42 computername kernel: ------------[ cut here ]------------
Apr 27 10:28:42 computername kernel: WARNING: CPU: 0 PID: 21972 at
drivers/tty/serial/samsung.c:381 s3c24xx_uart_copy_rx_to_tty+0xa0/0xd4
Apr 27 10:28:42 computername kernel: Modules linked in: tun cmac ccm
md5 ppp_deflate ppp_async arc4 ppp_generic slhc ath9k_htc ath9k_common
ath9k_hw ath mac80211 cfg80211 option usb_wwan rfkill hid_logitech_dj
usbserial bridge stp llc nf_log_ipv6 ip6table_filter ip6t_MASQUERADE
n>
Apr 27 10:28:42 computername kernel:  dvb_core videobuf2_v4l2 videodev
videobuf2_core nfsd auth_rpcgss oid_registry nfs_acl lockd grace
sunrpc crypto_user ip_tables x_tables
Apr 27 10:28:42 computername kernel: CPU: 0 PID: 21972 Comm:
kworker/0:1 Tainted: G      D W       4.14.0-dirty #6
Apr 27 10:28:42 computername kernel: Hardware name: SAMSUNG EXYNOS
(Flattened Device Tree)
Apr 27 10:28:42 computername kernel: Workqueue: events dbs_work_handler
Apr 27 10:28:42 computername kernel: [<c010f428>] (unwind_backtrace)
from [<c010ba74>] (show_stack+0x10/0x14)
Apr 27 10:28:42 computername kernel: [<c010ba74>] (show_stack) from
[<c0731e9c>] (dump_stack+0x88/0x9c)
Apr 27 10:28:42 computername kernel: [<c0731e9c>] (dump_stack) from
[<c011cab8>] (__warn+0xe8/0x100)
Apr 27 10:28:42 computername kernel: [<c011cab8>] (__warn) from
[<c011cbc8>] (warn_slowpath_null+0x20/0x28)
Apr 27 10:28:42 computername kernel: [<c011cbc8>] (warn_slowpath_null)
from [<c041f814>] (s3c24xx_uart_copy_rx_to_tty+0xa0/0xd4)
Apr 27 10:28:42 computername kernel: [<c041f814>]
(s3c24xx_uart_copy_rx_to_tty) from [<c041fb84>]
(s3c24xx_serial_rx_chars+0x14c/0x1b8)
Apr 27 10:28:42 computername kernel: [<c041fb84>]
(s3c24xx_serial_rx_chars) from [<c041fc38>]
(s3c64xx_serial_handle_irq+0x48/0x60)
Apr 27 10:28:42 computername kernel: [<c041fc38>]
(s3c64xx_serial_handle_irq) from [<c016da24>]
(__handle_irq_event_percpu+0x50/0x11c)
Apr 27 10:28:42 computername kernel: [<c016da24>]
(__handle_irq_event_percpu) from [<c016db1c>]
(handle_irq_event_percpu+0x2c/0x7c)
Apr 27 10:28:42 computername kernel: [<c016db1c>]
(handle_irq_event_percpu) from [<c016dba4>]
(handle_irq_event+0x38/0x5c)
Apr 27 10:28:42 computername kernel: [<c016dba4>] (handle_irq_event)
from [<c0171448>] (handle_fasteoi_irq+0xa4/0x158)
Apr 27 10:28:42 computername kernel: [<c0171448>] (handle_fasteoi_irq)
from [<c016cda0>] (generic_handle_irq+0x24/0x34)
Apr 27 10:28:42 computername kernel: [<c016cda0>] (generic_handle_irq)
from [<c016d2b8>] (__handle_domain_irq+0x5c/0xb4)
Apr 27 10:28:42 computername kernel: [<c016d2b8>]
(__handle_domain_irq) from [<c01014d8>] (gic_handle_irq+0x3c/0x78)
Apr 27 10:28:42 computername kernel: [<c01014d8>] (gic_handle_irq)
from [<c010c78c>] (__irq_svc+0x6c/0x90)
Apr 27 10:28:42 computername kernel: Exception stack(0xdd101db0 to 0xdd101df8)
Apr 27 10:28:42 computername kernel: 1da0:
        d35fdb77 00000000 c0c055d4 f080e000
Apr 27 10:28:42 computername kernel: 1dc0: c0c85640 036b7fbe 2e241000
00000002 c0c055d4 0000005f fd5c0698 00003172
Apr 27 10:28:42 computername kernel: 1de0: 00000002 dd101e00 c0182644
c05b4e5c 600c0013 ffffffff
Apr 27 10:28:42 computername kernel: [<c010c78c>] (__irq_svc) from
[<c05b4e5c>] (exynos4_frc_read+0x14/0x18)
Apr 27 10:28:42 computername kernel: [<c05b4e5c>] (exynos4_frc_read)
from [<c0182644>] (ktime_get+0x44/0xdc)
Apr 27 10:28:42 computername kernel: [<c0182644>] (ktime_get) from
[<c0190c60>] (get_cpu_idle_time_us+0x48/0x140)
Apr 27 10:28:42 computername kernel: [<c0190c60>]
(get_cpu_idle_time_us) from [<c058a9c4>]
(get_cpu_idle_time+0x48/0x18c)
Apr 27 10:28:42 computername kernel: [<c058a9c4>] (get_cpu_idle_time)
from [<c058e28c>] (dbs_update+0xa8/0x25c)
Apr 27 10:28:42 computername kernel: [<c058e28c>] (dbs_update) from
[<c058da80>] (od_dbs_update+0x48/0x160)
Apr 27 10:28:42 computername kernel: [<c058da80>] (od_dbs_update) from
[<c058e0f4>] (dbs_work_handler+0x2c/0x54)
Apr 27 10:28:42 computername kernel: [<c058e0f4>] (dbs_work_handler)
from [<c0133e6c>] (process_one_work+0x1d8/0x404)
Apr 27 10:28:42 computername kernel: [<c0133e6c>] (process_one_work)
from [<c0134c18>] (worker_thread+0x50/0x598)
Apr 27 10:28:42 computername kernel: [<c0134c18>] (worker_thread) from
[<c0139b18>] (kthread+0x14c/0x154)
Apr 27 10:28:42 computername kernel: [<c0139b18>] (kthread) from
[<c0107e50>] (ret_from_fork+0x14/0x24)
Apr 27 10:28:42 computername kernel: ---[ end trace 2f940e396221e98f ]---
*****
