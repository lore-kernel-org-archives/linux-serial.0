From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB Ooops PL2303 when unplug while use (linux v3.7.3)
Date: Wed, 13 Feb 2013 15:25:13 +0100
Message-ID: <20130213142513.GA21078@localhost>
References: <510B2C09.7020700@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:54105 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934039Ab3BMO0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 09:26:37 -0500
Content-Disposition: inline
In-Reply-To: <510B2C09.7020700@gtsys.com.hk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

On Fri, Feb 01, 2013 at 10:44:25AM +0800, Chris Ruehl wrote:
> I file a report for you, please have a look when you have time.

Thanks for the bug report, Chris.

You have come across what looks like a known issue, which since it's
discovery last summer has been made worse by an unrelated change.

A similar oops was reported and its cause identified in this thread:

	http://marc.info/?l=linux-usb&m=133837337927749&w=2

It turns out that the tty-layer may call the driver's dtr_rts even after
the device has been disconnected and the tty device unregistered. Since
last summer another change has made the problem worse by setting the
port data to NULL which results in even more drivers hitting the
problem.

While waiting for input from the tty-guru Alan Cox, and as the immediate
cause of that oops was remedied (by moving the offending interface
access in the driver in question), the problem was unfortunately
forgotten (or rather down-prioritised) until now.

I can still reliably reproduce a similar oops with pl2303 in the setup
which I used last summer, where I first open the port and then open and
close it repeatedly (while keeping the first reference open). When
disconnecting the device, the first reference is properly hung up, while
the second open fails (due to the disconnect) but still the tty layer
continues with an orderly close (which includes the call to dtr_rts)
despite the second open having failed, and to make things worse, even
when the tty device has been unregistered. I'll elaborate on this in a
follow up mail.

How about your oops (included below for reference) -- can you reproduce
it reliably, or was it a one-time thing? Do you only have minicom open
the port, or is there another process already holding the port open?

I'm responding to this mail with an updated version of a patch I
submitted last summer which works around the tty-bug and fixes the oops
that I can trigger. Care to give it a try?

Greg, I believe we need to get this fix into stable either way. It fixes
a perfectly reproducible null-deref in several usb-serial drivers. Even
if the original cause is in tty, which keeps calling dtr_rts even after
tty_unregister_device returns, I see no reason not to refactor the
disconnect handling for dtr_rts to usb-serial core (while fixing the
new null-derefs). This way it can also more easily be removed once the
tty bug has been fixed (it could even be more than one).

Thanks,
Johan

