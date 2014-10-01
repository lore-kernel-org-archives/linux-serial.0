From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] serial/core: Initialize the console pm state
Date: Wed, 1 Oct 2014 10:27:20 -0700
Message-ID: <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudhir Sreedharan <ssreedharan@mvista.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, lkml <linux-kernel@vger.kernel.org>, olof@lixom.net, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
<ssreedharan@mvista.com> wrote:
> For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
> to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
> are reinitialized when uart_change_pm is called from uart_configure_port.
>
> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>

Multiple boot failures on ARM[1] were bisected down to this patch.

How was this patch tested, and on which platforms?

Also, the changelog states that this should be done only for
UART_CAP_SLEEP, but the patch does it for every UART.

Greg, I suggest this patch be dropped from tty-next until it has been
better described and tested.

Kevin

[1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-October/005550.html
