From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] Bluetooth support for GXBB/GXL/GXM based devices
Date: Thu, 19 Jan 2017 14:39:06 +0100
Message-ID: <20170119133906.GB6072@kroah.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <CAFBinCC0RADEKnkYEF6_DkBTftdjmPMku+N3bdvZMCoqs96xGA@mail.gmail.com>
 <m2fukgyqld.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <m2fukgyqld.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, carlo@caione.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 18, 2017 at 02:02:06PM -0800, Kevin Hilman wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> 
> > Kevin,
> >
> > On Sun, Jan 15, 2017 at 11:32 PM, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >> This adds the missing kernel bits for Bluetooth support on the
> >> Tronsmart Vega S95 (GXBB based) boards as well as for the GXL
> >> P230/P231 and GXM Q200/Q201 reference boards.
> >>
> >> The Bluetooth functionality on these boards is provided by the
> >> SDIO wifi/Bluetooth combo-chip (Broadcom bcm43xx based). The
> >> Bluetooth module on that combo-chip has to be taken out of reset,
> >> which is taken care of the GPIO in the sdio_pwrseq.
> >>
> >> Once the module is taken out of reset it can be set up from userspace
> >> using the "hciattach" tool from bluez, which talks to the Bluetooth
> >> module which is connected to one of the serial ports (in our case
> >> uart_A). To get the Bluetooth module initialized within the timeout
> >> defined by "hciattach" (and to achieve usable speeds for Bluetooth
> >> transfers) the communication uses a speed of 2000000 baud, which was
> >> not supported by meson_uart before.
> >>
> >> NOTE: The .dts-changes from this series depends on my previous series
> >> "add support for uart_AO_B" - see [0]
> >>
> >>
> >> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-January/001982.html
> >>
> >>
> >> Martin Blumenstingl (4):
> >>   tty: serial: meson: allow baud-rates higher than 115200
> >>   ARM64: dts: meson-gx: add the serial CTS and RTS pin groups
> >
> > Neil just informed me that Rob Herring is working on defining the UART
> > Bluetooth device properly using devicetree (preparation for this is
> > named "[PATCH v2 0/9] Serial slave device bus", see [0] for the
> > mailing-list conversation and [1] for a WiP git repo).
> 
> Ah, good news.  I knew Rob had been talking about that for awhile, so
> I'm glad to see it coming into existence.  Thanks for the pointers.
> 
> > This means that there will be a better solution than the one proposed
> > in the meson-gx-p23x-q20x and meson-gxbb-vega-s95 patches (patches #1
> > and #2 are not affected by this),> namely:
> > - I'm currently (ab)using sdio-pwrseq node to power on the UART
> > Bluetooth module, this can solved by specifying a bluetooth {  } node
> > inside the &uart_A node in the future and providing the corresponding
> > GPIOs there
> 
> Good.  I didn't like the (ab)use of sdio_pwrseq GPIO resets for the
> bluetooth either.
> 
> > - all the userspace commands will not be necessary once
> > drivers/bluetooth/hci_bcm.c is changed to the serio framework and gets
> > devicetree support
> 
> Cool.  Maybe you can setup a WIP branch based on Rob's work for broader
> testing on Amlogic boards until this gets merged?
> 
> In the mean time, I've applied patch 2/4 and hopefully the drivers/tty
> patch will go through the serial tree.

Yes, I've taken it now, thanks.

greg k-h
