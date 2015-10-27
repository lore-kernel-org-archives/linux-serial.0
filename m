From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 03/15] tty: Deinline n_tty_receive_char_inline, save 224
 bytes
Date: Tue, 27 Oct 2015 14:08:59 -0400
Message-ID: <562FBDBB.70500@hurleysoftware.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
 <1445968007-12616-4-git-send-email-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-4-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/27/2015 01:46 PM, Denys Vlasenko wrote:
> This function compiles to 198 bytes of machine code.
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Peter Hurley <peter@hurleysoftware.com>
> CC: Jiri Slaby <jslaby@suse.com>
> CC: linux-serial@vger.kernel.org
> ---
>  drivers/tty/n_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index b09023b..c38f5d8 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1407,7 +1407,7 @@ handle_newline:
>  	return 0;
>  }
>  
> -static inline void
> +static void
>  n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
>  {
>  	struct n_tty_data *ldata = tty->disc_data;
> 

This is one of the patches I will rework differently to remove the
inlining (n_tty_receive_char_inline() can be deleted and its call
sites replaced with n_tty_receive_char()).

Regards,
Peter Hurley
