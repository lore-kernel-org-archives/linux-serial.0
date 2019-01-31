From: Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
Date: Thu, 31 Jan 2019 10:34:10 +0800
Message-ID: <1548902050.23230.4.camel@mtksdaap41>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
 <20190130162204.GA1521@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190130162204.GA1521@bogus>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ben Ho <Ben.Ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Mengqi Zhang <Mengqi.Zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hsin-Hsiung Wang <hsin-hsiung.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Weiyi Lu <weiyi.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Seiya Wang <seiya.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhiyong Tao <zhiyong.tao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > From: Ben Ho <Ben.Ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > Add basic chip support for Mediatek 8183, include
> > pinctrl file, uart node with correct uart clocks, pwrap device
> > 
> > Add clock controller nodes, include topckgen, infracfg,
> > apmixedsys and subsystem.
> > 
> > Signed-off-by: Ben Ho <Ben.Ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Seiya Wang <seiya.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Zhiyong Tao <zhiyong.tao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Weiyi Lu <weiyi.lu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Mengqi Zhang <Mengqi.Zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> 
> 
> > +	sysirq: intpol-controller@c530a80 {
> 
> interrupt-controller@...

I will modify it in next version.
> 
> 
> Place all the MMIO peripherals under one or more simple-bus nodes.
> 
> Rob
> 

Do you mean need to add simple-bus like this?

+   soc: soc {
+                #address-cells = <0x1>;
+                #size-cells = <0x1>;
+                ranges = <0 0 0 0xffffffff>;
+                compatible = "simple-bus";

	        soc_data: soc_data@08000000 {
	                compatible = "mediatek,mt8183-efuse",
	                             "mediatek,efuse";
	                reg = <0 0x08000000 0 0x0010>;
	                #address-cells = <1>;
	                #size-cells = <1>;
	                status = "disabled";
	        };

	        gic: interrupt-controller@0c000000 {
	                compatible = "arm,gic-v3";
	                #interrupt-cells = <4>;
	
Best Regards,
Erin

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
