From: Coleman Brumley <coleman.brumley@gmail.com>
Subject: Line Discipline Kernel BUG when using usb-serial and mos7840 in v3.11
Date: Fri, 25 Apr 2014 11:05:54 -0400
Message-ID: <CAEBke53+w73+hBmNpafnaY9dYps=JayZGjYz2E=BrmTFsOfVmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:62713 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbaDYPF4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Apr 2014 11:05:56 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so4174281qcx.27
        for <linux-serial@vger.kernel.org>; Fri, 25 Apr 2014 08:05:54 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm working with a line discipline in v3.11.10.5 in Ubuntu 12.04 LTS.
The kernel has been modified to use a HZ of 1000. CONFIG_HZ_1000=y and
CONFIG_HZ=1000 in .config.

I have a B&B USOPTL4 RS485 to USB converter connected, I have
usb-serial loaded and mos7840 loaded (CONFIG_USB_SERIAL=m and
CONFIG_USB_MOS7840=m) . The converter is identified and shows in dmesg
output and is attached to /dev/ttyUSB0.

This ldisc works correctly in older kernels, but this seems to fail in
v3.x kernels. I know for certain this happens in v3.2 and v3.11, both
on Ubuntu 12.04 LTS. To be honest, though, I don't recall using this
with a USB converter as all of those machines (mostly embedded) had
physical serial ports.

My line discipline loads correctly (I'm using O_RDWR|O_NONBLOCK) but
when the TIOCSETD ioctl is called, the kernel generates the following
bug report.

Is this an issue in the usb serial driver, the way my code calls
TIOCSETD, or something else?

Now that I think of it, my ldisc open function using printk to state
that it's open

printk(MY_MSG "Device %s set to my_ldisc at %d",my_ldisc_tty->name, baud);

where baud comes from tty_get_baud_rate. But it seems that message
isn't in dmesg output. So, is it possible that the call to open is
delayed and failing upon calling tty_get_baud_rate?

 1916.989339] ------------[ cut here ]------------
