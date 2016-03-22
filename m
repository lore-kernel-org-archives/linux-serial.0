From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/6] of/serial: move earlycon early_param handling to serial
Date: Tue, 22 Mar 2016 06:15:10 -0500
Message-ID: <CAL_JsqL+YU7qSze40c+M5AaOvpZDFgvg=SsRGmpT3k_=L6P8JQ@mail.gmail.com>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org> <1458643595-14719-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458643595-14719-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 22, 2016 at 5:46 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
>
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to decide if ACPI SPCR earlycon should be set up.

How so? Isn't that determined by whether we have ACPI tables or a DT?

This goes against trying to limit places of FDT parsing and keeping
the early scanning all within fdt.c. At least it is not in the arch
code. That said, I'm okay with this change if it helps.

Rob
