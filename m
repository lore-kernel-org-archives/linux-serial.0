From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Unthrottle tty when flushing read buffer
Date: Mon, 28 Jan 2013 16:38:58 -0500
Message-ID: <1359409138.3301.6.camel@thor.lan>
References: <1358980578-8811-1-git-send-email-Karthik.Manamcheri@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358980578-8811-1-git-send-email-Karthik.Manamcheri@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Karthik Manamcheri <Karthik.Manamcheri@ni.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>
List-Id: linux-serial@vger.kernel.org

[cc'ing Ilya Zykov]

Hi Karthik,

On Wed, 2013-01-23 at 16:36 -0600, Karthik Manamcheri wrote:
> When the tty input buffer is full and thereby throttled,
> flushing/resetting the read buffer should unthrottle to allow more
> data to be received.
> 
> Signed-off-by: Karthik Manamcheri <Karthik.Manamcheri@ni.com>
> ---
>  drivers/tty/n_tty.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 19083efa2314660b25e0fb5bc793af6fb7e9af57..d5cea3bb01eaeec61b577de6c58a8000412c0c37 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -229,6 +229,8 @@ static void reset_buffer_flags(struct tty_struct *tty)
>  	ldata->canon_head = ldata->canon_data = ldata->erasing = 0;
>  	bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
>  	n_tty_set_room(tty);
> +
> +	check_unthrottle(tty);
>  }
>  
>  /**

Although it's not really my place to NAK, the maintainership was
recently transitioned, so NAK.  See this kernel thread
http://www.gossamer-threads.com/lists/linux/kernel/1636154?do=post_view_threaded#1636154
for why.

See if this patch
http://www.gossamer-threads.com/lists/linux/kernel/1660788
works for you instead.

Regards,
Peter Hurley
