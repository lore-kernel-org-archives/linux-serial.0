From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v7 1/5] of/serial: move earlycon early_param handling to
 serial
Date: Mon, 4 Apr 2016 14:07:37 -0700
Message-ID: <5702D799.5050101@hurleysoftware.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/31/2016 06:40 AM, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
> 
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to defer setting up DT console until ACPI/DT decision is made.
> 
> Rename the exported function to avoid clashing with the function from
> arch/microblaze/kernel/prom.c

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
