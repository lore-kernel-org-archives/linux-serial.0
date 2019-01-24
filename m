From: Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date: Thu, 24 Jan 2019 15:07:47 +0800
Message-ID: <1548313667-125014-1-git-send-email-guan.yung.tseng@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.shevchenko@gmail.com
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Guan Yung Tseng <guan.yung.tseng@ni.com>
List-Id: linux-serial@vger.kernel.org

> On Wed, Jan 23, 2019 at 5:18 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com> wrote:
> > >
> > > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > > The reason of doing this is because all NI multi port serial cards 
> > > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the 
> > > serial_pci_is_class_communication test added in the commit 
> > > 7d8905d06405
> > > ("serial: 8250_pci: Enable device after we check black list").
> >
> > Guan, can you provide an output of the
> >
> > lspci -nk -xx -vv -s <BDF>
> >
> > of your device, where <BDF> is a PCI address in a form of bus:device.function?
>

Output of lspci before applied the patch

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0e.0
0d:0e.0 0780: 1093:70e8
        Subsystem: 1093:70e8
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe201000 (32-bit, non-prefetchable) [disabled] [size=4K]
00: 93 10 e8 70 40 01 80 02 00 00 80 07 10 20 00 00
10: 00 10 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 e8 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0a 01 00 00

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0f.0
0d:0f.0 0780: 1093:70ec
        Subsystem: 1093:70ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fe200000 (32-bit, non-prefetchable) [disabled] [size=4K]
00: 93 10 ec 70 40 01 80 02 00 00 80 07 10 20 00 00
10: 00 00 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 ec 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0b 01 00 00

> While I'm still wondering of the above, can you also test the bellow patch if it fixes your issue?

The patch fixes the issue. The devices bind to the serial kernel driver successfully.
Below is the output of lspci -nk -xx -vv -s <BDF> for the same devices after I applied the patch.

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0e.0
0d:0e.0 0780: 1093:70e8
        Subsystem: 1093:70e8
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fe201000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: serial
00: 93 10 e8 70 42 01 80 02 00 00 80 07 10 20 00 00
10: 00 10 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 e8 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0a 01 00 00

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0f.0
0d:0f.0 0780: 1093:70ec
        Subsystem: 1093:70ec
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fe200000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: serial
00: 93 10 ec 70 42 01 80 02 00 00 80 07 10 20 00 00
10: 00 00 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 ec 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0b 01 00 00
