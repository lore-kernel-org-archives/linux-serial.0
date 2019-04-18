From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] serial: Add Milbeaut serial control
Date: Thu, 18 Apr 2019 07:17:32 +0200
Message-ID: <20190418051732.GA17053@kroah.com>
References: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555555916-22251-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 18, 2019 at 11:51:56AM +0900, Sugaya Taichi wrote:
> Add Milbeaut serial control including earlycon and console.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
> Changes from v2:
>  - Fix build warning.

No, I only need an incremental patch fixing the one sparse warning
found, not a whole new patch as I have already merged your original
patch, right?

thanks,

greg k-h
