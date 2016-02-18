From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 04/12] ata: ahci_mvebu: add support for Armada 3700 variant
Date: Thu, 18 Feb 2016 18:39:26 +0100
Message-ID: <87y4ahq5o1.fsf@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
	<1455646502-23834-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455646502-23834-5-git-send-email-gregory.clement@free-electrons.com>
	(Gregory CLEMENT's message of "Tue, 16 Feb 2016 19:14:54 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi Tejun and Hans,
=20
 On mar., f=C3=A9vr. 16 2016, Gregory CLEMENT <gregory.clement@free-ele=
ctrons.com> wrote:

> From: Lior Amsalem <alior@marvell.com>
>
> The main difference in the new Armada 3700 is that no address
> decoding needs to take place in the driver probe.
>
> [gregory.clement@free-electrons.com: reformulate the commit log]
>
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I took care of the arm related part of the series, but I will let you
apply this patch in the sata subsystem once you have reviewed it. But
if for any reason you preferred that I took it through mvebu just tell
me.

Thanks,

Gregory


> ---
>  drivers/ata/ahci_mvebu.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> index f7a7fa81740e..de7128d81e9c 100644
> --- a/drivers/ata/ahci_mvebu.c
> +++ b/drivers/ata/ahci_mvebu.c
> @@ -112,12 +112,15 @@ static int ahci_mvebu_probe(struct platform_dev=
ice *pdev)
>  	if (rc)
>  		return rc;
> =20
> -	dram =3D mv_mbus_dram_info();
> -	if (!dram)
> -		return -ENODEV;
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "marvell,armada-380-ahci")) {
> +		dram =3D mv_mbus_dram_info();
> +		if (!dram)
> +			return -ENODEV;
> =20
> -	ahci_mvebu_mbus_config(hpriv, dram);
> -	ahci_mvebu_regret_option(hpriv);
> +		ahci_mvebu_mbus_config(hpriv, dram);
> +		ahci_mvebu_regret_option(hpriv);
> +	}
> =20
>  	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
>  				     &ahci_platform_sht);
> @@ -133,6 +136,7 @@ disable_resources:
> =20
>  static const struct of_device_id ahci_mvebu_of_match[] =3D {
>  	{ .compatible =3D "marvell,armada-380-ahci", },
> +	{ .compatible =3D "marvell,armada-3700-ahci", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
> --=20
> 2.5.0
>

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
