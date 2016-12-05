From: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH] SPCR: check bit width for the 16550 UART
Date: Mon, 5 Dec 2016 10:51:28 -0800
Message-ID: <CADaLND=cpfnrNUAR+hHBjMk=ei50Z=TFhgzDy0T+EkqUuM7ZWQ@mail.gmail.com>
References: <20161205130534.11080-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161205130534.11080-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Graeme Gregory <graeme.gregory@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 5, 2016 at 5:05 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> Check the 'Register Bit Width' field of the ACPI Generic Address
> Structure that specifies the address of the UART registers to
> decide if the driver should use "mmio32" access instead of "mmio".
>
> If the driver is other than 16550 the access with is defined
> by the Interface Type field of the SPCR table.
>
> For discussion:
>
> https://lkml.kernel.org/r/7fa523de-3fbb-1566-f521-927143f73d1e@redhat.com

Tested on X-Gene 1 and X-Gene 2 platforms.

Tested-by: Duc Dang <dhdang@apm.com>
>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Reported-by: Heyi Guo <heyi.guo@linaro.org>
> ---
>  drivers/acpi/spcr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index e8d7bc7..6c6710b 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -70,6 +70,10 @@ int __init parse_spcr(bool earlycon)
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
> +               if (table->serial_port.space_id ==
> +                       ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> +                   table->serial_port.bit_width == 32)
> +                       iotype = "mmio32";
>                 uart = "uart";
>                 break;
>         default:
> --
> 2.10.2
>
Thanks,
Duc Dang.
