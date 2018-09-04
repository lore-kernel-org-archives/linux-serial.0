From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 1/5] serial: sprd: Remove unused structure
Date: Tue, 4 Sep 2018 14:52:12 +0800
Message-ID: <CAAfSe-tVJ1P30y+aj-2AsEtsbQ=O3vADxZNc_UW6ri92suGMgA@mail.gmail.com>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> Remove the unused reg_backup structure.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 828f114..1b0e3fb 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -95,19 +95,8 @@
>  #define SPRD_IMSR_BREAK_DETECT         BIT(7)
>  #define SPRD_IMSR_TIMEOUT              BIT(13)
>
> -struct reg_backup {
> -       u32 ien;
> -       u32 ctrl0;
> -       u32 ctrl1;
> -       u32 ctrl2;
> -       u32 clkd0;
> -       u32 clkd1;
> -       u32 dspwait;
> -};
> -
>  struct sprd_uart_port {
>         struct uart_port port;
> -       struct reg_backup reg_bak;
>         char name[16];
>  };
>
> --
> 1.9.1
>
