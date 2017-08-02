From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
Date: Wed, 2 Aug 2017 16:56:25 +0200
Message-ID: <CAK8P3a20dXeeNkRCgs8BNWOo1zvNpBLqkQNwpj8dS2bOq1cq+A@mail.gmail.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com> <2578d94a-fd1b-9598-251d-59764a870933@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2578d94a-fd1b-9598-251d-59764a870933-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org, Jiri Pirko <jiri-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 2, 2017 at 4:30 PM, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> On 08/02/2017 03:18 PM, Oleksandr Shamray wrote:
>> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.

>> +static u32 aspeed_jtag_read(struct aspeed_jtag *aspeed_jtag, u32 reg)
>> +{
>> +     return readl(aspeed_jtag->reg_base + reg);
>> +}
>> +
>> +static void
>> +aspeed_jtag_write(struct aspeed_jtag *aspeed_jtag, u32 val, u32 reg)
>> +{
>> +     writel(val, aspeed_jtag->reg_base + reg);
>> +}
>
> Maybe readl_relaxed/writel_relaxed would be enough here.

I'd prefer keeping the regular accessors here, unless this is shown
to be a performance bottleneck, and there is a comment to explain
how the relaxed accessors are determined to be safe.

        Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