[ 1916.989344] kernel BUG at drivers/tty/tty_ioctl.c:990!
[ 1916.989375] invalid opcode: 0000 [#1] SMP
[ 1916.989379] Modules linked in: my_ldisc(OF) mos7840(F) ftdi_sio(F)
usbserial(F) joydev(F) hid_generic(F) btusb(F) snd_ens1371(F)
gameport(F) snd_ac97_codec(F) ac97_bus(F) snd_pcm(F) vmw_balloon(F)
snd_seq_midi(F) snd_rawmidi(F) psmouse(F) serio_raw(F)
snd_seq_midi_event(F) snd_seq(F) usbhid(F) hid(F) snd_timer(F)
snd_seq_device(F) snd(F) soundcore(F) snd_page_alloc(F) mac_hid(F)
vmwgfx(F) ttm(F) vmw_vmci(F) bnep(F) drm(F) rfcomm(F) i2c_piix4(F)
shpchp(F) bluetooth(F) parport_pc(F) ppdev(F) lp(F) parport(F)
floppy(F) pcnet32(F) mii(F) mptspi(F) mptscsih(F) mptbase(F)
vmw_pvscsi(F) vmxnet3(F)
[ 1916.989418] CPU: 0 PID: 2955 Comm: fref_linux Tainted: GF
O 3.11.10.5-polarsoft #1
[ 1916.989420] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 06/02/2011
[ 1916.989422] task: f5cf4060 ti: e2e68000 task.ti: e2e68000
[ 1916.989425] EIP: 0060:[<c13d1fdd>] EFLAGS: 00010246 CPU: 0
[ 1916.989450] EIP is at tty_mode_ioctl+0x4fd/0x500
[ 1916.989452] EAX: f5093600 EBX: 00000000 ECX: 802c542a EDX: 00000000
[ 1916.989453] ESI: e2e69db0 EDI: e2e69db0 EBP: e2e69d84 ESP: e2e69d38
[ 1916.989454]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[ 1916.989456] CR0: 80050033 CR2: b4a9d000 CR3: 22f08000 CR4: 000407f0
[ 1916.989523] Stack:
[ 1916.989525]  00000002 f4ba9000 f7a95500 f5c01980 e2e69db0 c165d88f
c14b5eb9 00000000
[ 1916.989529]  00001388 00000000 00060303 00000001 004b735a 00000000
f4ba8000 518961af
[ 1916.989533]  f5093600 f47266a0 e2e69db0 e2e69d9c c13d2011 e2e69db0
f5093600 f47266a0
[ 1916.989536] Call Trace:
[ 1916.989562]  [<c165d88f>] ? __slab_free+0x18c/0x268
[ 1916.989583]  [<c14b5eb9>] ? usb_alloc_urb+0x19/0x40
[ 1916.989587]  [<c13d2011>] n_tty_ioctl_helper+0x31/0x100
[ 1916.989591]  [<f9a60ac0>] my_ldisc_open+0x180/0x1d0 [my_ldisc]
[ 1916.989611]  [<c115f327>] ? kfree+0xe7/0x110
[ 1916.989614]  [<c13ceb70>] ? n_tty_close+0x40/0x60
[ 1916.989616]  [<c13ceb77>] ? n_tty_close+0x47/0x60
[ 1916.989618]  [<c13ceb77>] ? n_tty_close+0x47/0x60
[ 1916.989620]  [<c13d2623>] tty_ldisc_open.isra.2+0x33/0x60
[ 1916.989622]  [<c13d2c50>] tty_set_ldisc+0x1a0/0x6c0
[ 1916.989625]  [<c1665aad>] ? _raw_spin_lock_irqsave+0x2d/0x40
[ 1916.989630]  [<fa89140f>] ? serial_wait_until_sent+0x5f/0xc0 [usbserial]
[ 1916.989633]  [<fa8916ad>] ? serial_chars_in_buffer+0x3d/0x70 [usbserial]
[ 1916.989635]  [<c13d1653>] ? tty_wait_until_sent+0xd3/0x100
[ 1916.989668]  [<c10645ba>] ? ptrace_stop+0x16a/0x220
[ 1916.989671]  [<c13cd3ad>] tty_ioctl+0x4cd/0xa30
[ 1916.989674]  [<c1064263>] ? send_signal+0x43/0x80
[ 1916.989704]  [<c100fe9a>] ? do_signal+0x3a/0x8d0
[ 1916.989723]  [<c101adf8>] ? send_sigtrap+0x78/0x90
[ 1916.989726]  [<c13ccee0>] ? no_tty+0x30/0x30
[ 1916.989729]  [<c1182f7c>] do_vfs_ioctl+0x7c/0x580
[ 1916.989731]  [<c1183517>] SyS_ioctl+0x97/0xa0
[ 1916.989734]  [<c166d20d>] sysenter_do_call+0x12/0x28
[ 1916.989735] Code: ea f8 ff ff e9 0d fc ff ff b9 07 00 00 00 89 f2
89 d8 e8 d7 f8 ff ff e9 fa fb ff ff e8 cd 32 c8 ff b8 ea ff ff ff e9
eb fb ff ff <0f> 0b 90 55 89 e5 83 ec 10 89 5d f4 89 75 f8 89 7d fc 66
66 66
[ 1916.989765] EIP: [<c13d1fdd>] tty_mode_ioctl+0x4fd/0x500 SS:ESP 0068:e2e69d38
[ 1916.989853] ---[ end trace 20fe81540ae67627 ]---

uname -r output:
Linux ubuntu 3.11.10.5-coleman #1 SMP Thu Apr 24 11:10:31 PDT 2014
i686 i686 i386 GNU/Linux

dmesg output when the USOPTL4 is attached and my ldisc is installed:
[ 1055.255235] usbcore: registered new interface driver mos7840
[ 1055.255996] usbserial: USB Serial support registered for Moschip
7840/7820 USB Serial Driver
[ 1060.564983] usb 2-2.2: new full-speed USB device number 6 using uhci_hcd
[ 1060.681890] usb 2-2.2: New USB device found, idVendor=0856, idProduct=ac11
[ 1060.681895] usb 2-2.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[ 1060.681897] usb 2-2.2: Product: Model USOPTL4
[ 1060.681900] usb 2-2.2: Manufacturer: B&B Electronics
[ 1060.681901] usb 2-2.2: SerialNumber: BBPA191X
[ 1060.692052] ftdi_sio 2-2.2:1.0: FTDI USB Serial Device converter detected
[ 1060.692100] usb 2-2.2: Detected FT232RL
[ 1060.692103] usb 2-2.2: Number of endpoints 2
[ 1060.692105] usb 2-2.2: Endpoint 1 MaxPacketSize 64
[ 1060.692108] usb 2-2.2: Endpoint 2 MaxPacketSize 64
[ 1060.692110] usb 2-2.2: Setting MaxPacketSize 64
[ 1060.696156] usb 2-2.2: FTDI USB Serial Device converter now
attached to ttyUSB0
[ 1805.368185] My Line Discipline initialized

-- 
- Coleman
