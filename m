From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
Date: Tue, 11 Jun 2013 07:50:31 +0100
Message-ID: <51B6C8B7.50807@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com> <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com> <CAHTX3d+dk3W_9b7SVUokWq4KYXnj=Z1=WPj5zJ-gUvJqqwE=+Q@mail.gmail.com> <51B5BCB3.3060405@st.com> <20130610231934.GG18614@n2100.arm.linux.org.uk>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130610231934.GG18614@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Michal Simek <monstr@monstr.eu>, linux-arm <linux-arm-kernel@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Samuel Ortiz <sameo@linux.intel.com>, Stephen Gallimore <stephen.gallimore@st.com>, Stuart Menefy <stuart.menefy@st.com>, Thomas Gleixner <tglx@linutronix.de>Tony Prisk <linux>
List-Id: linux-serial@vger.kernel.org

On 11/06/13 00:19, Russell King - ARM Linux wrote:
> On Mon, Jun 10, 2013 at 12:46:59PM +0100, Srinivas KANDAGATLA wrote:
>>> > >     +       aux_ctrl = (0x1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
>>> > >     +               (0x1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
>>> > >     +               (0x1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
>>> > >     +               (way_size << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
>>> > > 
>>> > > 
>>> > > 
>>> > > #include <linux/bitops.h>
>>> > > Linus Walleij would write use  BIT() here
>> > 
>> > I will use BIT() macro.
> Without checking those fields... BIT() is only appropriate if you're
> really talking about single bits.  If you have a field of more than a
> single bit which you happen to be setting to '1' then it's not
> appropriate to use BIT().
> 
> 
You are right, It does not make sense to use BIT() macro for field which
has more than 1 bit. I think using mix of both BIT() and the old style
will make code look bit confusing to reader, Also no other mach code in
the kernel use BIT while configuring L2 controller. So am going to drop
the idea of using BIT here and leave the code as it is.

Thanks,
srini
