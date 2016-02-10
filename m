From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v8 0/3] tty: Introduce software RS485 direction control
 support
Date: Wed, 10 Feb 2016 08:05:59 -0800
Message-ID: <56BB5FE7.30009@hurleysoftware.com>
References: <1454350162-1840-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454350162-1840-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Matwey,

On 02/01/2016 10:09 AM, Matwey V. Kornilov wrote:
> Changes from v7:
>  - rework comments to follow guidelines
>  - minor style changes
> Changes from v6:
>  - minor style changes
>  - timers are not IRQSAFE now
> Changes from v5:
>  - rs485_emul variable has been renamed to em485 to follow function names convention
> Changes from v4:
>  - Add commit message to 1/3
> Changes from v3:
>  - Completely redesigned.
> Changes from v2:
>  - Introduced SER_RS485_SOFTWARE to show that software implementation is being used
>  - serial8250_rs485_config is located as required
>  - Timers are used to implement delay_before and delay_after timeouts
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

The holdup here is that I'd like to unit test this, which is 3rd on my todo list.
Should be done before the end of the week which will be soon enough
for this series to make linux-next.

Thanks for your work on this.

Regards,
Peter Hurley
