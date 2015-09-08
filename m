From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 5/5] HACK: serial: move pl011 initcall to device_initcall
Date: Tue, 8 Sep 2015 13:56:08 +0100
Message-ID: <20150908125608.GD20562@leverpostej>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-6-git-send-email-leif.lindholm@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441716217-23786-6-git-send-email-leif.lindholm@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "torez@redhat.com" <torez@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 08, 2015 at 01:43:37PM +0100, Leif Lindholm wrote:
> ---
>  drivers/tty/serial/amba-pl011.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 452dbba..31cf985 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2806,7 +2806,7 @@ static void __exit pl011_exit(void)
>   * While this can be a module, if builtin it's most likely the console
>   * So let's leave module_exit but move module_init to an earlier place
>   */
> -arch_initcall(pl011_init);
> +device_initcall(pl011_init);
>  module_exit(pl011_exit);

What's the ordering constraint that you're trying to solve with this?

The cover didn't mention anything, and there's no commit message.

Mark.

>  
>  MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
> -- 
> 2.1.4
> 
