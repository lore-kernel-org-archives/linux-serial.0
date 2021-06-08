Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC3C47082
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFFB61249
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 13:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhFHNeQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:34:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:19244 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233011AbhFHNeP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Jun 2021 09:34:15 -0400
IronPort-SDR: Lsq109aEuY9c2t6Bm8xgvyFSd2e0YEtbPf5x0knCKlqgZ5F+tXCNX4tiq3imcWpiQ5gh/Xay3n
 ELy3oaTQ1TXA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="268696524"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="268696524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:32:22 -0700
IronPort-SDR: hdEcr5c77I9K5OVpFo+ZLcBjijYHcvs73dIr9/l79bqHLD4a3M+t/eE1jcmVt9lmRyPIVwwgRo
 SYUf0reOq7Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552280220"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Jun 2021 06:32:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Jun 2021 16:32:19 +0300
Date:   Tue, 8 Jun 2021 16:32:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        linux-serial@vger.kernel.org
Subject: Re: Commit "serial: 8250_exar: Constify the software nodes' breaks
 suspend/resume
Message-ID: <YL9xY7jT13ZVRxMW@kuha.fi.intel.com>
References: <7bb02598035ce2fb2372f97ff531c11357818d1f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb02598035ce2fb2372f97ff531c11357818d1f.camel@redhat.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 08, 2021 at 04:17:58PM +0300, Maxim Levitsky wrote:
> Hi!
> 
> I happened to own one of Exar's PCI serial adapters, and this commit that I bisected
> breaks suspend/resume of the host.
> 
> The adapter that I have:
> 
> 02:00.0 Serial controller [0700]: Exar Corp. XR17V3521 Dual PCIe UART [13a8:0352] (rev 03) (prog-if 02 [16550])
> 
> 
> First suspend of the system works,but on the second suspend, the system hangs until it reboots.
> Reverting the commit helps.
> 
> I attached a backtrace captured with ramoops 
> (since I ironically use this serial port to capture the oops backtraces otherwise...)
> 
> Best regards,
> 	Maxim Levitsky
> 

