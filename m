From: Christian Riesch <christian.riesch@omicron.at>
Subject: Re: [PATCH] n_tty: Fix unordered accesses to lockless read buffer
Date: Thu, 1 Jan 2015 12:00:58 +0100
Message-ID: <CABkLObqhqE7Y3eD2gUxmqb0etfvYcDYRnE=-i=-4j=4Ea6=F-w@mail.gmail.com>
References: <1419941156-5303-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419941156-5303-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Peter,

Thank you for this patch! Unfortunately I had not much time for this
since my last patch submission, so I am happy that someone continued
this work.

I have a few comments/questions, please see below.

On Tue, Dec 30, 2014 at 1:05 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Add commit_head buffer index, which the producer-side publishes
> after input processing. This ensures the consumer-side observes
> correctly-ordered writes in raw mode

I understand that the commit_head reduces the number of memory
barriers and makes some things easier. But what is so special about
raw mode that requires the introduction of commit_head?

> (ie., the buffer data is
> written before the buffer index is advanced).
>
> Further, remove read_cnt() and expand inline, using ACCESS_ONCE()

"ACCESS_ONCE() and memory barriers"?

> on the relevant buffer index; read_tail from the producer-side
> and canon_head/commit_head from the consumer-side, or both in shared
> paths such as receive_room().
>
> Based on work by Christian Riesch <christian.riesch@omicron.at>
>
> NB: Exclusive access is still guaranteed with termios_rwsem write
> lock, eg. by n_tty_set_termios() and in n_tty_ioctl(); in this
> circumstance, commit_head is equivalent to read_head.
>
> Cc: Christian Riesch <christian.riesch@omicron.at>
> Cc: <stable@vger.kernel.org> # v3.14.x (will need backport to v3.12.x)
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/n_tty.c | 80 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index d2b4967..a618b10 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -90,6 +90,7 @@
>  struct n_tty_data {
>         /* producer-published */
>         size_t read_head;
> +       size_t commit_head;     /* == read_head when not receiving */
>         size_t canon_head;
>         size_t echo_head;
>         size_t echo_commit;
> @@ -127,11 +128,6 @@ struct n_tty_data {
>         struct mutex output_lock;
>  };
>
> -static inline size_t read_cnt(struct n_tty_data *ldata)
> -{
> -       return ldata->read_head - ldata->read_tail;
> -}
> -
>  static inline unsigned char read_buf(struct n_tty_data *ldata, size_t i)
>  {
>         return ldata->read_buf[i & (N_TTY_BUF_SIZE - 1)];
> @@ -164,15 +160,17 @@ static inline int tty_put_user(struct tty_struct *tty, unsigned char x,
>  static int receive_room(struct tty_struct *tty)
>  {
>         struct n_tty_data *ldata = tty->disc_data;
> +       size_t head = ACCESS_ONCE(ldata->commit_head);
> +       size_t tail = ACCESS_ONCE(ldata->read_tail);
>         int left;
>
>         if (I_PARMRK(tty)) {
> -               /* Multiply read_cnt by 3, since each byte might take up to
> +               /* Multiply count by 3, since each byte might take up to
>                  * three times as many spaces when PARMRK is set (depending on
>                  * its flags, e.g. parity error). */
> -               left = N_TTY_BUF_SIZE - read_cnt(ldata) * 3 - 1;
> +               left = N_TTY_BUF_SIZE - (head - tail) * 3 - 1;
>         } else
> -               left = N_TTY_BUF_SIZE - read_cnt(ldata) - 1;
> +               left = N_TTY_BUF_SIZE - (head - tail) - 1;

Actually, less room may be available, if read_head != commit_head.
Could this cause problems? I guess yes, at least in
n_tty_receive_buf_common, where this could lead to a buffer overflow,
right?

Best regards,
Christian
