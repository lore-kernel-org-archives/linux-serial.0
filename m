From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Fri, 16 Aug 2013 22:29:52 +0530
Message-ID: <CAKohpon9VQcfJ8_QcktS52jVyzVPdzBCC7X5PqAMxMHGunrwyg@mail.gmail.com>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
	<520E15C2.7030108@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:59094 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3HPQ7x (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 12:59:53 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so2567514oag.13
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 09:59:53 -0700 (PDT)
In-Reply-To: <520E15C2.7030108@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 16 August 2013 17:36, Peter Hurley <peter@hurleysoftware.com> wrote:
> Please include the lockdep warning in the changelog.

Sure.. For now it is here, will include it in V2..

 ======================================================
 [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
 3.10.6-linaro-arndale #1 Not tainted
 ------------------------------------------------------
 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (&(&(&bank->slock)->lock)->wait_lock){+.+...}, at: [<8068ba2c>]
rt_spin_lock_slowlock+0x54/0x2f8

 and this task is already holding:
 (&irq_desc_lock_class){-.....}, at: [<800bbe18>] __setup_irq+0x94/0x4c4
 which would create a new lock dependency:
 (&irq_desc_lock_class){-.....} -> (&(&(&bank->slock)->lock)->wait_lock){+.+...}

 but this new dependency connects a HARDIRQ-irq-safe lock:
 (&irq_desc_lock_class){-.....}
 ... which became HARDIRQ-irq-safe at:
 [<8008ffa0>] mark_lock+0x180/0x808
 [<80092a38>] __lock_acquire+0xb5c/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<800bdb10>] handle_fasteoi_irq+0x24/0x15c
 [<800b9c8c>] generic_handle_irq+0x34/0x44
 [<8002007c>] handle_IRQ+0x50/0xa0
 [<800085d8>] gic_handle_irq+0x48/0x78
 [<8001f1c4>] __irq_svc+0x44/0x8c
 [<800204a4>] arch_cpu_idle+0x40/0x4c
 [<800815f8>] cpu_startup_entry+0x1a4/0x2dc
 [<8067b780>] rest_init+0xdc/0xec
 [<80910c34>] start_kernel+0x428/0x434
 [<40008084>] 0x40008084

 to a HARDIRQ-irq-unsafe lock:
 (&(&(&bank->slock)->lock)->wait_lock){+.+...}
 ... which became HARDIRQ-irq-unsafe at:
 ... [<8008ffa0>] mark_lock+0x180/0x808
 [<80092498>] __lock_acquire+0x5bc/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<8068ba2c>] rt_spin_lock_slowlock+0x54/0x2f8
 [<8068c42c>] rt_spin_lock+0x3c/0x68
 [<803d0594>] samsung_pinconf_rw+0xc8/0x14c
 [<803d06dc>] samsung_pinconf_group_set+0x70/0x90
 [<803cf864>] pinconf_apply_setting+0x90/0x198
 [<803cc07c>] pinctrl_select_state+0xf0/0x1a8
 [<80436790>] pinctrl_bind_pins+0x7c/0xd4
 [<8041c900>] driver_probe_device+0x68/0x230
 [<8041cbb8>] __driver_attach+0x9c/0xa0
 [<8041aad4>] bus_for_each_dev+0x70/0xa4
 [<8041c430>] driver_attach+0x2c/0x30
 [<8041c048>] bus_add_driver+0x1e0/0x26c
 [<8041d26c>] driver_register+0x88/0x150
 [<8041e620>] platform_driver_register+0x60/0x68
 [<809426e0>] i2c_adap_s3c_init+0x18/0x1c
 [<800087a4>] do_one_initcall+0x128/0x180
 [<80910e40>] kernel_init_freeable+0x200/0x2a0
 [<8067b7b0>] kernel_init+0x20/0x170
 [<8001f758>] ret_from_fork+0x14/0x20

 other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

 CPU0 CPU1
 ---- ----
 lock(&(&(&bank->slock)->lock)->wait_lock);
 local_irq_disable();
 lock(&irq_desc_lock_class);
 lock(&(&(&bank->slock)->lock)->wait_lock);
 <Interrupt>
 lock(&irq_desc_lock_class);

 *** DEADLOCK ***

 2 locks held by swapper/0/1:
 #0: (&__lockdep_no_validate__){......}, at: [<8041cb7c>]
