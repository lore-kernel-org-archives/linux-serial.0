From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/4] ACPI: parse SPCR and enable matching console
Date: Mon, 29 Feb 2016 15:29:41 +0200
Message-ID: <CAHp75VdswvD23xqRNUX=fwMt5HReR-wcSo+RYweB6FYqWPar8w@mail.gmail.com>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
	<1456747355-15692-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456747355-15692-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 29, 2016 at 2:02 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> 'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
>
> Parse this table and check if any registered console match the
> description.  If it does, enable that console.
>
> Introduce a new function acpi_console_check().  At the uart port
> registration, this function checks if the ACPI SPCR table specifies
> its argument of type struct uart_port to be a console
> and if so calls add_preferred_console().

> +       if (ACPI_FAILURE(status)) {
> +               pr_err("could not get the table\n");

Is it worse to have on error level? Is it possible to have firmware
without this table? I think it would be a normal case for non-arm
world.
I'm also not sure if this message useful even on warn level.

> +               return -ENOENT;
> +       }
> +
> +       if (table->header.revision < 2) {
> +               err = -EINVAL;
> +               pr_err("wrong table version\n");

And this one quite good to have, indeed.

> + * acpi_console_check - Check if uart matches the console specified by SPCR.
> + *
> + * @uport:     uart port to check
> + *

Since you use sections, you may add:
+ * Description:

> + * This function checks if the ACPI SPCR table specifies @uport to be a console
> + * and if so calls add_preferred_console()
> + *
> + * Return: a non-error value if the console matches.

> @@ -2654,8 +2655,17 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>                 spin_lock_init(&uport->lock);
>                 lockdep_set_class(&uport->lock, &port_lock_key);
>         }
> -       if (uport->cons && uport->dev)
> -               of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
> +
> +       /*
> +        * Support both open FW and ACPI access to console definitions.
> +        * Both of_console_check() and acpi_console_check() will call
> +        * add_preferred_console() if a console definition is found.
> +        */
> +       if (uport->cons && uport->dev) {
> +               if (!acpi_console_check(uport))

if (cond1) {
 if (cond2) {
...
 }
}

is equivalent to
if (cond1 && cond2) {
...
}

> +                       of_console_check(uport->dev->of_node, uport->cons->name,
> +                                        uport->line);
> +       }



-- 
With Best Regards,
Andy Shevchenko
