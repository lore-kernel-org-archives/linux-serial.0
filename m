From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/10] serial:st-asc: Add ST ASC driver.
Date: Thu, 20 Jun 2013 21:01:10 +0200
Message-ID: <201306202101.11261.arnd@arndb.de>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com> <1371737103-8871-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371737103-8871-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Stuart Menefy <stuart.menefy@st.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel@stlinux.com, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>, Stephen Gallimore <stephen.gallimore@st.com>
List-Id: linux-serial@vger.kernel.org

On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
> This patch adds support to ASC (asynchronous serial controller)
> driver, which is basically a standard serial driver. This IP is common
> across all the ST parts for settop box platforms.
> 
> ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionality.
> It support all industry standard baud rates.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Stephen Gallimore <stephen.gallimore@st.com>
> CC: Stuart Menefy <stuart.menefy@st.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

>From my point of view the series is ready for merging in 3.11,
I only had a few final comments. I would prefer the first three
patches to go through the respective serial/clocksource/pinctrl
trees, since there are no direct build dependencies to the
platform parts.

If there is a reason to take those through arm-soc, I would
insist on getting Acked-by's from the subsystem maintainers.

	Arnd