__driver_attach+0x60/0xa0
 #1: (&irq_desc_lock_class){-.....}, at: [<800bbe18>] __setup_irq+0x94/0x4c4

 the dependencies between HARDIRQ-irq-safe lock and the holding lock:
 -> (&irq_desc_lock_class){-.....} ops: 3893 {
 IN-HARDIRQ-W at:
 [<8008ffa0>] mark_lock+0x180/0x808
 [<80092a38>] __lock_acquire+0xb5c/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<800bdb10>] handle_fasteoi_irq+0x24/0x15c
 [<800b9c8c>] generic_handle_irq+0x34/0x44
 [<8002007c>] handle_IRQ+0x50/0xa0
 [<800085d8>] gic_handle_irq+0x48/0x78
 [<8001f1c4>] __irq_svc+0x44/0x8c
 [<800204a4>] arch_cpu_idle+0x40/0x4c
 [<800815f8>] cpu_startup_entry+0x1a4/0x2dc
 [<8067b780>] rest_init+0xdc/0xec
 [<80910c34>] start_kernel+0x428/0x434
 [<40008084>] 0x40008084
 INITIAL USE at:
 [<8008ffa0>] mark_lock+0x180/0x808
 [<8009219c>] __lock_acquire+0x2c0/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cd88>] _raw_spin_lock_irqsave+0x68/0x7c
 [<800b9ef0>] __irq_get_desc_lock+0x60/0x9c
 [<800bd024>] irq_modify_status+0x30/0xbc
 [<800b9fe8>] irq_set_percpu_devid+0x74/0x8c
 [<803cb838>] gic_irq_domain_map+0x64/0x90
 [<800bf5d0>] irq_domain_add_legacy+0x114/0x158
 [<8093c2b0>] gic_init_bases+0x224/0x3c4
 [<8093c528>] gic_of_init+0xd8/0x110
 [<809445f0>] of_irq_init+0x184/0x29c
 [<8093be60>] irqchip_init+0x18/0x1c
 [<80919ca8>] exynos5_init_irq+0x10/0x28
 [<80913fb0>] init_IRQ+0x30/0x34
 [<80910a50>] start_kernel+0x244/0x434
 [<40008084>] 0x40008084
 }
 ... key at: [<80f288ac>] irq_desc_lock_class+0x0/0x8
 ... acquired at:
 [<8008fa94>] check_usage+0x464/0x648
 [<8008fcdc>] check_irq_usage+0x64/0xc0
 [<80092e98>] __lock_acquire+0xfbc/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<8068ba2c>] rt_spin_lock_slowlock+0x54/0x2f8
 [<8068c42c>] rt_spin_lock+0x3c/0x68
 [<803d2050>] exynos_wkup_irq_set_type+0xec/0x190
 [<800bbcc8>] __irq_set_trigger+0x64/0x120
 [<800bc14c>] __setup_irq+0x3c8/0x4c4
 [<800bc39c>] request_threaded_irq+0xbc/0x13c
 [<800bc478>] request_any_context_irq+0x5c/0x8c
 [<804e2e48>] gpio_keys_probe+0x2cc/0x83c
 [<8041df3c>] platform_drv_probe+0x24/0x28
 [<8041c9b0>] driver_probe_device+0x118/0x230
 [<8041cbb8>] __driver_attach+0x9c/0xa0
 [<8041aad4>] bus_for_each_dev+0x70/0xa4
 [<8041c430>] driver_attach+0x2c/0x30
 [<8041c048>] bus_add_driver+0x1e0/0x26c
 [<8041d26c>] driver_register+0x88/0x150
 [<8041e620>] platform_driver_register+0x60/0x68
 [<80942488>] gpio_keys_init+0x18/0x1c
 [<800087a4>] do_one_initcall+0x128/0x180
 [<80910e40>] kernel_init_freeable+0x200/0x2a0
 [<8067b7b0>] kernel_init+0x20/0x170
 [<8001f758>] ret_from_fork+0x14/0x20


 the dependencies between the lock to be acquired and HARDIRQ-irq-unsafe lock:
 -> (&(&(&bank->slock)->lock)->wait_lock){+.+...} ops: 145 {
 HARDIRQ-ON-W at:
 [<8008ffa0>] mark_lock+0x180/0x808
 [<80092498>] __lock_acquire+0x5bc/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<8068ba2c>] rt_spin_lock_slowlock+0x54/0x2f8
 [<8068c42c>] rt_spin_lock+0x3c/0x68
 [<803d0594>] samsung_pinconf_rw+0xc8/0x14c
 [<803d06dc>] samsung_pinconf_group_set+0x70/0x90
 [<803cf864>] pinconf_apply_setting+0x90/0x198
 [<803cc07c>] pinctrl_select_state+0xf0/0x1a8
 [<80436790>] pinctrl_bind_pins+0x7c/0xd4
 [<8041c900>] driver_probe_device+0x68/0x230
 [<8041cbb8>] __driver_attach+0x9c/0xa0
 [<8041aad4>] bus_for_each_dev+0x70/0xa4
 [<8041c430>] driver_attach+0x2c/0x30
 [<8041c048>] bus_add_driver+0x1e0/0x26c
 [<8041d26c>] driver_register+0x88/0x150
 [<8041e620>] platform_driver_register+0x60/0x68
 [<809426e0>] i2c_adap_s3c_init+0x18/0x1c
 [<800087a4>] do_one_initcall+0x128/0x180
 [<80910e40>] kernel_init_freeable+0x200/0x2a0
 [<8067b7b0>] kernel_init+0x20/0x170
 [<8001f758>] ret_from_fork+0x14/0x20
 SOFTIRQ-ON-W at:
 [<8008ffa0>] mark_lock+0x180/0x808
 [<800924c0>] __lock_acquire+0x5e4/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<8068ba2c>] rt_spin_lock_slowlock+0x54/0x2f8
 [<8068c42c>] rt_spin_lock+0x3c/0x68
 [<803d0594>] samsung_pinconf_rw+0xc8/0x14c
 [<803d06dc>] samsung_pinconf_group_set+0x70/0x90
 [<803cf864>] pinconf_apply_setting+0x90/0x198
 [<803cc07c>] pinctrl_select_state+0xf0/0x1a8
 [<80436790>] pinctrl_bind_pins+0x7c/0xd4
 [<8041c900>] driver_probe_device+0x68/0x230
 [<8041cbb8>] __driver_attach+0x9c/0xa0
 [<8041aad4>] bus_for_each_dev+0x70/0xa4
 [<8041c430>] driver_attach+0x2c/0x30
 [<8041c048>] bus_add_driver+0x1e0/0x26c
 [<8041d26c>] driver_register+0x88/0x150
 [<8041e620>] platform_driver_register+0x60/0x68
 [<809426e0>] i2c_adap_s3c_init+0x18/0x1c
 [<800087a4>] do_one_initcall+0x128/0x180
 [<80910e40>] kernel_init_freeable+0x200/0x2a0
 [<8067b7b0>] kernel_init+0x20/0x170
 [<8001f758>] ret_from_fork+0x14/0x20
 INITIAL USE at:
 [<8008ffa0>] mark_lock+0x180/0x808
 [<8009219c>] __lock_acquire+0x2c0/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<8068ba2c>] rt_spin_lock_slowlock+0x54/0x2f8
 [<8068c42c>] rt_spin_lock+0x3c/0x68
 [<803d0594>] samsung_pinconf_rw+0xc8/0x14c
 [<803d06dc>] samsung_pinconf_group_set+0x70/0x90
 [<803cf864>] pinconf_apply_setting+0x90/0x198
 [<803cc07c>] pinctrl_select_state+0xf0/0x1a8
 [<80436790>] pinctrl_bind_pins+0x7c/0xd4
 [<8041c900>] driver_probe_device+0x68/0x230
 [<8041cbb8>] __driver_attach+0x9c/0xa0
 [<8041aad4>] bus_for_each_dev+0x70/0xa4
 [<8041c430>] driver_attach+0x2c/0x30
 [<8041c048>] bus_add_driver+0x1e0/0x26c
 [<8041d26c>] driver_register+0x88/0x150
 [<8041e620>] platform_driver_register+0x60/0x68
 [<809426e0>] i2c_adap_s3c_init+0x18/0x1c
 [<800087a4>] do_one_initcall+0x128/0x180
 [<80910e40>] kernel_init_freeable+0x200/0x2a0
 [<8067b7b0>] kernel_init+0x20/0x170
 [<8001f758>] ret_from_fork+0x14/0x20
 }
 ... key at: [<80f6f0ec>] __key.15784+0x0/0x8
 ... acquired at:
 [<8008fad0>] check_usage+0x4a0/0x648
 [<8008fcdc>] check_irq_usage+0x64/0xc0
 [<80092e98>] __lock_acquire+0xfbc/0x1ec0
 [<800943f8>] lock_acquire+0xc4/0x174
 [<8068cbd8>] _raw_spin_lock+0x58/0x68
 [<8068ba2c>] rt_spin_lock_slowlock+0x54/0x2f8
 [<8068c42c>] rt_spin_lock+0x3c/0x68
 [<803d2050>] exynos_wkup_irq_set_type+0xec/0x190
 [<800bbcc8>] __irq_set_trigger+0x64/0x120
 [<800bc14c>] __setup_irq+0x3c8/0x4c4
 [<800bc39c>] request_threaded_irq+0xbc/0x13c
 [<800bc478>] request_any_context_irq+0x5c/0x8c
 [<804e2e48>] gpio_keys_probe+0x2cc/0x83c
 [<8041df3c>] platform_drv_probe+0x24/0x28
 [<8041c9b0>] driver_probe_device+0x118/0x230
 [<8041cbb8>] __driver_attach+0x9c/0xa0
 [<8041aad4>] bus_for_each_dev+0x70/0xa4
 [<8041c430>] driver_attach+0x2c/0x30
 [<8041c048>] bus_add_driver+0x1e0/0x26c
 [<8041d26c>] driver_register+0x88/0x150
 [<8041e620>] platform_driver_register+0x60/0x68
 [<80942488>] gpio_keys_init+0x18/0x1c
 [<800087a4>] do_one_initcall+0x128/0x180
 [<80910e40>] kernel_init_freeable+0x200/0x2a0
 [<8067b7b0>] kernel_init+0x20/0x170
 [<8001f758>] ret_from_fork+0x14/0x20


 stack backtrace:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.6-linaro-arndale #1
 [<80026578>] (unwind_backtrace+0x0/0x100) from [<80023a90>]
