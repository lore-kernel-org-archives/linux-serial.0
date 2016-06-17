From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH v2] tty: serial: msm: Don't reconfigure same baud rate
Date: Fri, 17 Jun 2016 13:02:44 +0300
Message-ID: <CAP71WjyPiDK+rr6Z6=Cvp_Bjrpd2HSQ_K58ucJqJ5ZWs_4khtw@mail.gmail.com>
References: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org> <1466101475-8851-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466101475-8851-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 16, 2016 at 9:24 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> msm_set_termios() is called whenever the tty is opened. Setting the b=
aud
> rate requires a full reset of the msm serial block, even when the rat=
e
> is unchanged. In the case when the same uart is used as console this
> reset will discard any console output data still being clocked out of
> the TX fifo.
>
> By skipping the rate-change in the case where the baud rate is unchan=
ged
> since last request we can avoid the reset and the discarding of the
> data.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Tested-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

I no longer see this type of corruption on serial console

[    6.325118] ALSA device =EF=BF=BD[    6.333338] Freeing unused kerne=
l
memory: 572K (ffffffc000c10000 - ffffffc000c9f000)
[   13.800269]  remoteproc2: remote processor a20400=EF=BF=BD[  OK  ] S=
tarted
Start the WCN core.
[ =EF=BF=BD         Starting Update UTMP about System Runlevel Changes.=
=2E.
