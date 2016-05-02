From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3] serial: samsung: Reorder the sequence of clock control
 when call s3c24xx_serial_set_termios()
Date: Mon, 2 May 2016 14:04:40 +0200
Message-ID: <CAJKOXPf-5QXcdmApzzZgcd=QEn5bVbtB2w90kxMGLTAz3HRoSw@mail.gmail.com>
References: <1461232711-4159-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461232711-4159-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, kgene@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 21, 2016 at 11:58 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch fixes the broken serial log when changing the clock source
> of uart device. Before disabling the original clock source, this patch
> enables the new clock source to protect the clock off state for a split second.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changes from v2:
> - Add reviewd-by tag from Marek Szyprowski
> - No changes about operation
>
> Changes from v1:
> - Enable the clock before changing the source by s3c24xx_serial_setsource()
> - Rebase it on Linux v4.6-rc1
>
>  drivers/tty/serial/samsung.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Fixes synchronous abort on our Exynos5433-based board. This should be
marked for cc-stable. I'll send a port for that.

BR,
Krzysztof
