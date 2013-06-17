From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 09/11] ARM:stixxxx: Add stixxxx options to
 multi_v7_defconfig
Date: Mon, 17 Jun 2013 10:32:48 +0100
Message-ID: <20130617093248.GB6809@e106331-lin.cambridge.arm.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856477-7237-1-git-send-email-srinivas.kandagatla@st.com>
 <20130610104032.GA2513@e106331-lin.cambridge.arm.com>
 <51B5B15E.50901@st.com>
 <20130610131513.GB2513@e106331-lin.cambridge.arm.com>
 <51B98FDD.4010401@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51B98FDD.4010401@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Stephen Gallimore <stephen.gallimore@st.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Stuart Menefy <stuart.menefy@st.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mauro
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 13, 2013 at 10:24:45AM +0100, Srinivas KANDAGATLA wrote:
> On 10/06/13 14:15, Mark Rutland wrote:
> > CONFIG_EXPERIMENTAL's gone as of 3d374d09f1: "final removal of
> > CONFIG_EXPERIMENTAL", so that's fine to go. CONFIG_GPIO_PL061 and
> > CONFIG_MMC_WMT get selected elsewhere, so that's fine.
> > 
> 
> Am planning to send a patch to clean this up, so that any new platform
> addition to the multi_v7_defconfig will not under go this discussion again..
> 
> > It looks like the architected timer deselection is fallout of my own making,
> > the multi_v7_defconfig should now contain HAVE_ARM_ARCH_TIMER rather than
> > ARM_ARCH_TIMER.
> Why should it even contain HAVE_ARM_ARCH_TIMER/ARM_ARCH_TIMER?
> The only reason I see for de-selection is because none of the platforms
> in the multi_v7 defconfig selects it.
> 
> Looks like there is no platform in mulit_v7 config which requires this
> support. If there is one I think it should select it.
> 
> Am I correct?

You're right, I agree that the selection should be moved down into the
platforms requiring it. I'll put together patches to fix up those platforms.

Thanks,
Mark.
