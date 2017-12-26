From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/3] Bluetooth: hci_bcm: Support Apple GPIO handling
Date: Tue, 26 Dec 2017 18:08:15 +0100
Message-ID: <20171226170815.GA31975@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Frederic Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Loic Poulain <loic.poulain-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Max Shavrick <mxms-BUHhN+a2lJ4@public.gmane.org>, Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>, Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>, "Peter Y. Chuang" <peteryuchuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

On Tue, Dec 26, 2017 at 05:07:34PM +0200, Lukas Wunner wrote:
> On the MacBook8,1 Bluetooth is muxed with a second device (a debug port
> on the SSD) under the control of PCH GPIO 36.  Because serdev cannot
> deal with multiple slaves yet, it is currently necessary to patch the
> DSDT and remove the SSDC device.

Last August you posted a series to add multiplexer support for serdev:

https://www.spinics.net/lists/linux-serial/msg27329.html

Another use case has now popped up where a GPIO-controlled mux is used
to switch between two serdev slaves:  As mentioned in a series I've just
posted to linux-bluetooth@ (quoted above), on the MacBook 8,1 the UART
is attached to a serial debug port on the SSD as well as to a Bluetooth
controller, subject to a mux controlled by PCH GPIO 36.

The SSD debug ported is listed first in the ACPI namespace and is attached
as a serdev slave without a hitch (see DSDT excerpt included below).
The Bluetooth controller comes next and fails to register due to a sanity
check in serdev_device_add():

[    0.361650] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.362633] 0000:00:15.5: ttyS0 at MMIO 0xc1819000 (irq = 21, base_baud = 2764800) is a 16550A
[    0.362769] serial serial0-0: controller busy
[    0.362815] serial serial0-0: failure adding ACPI serdev device. status -16
[    0.362860] serial serial0: tty port ttyS0 registered

The series you've posted in August hasn't been merged.  Taking a closer
look at patch [2/6] (linked above), you've put the calls to lock and
unlock the mux in the slave, i.e. max9260.c.  This works because in your
use case, the UART is shared only by MAX9260 chips.  I think a more
generic solution is called for which puts the locking of the mux in the
serdev controller and makes it fully transparent to the slaves.

So whenever data is read or written to the UART's FIFO or whenever
the modem control lines are accessed, the mux needs to be locked to
the respective slave first.

The sanity check introduced by 08fcee289f34 to prevent registration
of multiple serdev slaves needs to be amended to check for presence
of a mux if more than one slave registers, and check whether the
number of switch states is sufficient to accomodate the additional
slave.

If you do find the time to amend the series in this way, it would
result in something truly useful that we could also employ to solve
Bluetooth muxing on the MacBook8,1 in a clean way.

Thanks,

Lukas

-- cut here --

            Device (URT0)
            {
                Name (_ADR, 0x00150005)  // _ADR: Address
                Name (RBUF, ResourceTemplate ()
                {
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
                    {
                        0x00000015,
                    }
                })
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
                    {
                        Store (Package (0x02)
                            {
                                "uart-channel-number", 
                                Buffer (0x08)
                                {
                                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }

                    Return (0x00)
                }

                Name (DBUF, ResourceTemplate ()
                {
                    FixedDMA (0x0014, 0x0004, Width32bit, )
                    FixedDMA (0x0015, 0x0005, Width32bit, )
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Return (ConcatenateResTemplate (RBUF, DBUF))
                }
            }

            Scope (\_SB.PCI0.URT0)
            {
                Device (SSDC)
                {
                    Name (_CID, "apple-uart-ssdc")  // _CID: Compatible ID
                    Name (_UID, 0x01)  // _UID: Unique ID
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
                        {
                            Store (Package (0x08)
                                {
                                    "baud", 
                                    Buffer (0x08)
                                    {
                                         0xD0, 0x12, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "parity", 
                                    Buffer (0x08)
                                    {
                                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "dataBits", 
                                    Buffer (0x08)
                                    {
                                         0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "stopBits", 
                                    Buffer (0x08)
                                    {
                                         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }
                                }, Local0)
                            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                            Return (Local0)
                        }

                        Return (0x00)
                    }
                }
            }

            Scope (\_SB.PCI0.URT0)
            {
                Device (BLTH)
                {
                    Name (_HID, EisaId ("BCM2E7C"))  // _HID: Hardware ID
                    Name (_CID, "apple-uart-blth")  // _CID: Compatible ID
                    Name (_UID, 0x01)  // _UID: Unique ID
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne,
                                0xC0, LittleEndian, ParityTypeNone, FlowControlHardware,
                                0x0020, 0x0020, "\\_SB.PCI0.URT0",
                                0x00, ResourceProducer, ,
                                )
                        })
                        Name (ABUF, ResourceTemplate ()
                        {
                        })
                        If (LNot (OSDW ()))
                        {
                            Return (UBUF) /* \_SB_.PCI0.URT0.BLTH._CRS.UBUF */
                        }

                        Return (ABUF) /* \_SB_.PCI0.URT0.BLTH._CRS.ABUF */
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
                        {
                            Store (Package (0x08)
                                {
                                    "baud", 
                                    Buffer (0x08)
                                    {
                                         0xC0, 0xC6, 0x2D, 0x00, 0x00, 0x00, 0x00, 0x00   /* ..-..... */
                                    }, 

                                    "parity", 
                                    Buffer (0x08)
                                    {
                                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "dataBits", 
                                    Buffer (0x08)
                                    {
                                         0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "stopBits", 
                                    Buffer (0x08)
                                    {
                                         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }
                                }, Local0)
                            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                            Return (Local0)
                        }

                        Return (0x00)
                    }

                    Method (BTPU, 0, Serialized)
                    {
                        Store (0x01, \_SB.PCI0.LPCB.EC.BTPC)
                        Sleep (0x0A)
                    }

                    Method (BTPD, 0, Serialized)
                    {
                        Store (0x00, \_SB.PCI0.LPCB.EC.BTPC)
                        Sleep (0x0A)
                    }

                    Method (BTRS, 0, Serialized)
                    {
                        BTPD ()
                        BTPU ()
                    }

                    Method (BTLP, 1, Serialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            Store (0x01, GD54) /* \GD54 */
                        }

                        If (LEqual (Arg0, 0x01))
                        {
                            Store (0x00, GD54) /* \GD54 */
                            Store (0x00, GP54) /* \GP54 */
                        }
                    }
                }
            }
        }
