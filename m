From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: n_tty_write() going into schedule but NOT coming out
Date: Wed, 3 Apr 2013 13:12:28 +0530
Message-ID: <515BDD64.3010405@synopsys.com>
References: <5156DC21.20901@synopsys.com> <515BC1AF.1070103@izyk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:46403 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760049Ab3DCHne (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Apr 2013 03:43:34 -0400
In-Reply-To: <515BC1AF.1070103@izyk.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <linux@izyk.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Hi Ilya

On 04/03/2013 11:14 AM, Ilya Zykov wrote:
> Please, try this patch maybe it can help localize your problem.
>
>  drivers/tty/n_tty.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 05e72be..28f15d0 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -230,6 +230,7 @@ static void reset_buffer_flags(struct tty_struct *tty)
>  	ldata->canon_head = ldata->canon_data = ldata->erasing = 0;
>  	bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
>  	n_tty_set_room(tty);
> +	check_unthrottle(tty);
>  }
>  
>  /**

Thanks for the patch - but it didn't help at all - I see the same lockup.
I'm no tty expert so don't understand how this patch would help - care to elaborate ?

Thx,
-Vineet