Maybe we should fix this by making dev_fwnode() NULL safe?

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c26370aacdc66..65b866f8bfb1b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -20,8 +20,8 @@
 
 struct fwnode_handle *dev_fwnode(struct device *dev)
 {
-       return IS_ENABLED(CONFIG_OF) && dev->of_node ?
-               of_fwnode_handle(dev->of_node) : dev->fwnode;
+       return dev ? IS_ENABLED(CONFIG_OF) && dev->of_node ?
+               of_fwnode_handle(dev->of_node) : dev->fwnode : NULL;
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 

Andy, comments?

> Oops#1 Part1
> <7>[   73.639820] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x8 (reading 0xc8000a1)
> <7>[   73.639822] nvidia-gpu 0000:4d:00.3: saving config space at offset 0xc (reading 0x800010)
> <7>[   73.639824] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x10 (reading 0xb8084000)
> <7>[   73.639826] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x14 (reading 0x0)
> <7>[   73.639827] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x18 (reading 0x0)
> <7>[   73.639829] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x1c (reading 0x0)
> <7>[   73.639831] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x20 (reading 0x0)
> <7>[   73.639833] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x24 (reading 0x0)
> <7>[   73.639834] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x28 (reading 0x0)
> <7>[   73.639836] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x2c (reading 0x30713842)
> <7>[   73.639838] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x30 (reading 0x0)
> <7>[   73.639840] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x34 (reading 0x68)
> <7>[   73.639841] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x38 (reading 0x0)
> <7>[   73.639843] nvidia-gpu 0000:4d:00.3: saving config space at offset 0x3c (reading 0x4ff)
> <7>[   73.639864] nvidia-gpu 0000:4d:00.3: PME# enabled
> <7>[   73.654865] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x0 (reading 0xaae01002)
> <7>[   73.654868] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x4 (reading 0x100406)
> <7>[   73.654870] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x8 (reading 0x4030000)
> <7>[   73.654873] snd_hda_intel 0000:4c:00.1: saving config space at offset 0xc (reading 0x800010)
> <7>[   73.654875] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x10 (reading 0xb9060004)
> <7>[   73.654877] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x14 (reading 0x0)
> <7>[   73.654879] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x18 (reading 0x0)
> <7>[   73.654881] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x1c (reading 0x0)
> <7>[   73.654883] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x20 (reading 0x0)
> <7>[   73.654885] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x24 (reading 0x0)
> <7>[   73.654887] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x28 (reading 0x0)
> <7>[   73.654889] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x2c (reading 0xaae0103c)
> <7>[   73.654891] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x30 (reading 0x0)
> <7>[   73.654893] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x34 (reading 0x48)
> <7>[   73.654895] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x38 (reading 0x0)
> <7>[   73.654897] snd_hda_intel 0000:4c:00.1: saving config space at offset 0x3c (reading 0x2ff)
> <6>[   73.662183] IPv6: ADDRCONF(NETDEV_CHANGE): enp69s0: link becomes ready
> <6>[   73.701997] IPv6: ADDRCONF(NETDEV_CHANGE): enp71s0: link becomes ready
> <6>[   78.715982] PM: suspend entry (deep)
> <6>[   78.750836] Filesystems sync: 0.034 seconds
> <6>[   78.762054] Freezing user space processes ... (elapsed 0.001 seconds) done.
> <6>[   78.764294] OOM killer disabled.
> <6>[   78.764481] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> <6>[   78.766305] printk: Suspending console(s) (use no_console_suspend to debug)
> <1>[   78.769584] BUG: kernel NULL pointer dereference, address: 0000000000000290
> <1>[   78.769587] #PF: supervisor read access in kernel mode
> <1>[   78.769589] #PF: error_code(0x0000) - not-present page
> <6>[   78.769591] PGD 0 P4D 0 
> <4>[   78.769593] Oops: 0000 [#1] SMP
> <4>[   78.769596] CPU: 47 PID: 5743 Comm: kworker/u128:20 Tainted: G           O      5.13.0-rc5.unstable #13
> <4>[   78.769600] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F4c 03/05/2020
> <4>[   78.769602] Workqueue: events_unbound async_run_entry_fn
> <4>[   78.769607] RIP: 0010:dev_fwnode+0x6/0x20
> <4>[   78.769613] Code: 00 00 00 00 0f 1f 44 00 00 48 8b 97 d8 02 00 00 48 85 d2 74 08 55 48 89 e5 ff d2 5d c3 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 55 <48> 8b 87 80 02 00 00 48 89 e5 5d c3 66 66 2e 0f 1f 84 00 00 00 00
> <4>[   78.769615] RSP: 0018:ffffc900059a3cd0 EFLAGS: 00010282
> <4>[   78.769617] RAX: ffffffff82b2c320 RBX: ffffffff82b2c320 RCX: 0000000000000000
> <4>[   78.769619] RDX: ffff88a04bc7f000 RSI: 0000000000000000 RDI: 0000000000000010
> <4>[   78.769620] RBP: ffffc900059a3cf0 R08: ffff888103e94700 R09: ffffffff81758c2b
> <4>[   78.769622] R10: 0000000000000256 R11: ffff888107d0e6aa R12: 0000000000000000
> <4>[   78.769623] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000002
> <4>[   78.769625] FS:  0000000000000000(0000) GS:ffff889fc97c0000(0000) knlGS:0000000000000000
> <4>[   78.769627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   78.769628] CR2: 0000000000000290 CR3: 0000000180087000 CR4: 0000000000350ee0
> <4>[   78.769630] Call Trace:
> <4>[   78.769634]  ? device_remove_software_node+0x15/0x80
> <4>[   78.769637]  pci_xr17v35x_exit+0x2f/0x60
> <4>[   78.769641]  exar_suspend+0x4f/0x60
> <4>[   78.769644]  pci_pm_suspend+0x7b/0x180
> <4>[   78.769648]  ? pci_pm_freeze+0xc0/0xc0
> <4>[   78.769650]  dpm_run_callback+0x55/0x140
> <4>[   78.769654]  __device_suspend+0x197/0x520
> <4>[   78.769657]  ? pm_dev_err+0x3c/0x3c
> <4>[   78.769661]  async_suspend+0x20/0xa0
> <4>[   78.769664]  async_run_entry_fn+0x2d/0x120
> <4>[   78.769666]  process_one_work+0x1de/0x380
> <4>[   78.769670]  worker_thread+0x50/0x3e0
> <4>[   78.769674]  kthread+0x12c/0x160
> <4>[   78.769676]  ? rescuer_thread+0x3c0/0x3c0
> <4>[   78.769679]  ? kthread_create_worker_on_cpu+0x80/0x80
> <4>[   78.769682]  ret_from_fork+0x1f/0x30
> <4>[   78.769686] Modules linked in: xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004 jc42 wmi_bmof kvm_amd(O) kvm(O) iwlmvm irqbypass pcspkr mac80211 libarc4 snd_hda_codec_hdmi uvcvideo videobuf2_vmalloc i2c_nvidia_gpu snd_hda_intel snd_intel_dspcfg videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_codec videobuf2_common snd_usbmidi_lib iwlwifi btusb snd_hwdep videodev btrtl snd_hda_core snd_rawmidi xpad btbcm input_leds joydev ff_memless mc snd_pcm btintel cfg80211 bluetooth bfq thunderbolt zenpower i2c_piix4 rtc_cmos wmi binfmt_misc fuse dm_crypt wacom sd_mod hid_generic usbhid uas usb_storage ext4 mbcache jbd2 amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core ahci libahci drm libata igb i2c_algo_bit xhci_pci ccp nvme xhci_hcd nvme_core t10_pi dm_mirror dm_region_hash dm_log nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4
> <4>[   78.769755] CR2: 0000000000000290
> <4>[   78.769757] ---[ end trace 7899f9e21bcb5bbf ]---
> 
> No errors detected
> Oops#2 Part1
> <4>[   78.769637]  pci_xr17v35x_exit+0x2f/0x60
> <4>[   78.769641]  exar_suspend+0x4f/0x60
> <4>[   78.769644]  pci_pm_suspend+0x7b/0x180
> <4>[   78.769648]  ? pci_pm_freeze+0xc0/0xc0
> <4>[   78.769650]  dpm_run_callback+0x55/0x140
> <4>[   78.769654]  __device_suspend+0x197/0x520
> <4>[   78.769657]  ? pm_dev_err+0x3c/0x3c
> <4>[   78.769661]  async_suspend+0x20/0xa0
> <4>[   78.769664]  async_run_entry_fn+0x2d/0x120
> <4>[   78.769666]  process_one_work+0x1de/0x380
> <4>[   78.769670]  worker_thread+0x50/0x3e0
> <4>[   78.769674]  kthread+0x12c/0x160
> <4>[   78.769676]  ? rescuer_thread+0x3c0/0x3c0
> <4>[   78.769679]  ? kthread_create_worker_on_cpu+0x80/0x80
> <4>[   78.769682]  ret_from_fork+0x1f/0x30
> <4>[   78.769686] Modules linked in: xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004 jc42 wmi_bmof kvm_amd(O) kvm(O) iwlmvm irqbypass pcspkr mac80211 libarc4 snd_hda_codec_hdmi uvcvideo videobuf2_vmalloc i2c_nvidia_gpu snd_hda_intel snd_intel_dspcfg videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_codec videobuf2_common snd_usbmidi_lib iwlwifi btusb snd_hwdep videodev btrtl snd_hda_core snd_rawmidi xpad btbcm input_leds joydev ff_memless mc snd_pcm btintel cfg80211 bluetooth bfq thunderbolt zenpower i2c_piix4 rtc_cmos wmi binfmt_misc fuse dm_crypt wacom sd_mod hid_generic usbhid uas usb_storage ext4 mbcache jbd2 amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core ahci libahci drm libata igb i2c_algo_bit xhci_pci ccp nvme xhci_hcd nvme_core t10_pi dm_mirror dm_region_hash dm_log nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4
> <4>[   78.769755] CR2: 0000000000000290
> <4>[   78.769757] ---[ end trace 7899f9e21bcb5bbf ]---
> <4>[   78.830699] RIP: 0010:dev_fwnode+0x6/0x20
> <4>[   78.830703] Code: 00 00 00 00 0f 1f 44 00 00 48 8b 97 d8 02 00 00 48 85 d2 74 08 55 48 89 e5 ff d2 5d c3 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 55 <48> 8b 87 80 02 00 00 48 89 e5 5d c3 66 66 2e 0f 1f 84 00 00 00 00
> <4>[   78.830705] RSP: 0018:ffffc900059a3cd0 EFLAGS: 00010282
> <4>[   78.830708] RAX: ffffffff82b2c320 RBX: ffffffff82b2c320 RCX: 0000000000000000
> <4>[   78.830709] RDX: ffff88a04bc7f000 RSI: 0000000000000000 RDI: 0000000000000010
> <4>[   78.830710] RBP: ffffc900059a3cf0 R08: ffff888103e94700 R09: ffffffff81758c2b
> <4>[   78.830712] R10: 0000000000000256 R11: ffff888107d0e6aa R12: 0000000000000000
> <4>[   78.830713] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000002
> <4>[   78.830714] FS:  0000000000000000(0000) GS:ffff889fc97c0000(0000) knlGS:0000000000000000
> <4>[   78.830716] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   78.830718] CR2: 0000000000000290 CR3: 0000000180087000 CR4: 0000000000350ee0
> <1>[  201.836752] BUG: unable to handle page fault for address: ffffc900059a3de0
> <1>[  201.836756] #PF: supervisor write access in kernel mode
> <1>[  201.836758] #PF: error_code(0x0002) - not-present page
> <6>[  201.836760] PGD 101000067 P4D 101000067 PUD 1011b5067 PMD 1269c7067 PTE 0
> <4>[  201.836765] Oops: 0002 [#2] SMP
> <4>[  201.836768] CPU: 47 PID: 0 Comm: swapper/47 Tainted: G      D    O      5.13.0-rc5.unstable #13
> <4>[  201.836772] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F4c 03/05/2020
> <4>[  201.836773] RIP: 0010:__run_timers+0xa9/0x240
> <4>[  201.836779] Code: 8d 7d 88 89 c6 83 e6 3f 01 d6 49 0f b3 31 73 2c 48 8b 8d 78 ff ff ff 4c 8d 57 08 4c 8d 04 f1 49 8b 30 48 89 37 48 85 f6 74 04 <48> 89 7e 08 49 c7 00 00 00 00 00 41 83 c6 01 4c 89 d7 a8 07 75 0f
> <4>[  201.836781] RSP: 0018:ffffc90000da4ed0 EFLAGS: 00010086
> <4>[  201.836784] RAX: 00000000000fffe8 RBX: ffffffff826060c8 RCX: ffff889fc97db7b0
> <4>[  201.836786] RDX: 0000000000000100 RSI: ffffc900059a3dd8 RDI: ffffc90000da4ee8
> <4>[  201.836787] RBP: ffffc90000da4f58 R08: ffff889fc97dc0f0 R09: ffff889fc97db768
> <4>[  201.836789] R10: ffffc90000da4ef0 R11: ffffffff826060c0 R12: 0000000000000001
> <4>[  201.836790] R13: dead000000000122 R14: 0000000000000001 R15: ffff889fc97db740
> <4>[  201.836791] FS:  0000000000000000(0000) GS:ffff889fc97c0000(0000) knlGS:0000000000000000
> <4>[  201.836794] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  201.836795] CR2: ffffc900059a3de0 CR3: 0000000180087000 CR4: 0000000000350ee0
> <4>[  201.836797] Call Trace:
> <4>[  201.836798]  <IRQ>
> <4>[  201.836800]  ? tick_sched_timer+0x6b/0x80
> <4>[  201.836805]  ? __hrtimer_run_queues+0x139/0x280
> <4>[  201.836807]  ? lapic_timer_shutdown+0x45/0x60
> <4>[  201.836811]  ? clockevents_switch_state+0x5f/0xe0
> <4>[  201.836814]  run_timer_softirq+0x1d/0x40
> <4>[  201.836817]  __do_softirq+0xc2/0x26f
> <4>[  201.836821]  __irq_exit_rcu+0xc4/0x100
> <4>[  201.836825]  irq_exit_rcu+0xe/0x20
> <4>[  201.836827]  sysvec_apic_timer_interrupt+0x7c/0xa0
> <4>[  201.836831]  </IRQ>
> <4>[  201.836832]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> <4>[  201.836835] RIP: 0010:cpuidle_enter_state+0xd2/0x340
> <4>[  201.836839] Code: 89 c6 0f 1f 44 00 00 31 ff e8 ea 43 93 ff 80 7d d7 00 74 12 9c 58 f6 c4 02 0f 85 45 02 00 00 31 ff e8 92 07 9a ff fb 45 85 ff <0f> 88 e5 00 00 00 49 63 cf 4c 2b 75 c8 48 8d 04 49 48 89 ca 48 8d
> <4>[  201.836841] RSP: 0018:ffffc90000487e68 EFLAGS: 00000202
> <4>[  201.836843] RAX: ffff889fc97eae80 RBX: 0000000000000002 RCX: 000000000000001f
> <4>[  201.836844] RDX: 0000000000000000 RSI: 0000000022983f51 RDI: 0000000000000000
> <4>[  201.836846] RBP: ffffc90000487ea0 R08: 0000002efe684a7e R09: 0000000000000008
> <4>[  201.836847] R10: 00000000000007b1 R11: ffff889fc97e9d84 R12: ffff88810906c800
> <4>[  201.836848] R13: ffffffff827f5140 R14: 0000002efe684a7e R15: 0000000000000002
> <4>[  201.836852]  ? cpuidle_enter_state+0xb6/0x340
> <4>[  201.836855]  cpuidle_enter+0x2e/0x40
> <4>[  201.836858]  do_idle+0x1f3/0x2a0
> <4>[  201.836862]  cpu_startup_entry+0x20/0x40
> <4>[  201.836865]  start_secondary+0x104/0x140
> <4>[  201.836869]  secondary_startup_64_no_verify+0xb0/0xbb
> <4>[  201.836873] Modules linked in: xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004 jc42 wmi_bmof kvm_amd(O) kvm(O) iwlmvm irqbypass pcspkr mac80211 libarc4 snd_hda_codec_hdmi uvcvideo videobuf2_vmalloc i2c_nvidia_gpu snd_hda_intel snd_intel_dspcfg videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_codec videobuf2_common snd_usbmidi_lib iwlwifi btusb snd_hwdep videodev btrtl snd_hda_core snd_rawmidi xpad btbcm input_leds joydev ff_memless mc snd_pcm btintel cfg80211 bluetooth bfq thunderbolt zenpower i2c_piix4 rtc_cmos wmi binfmt_misc fuse dm_crypt wacom sd_mod hid_generic usbhid uas usb_storage ext4 mbcache jbd2 amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core ahci libahci drm libata igb i2c_algo_bit xhci_pci ccp nvme xhci_hcd nvme_core t10_pi dm_mirror dm_region_hash dm_log nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4
> <4>[  201.836941] CR2: ffffc900059a3de0
> <4>[  201.836952] ---[ end trace 7899f9e21bcb5bc0 ]---
> 
> No errors detected
> Panic#3 Part1
> <4>[   78.769755] CR2: 0000000000000290
> <4>[   78.769757] ---[ end trace 7899f9e21bcb5bbf ]---
> <4>[   78.830699] RIP: 0010:dev_fwnode+0x6/0x20
> <4>[   78.830703] Code: 00 00 00 00 0f 1f 44 00 00 48 8b 97 d8 02 00 00 48 85 d2 74 08 55 48 89 e5 ff d2 5d c3 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 55 <48> 8b 87 80 02 00 00 48 89 e5 5d c3 66 66 2e 0f 1f 84 00 00 00 00
> <4>[   78.830705] RSP: 0018:ffffc900059a3cd0 EFLAGS: 00010282
> <4>[   78.830708] RAX: ffffffff82b2c320 RBX: ffffffff82b2c320 RCX: 0000000000000000
> <4>[   78.830709] RDX: ffff88a04bc7f000 RSI: 0000000000000000 RDI: 0000000000000010
> <4>[   78.830710] RBP: ffffc900059a3cf0 R08: ffff888103e94700 R09: ffffffff81758c2b
> <4>[   78.830712] R10: 0000000000000256 R11: ffff888107d0e6aa R12: 0000000000000000
> <4>[   78.830713] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000002
> <4>[   78.830714] FS:  0000000000000000(0000) GS:ffff889fc97c0000(0000) knlGS:0000000000000000
> <4>[   78.830716] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   78.830718] CR2: 0000000000000290 CR3: 0000000180087000 CR4: 0000000000350ee0
> <1>[  201.836752] BUG: unable to handle page fault for address: ffffc900059a3de0
> <1>[  201.836756] #PF: supervisor write access in kernel mode
> <1>[  201.836758] #PF: error_code(0x0002) - not-present page
> <6>[  201.836760] PGD 101000067 P4D 101000067 PUD 1011b5067 PMD 1269c7067 PTE 0
> <4>[  201.836765] Oops: 0002 [#2] SMP
> <4>[  201.836768] CPU: 47 PID: 0 Comm: swapper/47 Tainted: G      D    O      5.13.0-rc5.unstable #13
> <4>[  201.836772] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F4c 03/05/2020
> <4>[  201.836773] RIP: 0010:__run_timers+0xa9/0x240
> <4>[  201.836779] Code: 8d 7d 88 89 c6 83 e6 3f 01 d6 49 0f b3 31 73 2c 48 8b 8d 78 ff ff ff 4c 8d 57 08 4c 8d 04 f1 49 8b 30 48 89 37 48 85 f6 74 04 <48> 89 7e 08 49 c7 00 00 00 00 00 41 83 c6 01 4c 89 d7 a8 07 75 0f
> <4>[  201.836781] RSP: 0018:ffffc90000da4ed0 EFLAGS: 00010086
> <4>[  201.836784] RAX: 00000000000fffe8 RBX: ffffffff826060c8 RCX: ffff889fc97db7b0
> <4>[  201.836786] RDX: 0000000000000100 RSI: ffffc900059a3dd8 RDI: ffffc90000da4ee8
> <4>[  201.836787] RBP: ffffc90000da4f58 R08: ffff889fc97dc0f0 R09: ffff889fc97db768
> <4>[  201.836789] R10: ffffc90000da4ef0 R11: ffffffff826060c0 R12: 0000000000000001
> <4>[  201.836790] R13: dead000000000122 R14: 0000000000000001 R15: ffff889fc97db740
> <4>[  201.836791] FS:  0000000000000000(0000) GS:ffff889fc97c0000(0000) knlGS:0000000000000000
> <4>[  201.836794] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  201.836795] CR2: ffffc900059a3de0 CR3: 0000000180087000 CR4: 0000000000350ee0
> <4>[  201.836797] Call Trace:
> <4>[  201.836798]  <IRQ>
> <4>[  201.836800]  ? tick_sched_timer+0x6b/0x80
> <4>[  201.836805]  ? __hrtimer_run_queues+0x139/0x280
> <4>[  201.836807]  ? lapic_timer_shutdown+0x45/0x60
> <4>[  201.836811]  ? clockevents_switch_state+0x5f/0xe0
> <4>[  201.836814]  run_timer_softirq+0x1d/0x40
> <4>[  201.836817]  __do_softirq+0xc2/0x26f
> <4>[  201.836821]  __irq_exit_rcu+0xc4/0x100
> <4>[  201.836825]  irq_exit_rcu+0xe/0x20
> <4>[  201.836827]  sysvec_apic_timer_interrupt+0x7c/0xa0
> <4>[  201.836831]  </IRQ>
> <4>[  201.836832]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> <4>[  201.836835] RIP: 0010:cpuidle_enter_state+0xd2/0x340
> <4>[  201.836839] Code: 89 c6 0f 1f 44 00 00 31 ff e8 ea 43 93 ff 80 7d d7 00 74 12 9c 58 f6 c4 02 0f 85 45 02 00 00 31 ff e8 92 07 9a ff fb 45 85 ff <0f> 88 e5 00 00 00 49 63 cf 4c 2b 75 c8 48 8d 04 49 48 89 ca 48 8d
> <4>[  201.836841] RSP: 0018:ffffc90000487e68 EFLAGS: 00000202
> <4>[  201.836843] RAX: ffff889fc97eae80 RBX: 0000000000000002 RCX: 000000000000001f
> <4>[  201.836844] RDX: 0000000000000000 RSI: 0000000022983f51 RDI: 0000000000000000
> <4>[  201.836846] RBP: ffffc90000487ea0 R08: 0000002efe684a7e R09: 0000000000000008
> <4>[  201.836847] R10: 00000000000007b1 R11: ffff889fc97e9d84 R12: ffff88810906c800
> <4>[  201.836848] R13: ffffffff827f5140 R14: 0000002efe684a7e R15: 0000000000000002
> <4>[  201.836852]  ? cpuidle_enter_state+0xb6/0x340
> <4>[  201.836855]  cpuidle_enter+0x2e/0x40
> <4>[  201.836858]  do_idle+0x1f3/0x2a0
> <4>[  201.836862]  cpu_startup_entry+0x20/0x40
> <4>[  201.836865]  start_secondary+0x104/0x140
> <4>[  201.836869]  secondary_startup_64_no_verify+0xb0/0xbb
> <4>[  201.836873] Modules linked in: xt_state xt_conntrack ip6table_filter ip6_tables tun pmbus pmbus_core ee1004 jc42 wmi_bmof kvm_amd(O) kvm(O) iwlmvm irqbypass pcspkr mac80211 libarc4 snd_hda_codec_hdmi uvcvideo videobuf2_vmalloc i2c_nvidia_gpu snd_hda_intel snd_intel_dspcfg videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_codec videobuf2_common snd_usbmidi_lib iwlwifi btusb snd_hwdep videodev btrtl snd_hda_core snd_rawmidi xpad btbcm input_leds joydev ff_memless mc snd_pcm btintel cfg80211 bluetooth bfq thunderbolt zenpower i2c_piix4 rtc_cmos wmi binfmt_misc fuse dm_crypt wacom sd_mod hid_generic usbhid uas usb_storage ext4 mbcache jbd2 amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core ahci libahci drm libata igb i2c_algo_bit xhci_pci ccp nvme xhci_hcd nvme_core t10_pi dm_mirror dm_region_hash dm_log nbd usbmon it87 hwmon_vid i2c_dev i2c_core autofs4
> <4>[  201.836941] CR2: ffffc900059a3de0
> <4>[  201.836952] ---[ end trace 7899f9e21bcb5bc0 ]---
> <4>[  201.888284] RIP: 0010:dev_fwnode+0x6/0x20
> <4>[  201.888288] Code: 00 00 00 00 0f 1f 44 00 00 48 8b 97 d8 02 00 00 48 85 d2 74 08 55 48 89 e5 ff d2 5d c3 31 c0 c3 cc cc cc cc 0f 1f 44 00 00 55 <48> 8b 87 80 02 00 00 48 89 e5 5d c3 66 66 2e 0f 1f 84 00 00 00 00
> <4>[  201.888290] RSP: 0018:ffffc900059a3cd0 EFLAGS: 00010282
> <4>[  201.888293] RAX: ffffffff82b2c320 RBX: ffffffff82b2c320 RCX: 0000000000000000
> <4>[  201.888294] RDX: ffff88a04bc7f000 RSI: 0000000000000000 RDI: 0000000000000010
> <4>[  201.888295] RBP: ffffc900059a3cf0 R08: ffff888103e94700 R09: ffffffff81758c2b
> <4>[  201.888297] R10: 0000000000000256 R11: ffff888107d0e6aa R12: 0000000000000000
> <4>[  201.888298] R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000002
> <4>[  201.888299] FS:  0000000000000000(0000) GS:ffff889fc97c0000(0000) knlGS:0000000000000000
> <4>[  201.888301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  201.888303] CR2: ffffc900059a3de0 CR3: 0000000180087000 CR4: 0000000000350ee0
> <0>[  201.888305] Kernel panic - not syncing: Fatal exception in interrupt
> <0>[  201.888616] Kernel Offset: disabled
> 
> No errors detected


-- 
heikki
