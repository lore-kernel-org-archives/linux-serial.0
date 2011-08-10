From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/4] serial: s5pv210: Add device tree support
Date: Wed, 10 Aug 2011 23:11:01 +0530
Message-ID: <CAJuYYwS8Wr38WPQsu7-EHEK5YFn0823eKjj-yTxyp7=c23KnPQ@mail.gmail.com>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
	<1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
	<20110803091249.GB28651@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110803091249.GB28651@trinity.fluff.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com, patches@linaro.org, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Ben,

On 3 August 2011 14:42, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Aug 03, 2011 at 12:08:27AM +0100, Thomas Abraham wrote:
>> For device tree based probe, the dependecy on pdev->id to attach a
>> corresponding default port info to the driver's private data is
>> removed. The fifosize parameter is obtained from the device tree
>> node and the next available instance of port info is updated
>> with the fifosize value and attached to the driver's private data.
>> The default platform data is selected based on the compatible proper=
ty.
>>
>> CC: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/serial/samsung_uart.txt =A0 =A0| =A0 16 +=
++++++
>> =A0drivers/tty/serial/s5pv210.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 43 +++++++++++++++++++-
>> =A0drivers/tty/serial/samsung.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A05 ++-
>> =A03 files changed, 62 insertions(+), 2 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/serial/samsu=
ng_uart.txt
>>

[...]

>> =A0/* device management */
>> =A0static int s5p_serial_probe(struct platform_device *pdev)
>> =A0{
>> - =A0 =A0 return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
>> + =A0 =A0 static unsigned int probe_index;
>> + =A0 =A0 unsigned int port =3D pdev->id;
>> + =A0 =A0 const struct of_device_id *match;
>> + =A0 =A0 struct s3c2410_uartcfg *cfg;
>> +
>> + =A0 =A0 if (pdev->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(pdev->dev.of_node=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "samsung,u=
art-fifosize",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &s5p_uart_=
inf[probe_index]->fifosize))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> I'd rather see the fifo size either being a property of the soc itsel=
f
> or being inferred by the compatible field.

When using the compatible field to infer the fifosize of the
controller, the code looks as listed below.

struct s3c24xx_uart_dt_compat_data {
        unsigned int fifosize;
        struct s3c2410_uartcfg *uartcfg;
};

static struct s3c2410_uartcfg s5pv310_uart_defcfg =3D {
        .ucon   =3D 0x3c5,
        .ufcon  =3D 0x111,
        .flags  =3D NO_NEED_CHECK_CLKSRC,
        .has_fracval =3D 1,
};

static struct s3c24xx_uart_dt_compat_data s5pv210_compat_fs256 =3D {
        .fifosize =3D 256;
        .uartcfg =3D &s5pv310_uart_defcfg;
};

static struct s3c24xx_uart_dt_compat_data s5pv210_compat_fs64 =3D {
        .fifosize =3D 64;
        .uartcfg =3D &s5pv310_uart_defcfg;
};

static struct s3c24xx_uart_dt_compat_data s5pv210_compat_fs16 =3D {
        .fifosize =3D 16;
        .uartcfg =3D &s5pv310_uart_defcfg;
};

static const struct of_device_id s5pv210_uart_dt_match[] =3D {
        { .compatible =3D "samsung,s5pv310-uart-fs256", .data =3D
&s5pv210_compat_fs256 },
        { .compatible =3D "samsung,s5pv310-uart-fs64", .data =3D
s5pv210_compat_fs64 },
        { .compatible =3D "samsung,s5pv310-uart-fs16", .data =3D
s5pv210_compat_fs16 },
        {},
};
MODULE_DEVICE_TABLE(of, s5pv210_uart_match);


This requires a new structure definition and additional data in the
driver. So I still prefer to use a property in the uart device node to
define the fifosize of the controller.

What would you be your preference? Or is there a better way to obtain
the fifosize?

Thanks,
Thomas.

>
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "s5pv210-uart",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D s5pv210_uart_dt_match,
>
> I think maybe doing something like
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D of_match_ptr(5pv21=
0_uart_dt_match),
>
> so we can avoid having the #else and #define 5pv210_uart_dt_match NUL=
L
> in a number of places.
>
>> =A0 =A0 =A0 },
>> =A0};
>
> --
> Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disa=
ppear.
>
>
