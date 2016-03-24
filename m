From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 1/5] of/serial: move earlycon early_param handling to serial
Date: Thu, 24 Mar 2016 16:07:20 -0500
Message-ID: <CAL_JsqJje4=U4+i3jfFDkRv2Px3cw5QzGHfq41OjRDNL6c_Q8Q@mail.gmail.com>
References: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org> <1458823925-19560-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1458823925-19560-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 24, 2016 at 7:51 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
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

Acked-by: Rob Herring <robh@kernel.org>
