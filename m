From: Abhijit Lamsoge <abhijitelinux@gmail.com>
Subject: Re: Serial Core crash in tty_open
Date: Wed, 28 May 2014 14:34:07 +0530
Message-ID: <CAKnSG-bX89qBe-TJUAJBTBGS1Y9sq3sc4L9GBrwKpxUxE2QHKw@mail.gmail.com>
References: <CAKnSG-bhcO6x309aiE2nwgBjXU=0u=3dXH-GgKQvjK=6S-q1JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35259 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbaE1JEJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 May 2014 05:04:09 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so5696477lbv.3
        for <linux-serial@vger.kernel.org>; Wed, 28 May 2014 02:04:07 -0700 (PDT)
In-Reply-To: <CAKnSG-bhcO6x309aiE2nwgBjXU=0u=3dXH-GgKQvjK=6S-q1JA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi All,
Crash Starts here.

 1498.722292] ------------[ cut here ]------------
[ 1498.722305] WARNING: CPU: 3 PID: 5029 at
/build/buildd/linux-3.13.0/drivers/tty/tty_io.c:1474
tty_init_dev+0x1d0/0x1e0()
[ 1498.722308] tty_init_dev:  driver does not set tty->port. This will
crash the kernel later. Fix the driver!
[ 1498.722310] Modules linked in: lvsd(OF) nls_utf8 isofs pci_stub
vboxpci(OF) vboxnetadp(OF) vboxnetflt(OF) vboxdrv(OF) bnep rfcomm
snd_hda_codec_hdmi snd_hda_codec_realtek uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_core videodev btusb bluetooth joydev arc4
iwldvm mac80211 intel_rapl x86_pkg_temp_thermal intel_powerclamp
coretemp kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd
psmouse serio_raw iwlwifi snd_hda_intel snd_hda_codec thinkpad_acpi
lpc_ich nvram snd_hwdep cfg80211 snd_pcm snd_seq_midi
snd_seq_midi_event snd_rawmidi snd_page_alloc snd_seq mei_me mei
snd_seq_device snd_timer snd soundcore i915 parport_pc drm_kms_helper
drm ppdev video i2c_algo_bit wmi lp parport mac_hid hid_generic usbhid
hid e1000e ahci sdhci_pci libahci ptp sdhci pps_core
[ 1498.722401] CPU: 3 PID: 5029 Comm: prj Tainted: GF          O
3.13.0-24-generic #46-Ubuntu
[ 1498.722403] Hardware name: LENOVO 242962Q/242962Q, BIOS G4ET97WW
(2.57 ) 10/17/2013
[ 1498.722406]  0000000000000009 ffff8800c82adb48 ffffffff81715a64
ffff8800c82adb90
[ 1498.722413]  ffff8800c82adb80 ffffffff810676bd ffff8800ac727800
ffff8800a18556c0
[ 1498.722418]  0000000000000001 ffffffff81863320 0000000000000000
ffff8800c82adbe0
[ 1498.722423] Call Trace:
[ 1498.722432]  [<ffffffff81715a64>] dump_stack+0x45/0x56
[ 1498.722438]  [<ffffffff810676bd>] warn_slowpath_common+0x7d/0xa0
[ 1498.722443]  [<ffffffff8106772c>] warn_slowpath_fmt+0x4c/0x50
[ 1498.722450]  [<ffffffff81362e63>] ? ___ratelimit+0x93/0x100
[ 1498.722455]  [<ffffffff814428e0>] tty_init_dev+0x1d0/0x1e0
[ 1498.722460]  [<ffffffff81443593>] tty_open+0x2f3/0x600
[ 1498.722467]  [<ffffffff811bdebf>] chrdev_open+0x9f/0x1d0
[ 1498.722472]  [<ffffffff811b6997>] do_dentry_open+0x1c7/0x2e0
[ 1498.722477]  [<ffffffff811bde20>] ? cdev_put+0x30/0x30
[ 1498.722481]  [<ffffffff811b6d39>] vfs_open+0x49/0x50
[ 1498.722486]  [<ffffffff811c6c61>] do_last+0x561/0x1200
[ 1498.722494]  [<ffffffff8130e23b>] ? apparmor_file_alloc_security+0x5b/0x180
[ 1498.722500]  [<ffffffff811c8d7b>] path_openat+0xbb/0x620
[ 1498.722506]  [<ffffffff8115683a>] ? __free_pages+0x5a/0x60
[ 1498.722511]  [<ffffffff811ca13a>] do_filp_open+0x3a/0x90
[ 1498.722517]  [<ffffffff811d6f27>] ? __alloc_fd+0xa7/0x130
[ 1498.722522]  [<ffffffff811b8859>] do_sys_open+0x129/0x280
[ 1498.722529]  [<ffffffff81020d35>] ? syscall_trace_enter+0x145/0x250
[ 1498.722534]  [<ffffffff811b89ce>] SyS_open+0x1e/0x20
[ 1498.722539]  [<ffffffff8172663f>] tracesys+0xe1/0xe6
[ 1498.722542] ---[ end trace 97728bd8c9f8c14b ]---
[ 1498.722552] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000090
[ 1498.722624] IP: [<ffffffff814427b5>] tty_init_dev+0xa5/0x1e0
[ 1498.722672] PGD b678f067 PUD 8b650067 PMD 0
[ 1498.722715] Oops: 0002 [#1] SMP
[ 1498.722749] Modules linked in: lvsd(OF) nls_utf8 isofs pci_stub
vboxpci(OF) vboxnetadp(OF) vboxnetflt(OF) vboxdrv(OF) bnep rfcomm
snd_hda_codec_hdmi snd_hda_codec_realtek uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_core videodev btusb bluetooth joydev arc4
iwldvm mac80211 intel_rapl x86_pkg_temp_thermal intel_powerclamp
coretemp kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd
psmouse serio_raw iwlwifi snd_hda_intel snd_hda_codec thinkpad_acpi
lpc_ich nvram snd_hwdep cfg80211 snd_pcm snd_seq_midi
snd_seq_midi_event snd_rawmidi snd_page_alloc snd_seq mei_me mei
snd_seq_device snd_timer snd soundcore i915 parport_pc drm_kms_helper
drm ppdev video i2c_algo_bit wmi lp parport mac_hid hid_generic usbhid
hid e1000e ahci sdhci_pci libahci ptp sdhci pps_core
[ 1498.723552] CPU: 3 PID: 5029 Comm: prj Tainted: GF       W  O
3.13.0-24-generic #46-Ubuntu
[ 1498.723612] Hardware name: LENOVO 242962Q/242962Q, BIOS G4ET97WW
(2.57 ) 10/17/2013
[ 1498.723668] task: ffff880114b82fe0 ti: ffff8800c82ac000 task.ti:
ffff8800c82ac000
[ 1498.723722] RIP: 0010:[<ffffffff814427b5>]  [<ffffffff814427b5>]
tty_init_dev+0xa5/0x1e0
[ 1498.723786] RSP: 0018:ffff8800c82adbf0  EFLAGS: 00010296
[ 1498.723825] RAX: 0000000000000000 RBX: ffff8800ac727800 RCX: 0000000000000006
[ 1498.723877] RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000009
[ 1498.723929] RBP: ffff8800c82adc10 R08: 0000000000000096 R09: 00000000000003f7
[ 1498.723981] R10: 0000000000000000 R11: ffff8800c82ad876 R12: ffff8800a18556c0
[ 1498.724033] R13: 0000000000000001 R14: ffffffff81863320 R15: 0000000000000000
[ 1498.724086] FS:  00007fe64bee4740(0000) GS:ffff88011e2c0000(0000)
knlGS:0000000000000000
[ 1498.724145] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1498.724187] CR2: 0000000000000090 CR3: 00000000989b9000 CR4: 00000000001407e0
[ 1498.724239] Stack:
[ 1498.724256]  ffff880098acff10 ffff880098acff00 0000000000000000
ffff8800a18556c0
[ 1498.724323]  ffff8800c82adc68 ffffffff81443593 ffff8800960edd38
ffff880114b82fe0
[ 1498.724387]  2580000100008002 00000001c82adc7c ffff8800a1a1c068
ffff8800960edd38
[ 1498.724452] Call Trace:
[ 1498.724476]  [<ffffffff81443593>] tty_open+0x2f3/0x600
[ 1498.724518]  [<ffffffff811bdebf>] chrdev_open+0x9f/0x1d0
[ 1498.724560]  [<ffffffff811b6997>] do_dentry_open+0x1c7/0x2e0
[ 1498.724606]  [<ffffffff811bde20>] ? cdev_put+0x30/0x30
[ 1498.724646]  [<ffffffff811b6d39>] vfs_open+0x49/0x50
[ 1498.724686]  [<ffffffff811c6c61>] do_last+0x561/0x1200
[ 1498.724728]  [<ffffffff8130e23b>] ? apparmor_file_alloc_security+0x5b/0x180
[ 1498.724781]  [<ffffffff811c8d7b>] path_openat+0xbb/0x620
[ 1498.724824]  [<ffffffff8115683a>] ? __free_pages+0x5a/0x60
[ 1498.724868]  [<ffffffff811ca13a>] do_filp_open+0x3a/0x90
[ 1498.724912]  [<ffffffff811d6f27>] ? __alloc_fd+0xa7/0x130
[ 1498.724954]  [<ffffffff811b8859>] do_sys_open+0x129/0x280
[ 1498.724998]  [<ffffffff81020d35>] ? syscall_trace_enter+0x145/0x250
[ 1498.725047]  [<ffffffff811b89ce>] SyS_open+0x1e/0x20
[ 1498.725087]  [<ffffffff8172663f>] tracesys+0xe1/0xe6
[ 1498.725125] Code: 84 24 a0 00 00 00 48 89 de 4c 89 e7 48 8b 40 08
48 85 c0 74 79 ff d0 85 c0 78 7b 48 8b 83 b8 02 00 00 48 85 c0 0f 84
9b 00 00 00 <48> 89 98 90 00 00 00 48 8b b3 f8 01 00 00 48 89 df e8 65
83 00
[ 1498.725494] RIP  [<ffffffff814427b5>] tty_init_dev+0xa5/0x1e0
[ 1498.725547]  RSP <ffff8800c82adbf0>
[ 1498.725574] CR2: 0000000000000090
[ 1498.739706] ---[ end trace 97728bd8c9f8c14c ]---
root@hacked:~/work/mydr#

On Wed, May 28, 2014 at 2:25 PM, Abhijit Lamsoge
<abhijitelinux@gmail.com> wrote:
> Hi All,
> I had written a char/serial driver for Kernel 3.0 to 3.1 in old times
> and it used to work absolutely fine.
> Now I need this driver for some bluetooth, virtual mount-point for
> data transfer to and fro to mobile,
> for kernel version 3.8 onwards, however, there is a big crash, when I
> do any data transfer on the uart_port created by this driver.
> I have attached the crash file dmesg here.
> I am not sure, where the problem is, whether it's the kernel or the driver.
>
> Please let me know if anybody gets any idea from the crash.
>
>
> Abhijit
