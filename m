From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 07/11] ARM:stixxxx: Add STiH416 SOC support
Date: Fri, 14 Jun 2013 08:12:35 +0100
Message-ID: <51BAC263.1000908@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com> <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com> <3733079.FxbR14kFrs@wuerfel>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3733079.FxbR14kFrs@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Samuel Ortiz <sameo@linux.intel.com>, Stephen Gallimore <stephen.gallimore@st.com>, Stuart Menefy <stuart.menefy@st.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Prisk <linux@prisktech.co.nz>
List-Id: linux-serial@vger.kernel.org

On 10/06/13 14:52, Arnd Bergmann wrote:
> On Monday 10 June 2013 10:27:05 Srinivas KANDAGATLA wrote:
> 
>> > +	soc {
>> > +		pin-controller-sbc {
>> > +			#address-cells	= <1>;
>> > +			#size-cells	= <1>;
>> > +			compatible	= "st,stih416-pinctrl", "simple-bus";
> Why is this both its own device with a compatible string and a
> "simple-bus" at the same time? Wouldn't it be simpler to just
> scan the child device nodes from the "st,stih416-pinctrl"
> driver instead of having a separate platform_driver for them?
> 
I did try this suggestion, and it simplified driver too, I will do this
change in next version.

Thanks,
srini
