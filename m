From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v11 17/19] serial: asc: Adopt readl_/writel_relaxed()
Date: Tue, 2 Sep 2014 15:55:19 +0200
Message-ID: <5405CC47.2040907@st.com>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org> <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org> <1409662853-29313-18-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47055 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751500AbaIBN4U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 09:56:20 -0400
In-Reply-To: <1409662853-29313-18-git-send-email-daniel.thompson@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgdb-bugreport@lists.sourceforge.net, patches@linaro.org, linaro-kernel@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Colin Cross <ccross@android.com>, kernel-team@android.com, Rob Herring <robherring2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>, Fabio Estevam <festevam@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Nicolas Pitre <nico@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, kernel@stlinux.com, linux-serial@vger.kernel.org

Hi Daniel,

On 09/02/2014 03:00 PM, Daniel Thompson wrote:
> The architectures where this peripheral exists (ARM and SH) have expensive
> implementations of writel(), reliant on spin locks and explicit L2 cache
> management. These architectures provide a cheaper writel_relaxed() which
> is much better suited to peripherals that do not perform DMA. The
> situation with readl()/readl_relaxed()is similar although less acute.
>
> This driver does not use DMA and will be more power efficient and more
> robust (due to absense of spin locks during console I/O) if it uses the
> relaxed variants.
>
> This change means the driver is no longer portable and therefore no
> longer suitable for compile testing.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: kernel@stlinux.com
> Cc: linux-serial@vger.kernel.org
> ---
>   drivers/tty/serial/Kconfig  | 2 +-
>   drivers/tty/serial/st-asc.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)



You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

thanks!
Maxime

