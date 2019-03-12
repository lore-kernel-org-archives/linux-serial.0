From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 09:33:56 -0700
Message-ID: <20190312163356.GB13549@kroah.com>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552402660-31730-2-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

No changelog or signed-off-by, sorry, please fix up the series and
resend.

thanks,

greg k-h
