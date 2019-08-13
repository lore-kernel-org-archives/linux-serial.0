From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 07/14] serial: tegra: add compatible for new chips
Date: Tue, 13 Aug 2019 11:55:31 +0200
Message-ID: <20190813095531.GL1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:16PM +0530, Krishna Yarlagadda wrote:
> Add new compatible string for Tegra186. It differs from earlier chips
> as it has fifo mode enable check and 8 byte dma buffer.
> Add new compatible string for Tegra194. Tegra194 has different error
> tolerance levels for baud rate compared to older chips.
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt | 3 +=
+-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I think device tree binding patches are supposed to start with
"dt-binding: ...".

Also: "fifo" -> "FIFO" and "dma" -> "DMA" in the commit message.

>=20
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsua=
rt.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> index d7edf73..187ec78 100644
> --- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> @@ -1,7 +1,8 @@
>  NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
> =20
>  Required properties:
> -- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart=
".
> +- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart=
",
> +  nvidia,tegra186-hsuart, nvidia,tegra194-hsuart.

Please use quotes around the compatible strings like the existing ones.
Also, I think it might be better to list these explicitly rather than
just give a list of potential values. As it is right now, it's
impossible to tell whether this is meant to say "should be all of these"
or whether it is meant to say "should be one of these".

Thierry

>  - reg: Should contain UART controller registers location and length.
>  - interrupts: Should contain UART controller interrupts.
>  - clocks: Must contain one entry, for the module clock.
> --=20
> 2.7.4
>=20

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1SiRMACgkQ3SOs138+
s6EJYw//YTnH42F/vn19weuxjELgdmwZkWjkvGeZf5gO2hiWgy5oR6J74ACsr87G
7IK6eQxszcqOsXXu/f5bX3XiTG8Xpz/6dyfutm9xP0/slRtpHJSLHHKuUofs8HQL
bHBAf9/ZG2mnrkWxm9q18AcZX4b9S7jAqnTI1gxMMZ+FvS2I8jL61dx+2S5bH9Jw
mp4JErcdf+ofxhM7o39q6jHlWhZBRj/3KwauW9sKyiQCKm4b/Lj9JePyeXjiz0Bv
Qs/H/k5GMqo5PqP6G1rw8m40V6hJtkUIdzKskOZJt94he1ULdMAFnXMlYwnK0OJU
MlSfuEhbJajQ4yOSXH+ShUw2j+p/zn+fXpPyWGH/4ckhNQS03T5QRedmpTGUYrkV
XlUyB9V26mYdyMtlNgozoWCHrkhSrmOCkPWDe0j9+F0LcoDNQGj4xvDT2wTAtmSu
wEMQQ47JmPP2rZ5dJi+rEeEVEOBv6VOBiwNgywL+aXV6o/jV71gHICKe6c6PFGnU
vqiRYWedvDtPhSFR9r6JCn7mZ77vgJfnkpSyQON1zupTAGXY+9dy/2m7no835gxe
7nvl072qH3b8GRytLuETp7sAcKNvJvL9Zb1Zjsa4XlJJZ/5M9xKPOVXfajXxLtQU
iEFehu7/BaMdggncN67Kb4s76xszM435j02l5m7aCxGM7eB65PU=
=/lhB
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
