From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BACKPORT 4.4.y 23/25] serial: sprd: clear timeout interrupt
 only rather than all interrupts
Date: Tue, 26 Mar 2019 10:34:58 +0900
Message-ID: <20190326013458.GC21198@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-24-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-24-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Lanqing Liu <lanqing.liu@spreadtrum.com>, Chunyan Zhang <chunyan.zhang@spreadtrum.com>, Lanqing Liu <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:14PM +0100, Arnd Bergmann wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> 
> On Spreadtrum's serial device, nearly all of interrupts would be cleared
> by hardware except timeout interrupt.  This patch removed the operation
> of clearing all interrupt in irq handler, instead added an if statement
> to check if the timeout interrupt is supposed to be cleared.
> 
> Wrongly clearing timeout interrupt would lead to uart data stay in rx
> fifo, that means the driver cannot read them out anymore.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 4350782570b919f254c1e083261a21c19fcaee90)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/sprd_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Also added to 4.9.y
