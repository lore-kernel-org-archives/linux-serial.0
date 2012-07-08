From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 09/11] fblog: register console driver
Date: Sun, 08 Jul 2012 15:09:21 -0700
Message-ID: <1341785361.13174.25.camel@joe2Laptop>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	 <1341784614-2797-10-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341784614-2797-10-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2012-07-08 at 23:56 +0200, David Herrmann wrote:
> We want to print the kernel log to all FBs so we need a console driver.
> This registers the driver on startup and writes all messages to all
> registered fblog instances.

Hi David.  Trivia only:

> diff --git a/drivers/video/console/fblog.c b/drivers/video/console/fblog.c
[]
> @@ -47,6 +71,107 @@ static struct fblog_fb *fblog_fbs[FB_MAX];
>  static bool active = 1;
>  
>  #define to_fblog_dev(_d) container_of(_d, struct fblog_fb, dev)
> +#define FBLOG_STR(x) x, sizeof(x) - 1

That's a rather ugly macro.

> +static void fblog_buf_resize(struct fblog_buf *buf, size_t width,
> +			     size_t height)
> +{
> +	u16 **lines = NULL;
> +	size_t i, j, minw, minh;
> +
> +	if (buf->height == height && buf->width == width)
> +		return;
> +
> +	if (width && height) {
> +		lines = kzalloc(height * sizeof(char*), GFP_KERNEL);

sizeof(char *) is a bit more kernel style like.
