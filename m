From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/7] serial: qcom_geni_serial: Finish supporting sysrq
Date: Fri, 02 Nov 2018 09:47:07 -0700
Message-ID: <154117722795.88331.829582703808332252@swboyd.mtv.corp.google.com>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-2-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029180707.207546-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Jason Wessel <jason.wessel@windriver.com>, gregkh@linuxfoundation.org, mingo@kernel.org, tglx@linutronix.de
Cc: linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Quoting Douglas Anderson (2018-10-29 11:07:01)
> The geni serial driver already had some sysrq code in it, but since
> SUPPORT_SYSRQ wasn't defined the code didn't do anything useful.
> Let's make it useful by adding that define using the same formula
> found in other serial drivers.
> =

> In order to prevent deadlock, we'll take a page from the
> 'msm_serial.c' where the spinlock is released around
> uart_handle_sysrq_char().  This seemed better than copying from
> '8250_port.c' where we skip locking in the console_write function
> since the '8250_port.c' method can cause lockdep warnings when
> dropping into kgdb.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Given that it's the same as msm_serial.c, and I wrote the msm_serial.c
"hack" then:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
