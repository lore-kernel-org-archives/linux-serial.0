From: digger vermont <dv_mlist@verizon.net>
Subject: [Problem] BT PCMCIA/CF cards using serial_cs times out with 2.6
	kernel
Date: Tue, 03 Feb 2004 23:52:33 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1075870352.2176.7.camel@myrna>
References: <1074885137.3532.9.camel@myrna>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out007pub.verizon.net ([206.46.170.107]:46329 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S266144AbUBDEwg
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Feb 2004 23:52:36 -0500
In-Reply-To: <1074885137.3532.9.camel@myrna>
List-Id: linux-serial@vger.kernel.org
To: bluez-users <bluez-users@lists.sourceforge.net>, Russell King <rmk+serial@arm.linux.org.uk>, Linux Serial Mailing List <linux-serial@vger.kernel.org>

Hello All,
	I believe the first time I submitted this report it was rejected by the
mailing list because I was not subscribed.  Sorry if you've already seen
it.

digger

------------------------------------------------------
[1.] BT PCMCIA/CF cards using serial_cs times out with 2.6 kernel

[2.] Problem:
Changes to the serial driver in 2.6.xx kernels have caused problems 
with some bluetooth pcmcia/cf cards using the serial_cs module that do
work
properly with 2.4.xx kernels.

When the cards are plugged the uarts are correctly identified and the
ports
created.  However, hciattach returns errors when trying to attach the
port to
the BlueZ stack. Different settings have been tried such as baud rates
and
irq's through setserial with no difference.

This problem has also been reported by others on the BlueZ-Users mailing
list
is not platform specific.  It occurs on my powerbook.  I'm not sure of
the 
platforms of the other reported errors, but they are not powerpc's.

Here are more specifics:

kernel 2.4.24 works fin e.

kernel 2.6.2-rc1 and 2.6.2-rc3-ben1
    Com One Platinum:  Reported to work fine.
    Xircom PC cards:   Reported to time out.
    Socket CF:         Error is "BCSP initialization timed out".
                       Card is reported as 
		         "Socket", "CF+ Personal Network Card Rev 2.5"
			 
Here is the thread on mailing list where the problem was discused:
http://thread.gmane.org/gmane.linux.bluez.user/1864

[3.] Keywords: pcmcia, cf, bluetooth, serial, serial_cs

[4.] Kernel: 2.6.2-rc1 - 2.6.2-rc3-benh

[5.] no Oops

[6.] Example: hciattach ttyS0 socket

[7.] Environment

[7.1]script/ver_linux
Linux myrna 2.6.2-rc3-ben1 #4 Tue Feb 3 00:08:05 EST 2004 ppc GNU/Linux
  
Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre5
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.5
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         radeon rfcomm ds yenta_socket pcmcia_core ipt_ttl
ipt_limit ipt_state iptable_filter iptable_mangle ipt_LOG ipt_MASQUERADE
ipt_TOS ipt_REDIRECT ipt_REJECT ip_conntrack_irc ip_conntrack_ftp
snd_seq_oss 
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_usb_audio
snd_rawmidi 
snd_seq_device i2c_keywest snd_powermac snd_pcm snd_page_alloc snd_timer
i2c_core snd soundcore iptable_nat ip_conntrack ip_tables ohci_hcd
ehci_hcd 
usbcore bnep l2cap bluetooth uninorth_agp agpgart vfat ide_cd cdrom fat 
apm_emu airport orinoco hermes

[7.2]/proc/cpuinfo
processor       : 0
cpu             : 7455, altivec supported
clock           : 667MHz
revision        : 2.1 (pvr 8001 0201)
bogomips        : 665.60
machine         : PowerBook3,4
motherboard     : PowerBook3,4 MacRISC2 MacRISC Power Macintosh
detected as     : 73 (PowerBook Titanium III)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld

[7.3] /proc/modules
radeon 132204 2 - Live 0xe3050000
rfcomm 32696 2 - Live 0xe3396000
ds 15076 2 - Live 0xe3391000
yenta_socket 16288 0 - Live 0xe338c000
pcmcia_core 67124 2 ds,yenta_socket, Live 0xe339f000
ipt_ttl 2208 1 - Live 0xe330d000
ipt_limit 2560 33 - Live 0xe330b000
ipt_state 2112 5 - Live 0xe330f000
iptable_filter 2880 1 - Live 0xe32d9000
iptable_mangle 2912 0 - Live 0xe32cc000
ipt_LOG 7008 1 - Live 0xe3304000
ipt_MASQUERADE 3648 0 - Live 0xe32a7000
ipt_TOS 2720 0 - Live 0xe327b000
ipt_REDIRECT 2432 0 - Live 0xe327d000
ipt_REJECT 6720 0 - Live 0xe32c6000
ip_conntrack_irc 71196 0 - Live 0xe336a000
ip_conntrack_ftp 71872 0 - Live 0xe3357000
snd_seq_oss 38936 0 - Live 0xe3324000
snd_seq_midi_event 7168 1 snd_seq_oss, Live 0xe32c3000
snd_seq 59096 4 snd_seq_oss,snd_seq_midi_event, Live 0xe3347000
snd_pcm_oss 63972 0 - Live 0xe3336000
snd_mixer_oss 19680 1 snd_pcm_oss, Live 0xe32fe000
snd_usb_audio 69088 0 - Live 0xe3312000
snd_rawmidi 24064 1 snd_usb_audio, Live 0xe32f7000
snd_seq_device 8008 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe32c0000
i2c_keywest 9668 0 - Live 0xe329c000
snd_powermac 38832 0 - Live 0xe32ce000
snd_pcm 106712 3 snd_pcm_oss,snd_usb_audio,snd_powermac, Live 0xe32db000
snd_page_alloc 10852 1 snd_pcm, Live 0xe3255000
snd_timer 23972 2 snd_seq,snd_pcm, Live 0xe32b7000
i2c_core 22148 2 i2c_keywest,snd_powermac, Live 0xe32a0000
snd 52344 11
snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_usb_audio,snd_rawmidi,snd_seq_device,snd_powermac,snd_pcm,snd_timer, Live 0xe32a9000
soundcore 8804 1 snd, Live 0xe3277000
iptable_nat 24530 2 ipt_MASQUERADE,ipt_REDIRECT, Live 0xe3280000
ip_conntrack 33420 6
ipt_state,ipt_MASQUERADE,ipt_REDIRECT,ip_conntrack_irc,ip_conntrack_ftp,iptable_nat, Live 0xe324b000
ip_tables 17856 11
ipt_ttl,ipt_limit,ipt_state,iptable_filter,iptable_mangle,ipt_LOG,ipt_MASQUERADE,ipt_TOS,ipt_REDIRECT,ipt_REJECT,iptable_nat, Live 0xe3245000
ohci_hcd 20064 0 - Live 0xe323f000
ehci_hcd 27236 0 - Live 0xe3237000
usbcore 117688 5 snd_usb_audio,ohci_hcd,ehci_hcd, Live 0xe3259000
bnep 16640 0 - Live 0xe321f000
l2cap 23780 6 rfcomm,bnep, Live 0xe3218000
bluetooth 53728 5 rfcomm,bnep,l2cap, Live 0xe3228000
uninorth_agp 6752 1 - Live 0xe31be000
agpgart 33228 2 uninorth_agp, Live 0xe320e000
vfat 13952 0 - Live 0xe31ea000
ide_cd 44804 0 - Live 0xe31f7000
cdrom 43644 1 ide_cd, Live 0xe31d0000
fat 46212 1 vfat, Live 0xe31dd000
apm_emu 6604 1 - Live 0xe31b7000
airport 5760 0 - Live 0xe31ab000
orinoco 50452 1 airport, Live 0xe31c2000
hermes 13536 2 airport,orinoco, Live 0xe31ae000

[7.4]
cat /proc/ioports
00000000-007fffff : /pci@f2000000
  00001000-00008fff : PCI CardBus #02
  00009000-000090ff : PCI CardBus #02
00802000-01001fff : /pci@f0000000
  00802400-008024ff : 0000:00:10.0
ff7fe000-ffffdfff : /pci@f4000000

cat /proc/iomem
80000000-afffffff : /pci@f2000000
  80000000-8007ffff : 0001:01:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
        80008000-800080ff : i2s-a- Tx DMA
      80008100-800081ff : 0.00010000:i2s
        80008100-800081ff : i2s-a- Rx DMA
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008a00-80008aff : 0.0001f000:ata-4
        80008a00-80008aff : ide-pmac (dma)
      80008b00-80008bff : 0.00020000:ata-3
        80008b00-80008bff : ide-pmac (dma)
      80008c00-80008cff : 0.00021000:ata-3
        80008c00-80008cff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
        80010000-80010fff : i2s-a
      80013000-80013000 : 0.00013000:ch-b
      80013010-80013010 : 0.00013000:ch-b
      80013020-80013020 : 0.00013020:ch-a
      80013030-80013030 : 0.00013020:ch-a
      80013040-80013040 : 0.00013000:ch-b
      80013050-80013050 : 0.00013020:ch-a
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
        80016000-80017fff : via-pmu
      80018000-80018fff : 0.00018000:i2c
      8001a000-8001a0ff : 0.00030000:radio
      8001f000-8001ffff : 0.0001f000:ata-4
        8001f000-8001ffff : ide-pmac (ports)
      80020000-80020fff : 0.00020000:ata-3
        80020000-80020fff : ide-pmac (ports)
      80021000-80021fff : 0.00021000:ata-3
      80030000-800300ff : 0.00030000:radio
        80030000-800300ff : airport
      80040000-8007ffff : 0.00040000:interrup
        80040000-8007ffff : interrupt-controller
  90000000-9fffffff : PCI CardBus #02
  a0000000-a0000fff : 0001:01:1a.0
    a0000000-a0000fff : yenta_socket
  a0001000-a0001fff : 0001:01:19.0
    a0001000-a0001fff : ohci_hcd
  a0002000-a0002fff : 0001:01:18.0
    a0002000-a0002fff : ohci_hcd
b0000000-bfffffff : /pci@f0000000
  b0000000-b000ffff : 0000:00:10.0
    b0000000-b000ffff : radeonfb
  b8000000-bfffffff : 0000:00:10.0
    b8000000-bfffffff : radeonfb
f1000000-f1ffffff : /pci@f0000000
  f1000000-f101ffff : 0000:00:10.0
f3000000-f3ffffff : /pci@f2000000
  f3000000-f31fffff : PCI CardBus #02
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:06:0e.0
  f5200000-f53fffff : 0002:06:0f.0
f8000000-f8ffffff : uni-n

[7.5] lspci -vvv
00:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 AGP
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Capabilities: [80] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4
 
00:10.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon Mobility M7 LW [Radeon
Mobility 7500]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at b8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 802400 [size=256]
        Region 2: Memory at b0000000 (32-bit, non-prefetchable)
[size=64K]
        Expansion ROM at f1000000 [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=8 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
 
01:17.0 Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Region 0: Memory at 80000000 (32-bit, non-prefetchable)
[size=512K]
 
01:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10
[OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at a0002000 (32-bit, non-prefetchable)
[size=4K]
 
01:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10
[OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max)
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at a0001000 (32-bit, non-prefetchable)
[size=4K]
 
01:1a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 58
        Region 0: Memory at a0000000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 90000000-9ffff000 (prefetchable)
        Memory window 1: f3000000-f31ff000
        I/O window 0: 00001000-00008fff
        I/O window 1: 00009000-000090ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001
 
06:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 Internal PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
 
06:0e.0 Class ffff: Lucent Microelectronics FW323 (rev ff) (prog-if ff)
        !!! Unknown header type 7f
 
06:0f.0 Class ffff: Apple Computer Inc. UniNorth GMAC (Sun GEM) (rev ff)
(prog-if ff)
        !!! Unknown header type 7f

[7.6] no scsi

[7.7]  ????

[X.]  Please let me know if there is any other info I can provide


