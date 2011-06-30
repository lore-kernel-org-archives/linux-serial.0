From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCHv3 2/2] tty: of_serial: support for 32 bit accesses
Date: Thu, 30 Jun 2011 12:38:22 -0600
Message-ID: <BANLkTimOJwZt7=yyZjQqW+ctF5zcRNp2aQ@mail.gmail.com>
References: <1309177954-8786-1-git-send-email-jamie@jamieiles.com>
	<1309177954-8786-2-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1309177954-8786-2-git-send-email-jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 27, 2011 at 6:32 AM, Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org> wrote:
> Some platforms e.g. TI Davinci require 32-bit accesses to the UARTs.
> The of_serial driver currently registers all UARTs as UPIO_MEM. =A0Add a
> new attribute "io-width" to allow the port to be registered with
> different IO width requirements.
>
> Acked-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Signed-off-by: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
> ---
> =A0.../devicetree/bindings/tty/serial/of-serial.txt =A0 | =A0 =A03 +++
> =A0drivers/tty/serial/of_serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 17 +++++++++++++++++
> =A02 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b=
/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> index 35e53ae..93260d0 100644
> --- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
> @@ -21,6 +21,9 @@ Optional properties:
> =A0- reg-shift : quantity to shift the register offsets by.
> =A0- used-by-rtas : set to indicate that the port is in use by the OpenFi=
rmware
> =A0 RTAS and should not be registered.
> +- io-width : the size (in bytes) of the IO accesses that should be perfo=
rmed

I know I've already picked this up into linux-next, but I'm going to
change the property name (unless there are objections).  This should
be okay since it hasn't appeared in any mainline kernels yet.  I'd
like this to be named 'reg-io-width' instead to be more consistent
with the existing 'reg-shift' and 'reg-offset' properties.

g.

> + =A0on the device. =A0There are some systems that require 32-bit accesse=
s to the
> + =A0UART (e.g. TI davinci).
>
> =A0Example:
>
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_seria=
l.c
> index c911b24..dfcad6f 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -65,6 +65,23 @@ static int __devinit of_platform_serial_setup(struct p=
latform_device *ofdev,
>
> =A0 =A0 =A0 =A0port->irq =3D irq_of_parse_and_map(np, 0);
> =A0 =A0 =A0 =A0port->iotype =3D UPIO_MEM;
> + =A0 =A0 =A0 prop =3D of_get_property(np, "io-width", &prop_size);
> + =A0 =A0 =A0 if (prop && (prop_size =3D=3D sizeof(u32))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (be32_to_cpup(prop)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->iotype =3D UPIO_MEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->iotype =3D UPIO_MEM32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&ofdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"unsuppo=
rted io width (%d bytes)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0be32_to_=
cpup(prop));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0port->type =3D type;
> =A0 =A0 =A0 =A0port->uartclk =3D be32_to_cpup(clk);
> =A0 =A0 =A0 =A0port->flags =3D UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IO=
REMAP
> --
> 1.7.4.1
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
