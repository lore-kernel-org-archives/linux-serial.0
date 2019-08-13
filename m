From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
Date: Tue, 13 Aug 2019 12:24:48 +0200
Message-ID: <20190813102448.GO1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-12-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-12-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:20PM +0530, Krishna Yarlagadda wrote:
> Tegra186 chip has a hardware issue resulting in frame errors when
> tolerance level for baud rate is negative. Provided entries to adjust
> baud rate to be within acceptable range and work with devices that
> can send negative baud rate. Also report error when baud rate set is
> out of tolerance range of controller updated in device tree.
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  .../bindings/serial/nvidia,tegra20-hsuart.txt      | 32 ++++++++++++++++=
++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsua=
rt.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> index 187ec78..1ce3fd4 100644
> --- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> @@ -20,6 +20,37 @@ Required properties:
>  Optional properties:
>  - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enab=
le
>  		only if all 8 lines of UART controller are pinmuxed.
> +- nvidia,adjust-baud-rates: List of entries providing percentage of baud=
 rate
> +  adjustment within a range.
> +  Each entry contains sets of 3 values. Range low/high and adjusted rate.
> +  <range_low range_high adjusted_rate>
> +  When baud rate set on controller falls within the range mentioned in t=
his
> +  field, baud rate will be adjusted by percentage mentioned here.
> +  Ex: <9600 115200 200>
> +  Increase baud rate by 2% when set baud rate falls within range 9600 to=
 115200
> +
> +Baud Rate tolerance:
> +  Standard UART devices are expected to have tolerance for baud rate err=
or by
> +  -4 to +4 %. All Tegra devices till Tegra210 had this support. However,
> +  Tegra186 chip has a known hardware issue. UART Rx baud rate tolerance =
level
> +  is 0% to +4% in 1-stop config. Otherwise, the received data will have
> +  corruption/invalid framing errors. Parker errata suggests adjusting ba=
ud
> +  rate to be higher than the deviations observed in Tx.

The above sounds like the tolerance deviation is a characteristic of the
Tegra186 chip. If the board design does not influence the deviation, why
can't we encode this in the driver? Why do we need a description of this
in device tree?

Thierry

> +
> +  Tx deviation of connected device can be captured over scope (or noted =
=66rom
> +  its spec) for valid range and Tegra baud rate has to be set above actu=
al
> +  Tx baud rate observed. To do this we use nvidia,adjust-baud-rates
> +
> +  As an example, consider there is deviation observed in Tx for baud rat=
es as
> +  listed below.
> +  0 to 9600 has 1% deviation
> +  9600 to 115200 2% deviation
> +  This slight deviation is expcted and Tegra UART is expected to handle =
it. Due
> +  to the issue stated above, baud rate on Tegra UART should be set equal=
 to or
> +  above deviation observed for avoiding frame errors.
> +  Property should be set like this
> +  nvidia,adjust-baud-rates =3D <0 9600 100>,
> +  			     <9600 115200 200>;
> =20
>  Example:
> =20
> @@ -34,4 +65,5 @@ serial@70006000 {
>  	reset-names =3D "serial";
>  	dmas =3D <&apbdma 8>, <&apbdma 8>;
>  	dma-names =3D "rx", "tx";
> +	nvidia,adjust-baud-rates =3D <1000000 4000000 136>; /* 1.36% shift */
>  };
> --=20
> 2.7.4
>=20

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1Sj/AACgkQ3SOs138+
s6HwExAAq7X5pSijSAZVzM3kGVoXrM6zoHfPFLRyd4hqd1TEMEdk3LlcLCEqaxco
xsrdMOQ6BfT8b9wtoyG5EZ9t62cxPVo33W2gh2JjkLVdTtQdTJVN/OwDgLee8HQJ
/CUuGrLeYKXrZZYxQPT3WzN1J4bIXBHAaLL7EfqvQ0FhppKonByUgUQf+YWt6dJY
qw9qtbGHKE+4JA/xSOmZwoGXnkiNwEnEC/bXZnRuK2uNmj29J4rNDBS4JRWIb8g8
W++rAIl4eowdahnnYjZvVknqNY7TfqYWqL19TN8zHHzkF0pINojWLgc5znQinRpV
q/3FBSUnT7BwvAas+wvRAhS21xfpoComXMrdsrqN6IYjOL0OiKhf0W5oD14sM17F
hU7GKLJZ86laLg7jCgkE5fq/7ZzGOnHkoxKPoLvIquJggJ+Iu8tSzDjLp7uhz3gf
Dqxs8OeS+uuOzs1jB7kmlFWbvjY6sPCMEgyH5CrTe6vEkyH+ZtW/E9c7l7sS/B7v
W58YDTu3un935rE77HLHNDa34pp63Oo9xqyeM8LPxCng6nRxloeEi0AnMd6xsa1N
e7X5nDi8HuEyl5DOZPkCePuR36ItYzO1Tu+hAh9xp9faeGJTRJLpjB996nLjnSGR
bATI3LKSg5edguc/APhLQmayQHgV/0r6urbbCW7jVeWDeGjL67k=
=mBhj
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
