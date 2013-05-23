From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
Date: Thu, 23 May 2013 23:44:11 +0200
Message-ID: <201305232344.11974.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com> <201305171636.49627.arnd@arndb.de> <519A1BBB.2070903@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <519A1BBB.2070903@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: srinivas.kandagatla@st.com
Cc: dong.aisheng@linaro.org, sameo@linux.intel.com, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stuart Menefy <stuart.menefy@st.com>, Shawn Guo <shawn.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@nvidia.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Dave Martin <dave.martin@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Monday 20 May 2013, Srinivas KANDAGATLA wrote:
> On 17/05/13 15:36, Arnd Bergmann wrote:
>
> Some of the drivers like Ethernet already provide higher level
> interfaces via callbacks. We did implement such a callbacks per each SOC
> in non-DT case, and ended up having code duplicated for each SOC.
> 
> On the other hand using device trees to describe the HW
> configuration(sysconfs) made more sense and got rid of SOC specific
> callbacks.

I'm sure it's possible to reduce the duplication without going all
the way to describing every bit in DT.

> > For drivers that are essentially just wrappers around sysconf,
> > I would make them one driver per SoC and use a low-level interface
> > but still hardcode the offsets in the driver instead of using DT
> > to find the registers.
> > 
> > The pinctrl and reset drivers are examples of this.
> 
> In pinctrl bindings case, I think we could do better job by replacing
> the existing bindings of sysconfs for a group of banks with just two
> integer offsets. This would mean that, we can still use the a common
> driver across the SOCs.
>
> And w.r.t to reset, we are planning on using sysconf based
> reset-controller API sitting underneath the reset-controller subsystem.
> Passing the information from device trees would be much clear and
> flexible than adding new driver per/SOC.

Ok

> >> 2> The infrastructure should protect the claimed registers from
> >> over-writing by other drivers. We do this by claim-read/write-release
> >> style API.
> > 
> > I don't understand this part. Is it about atomicity of accesses to
> > 32-bit registers when you only want to change a bit? That is something
> > the regmap interface handles already.
> 
> I forget to mention a important point here, the protection is at bit
> level for the sysconfs. Some of sysconfs have bits shared across IPs, so
> protecting them while the IP is still using it is what we are trying to
> achieve with sysconf-claim/release apis.
> While it may be overkill, but In past it has found bugs and been helpful
> with a meaning full debug output.

Can you give an example of something that is shared across multiple IPs?

Are those always done in the way that you have e.g. the ethernet pinctrl
in the same register as the usb pinctrl, or could you have an ethernet
pinctrl setting mixed together with the usb clock setting for instance?

If the hardware has been designed in a sensible way rather than just
grown by randomly adding bits in open spaces, I would assume that it's
possible to have high-level interfaces built around ranges of registers
rather than arbitrary subsets of registers.

	Arnd
