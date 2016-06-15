From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [RFC PATCH] tty: serial: msm_serial: Don't reset uart on set_termios
Date: Wed, 15 Jun 2016 18:28:16 +0530
Message-ID: <CANYu_0uH2xPRaLuWsGTsaKko6T2o9irRxmvDedaOt6UH7OwMKQ@mail.gmail.com>
References: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 14 June 2016 at 00:32, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> Upon opening the tty, uart_open() ends up calling msm_set_baud_rate()
> which resets the uart block. If this happens as we're coming out of
> msm_console_write() a full fifo worth of console output will be
> discarded.
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> As reported here:
> https://bugs.96boards.org/show_bug.cgi?id=378
>
>  drivers/tty/serial/msm_serial.c | 18 ------------------
>  1 file changed, 18 deletions(-)

Thanks for the patch.

I no longer see these corruptions with this patch. This is what I used
to see on my DB410C with debain FS:
http://paste.ubuntu.com/17319106/

Tested-by: Pramod Gurav <pramod.gurav@linaro.org>

Regards,
Pramod