> [171977.391986] pl2303 ttyUSB0: pl2303 converter now disconnected from ttyUSB0
> [171977.392001] pl2303 2-1.2:1.0: device disconnected
> [171977.489723] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [171977.489788] IP: [<ffffffff8102210d>] __ticket_spin_lock+0x5/0x1b
> [171977.489837] PGD 944ef067 PUD 944ee067 PMD 0 
> [171977.489874] Oops: 0002 [#1] SMP 
> [171977.489901] Modules linked in: usblp pl2303 usbserial tun ip6table_filter ip6_tables iptable_filter ip_tables ebtable_nat ebtables x_tables ppdev lp bnep rfcomm bluetooth cpufreq_userspace cpufreq_conservative cpufreq_stats cpufreq_powersave xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 binfmt_misc deflate zlib_deflate ctr twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common serpent_sse2_x86_64 glue_helper lrw serpent_generic xts gf128mul blowfish_x86_64 blowfish_common cast5_avx_x86_64 ablk_helper cryptd cast5_generic des_generic cbc ecb sha512_generic sha256_generic sha1_ssse3 sha1_generic hmac af_key fuse bridge stp llc loop snd_hda_codec_realtek i915 drm_kms_helper snd_hda_intel snd_hda_codec drm snd_hwdep snd_pcm snd_seq snd_timer acpi_cpufreq 
 i2c_algo_bit snd_seq_device kvm_intel snd parport_pc soundcore psmouse video mperf processor thermal_sys button hid_generic wmi parport pcspkr snd_page_alloc serio_raw kvm i2c_i801 i2c_core joydev evdev tpm_tis tpm tpm_bios hid_logitech_dj ext4 mbcache jbd2 crc16 dm_mod usb_storage nbd usbhid hid sd_mod crc_t10dif ahci libahci ehci_hcd libata scsi_mod usbcore usb_common r8169 mii
> [171977.490824] CPU 0 
> [171977.490842] Pid: 9298, comm: minicom Not tainted 3.7.3 #3 LENOVO 1652A7B/To be filled by O.E.M.
> [171977.490901] RIP: 0010:[<ffffffff8102210d>]  [<ffffffff8102210d>] __ticket_spin_lock+0x5/0x1b
> [171977.490960] RSP: 0018:ffff88004a427aa0  EFLAGS: 00010082
> [171977.490996] RAX: 0000000000010000 RBX: 0000000000000282 RCX: 0000000000000000
> [171977.491043] RDX: ffff88012d7b1000 RSI: 0000000000000282 RDI: 0000000000000000
> [171977.491090] RBP: ffff88012d7b1000 R08: 0000000000000000 R09: 0000000000000282
> [171977.491136] R10: 0000000000000282 R11: ffffffff813150a6 R12: 0000000000000000
> [171977.491185] R13: 0000000000000282 R14: ffff88003d745d00 R15: ffff88003d745d00
> [171977.491232] FS:  00007fc23503d700(0000) GS:ffff88013fa00000(0000) knlGS:0000000000000000
> [171977.491287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [171977.491325] CR2: 0000000000000000 CR3: 000000009493c000 CR4: 00000000000427e0
> [171977.491371] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [171977.491418] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [171977.491465] Process minicom (pid: 9298, threadinfo ffff88004a426000, task ffff880139a84600)
> [171977.491518] Stack:
> [171977.491533]  ffffffff81022176 ffffffff813150a6 0000000000000282 0000000000000000
> [171977.491590]  ffffffffa0518454 ffff88012d7b1008 ffff88012d7b6800 ffff88012d7b1018
> [171977.491647]  ffffffff811f4881 ffff88012d7b1008 ffff88012d7b6800 0000000000000000
> [171977.491703] Call Trace:
> [171977.491724]  [<ffffffff81022176>] ? default_spin_lock_flags+0x5/0xb
> [171977.491768]  [<ffffffff813150a6>] ? _raw_spin_lock_irqsave+0x1e/0x26
> [171977.491815]  [<ffffffffa0518454>] ? pl2303_dtr_rts+0x21/0x53 [pl2303]
> [171977.491861]  [<ffffffff811f4881>] ? tty_port_close_start+0x16a/0x178
> [171977.491905]  [<ffffffff811f4cc4>] ? tty_port_close+0x11/0x43
> [171977.491944]  [<ffffffff811ecf17>] ? tty_release+0x16d/0x4b9
> [171977.491984]  [<ffffffff810ec16f>] ? __pollwait+0xd0/0xd0
> [171977.492021]  [<ffffffff81313b6e>] ? mutex_lock+0xd/0x2b
> [171977.492059]  [<ffffffffa050b265>] ? serial_activate+0x52/0x7c [usbserial]
> [171977.492104]  [<ffffffff810ec16f>] ? __pollwait+0xd0/0xd0
> [171977.492141]  [<ffffffff811eef55>] ? tty_open+0x33a/0x46a
> [171977.492178]  [<ffffffff810e185f>] ? chrdev_open+0x12e/0x149
> [171977.492216]  [<ffffffff810e1731>] ? cdev_put+0x1a/0x1a
> [171977.492253]  [<ffffffff810dd2d1>] ? do_dentry_open+0x171/0x217
> [171977.492293]  [<ffffffff810dd44a>] ? finish_open+0x2c/0x35
> [171977.492331]  [<ffffffff810e8955>] ? do_last+0x897/0xa38
> [171977.492367]  [<ffffffff810e6c33>] ? __inode_permission+0x62/0xa3
> [171977.492408]  [<ffffffff8104a552>] ? lg_local_lock+0x11/0x14
> [171977.492446]  [<ffffffff810e908c>] ? path_openat+0xc0/0x33b
> [171977.492487]  [<ffffffff810077ad>] ? read_tsc+0x5/0x16
> [171977.492522]  [<ffffffff810e93fa>] ? do_filp_open+0x2c/0x72
> [171977.492561]  [<ffffffff810cf7ef>] ? kmem_cache_alloc+0x26/0xa1
> [171977.492600]  [<ffffffff81315085>] ? _raw_spin_lock+0x5/0x8
> [171977.492638]  [<ffffffff810f3c79>] ? __alloc_fd+0xf9/0x10c
> [171977.492677]  [<ffffffff810dd026>] ? do_sys_open+0x60/0xe7
> [171977.492716]  [<ffffffff8131a629>] ? system_call_fastpath+0x16/0x1b
> [171977.492757] Code: 02 81 4c 89 c9 44 89 c6 48 89 c7 41 5a e9 9d fb ff ff 0f b7 f6 40 0f b6 ff 48 89 c2 41 59 e9 fc fc ff ff 90 90 90 b8 00 00 01 00 <f0> 0f c1 07 89 c2 c1 e8 10 66 39 c2 74 07 f3 90 66 8b 17 eb f4 
> [171977.493018] RIP  [<ffffffff8102210d>] __ticket_spin_lock+0x5/0x1b
> [171977.493062]  RSP <ffff88004a427aa0>
> [171977.493086] CR2: 0000000000000000
> [171977.517440] ---[ end trace 6ffd69640c166d14 ]---
