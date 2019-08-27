From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
Date: Tue, 27 Aug 2019 09:31:27 +0000
Message-ID: <SN6PR12MB27349055DDF3C324B49E148EC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-12-git-send-email-kyarlagadda@nvidia.com>
 <20190813102448.GO1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813102448.GO1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:55 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
>=20
> On Mon, Aug 12, 2019 at 04:58:20PM +0530, Krishna Yarlagadda wrote:
> > Tegra186 chip has a hardware issue resulting in frame errors when
> > tolerance level for baud rate is negative. Provided entries to adjust
> > baud rate to be within acceptable range and work with devices that can
> > send negative baud rate. Also report error when baud rate set is out
> > of tolerance range of controller updated in device tree.
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  .../bindings/serial/nvidia,tegra20-hsuart.txt      | 32
> ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > index 187ec78..1ce3fd4 100644
> > ---
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.t
> > +++ xt
> > @@ -20,6 +20,37 @@ Required properties:
> >  Optional properties:
> >  - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be
> enable
> >  		only if all 8 lines of UART controller are pinmuxed.
> > +- nvidia,adjust-baud-rates: List of entries providing percentage of
> > +baud rate
> > +  adjustment within a range.
> > +  Each entry contains sets of 3 values. Range low/high and adjusted ra=
te.
> > +  <range_low range_high adjusted_rate>
> > +  When baud rate set on controller falls within the range mentioned
> > +in this
> > +  field, baud rate will be adjusted by percentage mentioned here.
> > +  Ex: <9600 115200 200>
> > +  Increase baud rate by 2% when set baud rate falls within range 9600
> > +to 115200
> > +
> > +Baud Rate tolerance:
> > +  Standard UART devices are expected to have tolerance for baud rate
> > +error by
> > +  -4 to +4 %. All Tegra devices till Tegra210 had this support.
> > +However,
> > +  Tegra186 chip has a known hardware issue. UART Rx baud rate
> > +tolerance level
> > +  is 0% to +4% in 1-stop config. Otherwise, the received data will
> > +have
> > +  corruption/invalid framing errors. Parker errata suggests adjusting
> > +baud
> > +  rate to be higher than the deviations observed in Tx.
>=20
> The above sounds like the tolerance deviation is a characteristic of the
> Tegra186 chip. If the board design does not influence the deviation, why
> can't we encode this in the driver? Why do we need a description of this =
in
> device tree?
>=20
> Thierry
>=20
Tolerance is chip specific and info regarding this is part of chip data.
Explained it here to set context for adjusting baud rates based on slave de=
vice
as below. Slave device clock might not be accurate and if the actual clock =
of
slave device would end up out of tolernace range then we will see frame err=
ors.

KY
> > +
> > +  Tx deviation of connected device can be captured over scope (or
> > + noted from  its spec) for valid range and Tegra baud rate has to be
> > + set above actual  Tx baud rate observed. To do this we use
> > + nvidia,adjust-baud-rates
> > +
> > +  As an example, consider there is deviation observed in Tx for baud
> > + rates as  listed below.
> > +  0 to 9600 has 1% deviation
> > +  9600 to 115200 2% deviation
> > +  This slight deviation is expcted and Tegra UART is expected to
> > + handle it. Due  to the issue stated above, baud rate on Tegra UART
> > + should be set equal to or  above deviation observed for avoiding fram=
e
> errors.
> > +  Property should be set like this
> > +  nvidia,adjust-baud-rates =3D <0 9600 100>,
> > +  			     <9600 115200 200>;
> >
> >  Example:
> >
> > @@ -34,4 +65,5 @@ serial@70006000 {
> >  	reset-names =3D "serial";
> >  	dmas =3D <&apbdma 8>, <&apbdma 8>;
> >  	dma-names =3D "rx", "tx";
> > +	nvidia,adjust-baud-rates =3D <1000000 4000000 136>; /* 1.36% shift */
> >  };
> > --
> > 2.7.4
> >
