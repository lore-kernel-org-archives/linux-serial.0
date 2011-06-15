From: John Lumby <johnlumby@hotmail.com>
Subject: PROBLEM:  BUG and system dies if cat /proc/tty/driver/serial while
 console on ttyS0
Date: Wed, 15 Jun 2011 11:08:51 -0400
Message-ID: <COL116-W65B54193A5784AAE0E1505A36B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from col0-omc2-s14.col0.hotmail.com ([65.55.34.88]:11119 "EHLO
	col0-omc2-s14.col0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753026Ab1FOPO0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jun 2011 11:14:26 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de


If I direct kernel console output to the serial port ttyS0
=A0by grub kernel command line like so
=A0 =A0 =A0 =A0 =A0 kernel /vmlinuz-2.6.39-FLG ro root=3D/dev/sdb3 root=
fstype=3Dext3 selinux=3D0 console=3DttyS0,19200n8r console=3Dtty0
then console output appears at the other end of the ttyS0 as expected, =
 but then if I log in (on local tty1) and

cat /proc/tty/driver/serial

I get this=A0 (on 2.6.39)

BUG:   sleeping function called from invalid context at arch/x86/mm/fau=
lt.c:1087
and the system is dead.

the line number refers to this code :

=A0=A0=A0 =A0=A0=A0 /*

=A0=A0=A0 =A0=A0=A0 =A0* The above down_read_trylock() might have succe=
eded in

=A0=A0=A0 =A0=A0=A0 =A0* which case we'll have missed the might_sleep()=
 from

=A0=A0=A0 =A0=A0=A0 =A0* down_read():

=A0=A0=A0 =A0=A0=A0 =A0*/

=A0=A0=A0 =A0=A0=A0 might_sleep();



This also occurs on 2.6.36 so (I would assume) many other releases as w=
ell.
John Lumby

-----------------------------------------------------------------------=
-----------------

ver_linux output:
(note --- the 4 CPUs are 2 cores each with SMT enabled)
(note -- relevant scsi and usb mass-stg drivers are builtin)

Linux lumbyont.localdomain 2.6.39-vnla #1 SMP Tue May 31 13:55:29 EDT 2=
011 i686 GNU/Linux

Gnu C 4.5.3
Gnu make 3.81
binutils 2.21
util-linux 2.13-pre7
mount support
module-init-tools 3.3-pre1
e2fsprogs 1.41.13
pcmciautils 014
quota-tools 3.13.
PPP 2.4.4
isdn4k-utils 3.9
Linux C Library 2.11.1
Dynamic linker (ldd) 2.11.1
Procps 3.2.7
Net-tools 1.60
Kbd 1.12
oprofile 0.9.7git
Sh-utils 8.9
udev 095
wireless-tools 29
Modules Loaded snd_hda_intel snd_hda_codec rtc_cmos rtc_core rtc_lib br=
idge stp llc i915 drm_kms_helper intel_agp intel_gtt tun xt_state ipt_M=
ASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_i=
pv4 dm_mod parport_pc lp parport
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /proc/cpuinfo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 28
model name : Intel(R) Atom(TM) CPU 330 @ 1.60GHz
stepping : 2
cpu MHz : 1596.167
cache size : 512 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc a=
rch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx1=
6 xtpr pdcm movbe lahf_lm dts
bogomips : 3192.33
clflush size : 64
cache_alignment : 64
address sizes : 32 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 28
model name : Intel(R) Atom(TM) CPU 330 @ 1.60GHz
stepping : 2
cpu MHz : 1596.167
cache size : 512 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 2
initial apicid : 2
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc a=
rch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx1=
6 xtpr pdcm movbe lahf_lm dts
bogomips : 3191.98
clflush size : 64
cache_alignment : 64
address sizes : 32 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 28
model name : Intel(R) Atom(TM) CPU 330 @ 1.60GHz
stepping : 2
cpu MHz : 1596.167
cache size : 512 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc a=
rch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx1=
6 xtpr pdcm movbe lahf_lm dts
bogomips : 3191.95
clflush size : 64
cache_alignment : 64
address sizes : 32 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 28
model name : Intel(R) Atom(TM) CPU 330 @ 1.60GHz
stepping : 2
cpu MHz : 1596.167
cache size : 512 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 2
apicid : 3
initial apicid : 3
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 10
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov p=
at clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc a=
rch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx1=
6 xtpr pdcm movbe lahf_lm dts
bogomips : 3191.85
clflush size : 64
cache_alignment : 64
address sizes : 32 bits physical, 48 bits virtual
power management:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /proc/modules =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
snd_hda_intel 17288 0 - Live 0xf81e5000
snd_hda_codec 49964 1 snd_hda_intel, Live 0xf81ca000
rtc_cmos 6500 0 - Live 0xf8151000
rtc_core 13963 1 rtc_cmos, Live 0xf814b000
rtc_lib 1765 1 rtc_core, Live 0xf80d0000
bridge 56404 0 - Live 0xf80b9000
stp 1136 1 bridge, Live 0xf80b3000
llc 2864 2 bridge,stp, Live 0xf8005000
i915 297997 1 - Live 0xf80e5000
drm_kms_helper 24000 1 i915, Live 0xf80d8000
intel_agp 8367 1 i915, Live 0xf8c10000
intel_gtt 11161 3 i915,intel_agp, Live 0xf8bd7000
tun 12525 1 - Live 0xf8b98000
xt_state 867 26 - Live 0xf8b44000
ipt_MASQUERADE 1358 1 - Live 0xf8ae6000
iptable_nat 3543 1 - Live 0xf8aa6000
nf_nat 11151 2 ipt_MASQUERADE,iptable_nat, Live 0xf8a3a000
nf_conntrack_ipv4 8405 29 iptable_nat,nf_nat, Live 0xf8910000
nf_conntrack 40997 5 xt_state,ipt_MASQUERADE,iptable_nat,nf_nat,nf_conn=
track_ipv4, Live 0xf8868000
nf_defrag_ipv4 887 1 nf_conntrack_ipv4, Live 0xf8696000
dm_mod 52766 0 - Live 0xf8350000
parport_pc 17355 1 - Live 0xf81de000
lp 6716 0 - Live 0xf802b000
parport 24631 2 parport_pc,lp, Live 0xf8159000
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /proc/ioports =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
0000-0cf7 : PCI Bus 0000:00
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-0060 : keyboard
0064-0064 : keyboard
0070-0071 : rtc0
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:1f.1
0170-0177 : piix
01f0-01f7 : 0000:00:1f.1
01f0-01f7 : piix
0376-0376 : 0000:00:1f.1
0376-0376 : piix
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : 0000:00:1f.1
03f6-03f6 : piix
03f8-03ff : serial
0400-047f : pnp 00:06
0400-0403 : ACPI PM1a_EVT_BLK
0404-0405 : ACPI PM1a_CNT_BLK
0408-040b : ACPI PM_TMR
0410-0415 : ACPI CPU throttle
0420-0420 : ACPI PM2_CNT_BLK
0428-042f : ACPI GPE0_BLK
0500-053f : pnp 00:06
0680-06ff : pnp 00:06
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
1000-1fff : PCI Bus 0000:04
1000-10ff : 0000:04:00.0
2000-2fff : PCI Bus 0000:01
2000-20ff : 0000:01:00.0
3000-301f : 0000:00:1f.3
3000-301f : i801_smbus
3020-303f : 0000:00:1d.3
3040-305f : 0000:00:1d.2
3060-307f : 0000:00:1d.1
3080-309f : 0000:00:1d.0
30a0-30af : 0000:00:1f.2
30a0-30af : ata_piix
30b0-30bf : 0000:00:1f.1
30b0-30bf : piix
30c0-30c7 : 0000:00:1f.2
30c0-30c7 : ata_piix
30c8-30cf : 0000:00:1f.2
30c8-30cf : ata_piix
30e0-30e7 : 0000:00:02.0
30e8-30eb : 0000:00:1f.2
30e8-30eb : ata_piix
30ec-30ef : 0000:00:1f.2
30ec-30ef : ata_piix
4000-4fff : PCI Bus 0000:03
5000-5fff : PCI Bus 0000:02
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /proc/iomem =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
00000000-0000ffff : reserved
00010000-0008efff : System RAM
0008f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cb000-000cbfff : Adapter ROM
000e0000-000fffff : reserved
000e0000-000effff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-7f531fff : System RAM
01000000-0141a980 : Kernel code
0141a981-0159cabf : Kernel data
0160d000-0166cfff : Kernel bss
7f532000-7f539fff : reserved
7f53a000-7f5cafff : System RAM
7f5cb000-7f5cefff : reserved
7f5cf000-7f65ffff : System RAM
7f660000-7f6effff : ACPI Non-volatile Storage
7f6f0000-7f6f1fff : System RAM
7f6f2000-7f6fefff : ACPI Tables
7f6ff000-7f6fffff : System RAM
7f700000-7fffffff : reserved
80000000-ffffffff : reserved
80000000-f0000000 : PCI Bus 0000:00
80000000-8fffffff : 0000:00:02.0
90000000-900fffff : PCI Bus 0000:01
90000000-9000ffff : 0000:01:00.0
90020000-9003ffff : 0000:01:00.0
90100000-901fffff : PCI Bus 0000:04
90100000-901000ff : 0000:04:00.0
90200000-902fffff : PCI Bus 0000:01
90200000-90200fff : 0000:01:00.0
90300000-9037ffff : 0000:00:02.0
90380000-903bffff : 0000:00:02.0
903c0000-903c3fff : 0000:00:1b.0
903c0000-903c3fff : ICH HD audio
903c4000-903c43ff : 0000:00:1d.7
903c4000-903c43ff : ehci_hcd
90400000-904fffff : PCI Bus 0000:04
90400000-9040ffff : 0000:04:00.0
90500000-906fffff : PCI Bus 0000:03
90700000-908fffff : PCI Bus 0000:03
90900000-90afffff : PCI Bus 0000:02
90b00000-90cfffff : PCI Bus 0000:02
f8000000-febfffff : PCI Bus 0000:00
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed13000-fed13fff : pnp 00:01
fed14000-fed17fff : pnp 00:01
fed18000-fed18fff : pnp 00:01
fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : pnp 00:01
fed20000-fed3ffff : pnp 00:01
fed45000-fed99fff : pnp 00:01
fee00000-fee00fff : Local APIC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /proc/scsi/scsi =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: ATA Model: WDC WD5000AAKS-6 Rev: 05.0
Type: Direct-Access ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
Vendor: ATA Model: WDC WD5000AAKS-6 Rev: 05.0
Type: Direct-Access ANSI SCSI revision: 05
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
