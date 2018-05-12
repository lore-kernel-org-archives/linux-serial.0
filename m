From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
Date: Sat, 12 May 2018 20:59:28 +0200
Message-ID: <20180512185928.nzeyvxqnvfefqnzj@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <20180510112101.GD6977@amd>
 <20180510112229.GE6977@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510112229.GE6977@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, linux-can@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, linux-leds@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 10, 2018 at 01:22:29PM +0200, Pavel Machek wrote:
> On Thu 2018-05-10 13:21:01, Pavel Machek wrote:
> > Hi!
> > 
> > > This allows one to simplify drivers that provide a trigger with a
> > > non-constant name (e.g. one trigger per device with the trigger name
> > > depending on the device's name).
> > > 
> > > Internally the memory the name member of struct led_trigger points to
> > > now always allocated dynamically instead of just taken from the caller.
> > > 
> > > The function led_trigger_rename_static() must be changed accordingly and
> > > was renamed to led_trigger_rename() for consistency, with the only user
> > > adapted.
> > 
> > Well, I'm not sure if we want to have _that_ many trigger. Trigger
> > interface is going to become.. "interesting".
> > 
> > We have 4K limit on total number of triggers. We use rather strange
> > interface to select trigger.
> > 
> > > @@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
> > >  
> > >  	if (msg == NETDEV_CHANGENAME) {
> > >  		snprintf(name, sizeof(name), "%s-tx", netdev->name);
> > > -		led_trigger_rename_static(name, priv->tx_led_trig);
> > > +		led_trigger_rename(priv->tx_led_trig, name);
> > >  
> > >  		snprintf(name, sizeof(name), "%s-rx", netdev->name);
> > > -		led_trigger_rename_static(name, priv->rx_led_trig);
> > > +		led_trigger_rename(priv->rx_led_trig, name);
> > >  
> > >  		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
> > > -		led_trigger_rename_static(name, priv->rxtx_led_trig);
> > > +		led_trigger_rename(priv->rxtx_led_trig, name);
> > >  	}
> > >  
> > 
> > I know this is not your fault, but if you have a space or "[]" in
> > netdev names, confusing things will happen.
> 
> Hmm. If we are doing this we really should check trigger names for
> forbidden characters. At least "[] " should be forbidden.

I think you don't expect me to change the patch, but to make this
explicit: My patch doesn't make this problem worse, so this would be an
orthogonal change and doesn't affect this one.

Spaces don't seem to be allowed in netdev names:

uwe@taurus:~$ sudo ip link set wlp3s0 name 'la la'
Error: argument "la la" is wrong: "name" not a valid ifname

(Didn't check if only ip forbids that, of if that is a kernel policy.) I
could rename my device to "lala[]" though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