(show_stack+0x20/0x24)
 [<80023a90>] (show_stack+0x20/0x24) from [<80688914>] (dump_stack+0x24/0x28)
 [<80688914>] (dump_stack+0x24/0x28) from [<8008faf4>] (check_usage+0x4c4/0x648)
 [<8008faf4>] (check_usage+0x4c4/0x648) from [<8008fcdc>]
(check_irq_usage+0x64/0xc0)
 [<8008fcdc>] (check_irq_usage+0x64/0xc0) from [<80092e98>]
(__lock_acquire+0xfbc/0x1ec0)
 [<80092e98>] (__lock_acquire+0xfbc/0x1ec0) from [<800943f8>]
(lock_acquire+0xc4/0x174)
 [<800943f8>] (lock_acquire+0xc4/0x174) from [<8068cbd8>]
(_raw_spin_lock+0x58/0x68)
 [<8068cbd8>] (_raw_spin_lock+0x58/0x68) from [<8068ba2c>]
(rt_spin_lock_slowlock+0x54/0x2f8)
 [<8068ba2c>] (rt_spin_lock_slowlock+0x54/0x2f8) from [<8068c42c>]
(rt_spin_lock+0x3c/0x68)
 [<8068c42c>] (rt_spin_lock+0x3c/0x68) from [<803d2050>]
