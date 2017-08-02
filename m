From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
Date: Wed, 2 Aug 2017 16:54:57 +0200
Message-ID: <CAK8P3a02O4Xrt+HECjs+GQLw8s9novYLdUUmk_V+oK=EX-HqfQ@mail.gmail.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com> <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org, vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org, system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org, Jiri Pirko <jiri-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 2, 2017 at 3:18 PM, Oleksandr Shamray
<oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org> wrote:
> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
>
> Driver implements the following jtag ops:
> - freq_get;
> - freq_set;
> - status_get;
> - idle;
> - xfer;
>
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
>
> Signed-off-by: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jiri Pirko <jiri-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>

Looking at this one before the subsystem. Overall looks really nice,
it seems you got a good abstraction between the subsystem and the
driver.

> +
> +static int aspeed_jtag_freq_set(struct jtag *jtag, unsigned long freq);
> +static int aspeed_jtag_freq_get(struct jtag *jtag, unsigned long *frq);
> +static int aspeed_jtag_status_get(struct jtag *jtag,
> +                                 enum jtag_endstate *status);
> +static int aspeed_jtag_idle(struct jtag *jtag,
> +                           struct jtag_run_test_idle *runtest);
> +static int aspeed_jtag_xfer(struct jtag *jtag, struct jtag_xfer *xfer);

Please try to reorder the functions definitions in a way that lets you
remove the forward declarations.

> +
> +static void aspeed_jtag_run_test_idle_sw(struct aspeed_jtag *aspeed_jtag,
> +                                        struct jtag_run_test_idle *runtest)
> +{
> +       char sm_pause_irpause[] = {1, 1, 1, 1, 0, 1, 0};
> +       char sm_pause_drpause[] = {1, 1, 1, 0, 1, 0};
> +       char sm_idle_irpause[] = {1, 1, 0, 1, 0};
> +       char sm_idle_drpause[] = {1, 0, 1, 0};
> +       char sm_pause_idle[] = {1, 1, 0};

These could be 'static const' if you adapt the aspeed_jtag_sm_cycle
prototype accordingly.

> +
> +static const struct of_device_id aspeed_jtag_of_match[] = {
> +       { .compatible = "aspeed,aspeed-jtag", },
> +       {}
> +};

The series should include a patch for the DT binding for this device.
You may want to be a little more specific here, to avoid problems if
aspeed ever makes an updated version of this device with a slightly
different register interface. Usually we include the full name of the
SoC in the "compatible" string for that.

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
