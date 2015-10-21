From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 21 Oct 2015 08:09:23 -0400
Message-ID: <56278073.6030700@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
 <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de>
 <55AED708.903@hurleysoftware.com> <55AEE805.9050204@svenbrauch.de>
 <55B01554.90201@hurleysoftware.com> <55B01EDE.3050503@svenbrauch.de>
 <55C249A3.6030809@hurleysoftware.com> <562684F4.1020501@hurleysoftware.com>
 <1445422352.2246.22.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445422352.2246.22.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Johan Hovold <johan@kernel.org>, Sven Brauch <mail@svenbrauch.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/21/2015 06:12 AM, Oliver Neukum wrote:
> On Tue, 2015-10-20 at 14:16 -0400, Peter Hurley wrote:
>> ECHO is on by default and the cdc-acm driver does not implement the
>> put_char() and flush_chars() tty driver methods, which made the
>> problem
>> _way worse_, since every echoed char is sent as it's own URB.
> 
> That can be fixed. How can I test this?

I'm working on getting my tty tests organized for upstreaming, but it's
not there yet. Let me see if I can get you a standalone test for
accuracy, at least.

> Will the tty layer use write() and put_char()?

Echoing uses put_char() + flush_chars() for echoing, if the driver
supports it; otherwise, it uses write().

Be aware that while the N_TTY line discipline ensures that put_char()
and write() usage will not be interleaved without flush_chars(), other
line disciplines might not, so at least be sure that driver won't
crash if that happens.

Regards,
Peter Hurley


> From ac75a2c9ea67ec22c704a6bcaa30e6fc415d64d3 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Wed, 21 Oct 2015 12:10:07 +0200
> Subject: [PATCH] cdc-acm: implement put_char() and flush_chars()
> 
> This should cut down latencies and waste if the tty layer writes single bytes.
> 
> Signed-off-by: Oliver Neukum >oneukum@suse.com>
> ---
>  drivers/usb/class/cdc-acm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/class/cdc-acm.h |  1 +
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index b30e742..262f179 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -725,6 +725,62 @@ static int acm_tty_write(struct tty_struct *tty,
>  	return count;
>  }
>  
> +static void acm_tty_flush_chars(struct tty_struct *tty)
> +{
> +	struct acm *acm = tty->driver_data;
> +	struct acm_wb *cur = acm->putbuffer;
> +	int err;
> +	unsigned long flags;
> +
> +	acm->putbuffer = NULL;
> +	err = usb_autopm_get_interface_async(acm->control);
> +	spin_lock_irqsave(&acm->write_lock, flags);
> +	if (err < 0) {
> +		cur->use = 0;
> +		goto out;
> +	}
> +
> +	if (acm->susp_count) {
> +		usb_anchor_urb(cur->urb, &acm->delayed);
> +		goto out;
> +	}
> +
> +	acm_start_wb(acm, cur);
> +out:
> +	spin_unlock_irqrestore(&acm->write_lock, flags);
> +	return;
> +}
> +
> +static int acm_tty_put_char(struct tty_struct *tty, unsigned char ch)
> +{
> +	struct acm *acm = tty->driver_data;
> +	struct acm_wb *cur;
> +	int wbn;
> +	unsigned long flags;
> +
> +overflow:
> +	cur = acm->putbuffer;
> +	if (!cur) {
> +		spin_lock_irqsave(&acm->write_lock, flags);
> +		wbn = acm_wb_alloc(acm);
> +		if (wbn >= 0) {
> +			cur = &acm->wb[wbn];
> +			acm->putbuffer = cur;
> +		}
> +		spin_unlock_irqrestore(&acm->write_lock, flags);
> +		if (!cur)
> +			return 0;
> +	}
> +
> +	if (cur->len == acm->writesize) {
> +		acm_tty_flush_chars(tty);
> +		goto overflow;
> +	}
> +
> +	cur->buf[cur->len++] = ch;
> +	return 1;
> +}
> +
>  static int acm_tty_write_room(struct tty_struct *tty)
>  {
>  	struct acm *acm = tty->driver_data;
> @@ -1888,6 +1944,8 @@ static const struct tty_operations acm_ops = {
>  	.cleanup =		acm_tty_cleanup,
>  	.hangup =		acm_tty_hangup,
>  	.write =		acm_tty_write,
> +	.put_char =		acm_tty_put_char,
> +	.flush_chars =		acm_tty_flush_chars,
>  	.write_room =		acm_tty_write_room,
>  	.ioctl =		acm_tty_ioctl,
>  	.throttle =		acm_tty_throttle,
> diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
> index dd9af38..648a6f7 100644
> --- a/drivers/usb/class/cdc-acm.h
> +++ b/drivers/usb/class/cdc-acm.h
> @@ -94,6 +94,7 @@ struct acm {
>  	unsigned long read_urbs_free;
>  	struct urb *read_urbs[ACM_NR];
>  	struct acm_rb read_buffers[ACM_NR];
> +	struct acm_wb *putbuffer;			/* for acm_tty_put_char() */
>  	int rx_buflimit;
>  	int rx_endpoint;
>  	spinlock_t read_lock;
> 
