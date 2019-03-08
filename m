From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
Date: Fri, 8 Mar 2019 10:40:03 -0800
Message-ID: <CAKwvOdk=A6QOHbqr78sr1jt=wfy08yqRf5HxE_qVOQVOZhNsvg@mail.gmail.com>
References: <20190308084022.GA31474@kroah.com> <20190308183743.11145-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308183743.11145-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux@googlegroups.com
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 8, 2019 at 10:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud'
> is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> It's not wrong; when options is NULL, baud has no default value. Use
> 9600 as that is a sane default.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/395
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Great find. Thanks for the fix, and thanks Greg for the advice and
additional analysis here.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3bcec1c20219..35e5f9c5d5be 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1050,7 +1050,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
>  {
>         struct uart_port *uport;
>         struct qcom_geni_serial_port *port;
> -       int baud;
> +       int baud = 9600;
>         int bits = 8;
>         int parity = 'n';
>         int flow = 'n';
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
