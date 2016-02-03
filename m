From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for
 Armada-3700 serial port
Date: Wed, 3 Feb 2016 17:05:07 +0000
Message-ID: <20160203170506.GE1234@leverpostej>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <20160202182842.GD29778@leverpostej>
 <87egct4trb.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87egct4trb.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 03, 2016 at 05:56:56PM +0100, Gregory CLEMENT wrote:
> Hi Mark,
> =20
>  On mar., f=C3=A9vr. 02 2016, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wro=
te:
> >> diff --git a/Documentation/kernel-parameters.txt b/Documentation/k=
ernel-parameters.txt
> >> index 87d40a72f6a1..198f6bd56e84 100644
> >> --- a/Documentation/kernel-parameters.txt
> >> +++ b/Documentation/kernel-parameters.txt
> >> @@ -1058,6 +1058,12 @@ bytes respectively. Such letter suffixes ca=
n also be entirely omitted.
> >>  			A valid base address must be provided, and the serial
> >>  			port must already be setup and configured.
> >> =20
> >> +		mvebu_uart,<addr>
> >> +			Start an early, polled-mode console on an some mvebu
> >> +			SoC (as the Armada-3700) serial port at the specified
> >> +			address. The serial port must already be setup and
> >> +			configured. Options are not yet supported.
> >> +
> >
> > Does the the mvebu UART vary between platforms at all?
>=20
> I am not sure to undersatnd your question.
>=20
> If you asked about the UART used on the other mvebu SoCs then my answ=
er
> is: on all the other mvebu SoC until now third party IPs were used.

Ah, I hadn't realised that.

> This one is the first one dedicated to an mevbu SoC and currently onl=
y
> used on Armada 3700 but I don't know what are the plan for the future
> mvebu SoCs.

Given that, I think it would be better to use "armada3700_uart=3D" for
now, given it doesn't cover all mvebu SoCs.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
