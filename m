From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 0/4] msm_serial fixes and improvements
Date: Mon, 29 Jul 2013 12:31:45 +0300
Message-ID: <1375090305.1956.49.camel@iivanov-dev.int.mm-sol.com>
References: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Hi, 

On Wed, 2013-07-24 at 11:37 -0700, Stephen Boyd wrote:
> Here are a couple fixes and improvements to the msm_serial
> driver. The first two patches fix a bug on UARTDM devices and
> silence sparse warnings. The last two patches improve the baud
> code detection and increase the throughput on UARTDM devices.
> 
> After this it is rather trivial to add support for newer UARTDM
> devices via new compatible fields.
> 
> Stephen Boyd (4):
>   msm_serial: Fix NUL byte output on UARTDM
>   msm_serial: Fix sparse warnings
>   msm_serial: Make baud_code detection more dynamic
>   msm_serial: Send more than 1 character at a time on UARTDM
> 

Thanks, It is working on 8074 based DragonBoard.

Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>


>  drivers/tty/serial/msm_serial.c | 180 ++++++++++++++++++++--------------------
>  drivers/tty/serial/msm_serial.h |  19 ++---
>  2 files changed, 97 insertions(+), 102 deletions(-)
> 
