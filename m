From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [STLinux Kernel] [PATCH v3 03/10] pinctrl:st: Add pinctrl and
 pinconf support.
Date: Tue, 25 Jun 2013 12:08:02 +0100
Message-ID: <51C97A12.3090608@st.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com> <1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com> <51C45816.5010207@st.com> <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com> <20130624141257.GM27646@sirena.org.uk> <CACRpkdaxqfdXz8bE0coF_mN2W5EUW1ENUJqwV8ne-ezUBpziCA@mail.gmail.com>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog124.obsmtp.com ([207.126.144.157]:49668 "EHLO
	eu1sys200aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751540Ab3FYLNh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Jun 2013 07:13:37 -0400
In-Reply-To: <CACRpkdaxqfdXz8bE0coF_mN2W5EUW1ENUJqwV8ne-ezUBpziCA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Stephen Gallimore <stephen.gallimore@st.com>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 25/06/13 11:58, Linus Walleij wrote:
> On Mon, Jun 24, 2013 at 4:12 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Jun 24, 2013 at 01:57:56PM +0200, Linus Walleij wrote:
>>
>>> This seems fairly complete, but I cannot have such a basic dependency onto
>>> the regmap tree this late in the merge window, i.e. I'm not ready to pull
>>> all of regmap into the pinctrl tree. I'd consider this for merging
>>> for the next kernel cycle so it's more orthogonal.
>>
>> I've got the patch on a topic branch in regmap to allow for this sort of
>> stuff - I can readily provide a signed tag for you to get just that
>> patch if that'd help?  Alternatively I'm happy to carry the pinctrl
>> patch in regmap?
> 
> I'm OK that you carry this in the regmap tree.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks Linus W.

> 
> The clock retime weirdness convinced me that this cannot really
> use the generic pin config layout...
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> Kernel mailing list
> Kernel@stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
> 

