From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 1/5] of/serial: move earlycon early_param handling to
 serial
Date: Thu, 28 Apr 2016 17:42:44 -0700
Message-ID: <20160429004244.GA31752@kroah.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 31, 2016 at 04:40:23PM +0300, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
> 
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to defer setting up DT console until ACPI/DT decision is made.
> 
> Rename the exported function to avoid clashing with the function from
> arch/microblaze/kernel/prom.c
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/fdt.c              | 11 +----------
>  drivers/tty/serial/earlycon.c |  2 +-
>  include/linux/of_fdt.h        |  2 ++
>  3 files changed, 4 insertions(+), 11 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
