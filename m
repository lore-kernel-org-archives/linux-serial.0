From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
Date: Tue, 11 Jun 2013 00:19:34 +0100
Message-ID: <20130610231934.GG18614@n2100.arm.linux.org.uk>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
 <CAHTX3d+dk3W_9b7SVUokWq4KYXnj=Z1=WPj5zJ-gUvJqqwE=+Q@mail.gmail.com>
 <51B5BCB3.3060405@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51B5BCB3.3060405@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Stephen Gallimore <stephen.gallimore@st.com>, linux-serial@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2013 at 12:46:59PM +0100, Srinivas KANDAGATLA wrote:
> >     +       aux_ctrl = (0x1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
> >     +               (0x1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
> >     +               (0x1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
> >     +               (way_size << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
> > 
> > 
> > 
> > #include <linux/bitops.h>
> > Linus Walleij would write use  BIT() here
> 
> I will use BIT() macro.

Without checking those fields... BIT() is only appropriate if you're
really talking about single bits.  If you have a field of more than a
single bit which you happen to be setting to '1' then it's not
appropriate to use BIT().
