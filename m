From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 03/10] pinctrl:st: Add pinctrl and pinconf support.
Date: Mon, 24 Jun 2013 13:57:56 +0200
Message-ID: <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
	<1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com>
	<51C45816.5010207@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51C45816.5010207@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Stuart Menefy <stuart.menefy@st.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, kernel@stlinux.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Stephen Gallimore <stephen.gallimore@st.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 21, 2013 at 3:41 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> Hi Linus W,
> If its not too late can this patch be considered for 3.11 via pinctrl tree?
> There is a build dependecy with regmap_field apis pulled by Mark Brown
> in regmap repository.

This seems fairly complete, but I cannot have such a basic dependency onto
the regmap tree this late in the merge window, i.e. I'm not ready to pull
all of regmap into the pinctrl tree. I'd consider this for merging
for the next kernel cycle so it's more orthogonal.

Yours,
Linus Walleij
