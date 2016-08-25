From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Add runtime PM and system sleep support
Date: Thu, 25 Aug 2016 09:54:43 +0530
Message-ID: <CANYu_0tyVNfzJ4G1MutacbYKRNvJfQx2P_tVoiWDD1m3+swUhQ@mail.gmail.com>
References: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1466158618-6702-1-git-send-email-pramod.gurav@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, open list <linux-kernel@vger.kernel.org>, Pramod Gurav <pramod.gurav@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 17 June 2016 at 15:46, Pramod Gurav <pramod.gurav@linaro.org> wrote:
> Add runtime pm and suspend/resume callback support to serial msm
> driver so that clock resources are managed runtime to save power.
>

Any comments on this patch?

> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.c | 183 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 168 insertions(+), 15 deletions(-)
>

>
