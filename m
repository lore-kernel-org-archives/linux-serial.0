From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BACKPORT 4.4.y 19/25] serial: sprd: adjust TIMEOUT to a big
 value
Date: Tue, 26 Mar 2019 10:21:54 +0900
Message-ID: <20190326012154.GE29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-20-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-20-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Wei Qiao <wei.qiao@spreadtrum.com>, Chunyan Zhang <chunyan.zhang@spreadtrum.com>, Lanqing Liu <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:10PM +0100, Arnd Bergmann wrote:
> From: Wei Qiao <wei.qiao@spreadtrum.com>
> 
> SPRD_TIMEOUT was 256, which is too small to wait until the status
> switched to workable in a while loop, so that the earlycon could
> not work correctly.
> 
> Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit e1dc9b08051a2c2e694edf48d1e704f07c7c143c)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/sprd_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Also applied to 4.9.y