(exynos_wkup_irq_set_type+0xec/0x190)
 [<803d2050>] (exynos_wkup_irq_set_type+0xec/0x190) from [<800bbcc8>]
(__irq_set_trigger+0x64/0x120)
 [<800bbcc8>] (__irq_set_trigger+0x64/0x120) from [<800bc14c>]
(__setup_irq+0x3c8/0x4c4)
 [<800bc14c>] (__setup_irq+0x3c8/0x4c4) from [<800bc39c>]
(request_threaded_irq+0xbc/0x13c)
 [<800bc39c>] (request_threaded_irq+0xbc/0x13c) from [<800bc478>]
(request_any_context_irq+0x5c/0x8c)
 [<800bc478>] (request_any_context_irq+0x5c/0x8c) from [<804e2e48>]
(gpio_keys_probe+0x2cc/0x83c)
 [<804e2e48>] (gpio_keys_probe+0x2cc/0x83c) from [<8041df3c>]
(platform_drv_probe+0x24/0x28)
 [<8041df3c>] (platform_drv_probe+0x24/0x28) from [<8041c9b0>]
(driver_probe_device+0x118/0x230)
 [<8041c9b0>] (driver_probe_device+0x118/0x230) from [<8041cbb8>]
(__driver_attach+0x9c/0xa0)
 [<8041cbb8>] (__driver_attach+0x9c/0xa0) from [<8041aad4>]
(bus_for_each_dev+0x70/0xa4)
 [<8041aad4>] (bus_for_each_dev+0x70/0xa4) from [<8041c430>]
(driver_attach+0x2c/0x30)
 [<8041c430>] (driver_attach+0x2c/0x30) from [<8041c048>]
(bus_add_driver+0x1e0/0x26c)
 [<8041c048>] (bus_add_driver+0x1e0/0x26c) from [<8041d26c>]
(driver_register+0x88/0x150)
 [<8041d26c>] (driver_register+0x88/0x150) from [<8041e620>]
(platform_driver_register+0x60/0x68)
 [<8041e620>] (platform_driver_register+0x60/0x68) from [<80942488>]
(gpio_keys_init+0x18/0x1c)
 [<80942488>] (gpio_keys_init+0x18/0x1c) from [<800087a4>]
(do_one_initcall+0x128/0x180)
 [<800087a4>] (do_one_initcall+0x128/0x180) from [<80910e40>]
(kernel_init_freeable+0x200/0x2a0)
 [<80910e40>] (kernel_init_freeable+0x200/0x2a0) from [<8067b7b0>]
(kernel_init+0x20/0x170)
 [<8067b7b0>] (kernel_init+0x20/0x170) from [<8001f758>]
(ret_from_fork+0x14/0x20)


> Does this happen on linux-next?

Not tried on that, it was tried on 3.10 stable kernel merged with RT patches..

--
viresh
