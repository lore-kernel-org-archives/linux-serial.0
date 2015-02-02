From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] serial: samsung: earlycon support depends on CONFIG_SERIAL_SAMSUNG_CONSOLE
Date: Mon, 2 Feb 2015 19:14:18 +0530
Message-ID: <CAGOxZ52o79rTKV5c1c5DKc3adze=4Mj=8b=aZTBCr8qs0GkgAQ@mail.gmail.com>
References: <1422870455-19581-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422870455-19581-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Mon, Feb 2, 2015 at 3:17 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> EarlyCon support depends on serial console infrastructure, so the cod=
e
> implementing it should depend on CONFIG_SERIAL_SAMSUNG_CONSOLE.
>
> This patch fixes the following build break:
> CC [M]  drivers/tty/serial/samsung.o
> drivers/tty/serial/samsung.c:2468:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before string constant
> drivers/tty/serial/samsung.c:2468:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before =E2=80=98s3c2410_setup_earlycon=E2=
=80=99
> drivers/tty/serial/samsung.c:2487:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before string constant
> drivers/tty/serial/samsung.c:2487:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before =E2=80=98s3c2412_setup_earlycon=E2=
=80=99
> drivers/tty/serial/samsung.c:2488:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before string constant
> drivers/tty/serial/samsung.c:2488:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before =E2=80=98s3c2440_setup_earlycon=E2=
=80=99
> drivers/tty/serial/samsung.c:2489:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before string constant
> drivers/tty/serial/samsung.c:2489:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before =E2=80=98s3c6400_setup_earlycon=E2=
=80=99
> drivers/tty/serial/samsung.c:2506:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before string constant
> drivers/tty/serial/samsung.c:2506:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before =E2=80=98s5pv210_setup_earlycon=E2=
=80=99
> drivers/tty/serial/samsung.c:2507:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before string constant
> drivers/tty/serial/samsung.c:2507:1: error: expected declaration spec=
ifiers or =E2=80=98...=E2=80=99 before =E2=80=98exynos4210_setup_earlyc=
on=E2=80=99
> drivers/tty/serial/samsung.c:2468:1: warning: =E2=80=98s3c2410_setup_=
earlycon=E2=80=99 defined but not used [-Wunused-function]
> drivers/tty/serial/samsung.c:2487:1: warning: =E2=80=98s3c2412_setup_=
earlycon=E2=80=99 defined but not used [-Wunused-function]
> drivers/tty/serial/samsung.c:2488:1: warning: =E2=80=98s3c2440_setup_=
earlycon=E2=80=99 defined but not used [-Wunused-function]
> drivers/tty/serial/samsung.c:2489:1: warning: =E2=80=98s3c6400_setup_=
earlycon=E2=80=99 defined but not used [-Wunused-function]
> drivers/tty/serial/samsung.c:2506:1: warning: =E2=80=98s5pv210_setup_=
earlycon=E2=80=99 defined but not used [-Wunused-function]
> drivers/tty/serial/samsung.c:2507:1: warning: =E2=80=98exynos4210_set=
up_earlycon=E2=80=99 defined but not used [-Wunused-function]
> make[3]: *** [drivers/tty/serial/samsung.o] Error 1
>

Which config results in these build errors?

I just tried building arch/arm exynos_defconfig /wo
CONFIG_SERIAL_SAMSUNG_CONSOLE
and I do got below error [1]:

[1]:
drivers/built-in.o: In function `samsung_early_write':
/home/alim/linux-next/drivers/tty/serial/samsung.c:2442: undefined
reference to `uart_console_write'
make: *** [vmlinux] Error 1

and $SUBJECT patch does resolve [1],
So, Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

but when I build arm64 _defconfig_ (with exynos7 enabled, manually)
/wo  CONFIG_SERIAL_SAMSUNG_CONSOLE,
build is successful, no build error like [1] above.

Also a build with multi_v7_defconfig does not result in any build error=
=2E
Probably this is to do with the way SERIAL_CORE_CONSOLE is handled in
arm64 defconfig and multi_v7_defconfig.
Not sure if there are other ways to fix this, lets see what others thin=
ks.
In my view $SUBJECT patch is ok.


> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsun=
g.c
> index a6bef8dcdc3c..bb73897809a1 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -2403,6 +2403,7 @@ static struct platform_driver samsung_serial_dr=
iver =3D {
>
>  module_platform_driver(samsung_serial_driver);
>
> +#ifdef CONFIG_SERIAL_SAMSUNG_CONSOLE
>  /*
>   * Early console.
>   */
> @@ -2505,6 +2506,7 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos=
4210-uart",
>                         s5pv210_early_console_setup);
>  EARLYCON_DECLARE(s5pv210, s5pv210_early_console_setup);
>  EARLYCON_DECLARE(exynos4210, s5pv210_early_console_setup);
> +#endif
>
>  MODULE_ALIAS("platform:samsung-uart");
>  MODULE_DESCRIPTION("Samsung SoC Serial port driver");
> --
> 1.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards,
Alim
