From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [STLinux Kernel] [PATCH v3 03/10] pinctrl:st: Add pinctrl and
 pinconf support.
Date: Tue, 25 Jun 2013 10:39:06 +0100
Message-ID: <51C9653A.4050500@st.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com> <1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com> <51C45816.5010207@st.com> <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com> <20130624141257.GM27646@sirena.org.uk>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130624141257.GM27646@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Stephen Gallimore <stephen.gallimore@st.com>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 24/06/13 15:12, Mark Brown wrote:
> On Mon, Jun 24, 2013 at 01:57:56PM +0200, Linus Walleij wrote:
> 
>> This seems fairly complete, but I cannot have such a basic dependency onto
>> the regmap tree this late in the merge window, i.e. I'm not ready to pull
>> all of regmap into the pinctrl tree. I'd consider this for merging
>> for the next kernel cycle so it's more orthogonal.
> 
> I've got the patch on a topic branch in regmap to allow for this sort of
> stuff - I can readily provide a signed tag for you to get just that
> patch if that'd help?  Alternatively I'm happy to carry the pinctrl
> patch in regmap?
Thanks Mark,

Am Ok with either way, it is required that these 2 patches to go together.

Linus W, if you are happy with the patch can Mark take it via regmap repo?

Thanks,
srini

> 
> 
> 
> _______________________________________________
> Kernel mailing list
> Kernel@stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
> 

