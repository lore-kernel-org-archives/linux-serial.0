From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: ar933x_uart: add device tree support and binding
 documentation
Date: Fri, 30 Aug 2013 18:31:06 -0700
Message-ID: <20130831013106.GE1457@kroah.com>
References: <1377769695-27397-1-git-send-email-juhosg@openwrt.org>
 <20130830211327.GA30138@kroah.com>
 <52211375.8040609@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51368 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab3HaB2m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 Aug 2013 21:28:42 -0400
Content-Disposition: inline
In-Reply-To: <52211375.8040609@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Aug 30, 2013 at 11:49:41PM +0200, Gabor Juhos wrote:
> 2013.08.30. 23:13 keltez=E9ssel, Greg Kroah-Hartman =EDrta:
> > On Thu, Aug 29, 2013 at 11:48:15AM +0200, Gabor Juhos wrote:
> >> Modify the probe routine to get the port line number
> >> from device tree if the 'of_node' is populated in the
> >> platform device. The driver can be built as module,
> >> thus add an OF specific module device table as well
> >> to support module auto loading.
> >>
> >> This makes it possible to use the driver for AR9330
> >> UART devices specified in device tree.
> >>
> >> Cc: devicetree@vger.kernel.org
> >> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> >> ---
> >> Changes since v1:
> >>   - move the doc from bindings/tty/serial to bindings/serial
> >>
> >> The patch is agains the 'tty-next' branch of the
> >> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
> >=20
> > No it isn't, it fails to apply here :(
>=20
> Well, it was created on top of ...
>=20
>   commit 9dfe59f15195b8c5bd4c2950266877c51fc329f0
>   Author: Stephen Boyd <sboyd@codeaurora.org>
>   Date:   Wed Aug 28 13:32:41 2013 -0700
>=20
>       ARM: dts: msm: Update uartdm compatible strings
>=20
>       Let's follow the ratified DT binding and use uartdm instead of
>       hsuart. This does break backwards compatibility but this
>       shouldn't be a problem because the uart driver isn't probing on
>       these devices without adding clock support (which isn't merged =
so
>       far).
>=20
>       Cc: David Brown <davidb@codeaurora.org>
>       Acked-by: Kumar Gala <galak@codeaurora.org>
>       Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> ... and i can still apply the patch on top of that commit.
>=20
> However the current tty-next tree contains the previous version of th=
e patch:
>=20
>   commit dd910d98a2e240443db0090b0ae8a719a4a460f8
>   Author: Gabor Juhos <juhosg@openwrt.org>
>   Date:   Thu Aug 29 08:44:01 2013 +0200
>=20
>       tty: ar933x_uart: add device tree support and binding documenta=
tion
>=20
>     Modify the probe routine to get the port line number
>     from device tree if the 'of_node' is populated in the
>     platform device. The driver can be built as module,
>     thus add an OF specific module device table as well
>     to support module auto loading.
>=20
>     This makes it possible to use the driver for AR9330
>     UART devices specified in device tree.
>=20
>     Cc: devicetree@vger.kernel.org
>     Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> And that is the reason why you can't apply v2. Probably you have miss=
ed my
> preceding [1] mail.
>=20
> What should I do now? Should I send a follow-up patch which moves the
> documentation from 'bindings/tty/serial' to bindings/serial?

As I can't apply this one, I guess a new patch that I can apply will be
the best, right?  :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
