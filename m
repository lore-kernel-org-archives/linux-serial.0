From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
Date: Fri, 17 May 2013 16:36:49 +0200
Message-ID: <201305171636.49627.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305082148.10933.arnd@arndb.de> <518B77C1.70107@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <518B77C1.70107-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: srinivas.kandagatla-qxv4g6HH51o@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thursday 09 May 2013, Srinivas KANDAGATLA wrote:
> On 08/05/13 20:48, Arnd Bergmann wrote:
> I agree, my initial approach was having a dedicated driver specific to
> ST syscon, however syscon seems to do things very much similar to what
> we want, so I have integrated those 3 functions in syscon.
> Am happy to go back with my first approach of adding ST specific syscon
> driver if no one is actually going to benefit with such a change to
> syscon driver.

That would at least be less controversial.

> > Can you describe how your syscon registers are laid out?
> On STiH416 SOC we have 9 SYSCONF(aka System Configuration
> Registers)named banks/groups, each bank has its own memory map.
> Each sysconf bank has number of 32 bit registers which vary from bank to
> bank, like sysconf bank "sbc" has range from SYSTEM_CONFIG0 to
> SYSTEM_CONFIG999 where as  sysconf bank "front" has range of
> SYSTEM_CONFIG1000 to SYSTEM_CONFIG1999 and so on.
> 
> Each register is assigned with a unique SYCONF number, example:
> SYSTEM_CONFIG100, SYSTEM_CONFIG101 , .. and so on.
> Each sysconf contains bits of the IP configurations wired-up to the
> sysconf register bits.

Ok.

> As example:
> 
> - Each pinctrl entry for set of 8 pins uses around 8-10 sysconfig
> register to control pinconf and pin functions.
> - IPs like Ethernet have few bit like Ethernet-Mode selection external
> or internal phyclk wired up to bits in sysconf registers,
> - Few clocks are controlled by sysconf registers.
> - Reset to IPs are wired up to bits of sysconf same registers.
> - ARM core soft reset is wired up to the sysconf registers...
> And most of the IPs have similar requirements ......
> 
> Total layout of the sysconf changes per SOC, and the bit arrangements
> aswell, however the core IP(pinctrl, etherenet ...) and logic to drive
> those bits remains exactly same.

It sounds like you really need a driver with high-level interfaces
for the bits that change by each core and are needed by otherwise
identical drivers, like the Ethernet driver you mention.

I would not go as far as you did describing the individual bits in
the device node using these however. That driver can be layered on
top of the existing syscon driver, but hardcode the bits for each
SoC it knows of.

For drivers that are essentially just wrappers around sysconf,
I would make them one driver per SoC and use a low-level interface
but still hardcode the offsets in the driver instead of using DT
to find the registers.

The pinctrl and reset drivers are examples of this.

> In general the requirements of the sysconf support to the SOC/driver
> support is.
> 1> It should be able to read/write a sysconf register bits without
> having to "if" each SOC in the code. So that code is totally abstracted.
> Which is currently achieved by passing the information from the device
> trees and the driver just uses the property to get it.

The goal sounds fine, just the method is a bit more complex than necessary
here I think.

> 2> The infrastructure should protect the claimed registers from
> over-writing by other drivers. We do this by claim-read/write-release
> style API.

I don't understand this part. Is it about atomicity of accesses to
32-bit registers when you only want to change a bit? That is something
the regmap interface handles already.

If this is about drivers touching registers they should not touch
in the first place, I think it should not be needed at all, because
that would be a driver bug, and you can't really protect yourself
from broken drivers anyway.

> 3> The driver should be able to set a group of sysconf registers bits to
> a particular values before initialises the IP. I was thinking of doing
> this in a same way as pinctrl state.

That does not fit well with the model we use for other subsystems. If possible,
try to use the existing abstractions for clock, regulator, pinctrl, reset,
etc. and call generic interfaces from the driver. When that does not work,
create a high-level function call from your sysconf driver to do a particular
thing (e.g. stih_sysconf_ethernet_set_phy_mode()) rather than set up random
bits from the driver.

	Arnd
