From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] serial: tegra: convert to standard DMA DT bindings
Date: Fri, 29 Nov 2013 15:20:33 +0100
Message-ID: <20131129142032.GB22771@ulmo.nvidia.com>
References: <1385416270-3421-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/w6WUUxYkubDgwa5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385416270-3421-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--/w6WUUxYkubDgwa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 02:51:10PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> By using dma_request_slave_channel_or_err(), the DMA slave ID can be
> looked up from standard DT properties, and squirrelled away during
> channel allocation. Hence, there's no need to use a custom DT property
> to store the slave ID.
>=20
> Cc: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v2:
> * Don't allocate DMA channels inside probe(); the DMA channel setup
>   relies on some buffers that don't get allocated until startup().
>=20
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
>=20
> Greg, you'd previously ack'd this, but I had to change the patch to fix
> some bugs, which was a fair textual change, so I dropped your ack.
> ---
>  drivers/tty/serial/serial-tegra.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--/w6WUUxYkubDgwa5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKKwAAoJEN0jrNd/PrOhooEQAJlO+SpiafNDWoa+2PBeXo+w
phCkGhTRm/NzXkulO1jrRA9Z9Wb6wZPIHKTsHpEgoUqvryeOgFgKFu4dNtyuq7GR
b2R6N48zZYrprR9/p6JPkwFSqFm2UkKZL9Yazrjls/bvkS65WfZoGqXMLCKL7ttY
3r518eWMHK6YIwg2TYlVWcMrEarItCJ9e3IvtnyKre8XnoSGHO0CQtSt9DRIiK+d
0KA4AhJ3h3ZEOySquQYG0tHzVmb2tTaWqkauEzIPO9gzSKZM+hjqI4/PIETZ3ajg
Y7HDuQD46Bm2bd6T/hq5/gCRlGXIgrOGXfpiaAIjcvYnWlymwXeNHAh3yNt/bJiV
0lgAYU+dqms2nCdbWhfQjtQlNNWmd95S6dJHkpUBGPbP9lmrrdUAqMctQBYqZzzl
1TnAi22ze9ScHK/olQQDAo13Z/RnKhWsE5zENKWWdjcYqvi4/f+sHqQKPZCLwWKr
EXq45wFdY1hakH5uf2cdCnq3+pgNWcYMVQFJGkRw/UghkxzgzsYOJpMHn5u98krO
5JWEKGBzr1cLZmbpxnJakhJAtTLKAf+L7ZKrGPfeCI0LMWnZuX+E9HzSRYMpYtuH
Ce2xN4V9ROZXc0o+fyLOuLgamwLGHEwhWeS2vNHL4kevJJreT4yvNz7BkuZVc7ll
48RYTtuDOis1vtOXbw8A
=bw9m
-----END PGP SIGNATURE-----

--/w6WUUxYkubDgwa5--
