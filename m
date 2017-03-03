From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: No output on console despite ignore_loglevel earlyprintk
Date: Fri, 3 Mar 2017 17:18:39 +0000
Message-ID: <20170303171839.GP21222@n2100.armlinux.org.uk>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
 <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-serial <linux-serial@vger.kernel.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 03, 2017 at 06:07:39PM +0100, Marc Gonzalez wrote:
> On 03/03/2017 17:59, Andreas F=E4rber wrote:
> >> I suppose this is related to my DT description?
> >>
> >> 	chosen {
> >> 		stdout-path =3D "serial:115200n8";
> >> 	};
> >>
> >> Isn't stdout-path =3D "serial:115200n8" supposed to be equivalent to
> >> console=3DttyS0,115200 ?
> > =

> > First of all, that should probably be serial0, and it needs to be
> > defined as an alias. In my case that's a given.
> =

> My DT root node contains
> =

> 	aliases {
> 		serial =3D &uart;
> 		eth0 =3D &eth0;
> 	};
> =

> Should I be using serial0 everywhere?
> (I thought I could call it "foo", if I wanted.)

Correct, stdout-path contains the node name - please see
Documentation/devicetree/bindings/chosen.txt for the definitive
information.

Setting the early console has no effect on the eventual system
console that the kernel chooses.  See these files:

drivers/of/fdt.c
drivers/tty/serial/earlycon.c

-- =

RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
