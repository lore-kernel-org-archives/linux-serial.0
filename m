From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Race between release_tty() and vt_disallocate()
Date: Thu, 17 Aug 2017 13:11:49 +0100
Message-ID: <20170817131149.4ee52505@alans-desktop>
References: <CAK8P3a2Pok0Mpmj+DZG3gi13F9bWrK_u7M0hC4kHKuUzSuH1Ng@mail.gmail.com>
        <20170814133947.37ad1855@alans-desktop>
        <8400458.N1a9Uh7DF8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8400458.N1a9Uh7DF8@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, jun.he@linaro.org, graeme.gregory@linaro.org, gema.gomez-solano@linaro.org
List-Id: linux-serial@vger.kernel.org

> It seems that part of the problem is the lack of tty_port_put/tty_port_get
> calls in the VT code.

Yes
 
> > The only easy way I can think to keep the current semantics would instead
> > be to keep the tty port resources around and indexed somewhere but
> > blackhole input to/output from that port or switching to it and also call
> > tty_hangup if the port has a tty.  
> 
> What would still be missing if we just add that reference counting and
> delay the freeing of the vc_data/tty_port? I probably missed part of your
> analysis, so just throwing this out for discussion.

Is the expected behaviour that the disallocate also shuts down anything
using the port. If so I think you also need to do a hangup on it.

Otherwise, assuming the change in behaviour is ok this seems only part of
the picture. Possibly we should also hangup any proces on the now
destructed port, and right now I don't see that being done
(tty_port_tty_hangup(port, 0);)

I think the rest might also need fixing up.

con_install sets vc->port.tty rather than using tty_port_tty_set() so
looks like it doesn't end up with the needed refcount, and likewise
con_sbutdown touches it wrongly as far as I can see.

(That might actually explain a really strange tty ref counting race
bug I've seen reported very rarely for some years and never found!)

In addition there are other places that reference port->tty directly
without the right locks against hangup that probably need to use
tty_port_tty_get() instead (eg a vc_resize at the exact moment of a
hangup looks like it will crash)

> 
> (not tested, probably wrong as I said)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 2ebaba16f785..9ab3df49d988 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -750,6 +750,16 @@ static void visual_init(struct vc_data *vc, int num, int init)
>  	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
>  }
>  
> +static void vt_destruct(struct tty_port *port)
> +{
> +	struct vc_data *vc = container_of(port, struct vc_data, port);
> +	kfree(vc);
> +}
> +
> +static const struct tty_port_operations vt_port_operations = {
> +	.destruct = vt_destruct,
> +};
> +
>  int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  {
>  	struct vt_notifier_param param;
> @@ -775,6 +785,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  
>  	vc_cons[currcons].d = vc;
>  	tty_port_init(&vc->port);
> +	vc->port.ops = &vt_port_operations;
>  	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  
>  	visual_init(vc, currcons, 1);
> @@ -2880,14 +2891,16 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
>  	vc = vc_cons[currcons].d;
>  
>  	/* Still being freed */
> -	if (vc->port.tty) {
> +	if (vc->port.tty || !tty_port_get(&vc->port)) {

Do we still need to check vc->port.tty as we should have a reference to
the port if the tty is open ? Also on a hangup port->tty changes under
tty_lock and port->lock not console lock.

BTW if you need an example that handles every case of hotplugging at once
the drivers/mmc/core/sdio_uart.c driver pretty much uses every API
feature to handle the sd and tty refcounting.

Alan
