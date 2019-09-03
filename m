From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 0/3] keep console alive even if missing the 'enable' clock
Date: Tue, 3 Sep 2019 17:20:54 +0800
Message-ID: <CAMz4ku+j-pSnfp1SJ4WN5seYe=vXxLGH+khaGNrseXi8+WKkoA@mail.gmail.com>
References: <20190826072929.7696-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826072929.7696-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 26 Aug 2019 at 15:29, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> After the commit 4007098f4ce4 (serial: sprd: Add power management for the Spreadtrum serial controller),
> the 'enable' clock was forced to be configured in device tree, otherwise the uart devices couldn't be
> probed successfully.
>
> With this patch-set, the uart device which is used as console would be allowed to register even without
> any clock configured in device tree, this will make debug easier.

Tested on my board, works well and looks good to me. So for the whole series:
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>

>
> Chunyan Zhang (3):
>   serial: sprd: check the right port and membase
>   serial: sprd: add console_initcall in sprd's uart driver
>   serial: sprd: keep console alive even if missing the 'enable' clock
>
>  drivers/tty/serial/sprd_serial.c | 42 ++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> --
> 2.20.1
>


-- 
Baolin Wang
Best Regards
