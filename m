From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] serial: samsung: Reorder the sequence of clock control
 when call s3c24xx_serial_set_termios()
Date: Fri, 25 Mar 2016 09:10:16 +0900
Message-ID: <56F481E8.1000602@samsung.com>
References: <1457916065-27418-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1457916065-27418-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: k.kozlowski@samsung.com, kgene@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Robert Baldyga (SRPOL)" <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hi Robert,

I send following patch to fix the broken serial log of Exynos SoC.
As I knew, you also knew this issue.
If possible, could you review or test this patch?

Best Regards,
Chanwoo Choi

On 2016=EB=85=84 03=EC=9B=94 14=EC=9D=BC 09:41, Chanwoo Choi wrote:
> This patch fixes the broken serial log when changing the clock source
> of uart device. Before disabling the original clock source, this patc=
h
> enables the new clock source to protect the clock off state for a spl=
it second.
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsun=
g.c
> index d72cd736bdc6..80d59dbfebba 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1265,13 +1265,13 @@ static void s3c24xx_serial_set_termios(struct=
 uart_port *port,
>  	if (ourport->baudclk !=3D clk) {
>  		s3c24xx_serial_setsource(port, clk_sel);
> =20
> +		clk_prepare_enable(clk);
> +
>  		if (!IS_ERR(ourport->baudclk)) {
>  			clk_disable_unprepare(ourport->baudclk);
>  			ourport->baudclk =3D ERR_PTR(-EINVAL);
>  		}
> =20
> -		clk_prepare_enable(clk);
> -
>  		ourport->baudclk =3D clk;
>  		ourport->baudclk_rate =3D clk ? clk_get_rate(clk) : 0;
>  	}
>=20
