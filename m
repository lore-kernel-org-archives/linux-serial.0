From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: -Wsometimes-uninitialized Clang warning in
 drivers/tty/serial/qcom_geni_serial.c
Date: Fri, 8 Mar 2019 09:40:22 +0100
Message-ID: <20190308084022.GA31474@kroah.com>
References: <20190308004526.GA11580@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308004526.GA11580@archlinux-ryzen>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Ryan Case <ryandcase@chromium.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 07, 2019 at 05:45:26PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> kernel as it can catch some bugs that GCC can't. This warning came up:
> 
> drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         if (options)
>             ^~~~~~~
> drivers/tty/serial/qcom_geni_serial.c:1082:37: note: uninitialized use occurs here
>         return uart_set_options(uport, co, baud, parity, bits, flow);
>                                            ^~~~
> drivers/tty/serial/qcom_geni_serial.c:1079:2: note: remove the 'if' if its condition is always true
>         if (options)
>         ^~~~~~~~~~~~
> drivers/tty/serial/qcom_geni_serial.c:1053:10: note: initialize the variable 'baud' to silence this warning
>         int baud;
>                 ^
>                  = 0
> 1 warning generated.
> 
> While this is probably not an issue in practice (I assume baud is always
> supplied as an option), we should clean up this warning. I would fix it
> myself but I have no idea what baud's initial value should be as it
> seems it is dependent on the driver. Your input would be much
> appreciated.

this function can be called with the option variable set to NULL, so
there could not be a default baud rate set, nice catch.

As for the default, let's just be sane and set it to 9600 as that's a
normal default baudrate.

Do you want to make up a patch for this, or do you need me to?

thanks,

greg k-h
