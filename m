From: Nathan Chancellor <natechancellor@gmail.com>
Subject: -Wsometimes-uninitialized Clang warning in
 drivers/tty/serial/qcom_geni_serial.c
Date: Thu, 7 Mar 2019 17:45:26 -0700
Message-ID: <20190308004526.GA11580@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Ryan Case <ryandcase@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com
List-Id: linux-serial@vger.kernel.org

Hi all,

We are trying to get Clang's -Wsometimes-uninitialized turned on for the
kernel as it can catch some bugs that GCC can't. This warning came up:

drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (options)
            ^~~~~~~
drivers/tty/serial/qcom_geni_serial.c:1082:37: note: uninitialized use occurs here
        return uart_set_options(uport, co, baud, parity, bits, flow);
                                           ^~~~
drivers/tty/serial/qcom_geni_serial.c:1079:2: note: remove the 'if' if its condition is always true
        if (options)
        ^~~~~~~~~~~~
drivers/tty/serial/qcom_geni_serial.c:1053:10: note: initialize the variable 'baud' to silence this warning
        int baud;
                ^
                 = 0
1 warning generated.

While this is probably not an issue in practice (I assume baud is always
supplied as an option), we should clean up this warning. I would fix it
myself but I have no idea what baud's initial value should be as it
seems it is dependent on the driver. Your input would be much
appreciated.

Cheers,
Nathan
