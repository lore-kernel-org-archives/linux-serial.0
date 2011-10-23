From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
Date: Sun, 23 Oct 2011 21:20:08 +0100
Message-ID: <20111023202008.GB27802@n2100.arm.linux.org.uk>
References: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
	<20111022134726.GD21374@n2100.arm.linux.org.uk>
	<CAC=G6syuf-J4am1mHRg-5gzqy661yOT9pUK2vQyToLPtv4tvEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAC=G6syuf-J4am1mHRg-5gzqy661yOT9pUK2vQyToLPtv4tvEg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-serial@vger.kernel.org, Boojin Kim <boojin.kim@samsung.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 23, 2011 at 12:12:13PM -0500, Paul Schilling wrote:
> On Sat, Oct 22, 2011 at 8:47 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set a short timer to togg=
le RTS */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &(ourport->rs485_tx_timer),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 jiffies + usecs_to_jiffies(
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ourport->char_time_usec
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 / 10));
> >
> > This could do with being better formatted. =A0Also, & doesn't need foll=
owing
> > parens.
> =

> when I ran checkpatch it complained that it exceeded 80 characters.  I
> had trouble keeping this line
> under 80 characters.

		} else {
			mod_timer(&our_port->rs485_tx_timer, jiffies +
				  usecs_to_jiffies(ourport->char_time_usec
						   / 10));

is probably a better way to format it.

> >> - =A0 =A0 =A0 =A0 =A0 =A0 if (port->flags & UPF_CONS_FLOW)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (port->flags & UPF_CONS_FLOW) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c24xx_serial_rx_enable(p=
ort);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > Why are you reformatting code?
> =

> I will remove the reformatting of the code.

If you wish to reformat the code to clean up checkpatch warnings, then that
needs to be a separate patch from any other changes.
