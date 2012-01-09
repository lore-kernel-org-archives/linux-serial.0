From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Kconfig option for compile time build coverage (Was: Re: [PATCH]
 serial/efm32: add new driver)
Date: Mon, 9 Jan 2012 10:59:03 +0100
Message-ID: <20120109095903.GC14252@pengutronix.de>
References: <20111221202847.4ffeba10@bob.linux.org.uk>
 <1324561092-1945-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201112231035.23215.arnd@arndb.de>
 <20111223204428.GI24496@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111223204428.GI24496-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, Dec 23, 2011 at 09:44:28PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Dec 23, 2011 at 10:35:22AM +0000, Arnd Bergmann wrote:
> > On Thursday 22 December 2011, Uwe Kleine-K=F6nig wrote:
> > > [...]
> > > +config SERIAL_EFM32_USART
> > > +	bool "EFM32 USART port."
> > > +	depends on ARCH_EFM32
> > > +	select SERIAL_CORE
> [...]
> > I would generally prefer not to make the driver depend on the
> > platform, so we can get better compile time coverage. I think a better
> > set of dependencies would be
> > =

> > 	depends on HAVE_CLK
> > 	depends on OF
> > 	default ARCH_EFM32
> I'd prefer something like:
> =

> 	depends on HAVE_CLK
> 	depends on ARCH_EFM32 || I_DO_BUILD_COVERAGE_TESTING
> =

> This would make it easier for Joe User to pick the right options for his
> kernel (assuming he found out to better keep I_DO_BUILD_COVERAGE_TESTING
> disabled). [...]
What do you think about this I_DO_BUILD_COVERAGE_TESTING option? It
would allow testers to get all possible options enabled (though there
will never be an EFM32 USART port on a non-EFM32 machine I guess) and
still users and distribution packagers would easily keep the option off
even without cluttering .config and {menu,n,x,whatever}config.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
