From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/10] serial: stm32: Use of_device_get_match_data()
Date: Sat, 5 Oct 2019 08:53:17 +0200
Message-ID: <20191005065317.GC928719@kroah.com>
References: <20191004214334.149976-1-swboyd@chromium.org>
 <20191004214334.149976-6-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004214334.149976-6-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 04, 2019 at 02:43:29PM -0700, Stephen Boyd wrote:
> This driver casts away the constness of struct stm32_usart_info that is
> pointed to by the of match table. Use of_device_get_match_data() instead
> of of_match_device() here and push the const throughout the code so that
> we don't cast away const. This nicely avoids referencing the match table
> when it is undefined with configurations where CONFIG_OF=n and fixes the
> const issues.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <linux-serial@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please ack or pick for immediate merge so the last patch can be merged.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
