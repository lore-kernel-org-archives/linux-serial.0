From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 1/1] staging: fwserial: Add TTY-over-Firewire serial
 driver
Date: Tue, 27 Nov 2012 20:00:01 -0500
Message-ID: <1354064401.2703.13.camel@thor>
References: <1350565015.23730.4.camel@thor>
	 <cover.1351817601.git.peter@hurleysoftware.com>
	 <55547e779e65e6865f18d537ef1a42191a4b7e46.1351817601.git.peter@hurleysoftware.com>
	 <20121113003338.6aafd7c8@stein> <1352834072.16401.100.camel@thor>
	 <20121114022522.633a44d4@stein> <1354041196.3284.121.camel@thor>
	 <20121128005846.0f1d4d5e@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:36151 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752263Ab2K1BAK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 20:00:10 -0500
In-Reply-To: <20121128005846.0f1d4d5e@stein>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux1394-devel@lists.sourceforge.net, linux-serial@vger.kernel.org

On Wed, 2012-11-28 at 00:58 +0100, Stefan Richter wrote:
> On Nov 27 Peter Hurley wrote:
> > > > Currently, firewire-net sets an arbitrary address handler lengt=
h of
> > > > 4096. This works because the largest AR packet size the current
> > > > firewire-ohci driver handles is 4096 (value of MAX_ASYNC_PAYLOA=
D) +
> > > > header/trailer. Note that firewire-ohci does not limit card->ma=
x_receive
> > > > to this value.
> > > >=20
> > > > So if the ohci driver changes to handle 8K+ AR packets and the =
hardware
> > > > supports it, these address handler windows will be too small. =20
> > >=20
> > > While the IEEE 1394:2008 link layer specification (section 6) pro=
vides for
> > > asynchronous packet payloads of up to 16384 bytes (table 6-4), th=
e IEEE
> > > 1394 beta mode port specification (section 13) only allows up to =
4096
> > > bytes (table 16-18).  And alpha mode is of course limited to 2048=
 bytes.
> > >=20
> > > So, asynchronous packet payloads greater than 4096 bytes are out =
of scope
> > > of the current revision of IEEE 1394. =20
> >=20
> > You should look at this 1394ta.org video
> > http://www.youtube.com/watch?v=3DxVXNvXHNQTY of DAP Technologies S1=
600
> > OHCI controllers running S1600 cameras using beta cables.
>=20
> I don't know the details of their implementation, but I suppose they =
conform
> with the 1394 beta mode port specification.  Which in turn means that=
 their
> S1600 solution (and by extrapolation, their S3200 prototypes) comply =
with a
> maximum asynchronous packet payload of 4096 bytes.  Citing IEEE 1394-=
2008:
>=20
> >>>
> 	Table 16-18=E2=80=94=E2=80=94=E2=80=94Maximum payload size for Beta =
data packets
>  Data rate | Maximum asynchronous payload size | Maximum isochronous =
payload
>            |              (bytes)              |           (bytes)
>  ----------+-----------------------------------+---------------------=
-------
>     S100   |                 512               |             1024
>     S200   |                1024               |             2048
>     S400   |                2048               |             4096
>     S800   |                4096               |             8192
>     S1600  |                4096               |            16384
>     S3200  |                4096               |            32768
> <<<
>=20
> (Alpha mode payload limits are the same as the S100...S400 subset of =
beta mode.
> In IEEE 1394b-2002, the table number is 16-3.)
>=20
> You can of course define registers (or better termed: buffers) which =
are larger
> than what can be atomically read or written, or atomically compared-s=
wapped;
> IOW which are larger than what can be accessed in a single transactio=
n, if such
> registers or buffers are useful.  But if you particularly need a regi=
ster which
> is just large enough to accommodate the largest possible inbound bloc=
k write
> transaction which complies with IEEE 1394, and you don't know the pee=
r's
> capability and the speeds of all intermediary cable hops, then
> fw_card.max_receive is the number that you need.  Or you ignore the c=
ards actual
> capability and just allocate 4096 bytes.

Thanks for the clarification. I need to update
link_speed_to_max_payload() now. ;)

Plus I should just renew my IEEE membership so I can get the 1394-2008
spec without having to saw my arm off.

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
