From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] tty: implement led triggers
Date: Sat, 12 May 2018 21:00:22 +0200
Message-ID: <20180512190022.rx7ix5gpx5kncvcj@pengutronix.de>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost>
 <20180510111434.GC6977@amd>
 <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 10, 2018 at 12:25:21PM +0100, Robin Murphy wrote:
> On 10/05/18 12:14, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> > > > > >   		struct tty_buffer *head = buf->head;
> > > > > >   		struct tty_buffer *next;
> > > > > >   		int count;
> > > > > > +		unsigned long delay = 50 /* ms */;
> > > > > 
> > > > > Comment after the semicolon?
> > > > 
> > > > Given that this comment is about the 50 and not the delay member, I
> > > > prefer it before the ;.
> > > 
> > > Hmm. I personally find it hard to read and can only find about 30
> > > instances of this comment style (for assignments) in the kernel. And
> > > arguably the comment applies equally well to the delay variable in this
> > > case too.
> > 
> > It is not too traditional, but I believe it makes sense....
> > 
> > (and yes, I wish we had kernel in Rust, so we could have real units
> > attached to our variables...)
> 
> Well, the variable itself could always be named "delay_ms" if it's really
> that important.

FTR: That's what I did for v3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
