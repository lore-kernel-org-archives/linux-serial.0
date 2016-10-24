From: Borislav Petkov <bp@alien8.de>
Subject: BUG: unable to handle kernel NULL pointer dereference at
 00000000000001e0
Date: Mon, 24 Oct 2016 16:48:31 +0200
Message-ID: <20161024144831.a4ieul22jck4vwk3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi people,

typing "reboot" splats the following on the serial console. Ideas?

INIT: Sending p[  427.863916] BUG: unable to handle kernel NULL pointer dereference at 00000000000001e0
[  427.885156] IP: [<ffffffffa24bfb6c>] tty_wakeup+0xc/0x70
[  427.898337] PGD 0 [  427.902051] 
[  427.907498] Oops: 0000 [#1] PREEMPT SMP
[  427.917635] Modules linked in: nfsv3 nfs_acl nfs fscache lockd sunrpc grace edd af_packet cpufreq_conservative cpufreq_userspace cpufreq_powersave fuse loop md_mod dm_mod joydev hid_generic usbhid ipmi_ssif ohci_pci ohci_hcd ehci_pci ehci_hcd e1000e ptp firewire_ohci edac_core pps_core tpm_infineon sp5100_tco firewire_core acpi_cpufreq serio_raw pcspkr fjes usbcore shpchp edac_mce_amd tpm_tis ipmi_si tpm_tis_core i2c_piix4 k10temp sg ipmi_msghandler tpm sr_mod button cdrom kvm_amd kvm irqbypass crc_itu_t ast ttm drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea i2c_algo_bit scsi_dh_rdac scsi_dh_alua scsi_dh_emc scsi_dh_hp_sw ata_generic pata_atiixp
[  428.054179] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.0-rc1-1.g73e3f23-default #1
[  428.072868] Hardware name: System manufacturer System Product Name/KGP(M)E-D16, BIOS 0902    12/03/2010
[  428.094755] task: ffffffffa2c0d500 task.stack: ffffffffa2c00000
[  428.109717] RIP: 0010:[<ffffffffa24bfb6c>]  [<ffffffffa24bfb6c>] tty_wakeup+0xc/0x70
[  428.128407] RSP: 0018:ffff9a1a5fc03df8  EFLAGS: 00010086
[  428.142184] RAX: ffff9a1857258000 RBX: ffffffffa3050ea0 RCX: 0000000000000000
[  428.159649] RDX: 000000000000001b RSI: 0000000000000000 RDI: 0000000000000000
[  428.177109] RBP: ffff9a1a5fc03e08 R08: 0000000000000000 R09: 0000000000000000
[  428.194547] R10: 0000000000021c77 R11: 0000000000000000 R12: ffff9a1857258000
[  428.212002] R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000020
[  428.229481] FS:  0000000000000000(0000) GS:ffff9a1a5fc00000(0000) knlGS:0000000000000000
[  428.248938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  428.263726] CR2: 00000000000001e0 CR3: 0000000390c06000 CR4: 00000000000006f0
[  428.281331] Stack:
[  428.288696]  ffffffffa3050ea0 ffff9a1857258000 ffff9a1a5fc03e18 ffffffffa24e0ab1
[  428.307064]  ffff9a1a5fc03e40 ffffffffa24e8865 ffffffffa3050ea0 00000000000000c2
[  428.325456]  0000000000000046 ffff9a1a5fc03e78 ffffffffa24e8a5f ffffffffa3050ea0
[  428.343905] Call Trace:
[  428.352319]  <IRQ> [  428.356216]  [<ffffffffa24e0ab1>] uart_write_wakeup+0x21/0x30
[  428.371337]  [<ffffffffa24e8865>] serial8250_tx_chars+0x225/0x240
[  428.387182]  [<ffffffffa24e8a5f>] serial8250_handle_irq.part.21+0xdf/0xf0
[  428.404405]  [<ffffffffa24e8ad7>] serial8250_default_handle_irq+0x47/0x70
[  428.421603]  [<ffffffffa24e4023>] serial8250_interrupt+0x63/0x120
[  428.437398]  [<ffffffffa20e0521>] __handle_irq_event_percpu+0x81/0x1d0
[  428.454024]  [<ffffffffa20e0693>] handle_irq_event_percpu+0x23/0x60
[  428.470091]  [<ffffffffa20e070c>] handle_irq_event+0x3c/0x60
[  428.484900]  [<ffffffffa20e3d10>] handle_edge_irq+0x80/0x150
[  428.499687]  [<ffffffffa20312ad>] handle_irq+0x1d/0x30
[  428.513458]  [<ffffffffa271c22b>] do_IRQ+0x4b/0xd0
[  428.526456]  [<ffffffffa271a282>] common_interrupt+0x82/0x82
[  428.541125]  <EOI> [  428.544999]  [<ffffffffa2718f36>] ? native_safe_halt+0x6/0x10
[  428.559947]  [<ffffffffa2718c10>] default_idle+0x20/0x100
[  428.574182]  [<ffffffffa2038f3f>] arch_cpu_idle+0xf/0x20
[  428.588183]  [<ffffffffa27190b3>] default_idle_call+0x23/0x30
[  428.603091]  [<ffffffffa20c81b1>] cpu_startup_entry+0x1c1/0x230
[  428.618343]  [<ffffffffa270bc94>] rest_init+0x84/0x90
[  428.631830]  [<ffffffffa2d58f7d>] start_kernel+0x438/0x445
[  428.646182]  [<ffffffffa2d58120>] ? early_idt_handler_array+0x120/0x120
[  428.662761]  [<ffffffffa2d582ca>] x86_64_start_reservations+0x24/0x26
[  428.678952]  [<ffffffffa2d5840a>] x86_64_start_kernel+0x13e/0x14d
[  428.694421] Code: 00 ba 01 00 00 00 be 01 00 00 00 e8 4f 78 c0 ff 5b 5d c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <48> 8b 87 e0 01 00 00 48 89 fb a8 20 75 20 48 8d bb 30 02 00 00 
[  428.740966] RIP  [<ffffffffa24bfb6c>] tty_wakeup+0xc/0x70
[  428.755113]  RSP <ffff9a1a5fc03df8>
[  428.765310] CR2: 00000000000001e0

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
