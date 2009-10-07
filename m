From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: [need suggestion] Re: sharing UART
Date: Wed, 7 Oct 2009 13:58:52 +0530 (IST)
Message-ID: <258531.99320.qm@web94902.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web94902.mail.in2.yahoo.com ([203.104.17.140]:35575 "HELO
	web94902.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933235AbZJGI3b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Oct 2009 04:29:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

So, If I would want to implement a driver, which exposes some fake char=
acter devices such as /dev/fake[0,1,2] and every write on such a charac=
ter device, I would want to send it out to UART, and when the data come=
s back [receive_buf?], I intrepret the header and copy it onto the rele=
vant buffer of character device fake[0,1,2].

If such a driver has to be implemented,=20
PLEASE SUGGEST AS TO WHAT SORT OF A DRIVER SHOULD IT BE ?
Currently I have thought of it as a line discipline driver, can it be a=
ny other sort of a driver ? [PTY sort of driver, or something which isn=
't even dependent on TTY layer?]

Because I see that the serial-core and the TTY aren't seperate, every U=
ART driver [say 8250, mcf_serial] also gets registered as a tty driver =
because it did an uart_register....

Any help is appreciaated...
regards,
Pavan

--- On Wed, 30/9/09, Pavan Savoy <pavan_savoy@yahoo.co.in> wrote:

> From: Pavan Savoy <pavan_savoy@yahoo.co.in>
> Subject: Re: sharing UART
> To: linux-serial@vger.kernel.org
> Date: Wednesday, 30 September, 2009, 6:22 PM
> Hi,
>=20
> So is it confirmed that no one as of now, had to use 1 UART
> for 2 purposes?
> That is, say the UART had switch between working as a
> normal TTY and also as a Line discipline ?
>=20
> No one had to send modem commands and some unique
> manufacturer specific commands to modem @ the same time ?
>=20
> regards,
> Pavan
>=20
>=20
> --- On Thu, 17/9/09, Pavan Savoy <pavan_savoy@yahoo.co.in>
> wrote:
>=20
> > From: Pavan Savoy <pavan_savoy@yahoo.co.in>
> > Subject: sharing UART
> > To: linux-serial@vger.kernel.org
> > Date: Thursday, 17 September, 2009, 12:46 PM
> > Hi,
> > I have searched through the archives, but did not find
> any
> > example or need to share a UART by 2 drivers.
> >=20
> > Basically there is a "hci_ldisc" line discipline
> driver
> > which makes use of the UART which will be followed up
> by
> > another driver with normal char dev exposed to
> user-space
> > which needs to make use of UART as well.
> >=20
> > So some-one somewhere would have wanted such an
> > implementation right ?
> > what should be done ? any suggestions are welcome.
> >=20
> > regards,
> > Pavan
> >=20
> >=20
> >=20
> > =A0 =A0 =A0 Add whatever you love to the Yahoo!
> > India homepage. Try now! http://in.yahoo.com/trynew
> > --
> > To unsubscribe from this list: send the line
> "unsubscribe
> > linux-serial" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=A0 http://vger.kernel.org/majordomo-info.htm=
l
> >=20
>=20
>=20
> =A0 =A0 =A0 Keep up with people you care about
> with Yahoo! India Mail. Learn how. http://in.overview.mail.yahoo.com/=
connectmore
>=20


      Connect more, do more and share more with Yahoo! India Mail. Lear=
n more. http://in.overview.mail.yahoo.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
