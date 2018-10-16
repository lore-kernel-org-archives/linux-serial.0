From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Don't slow all ports just for kgdb
Date: Tue, 16 Oct 2018 13:53:33 -0700
Message-ID: <153972321308.5275.4720449474527347628@swboyd.mtv.corp.google.com>
References: <20181015204425.84537-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015204425.84537-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: msavaliy@codeaurora.org, linux-arm-msm@vger.kernel.org, alokc@codeaurora.org, mka@chromium.org, evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Quoting Douglas Anderson (2018-10-15 13:44:24)
> If you turn on CONFIG_KGDB then you'll get CONFIG_CONSOLE_POLL
> selected.
> =

> If you have CONFIG_CONSOLE_POLL selected then the GENI serial driver
> was setting RX_BYTES_PW to 1 for _all_ UART ports.
> =

> This doesn't seem like such a good idea.  Let's only set RX_BYTES_PW
> to 1 for the console port.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
