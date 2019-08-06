From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Tue, 6 Aug 2019 20:40:42 +0200
Message-ID: <20190806184042.GA26041@kroah.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Larisa Ileana Grigore <larisa.grigore@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:
> On 8/5/2019 6:31 PM, gregkh@linuxfoundation.org wrote:
> > On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >>
> >> +/* Freescale Linflex UART */
> >> +#define PORT_LINFLEXUART     121
> > 
> > Do you really need this modified?
> 
> Hello Greg,
> 
> This macro is meant to be assigned to port->type in the config_port
> method from uart_ops, in order for verify_port to know if the received
> serial_struct structure was really targeted for a LINFlex port. It
> needs to be defined outside, to avoid "collisions" with other drivers.

Yes, I know what it goes to, but does anyone in userspace actually use
it?

> As far as I see, uart_set_info() will actually fail at the
> "baud_base < 9600" check[1], right after calling verify_port(), when
> performing an ioctl() on "/dev/console" with TIOCSSERIAL using a
> serial_struct obtained with TIOCGSERIAL. This happens because this
> reduced version of the LINFlex UART driver will not touch the uartclk
> field of the uart_port (as there is currently no clock support).
> Therefore, the linflex_config/verify_port() functions, along with the
> PORT_LINFLEXUART macro, may be indeed unnecessary at this point (and
> should be added later). Is this what you mean?

No, see below.

> Other than that, I do not see anything wrong with the addition of a
> define in serial_core.h for this purpose (which is also what most of the
> serial drivers do, including amba-pl011.c, mentioned in
> Documentation/driver-api/serial/driver.rst as providing the reference
> implementation), so please be more specific.

I am getting tired of dealing with merge issues with that list, and no
one seems to be able to find where they are really needed for userspace,
especially for new devices.  What happens if you do not have use it?

thanks,

greg k-h
