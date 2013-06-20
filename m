From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 02/10] clocksource:arm_global_timer: Add ARM global timer support.
Date: Thu, 20 Jun 2013 21:02:30 +0200
Message-ID: <201306202102.30478.arnd@arndb.de>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com> <1371737121-9295-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65517 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965763Ab3FTTCj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Jun 2013 15:02:39 -0400
In-Reply-To: <1371737121-9295-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Stuart Menefy <stuart.menefy@st.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel@stlinux.com, linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>, Stephen Gallimore <stephen.gallimore@st.com>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>

On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
> +static u64 gt_counter_read(void)
> +{
> +       u64 counter;
> +       u32 lower;
> +       u32 upper, old_upper;
> +
> +       upper = __raw_readl(gt_base + GT_COUNTER1);
> +       do {
> +               old_upper = upper;
> +               lower = __raw_readl(gt_base + GT_COUNTER0);
> +               upper = __raw_readl(gt_base + GT_COUNTER1);
> +       } while (upper != old_upper);
> +
> +       counter = upper;
> +       counter <<= 32;
> +       counter |= lower;
> +       return counter;
> +}

Please replace __raw_readl etc with the non-__raw variants
throughout the code.

The __raw accessors are not endian safe and are not meant
for device drivers. If you are worried about latency from
extra barriers, use readl_relaxed().

	Arnd
