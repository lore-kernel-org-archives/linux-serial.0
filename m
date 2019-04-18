From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: Fix using plain integer instead of Null pointer
Date: Thu, 18 Apr 2019 08:40:45 +0200
Message-ID: <20190418064045.GA12503@kroah.com>
References: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555568485-6421-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 18, 2019 at 03:21:25PM +0900, Sugaya Taichi wrote:
> Fix build warning that using plain integer as Null pointer.
> This is reported by kbuild test robot.
> 
> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  drivers/tty/serial/milbeaut_usio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Using a "Reported-by:" tag is usually a good idea.  I'll add it when I
apply the patch, but for next time can you please add it?

thanks,

greg k-h
