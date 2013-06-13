From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
Date: Thu, 13 Jun 2013 12:56:40 +0100
Message-ID: <20130613115640.GC18614@n2100.arm.linux.org.uk>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
 <CAHTX3d+dk3W_9b7SVUokWq4KYXnj=Z1=WPj5zJ-gUvJqqwE=+Q@mail.gmail.com>
 <51B5BCB3.3060405@st.com> <20130610231934.GG18614@n2100.arm.linux.org.uk>
 <51B6C8B7.50807@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51B6C8B7.50807@st.com>
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

On Tue, Jun 11, 2013 at 07:50:31AM +0100, Srinivas KANDAGATLA wrote:
> You are right, It does not make sense to use BIT() macro for field which
> has more than 1 bit. I think using mix of both BIT() and the old style
> will make code look bit confusing to reader, Also no other mach code in
> the kernel use BIT while configuring L2 controller. So am going to drop
> the idea of using BIT here and leave the code as it is.

I'd suggest putting a comment in the code to that effect.  With the way
"cleanups" get done, I wouldn't be surprised if this attracts a lot of
people wanting to do a trivial "1 << bit" -> "BIT(bit)" conversions.

One of the problems of open source is that you can say "no" to a patch
like that until you're blue in the face, but it will eventually make
its way in via some path.

Just one of the reasons I consider BIT() to be evil and an inappropriate
macro.
