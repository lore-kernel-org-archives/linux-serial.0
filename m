From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 03/10] pinctrl:st: Add pinctrl and pinconf support.
Date: Tue, 25 Jun 2013 12:58:57 +0200
Message-ID: <CACRpkdaxqfdXz8bE0coF_mN2W5EUW1ENUJqwV8ne-ezUBpziCA@mail.gmail.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
	<1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com>
	<51C45816.5010207@st.com>
	<CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
	<20130624141257.GM27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36946 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab3FYK65 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Jun 2013 06:58:57 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so27105059iea.39
        for <linux-serial@vger.kernel.org>; Tue, 25 Jun 2013 03:58:57 -0700 (PDT)
In-Reply-To: <20130624141257.GM27646@sirena.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Stuart Menefy <stuart.menefy@st.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, kernel@stlinux.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Stephen Gallimore <stephen.gallimore@st.com>, Arnd Bergmann <arnd@arndb.de>

On Mon, Jun 24, 2013 at 4:12 PM, Mark Brown <broonie@kernel.org> wrote:
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

I'm OK that you carry this in the regmap tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The clock retime weirdness convinced me that this cannot really
use the generic pin config layout...

Yours,
Linus Walleij
