From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH] serial: max310x: Use =?iso-8859-1?Q?struct=5Fsize()_in_devm=5Fkzalloc()?=
Date: Thu, 07 Mar 2019 12:03:15 +0100
Message-ID: <99ee4232-3d1c-470a-b406-16af30ca6990@cesnet.cz>
References: <20190104213913.GA21248@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104213913.GA21248@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On p=C3=A1tek 4. ledna 2019 22:39:13 CET, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance =3D devm_kzalloc(dev, sizeof(struct foo) + sizeof(void=20
> *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance =3D devm_kzalloc(dev, struct_size(instance, entry,=20
> count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/tty/serial/max310x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 4f479841769a..1d700a8ab517 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1197,8 +1197,7 @@ static int max310x_probe(struct device=20
> *dev, struct max310x_devtype *devtype,
>  =09=09return PTR_ERR(regmap);
> =20
>  =09/* Alloc port structure */
> -=09s =3D devm_kzalloc(dev, sizeof(*s) +
> -=09=09=09 sizeof(struct max310x_one) * devtype->nr, GFP_KERNEL);
> +=09s =3D devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
>  =09if (!s) {
>  =09=09dev_err(dev, "Error allocating port structure\n");
>  =09=09return -ENOMEM;

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
