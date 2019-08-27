From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 07/14] serial: tegra: add compatible for new chips
Date: Tue, 27 Aug 2019 09:29:48 +0000
Message-ID: <SN6PR12MB27347E57CCA735DB36A49E73C3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
 <20190813095531.GL1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813095531.GL1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:26 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 07/14] serial: tegra: add compatible for new chips
>=20
> On Mon, Aug 12, 2019 at 04:58:16PM +0530, Krishna Yarlagadda wrote:
> > Add new compatible string for Tegra186. It differs from earlier chips
> > as it has fifo mode enable check and 8 byte dma buffer.
> > Add new compatible string for Tegra194. Tegra194 has different error
> > tolerance levels for baud rate compared to older chips.
> >
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt |
> > 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> I think device tree binding patches are supposed to start with
> "dt-binding: ...".
>=20
> Also: "fifo" -> "FIFO" and "dma" -> "DMA" in the commit message.
>=20
> >
> > diff --git
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > index d7edf73..187ec78 100644
> > ---
> > a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.t
> > +++ xt
> > @@ -1,7 +1,8 @@
> >  NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
> >
> >  Required properties:
> > -- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsua=
rt".
> > +- compatible : should be "nvidia,tegra30-hsuart",
> > +"nvidia,tegra20-hsuart",
> > +  nvidia,tegra186-hsuart, nvidia,tegra194-hsuart.
>=20
> Please use quotes around the compatible strings like the existing ones.
> Also, I think it might be better to list these explicitly rather than jus=
t give a list
> of potential values. As it is right now, it's impossible to tell whether =
this is
> meant to say "should be all of these"
> or whether it is meant to say "should be one of these".
>=20
> Thierry
>=20
Will update in next version.
KY
> >  - reg: Should contain UART controller registers location and length.
> >  - interrupts: Should contain UART controller interrupts.
> >  - clocks: Must contain one entry, for the module clock.
> > --
> > 2.7.4
> >
