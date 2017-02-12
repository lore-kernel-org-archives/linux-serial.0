From: Greg KH <gregkh@linuxfoundation.org>
Subject: Bug#854231: Fwd: Kernel 4.9 traces
Date: Sun, 12 Feb 2017 18:03:10 +0100
Message-ID: <20170212170310.GA32207@kroah.com>
References: <70847af1-5dd9-d799-1220-076668a7d26f@gmx.de>
 <ed196ccd-6c86-9354-f503-9eaaa3cf7086@gmx.de>
 <20170204115348.GA19932@kroah.com>
 <5d1b3176-8c74-5495-28bb-4a6da64d78a6@gmx.de>
 <20170204130540.GA21394@kroah.com>
 <b1985aec-cb09-67e7-ec47-6e4013491081@gmx.de>
 <eef42674-979f-1d56-8b71-2d8863f71dc7@gmx.de>
Reply-To: Greg KH <gregkh@linuxfoundation.org>, 854231@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.854231.B854231.14869194599132@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <eef42674-979f-1d56-8b71-2d8863f71dc7@gmx.de>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Wolfgang Schnitker <wolfgang.schnitker@gmx.de>
Cc: linux-serial@vger.kernel.org, 854231@bugs.debian.org
List-Id: linux-serial@vger.kernel.org

On Sun, Feb 12, 2017 at 05:45:06PM +0100, Wolfgang Schnitker wrote:
> Dear serial developers,
> 
> my suggestion is now following:
> 
> My box has 3 physical serial IO ports, 1 on MB and 2 on PCI IO board.
> 
> dmesg | grep ttyS shows this:
> 
> (rmmod parport_serial and modprobe it again)
> 
> [    0.833923] 00:00: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 115200)
> is a 16550A
> [    9.498473] 0000:03:00.0: ttyS0 at I/O 0xcc00 (irq = 17, base_baud =
> 115200) is a 16550A
> [    9.519894] 0000:03:00.0: ttyS1 at I/O 0xc880 (irq = 17, base_baud =
> 115200) is a 16550A
> [   17.519943] ttyS0: LSR safety check engaged!
> [   17.521182] ttyS0: LSR safety check engaged!
> [   30.043754] ttyS0: LSR safety check engaged!
> [   30.044734] ttyS0: LSR safety check engaged!
> [   30.044956] ttyS0: LSR safety check engaged!
> [   30.045153] ttyS0: LSR safety check engaged!
> [   30.045344] ttyS0: LSR safety check engaged!
> [   41.594802] ttyS0: LSR safety check engaged!
> [  273.130756] 0000:03:00.0: ttyS1 at I/O 0xcc00 (irq = 17, base_baud =
> 115200) is a 16550A
> [  273.153032] 0000:03:00.0: ttyS2 at I/O 0xc880 (irq = 17, base_baud =
> 115200) is a 16550A
> 
> ttyS3 is on the MB, ttyS0/S1 are the one on he IO card.
> 
> It happens right after activating LSR safety check.
> 
> [   16.522925] EXT4-fs (sda5): mounted filesystem with ordered data
> mode. Opts: (null)
> [   16.552462] EXT4-fs (sda7): mounted filesystem with ordered data
> mode. Opts: errors=remount-ro
> [   17.097626] systemd-journald[216]: Received request to flush runtime
> journal from PID 1
> [   17.519943] ttyS0: LSR safety check engaged!
> [   17.521182] ttyS0: LSR safety check engaged!
> [   17.523884] ------------[ cut here ]------------
> 
> So look up PCI values for this board:
> 
> 03:00.0 Communication controller: MosChip Semiconductor Technology Ltd.
> PCI 9835 Multi-I/O Controller (rev 01)
>     Subsystem: LSI Logic / Symbios Logic 1P2S
>     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Interrupt: pin A routed to IRQ 17
>     Region 0: I/O ports at cc00 [size=8]
>     Region 1: I/O ports at c880 [size=8]
>     Region 2: I/O ports at c800 [size=8]
>     Region 3: I/O ports at c480 [size=8]
>     Region 4: I/O ports at c400 [size=8]
>     Region 5: I/O ports at c080 [size=16]
>     Kernel driver in use: parport_serial
>  
> 
> Please tell me, if you need more information.

What exactly is the problem here?
